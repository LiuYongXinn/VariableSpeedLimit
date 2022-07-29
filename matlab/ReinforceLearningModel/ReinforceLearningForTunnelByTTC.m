%% 基于TTC奖励的隧道场景强化学习主函数
% 输入
% vissimFileName        ：文件名
% vissimPathName        ：文件路径
% vissimUnifiedName     ：文件统一名称
% userWeatherChooseRL   ：用户的天气选择
% rewardFunctionChoose  ：用户的奖励函数选择
%% 
function ReinforceLearningForTunnelByTTC(vissimFileName,vissimPathName,vissimUnifiedName,...
    userWeatherChooseRL,invadeLineSet,trainingNum)
%仿真时间
evaluationTime = 1500;

[vissim_com, vissimNet, vissimEvaluation, vissimSimulation,netVehicleInputs, ...
    netDataCollections, netTravelTime, netDelay,netQueueCounters,...
    netDrivingBehaviorParSets, netReducedSpeedAreas,netVehicles, netLinks] ...
    = VissimConnect(evaluationTime,vissimFileName,vissimPathName,vissimUnifiedName);
%% 设置不同的驾驶行为(根据不同天气状况设置)
% 根据不同的天气选择不同的驾驶行为
[CC0, CC1, CC2, CC3, CC4, CC5, CC6, CC7, CC8, CC9]...
    = DrivingBehaviorSettings(netDrivingBehaviorParSets, userWeatherChooseRL);

%% 参数定义
%计数
reducedSpeedAreasCount = netReducedSpeedAreas.Count;

%侵入线位置
global invadeLine
invadeLine = invadeLineSet;

