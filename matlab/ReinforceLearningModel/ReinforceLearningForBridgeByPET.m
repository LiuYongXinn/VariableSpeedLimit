%% 基于PET奖励的桥梁场景强化学习主函数
% 输入
% vissimFileName        ：文件名
% vissimPathName        ：文件路径
% vissimUnifiedName     ：文件统一名称
% userWeatherChooseRL   ：用户的天气选择
% rewardFunctionChoose  ：用户的奖励函数选择
%% 
function ReinforceLearningForBridgeByPET(vissimFileName,vissimPathName,vissimUnifiedName,...
    userWeatherChooseRL, invadeLineSet,trainingNum)
%% VISSIM连接和二次开发COM接口

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
%数据
global PETSum PETSumNumber
global PETSumScene PETSumNumberScene
global PETSumUpstream PETSumNumberUpstream


global allStepVehiclePETNumber
global invadeTimeLane1 invadeTimeLane2 invadeTimeLane3 invadeTimeLane4
global invadeTimeLane1Number invadeTimeLane2Number invadeTimeLane3Number invadeTimeLane4Number
global invadeTimeNumber1 invadeTimeNumber2 invadeTimeNumber3 invadeTimeNumber4

global allStepVehiclePETNumberScene
global invadeTimeLane1Scene invadeTimeLane2Scene invadeTimeLane3Scene invadeTimeLane4Scene
global invadeTimeLane1NumberScene invadeTimeLane2NumberScene invadeTimeLane3NumberScene invadeTimeLane4NumberScene
global invadeTimeNumber1Scene invadeTimeNumber2Scene invadeTimeNumber3Scene invadeTimeNumber4Scene
global allStepVehiclePETNumberUpstream
global invadeTimeLane1Upstream invadeTimeLane2Upstream invadeTimeLane3Upstream invadeTimeLane4Upstream
global invadeTimeLane1NumberUpstream invadeTimeLane2NumberUpstream invadeTimeLane3NumberUpstream invadeTimeLane4NumberUpstream
global invadeTimeNumber1Upstream invadeTimeNumber2Upstream invadeTimeNumber3Upstream invadeTimeNumber4Upstream


%% 强化学习参数设置

