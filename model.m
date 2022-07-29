vissimFileName = 'tunnel.inp';
vissimPathName = 'E:\桌面\2022-5-23version2\VISSIM\Tunnel\';
vissimUnifiedName = 'vissim';
userWeatherChooseRL= 1;
global invadeLine;

evaluationTime = 1200;
[vissim_com, vissimNet, vissimEvaluation, vissimSimulation,netVehicleInputs, ...
    netDataCollections, netTravelTime, netDelay,netQueueCounters,...
    netDrivingBehaviorParSets, netReducedSpeedAreas,netVehicles, netLinks] ...
    = VissimConnect(evaluationTime,vissimFileName,vissimPathName,vissimUnifiedName);

%计数
reducedSpeedAreasCount = netReducedSpeedAreas.Count;
%设置减速区域开始时间
SetStartTimeForReduceArea(netReducedSpeedAreas, 1);
%减速区域设置
reducedSpeed = 120;
ReducedSpeedSettings(netReducedSpeedAreas,reducedSpeedAreasCount,reducedSpeed);
%施工区限速设置
AgentReducedSpeedSettingsForCLoseBridgeTunnel_2248(netReducedSpeedAreas,reducedSpeed);

%% 车流量设置
%设置车流量
volume1 = 0;
%设置主干道车流量
vehicleInput1 = netVehicleInputs.GetVehicleInputByNumber(1);
vehicleInput1.set('AttValue', 'Volume',volume1);
vehicleInput1.set('AttValue', 'TIMEUNTIL',evaluationTime);
%设置随机种子
randSeed = 64;
vissimSimulation.set('AttValue', 'RANDOMSEED',randSeed);


%动作选择前多个时刻的交通流密度总和
densitySum1 = 0;
%动作选择前统计交通流密度的次数
densityNum1 = 0;
%动作选择后多个时刻的交通流密度总和
densitySum2 = 0;
%动作选择后统计交通流密度的次数
densityNum2 = 0;

stepTime = 1;
TTCSum1 = 0;
TTCSum2 = 0;

%动作集
[limitSet,motionSet] = AgentActionDefine("tunnel");
% 根据不同的天气选择不同的Q表
[Qtable,Qtabledirection] = AgentQtableChoose_2248(vissimPathName,userWeatherChooseRL, 2);
% 根据不同的天气选择不同的驾驶行为
[CC0, CC1, CC2, CC3, CC4, CC5, CC6, CC7, CC8, CC9]...
    = DrivingBehaviorSettings(netDrivingBehaviorParSets, userWeatherChooseRL);

RealTimeTTC = zeros(evaluationTime,2);

while(stepTime <= evaluationTime)
    vissimSimulation.RunSingleStep;
    stepTimeMod = mod(stepTime,60);
    
    if(stepTime == 1)
        volume1 = 3000;
        vehicleInput1.set('AttValue', 'Volume',volume1);
    end
    
    
    %初始化PET、侵入时间统计数据
    %用于统计下个10秒的车辆数据
    if(stepTimeMod == 0 || stepTime == 1)
        %初试化PET统计数据
        TTCCounts = zeros(evaluationTime, 4);
        TTCCountNum = 1;
    end
    
    
    %%收集PET数据表
    if(stepTime >= 120 && stepTime <= 540 && stepTimeMod > 0 && stepTimeMod <= 10 )
        %采集路段密度信息
        density = AgentTrafficFlowInformationInLink_2248(netLinks, 2);
        densitySum1 = densitySum1 + density;
        densityNum1 = densityNum1 + 1;
        
        %获取车辆数据
        %上游
        invadeLine = 1000;
        vehicleData = CollectVehicleData_All_v3(netVehicles, stepTime, 1, 500, 1000);
        [vehiclesDataLane1, vehiclesDataLane2, vehiclesDataLane3]...
            = SortByLaneAndLinkcoord_v3(vehicleData,3);
        [TTCCounts,TTCCountNum] = CalculateTTCTimes_v3...
            (stepTime, TTCCounts,TTCCountNum,vehiclesDataLane1,vehiclesDataLane2,vehiclesDataLane3);
        
        
        %场景
        invadeLine = 1000;
        vehicleData = CollectVehicleData_All_v3(netVehicles, stepTime, 2, 0, 1000);
        [vehiclesDataLane1, vehiclesDataLane2, vehiclesDataLane3]...
            = SortByLaneAndLinkcoord_v3(vehicleData,4);
        [TTCCounts,TTCCountNum] = CalculateTTCTimes_v3...
            (stepTime, TTCCounts,TTCCountNum,vehiclesDataLane1,vehiclesDataLane2,vehiclesDataLane3);
        
        if(stepTimeMod == 10)
            tenSecondTTCSum = CountTTCSum_v3(TTCCounts, TTCCountNum);
            TTCSum1 = TTCSum1 + tenSecondTTCSum;
            RealTimeTTC(stepTime,:) = [stepTime, tenSecondTTCSum];
            
        end
        
    end
    
    
    if(stepTime == 540)
        %确定当前状态
        densityAverage1 = densitySum1 / densityNum1;
        state1 = AgentStateChoose(densityAverage1);
        action = ChooseMaxValueAction_Agent(Qtable,state1);
        [volumeLimit,speedLimit] = AgentActionChoose(action, limitSet, motionSet);
        
        
        %减速区域设置
        ReducedSpeedSettings(netReducedSpeedAreas,reducedSpeedAreasCount,speedLimit);
        AgentReducedSpeedSettingsForCLoseBridgeTunnel_2248(netReducedSpeedAreas,volumeLimit);
        
    end
    
    
    %%收集PET数据表
    if(stepTime >= 660 && stepTime < 1080 && stepTimeMod > 0 && stepTimeMod <= 10)
        %采集路段密度信息
        density = AgentTrafficFlowInformationInLink_2248(netLinks, 2);
        densitySum2 = densitySum2 + density;
        densityNum2 = densityNum2 + 1;
        
        
        
        %获取车辆数据
        %上游
        invadeLine = 1000;
        vehicleData = CollectVehicleData_All_v3(netVehicles, stepTime, 1, 500, 1000);
        [vehiclesDataLane1, vehiclesDataLane2, vehiclesDataLane3]...
            = SortByLaneAndLinkcoord_v3(vehicleData,3);
        [TTCCounts,TTCCountNum] = CalculateTTCTimes_v3...
            (stepTime, TTCCounts,TTCCountNum,vehiclesDataLane1,vehiclesDataLane2,vehiclesDataLane3);
        
        
        %场景
        invadeLine = 1000;
        vehicleData = CollectVehicleData_All_v3(netVehicles, stepTime, 2, 0, 1000);
        [vehiclesDataLane1, vehiclesDataLane2, vehiclesDataLane3]...
            = SortByLaneAndLinkcoord_v3(vehicleData,4);
        [TTCCounts,TTCCountNum] = CalculateTTCTimes_v3...
            (stepTime, TTCCounts,TTCCountNum,vehiclesDataLane1,vehiclesDataLane2,vehiclesDataLane3);
        
     
        if(stepTimeMod == 10)
            tenSecondTTCSum = CountTTCSum_v3(TTCCounts, TTCCountNum);
            TTCSum2 = TTCSum2 + tenSecondTTCSum;
            RealTimeTTC(stepTime,:) = [stepTime, tenSecondTTCSum];
            
        end
        
        
    end
    
    
    stepTime = stepTime + 1;
end
RealTimeTTC(all(RealTimeTTC == 0,2),:) = [];
vissimSimulation.Stop;