global TTCSum TTCSumNumber;
global TTCSumUpstream TTCSumNumberUpstream;
global TTCSumScene TTCSumNumberScene;
%% 强化学习参数设置
% 学习率
learningRate = 0.8;
%折扣率
discountFactor = 0.8;
%动作集
[limitSet,motionSet] = AgentActionDefine("tunnel");
% 根据不同的天气选择不同的Q表
[Qtable,Qtabledirection] = AgentQtableChoose_2248(vissimPathName,userWeatherChooseRL, 2);
volume1Temp = 300;
%% 主循环
for tti = 1 : trainingNum
    %% 车流量设置和减速区域设置
    %设置车流量
    volume1 = 0;
    %设置主干道车流量
    vehicleInput1 = netVehicleInputs.GetVehicleInputByNumber(1);
    vehicleInput1.set('AttValue', 'Volume',volume1);
    vehicleInput1.set('AttValue', 'TIMEUNTIL',evaluationTime);
    %设置随机种子
    randSeed = randi(100);
    vissimSimulation.set('AttValue', 'RANDOMSEED',randSeed);
    
    %减速区域设置
    reducedSpeed = 120;
    ReducedSpeedSettings(netReducedSpeedAreas,reducedSpeedAreasCount,reducedSpeed);
    %施工区限速设置
    AgentReducedSpeedSettingsForCLoseBridgeTunnel_2248(netReducedSpeedAreas,reducedSpeed);
    
    
    %% 参数设置
    %仿真起始步长
    step = 1;
    %动作选择前多个时刻的交通流密度总和
    densitySum1 = 0;
    %动作选择前统计交通流密度的次数
    densityNum1 = 0;
    %动作选择后多个时刻的交通流密度总和
    densitySum2 = 0;
    %动作选择后统计交通流密度的次数
    densityNum2 = 0;
  
    %TTC数据
    TTCSum = zeros(evaluationTime*10,4);
    TTCSumNumber = 1;
    TTCSumUpstream = zeros(evaluationTime*10,4);
    TTCSumNumberUpstream = 1;
    TTCSumScene = zeros(evaluationTime*10,4);
    TTCSumNumberScene = 1;
    TTCTimesSum1 = 0;
    TTCTimesSum2 = 0;
    
    if( mod(tti, 570) == 0)
        volume1Temp= 300;
    end
    %% 仿真主体
    while step <= evaluationTime
        vissimSimulation.RunSingleStep;
        
        %% 设置随机车流量，用于获取不同的交通流密度
         if (step == 1)
            volume1 = volume1Temp;
            volume1Temp = volume1Temp + 10;
            vehicleInput1.set('AttValue', 'Volume',volume1);
            
        end
        
        %% 300秒到600秒之间，收集路段信息
        if(step >= 300 && step < 600 && mod(step,60) == 0)
            %采集路段密度信息
            density = AgentTrafficFlowInformationInLink_2248(netLinks,2);
            densitySum1 = densitySum1 + density;
            densityNum1 = densityNum1 + 1;
            
            %% 上游区
            vehicleData = VehicleDataByUpstream_All(netVehicles, step);
            [vehicleDataLane1, vehicleDataLane2, vehicleDataLane3] = ...
                AgentSortByLaneAndLinkCoordOnlineForThreeLane_2248(vehicleData);
            ConvertInvadeLineAndTTCSum(-1, invadeLineSet);
            TTCTimes = TTCTimesCalculate_All(step, vehicleDataLane1, vehicleDataLane2, vehicleDataLane3);
            TTCTimesSum1 = TTCTimesSum1 + TTCTimes;
            ConvertInvadeLineAndTTCSum(-2, invadeLineSet);
            
            
            
            %% 场景区
            %车辆数据采集
            vehicleData = AgentRealTimeVehicleData_2248(netVehicles,step,2);
            %车辆按车道和位置进行分类
            [vehicleDataLane1, vehicleDataLane2, vehicleDataLane3] = ...
                AgentSortByLaneAndLinkCoordOnlineForThreeLane_2248(vehicleData);
            ConvertInvadeLineAndTTCSum(1, invadeLineSet);
            TTCTimes = TTCTimesCalculate_All(step, vehicleDataLane1, vehicleDataLane2, vehicleDataLane3);
            TTCTimesSum1 = TTCTimesSum1 + TTCTimes;
            ConvertInvadeLineAndTTCSum(2, invadeLineSet);
            
       
            
        end
        
        %% 600秒时进行限速控制
        if(step == 600)
            %确定当前状态
            densityAverage1 = densitySum1 / densityNum1;
            state1 = AgentStateChoose(densityAverage1);
            
            %基于softmax模型进行动作选择
            %action = Agent_ActionChosseBySoftMax(Qtable, state1, 1000);
            action = ActionChooseForBaseTraining(Qtable, state1,1000);
            [speedLimit1, speedLimit2] = AgentActionChoose(action, limitSet, motionSet);
            
            %减速区域设置
            ReducedSpeedSettings(netReducedSpeedAreas,reducedSpeedAreasCount,speedLimit1);
            %施工区域限速设置
            AgentReducedSpeedSettingsForCLoseBridgeTunnel_2248(netReducedSpeedAreas,speedLimit2);
        end
        
        
        
        %% 900秒到1200秒，收集限速后的路段信息
        if(step >= 900 && step < 1200 && mod(step,60) == 0)
            %采集路段密度信息
            density = AgentTrafficFlowInformationInLink_2248(netLinks,2);
            densitySum2 = densitySum2 + density;
            densityNum2 = densityNum2 + 1;
            %% 上游区
            vehicleData = VehicleDataByUpstream_All(netVehicles, step);
            [vehicleDataLane1, vehicleDataLane2, vehicleDataLane3] = ...
                AgentSortByLaneAndLinkCoordOnlineForThreeLane_2248(vehicleData);
            ConvertInvadeLineAndTTCSum(-1, invadeLineSet);
            TTCTimes = TTCTimesCalculate_All(step, vehicleDataLane1, vehicleDataLane2, vehicleDataLane3);
            TTCTimesSum2 = TTCTimesSum2 + TTCTimes;
            ConvertInvadeLineAndTTCSum(-2, invadeLineSet);
            
            
            
            %% 场景区
            %车辆数据采集
            vehicleData = AgentRealTimeVehicleData_2248(netVehicles,step,2);
            %车辆按车道和位置进行分类
            [vehicleDataLane1, vehicleDataLane2, vehicleDataLane3] = ...
                AgentSortByLaneAndLinkCoordOnlineForThreeLane_2248(vehicleData);
            ConvertInvadeLineAndTTCSum(1, invadeLineSet);
            TTCTimes = TTCTimesCalculate_All(step, vehicleDataLane1, vehicleDataLane2, vehicleDataLane3);
            TTCTimesSum2 = TTCTimesSum2 + TTCTimes;
            ConvertInvadeLineAndTTCSum(2, invadeLineSet);
        end
        
        %% 更新Q表
        if (step == 1200)
            %确定当前状态
            densityAverage2 = densitySum2 / densityNum2;
            state2 = AgentStateChoose(densityAverage2);
            
            %根据事故风险设置reward
            reward = AgentRewardBySecurityTTC_2248(TTCTimesSum1,TTCTimesSum2);
            %更新Q表
            Qtable(state1,action) = Qtable(state1,action) + ...
                learningRate*(reward + discountFactor * max(Qtable(state2,:)) - Qtable(state1,action));
            
            %清空输入的车流量
            vehicleInput1.set('AttValue', 'Volume',0);
        end
        
        step = step + 1;
    end
    vissimSimulation.Stop;
    %保存Q表
    AgentSaveQtable(Qtabledirection,Qtable);
    if(mod(tti, 2000) == 0)
        % Qtabledirection = strcat(QtablePathName,QtableFileName);
        tempDirection = strcat(vissimPathName,"训练次数\QtableByTTC",num2str(tti+2500),".txt");
        AgentSaveQtable(tempDirection,Qtable);
    end
    
end

end