% 学习率
learningRate = 0.8;
%折扣率
discountFactor = 0.8;
%动作集
[limitSet,motionSet] = AgentActionDefine("bridge");
% 根据不同的天气选择不同的Q表
[Qtable,Qtabledirection] = AgentQtableChoose_2248(vissimPathName,userWeatherChooseRL, 1);
volume1Temp = 3000;
densityAndVolume = zeros(trainingNum,3);
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
    %数据
  %场景区数据PET数据存储变量
    invadeTimeLane1Scene = zeros(evaluationTime*10,3);
    invadeTimeLane1NumberScene = 1;
    invadeTimeLane2Scene = zeros(evaluationTime*10,3);
    invadeTimeLane2NumberScene = 1;
    invadeTimeLane3Scene = zeros(evaluationTime*10,3);
    invadeTimeLane3NumberScene = 1;
    invadeTimeLane4Scene = zeros(evaluationTime*10,3);
    invadeTimeLane4NumberScene = 1;
    invadeTimeNumber1Scene = 0;
    invadeTimeNumber2Scene = 0;
    invadeTimeNumber3Scene = 0;
    invadeTimeNumber4Scene = 0;
    allStepVehiclePETNumberScene = zeros(4,evaluationTime);
    
    %上游数据PET存储变量
    invadeTimeLane1Upstream = zeros(evaluationTime*10,3);
    invadeTimeLane1NumberUpstream = 1;
    invadeTimeLane2Upstream = zeros(evaluationTime*10,3);
    invadeTimeLane2NumberUpstream = 1;
    invadeTimeLane3Upstream = zeros(evaluationTime*10,3);
    invadeTimeLane3NumberUpstream = 1;
    invadeTimeLane4Upstream = zeros(evaluationTime*10,3);
    invadeTimeLane4NumberUpstream = 1;
    invadeTimeNumber1Upstream = 0;
    invadeTimeNumber2Upstream = 0;
    invadeTimeNumber3Upstream = 0;
    invadeTimeNumber4Upstream = 0;
    allStepVehiclePETNumberUpstream = zeros(4,evaluationTime);
    
    
    %车辆越过侵入线的时刻
    invadeTimeLane1 = zeros(evaluationTime*10,3);
    invadeTimeLane1Number = 1;
    invadeTimeLane2 = zeros(evaluationTime*10,3);
    invadeTimeLane2Number = 1;
    invadeTimeLane3 = zeros(evaluationTime*10,3);
    invadeTimeLane3Number = 1;
    invadeTimeLane4 = zeros(evaluationTime*10,3);
    invadeTimeLane4Number = 1;
      
    %每时刻获取到的车辆数，用于PET
    allStepVehiclePETNumber = zeros(4,evaluationTime);
    
    %越过侵入线的起始车辆数
    %车道1
    invadeTimeNumber1 = 0;
    %车道2
    invadeTimeNumber2 = 0;
    %车道3
    invadeTimeNumber3 = 0;
    %车道4
    invadeTimeNumber4 = 0;
    
    %在线PET数据
    PETSum = zeros(evaluationTime*10,4);
    PETSumNumber = 1;
    PETSumScene = zeros(evaluationTime*10,4);
    PETSumNumberScene = 1;
    PETSumUpstream = zeros(evaluationTime*10,4);
    PETSumNumberUpstream = 1;
    PETTimesSum1 = 0;
    PETTimesSum2 = 0;
    if( mod(tti, 30) == 0)
        volume1Temp= 3500; 
    end
    
    %% 仿真主体
    while step <= evaluationTime
        vissimSimulation.RunSingleStep;
         
        %% 设置随机车流量，用于获取不同的交通流密度
        if (step == 1)
            volume1 = volume1Temp;
            volume1Temp = volume1Temp + 50;
            vehicleInput1.set('AttValue', 'Volume',volume1);
        end
        
        %% 300秒到600秒之间，收集路段信息
        if(step >= 300 && step < 600 && mod(step,60) == 0)
            %采集路段密度信息
            density = AgentTrafficFlowInformationInLink_2248(netLinks, 2);
            densitySum1 = densitySum1 + density;
            densityNum1 = densityNum1 + 1;
            %%PET计算
            %% 上游数据采集
            %车辆数据采集
            ConvertInvadeTimeForSceneAndUpstream_All(-1,invadeLineSet);
            vehicleData = VehicleDataByUpstream_All(netVehicles, step);
            %车辆按车道和位置进行分类
            [vehicleDataLane1, vehicleDataLane2, vehicleDataLane3] = ...
                AgentSortByLaneAndLinkCoordOnlineForThreeLane_2248(vehicleData);
            PETTimes = PETTimesCalculate_All(step, vehicleDataLane1, vehicleDataLane2, vehicleDataLane3);
            PETTimesSum1 = PETTimesSum1 + PETTimes;
            ConvertInvadeTimeForSceneAndUpstream_All(-2,invadeLineSet);
            %% 场景区数据
            
            %车辆数据采集
            ConvertInvadeTimeForSceneAndUpstream_All(1,invadeLineSet);
            vehicleData = AgentRealTimeVehicleData_2248(netVehicles,step,2);
            %车辆按车道和位置进行分类
            [vehicleDataLane1, vehicleDataLane2, vehicleDataLane3] = ...
                AgentSortByLaneAndLinkCoordOnlineForThreeLane_2248(vehicleData);
            PETTimes = PETTimesCalculate_All(step, vehicleDataLane1, vehicleDataLane2, vehicleDataLane3);
            
            PETTimesSum1 = PETTimesSum1 + PETTimes;
            ConvertInvadeTimeForSceneAndUpstream_All(2,invadeLineSet);

        end
        
        
        %% 600秒时进行限速控制
        if(step == 600)
            %确定当前状态
            densityAverage1 = densitySum1 / densityNum1;
            state1 = AgentStateChoose(densityAverage1);
            densityAndVolume(tti,:) = [volume1,densityAverage1,state1];
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
            density = AgentTrafficFlowInformationInLink_2248(netLinks, 2);
            densitySum2 = densitySum2 + density;
            densityNum2 = densityNum2 + 1;
            
            %%PET计算
            %% 上游数据采集
            %车辆数据采集
            ConvertInvadeTimeForSceneAndUpstream_All(-1,invadeLineSet);
            vehicleData = VehicleDataByUpstream_All(netVehicles, step);
            %车辆按车道和位置进行分类
            [vehicleDataLane1, vehicleDataLane2, vehicleDataLane3] = ...
                AgentSortByLaneAndLinkCoordOnlineForThreeLane_2248(vehicleData);
            PETTimes = PETTimesCalculate_All(step, vehicleDataLane1, vehicleDataLane2, vehicleDataLane3);
            PETTimesSum2 = PETTimesSum2 + PETTimes;
            ConvertInvadeTimeForSceneAndUpstream_All(-2,invadeLineSet);
            %% 场景区数据
            
            %车辆数据采集
            ConvertInvadeTimeForSceneAndUpstream_All(1,invadeLineSet);
            vehicleData = AgentRealTimeVehicleData_2248(netVehicles,step,2);
            %车辆按车道和位置进行分类
            [vehicleDataLane1, vehicleDataLane2, vehicleDataLane3] = ...
                AgentSortByLaneAndLinkCoordOnlineForThreeLane_2248(vehicleData);
            PETTimes = PETTimesCalculate_All(step, vehicleDataLane1, vehicleDataLane2, vehicleDataLane3);
            PETTimesSum2 = PETTimesSum2 + PETTimes;
            ConvertInvadeTimeForSceneAndUpstream_All(2,invadeLineSet);
            
        end
        
        %% 更新Q表
        if (step == 1200)
            %确定当前状态
            densityAverage2 = densitySum2 / densityNum2;
            state2 = AgentStateChoose(densityAverage2);
            
            %根据事故风险设置reward
            reward = AgentRewardBySecurity(PETTimesSum1,PETTimesSum2);
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
        tempDirection = strcat(vissimPathName,"训练次数\QtableByPET",num2str(tti+10000),".txt");
        AgentSaveQtable(tempDirection,Qtable);
    end
end
end