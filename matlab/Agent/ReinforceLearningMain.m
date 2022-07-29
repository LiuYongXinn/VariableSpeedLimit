%%强化学习主函数
function ReinforceLearningMain...
    (vissimFileName,vissimPathName,vissimUnifiedName,userWeatherChooseRL)

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
    invadeLine = 880;
    


%% 强化学习参数设置
    %训练次数
     trainTimes = 1000;
    % 学习率
    learningRate = 0.8;
    %折扣率
    discountFactor = 0.8;   
    % 根据不同的天气选择不同的Q表
    [Qtable,Qtabledirection] = AgentQtableChoose(vissimPathName,userWeatherChooseRL);

%% 主循环
    for tti = 1 : trainTimes
        %% 车流量设置和减速区域设置
        %设置车流量
        volume1 = 0;
        volume2 = 0;
        %设置主干道车流量
        vehicleInput1 = vnet.VehicleInputs.GetVehicleInputByNumber(1);
        vehicleInput1.set('AttValue', 'Volume',volume1);
        vehicleInput1.set('AttValue', 'TIMEUNTIL',evaluationTime);
        %设置匝道车流量
        vehicleInput2 = vnet.VehicleInputs.GetVehicleInputByNumber(2);
        vehicleInput2.set('AttValue', 'Volume',volume2);
        vehicleInput2.set('AttValue', 'TIMEUNTIL',evaluationTime);
        
        %减速区域设置
        reducedSpeed = 120;
        ReducedSpeedSettings(netReducedSpeedAreas,reducedSpeedAreasCount,reducedSpeed);
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
        %车辆越过侵入线的时刻
        invadeTimeLane1 = zeros(evaluationTime*1000,3);
        invadeTimeLane1Number = 1;
        invadeTimeLane2 = zeros(evaluationTime*1000,3);
        invadeTimeLane2Number = 1;
        invadeTimeLane3 = zeros(evaluationTime*1000,3);
        invadeTimeLane3Number = 1;
        
        %每时刻获取到的车辆数，用于PET                       add in 2021-12-26
        allStepVehiclePETNumber = zeros(3,evaluationTime);
       
        %越过侵入线的起始车辆数
        %车道1
        invadeTimeNumber1 = 0;
        %车道1
        invadeTimeNumber2 = 0;
        %车道1
        invadeTimeNumber3 = 0;
        
        %在线PET数据
        PETSum1 = zeros(evaluationTime*1000,4);
        PETSumNumber1 = 1;
        PETTimesSum1 = 0;
        PETSum2 = zeros(evaluationTime*1000,4);
        PETSumNumber2 = 1;
        PETTimesSum2 = 0;
        
        %在线TTC数据
        TTCSum = zeros(evaluationTime*1000,4);
        TTCSumNumber = 1;
        TTCTimseSum = 0;

        while step <= evaluationTime
            %% 设置随机车流量，用于获取不同的交通流密度
            if (step == 1)
               volume1 = randi(40)*100;
               volume2 = randi(20)*100;
               vehicleInput1.set('AttValue', 'Volume',volume1); 
               vehicleInput2.set('AttValue', 'Volume',volume2);
            end

            %% 300秒到600秒之间，收集路段信息
            if(step >= 300 && step < 600 && mod(step,60) == 0)
                %采集路段密度信息
                density = AgentTrafficFlowInformationInLink(netLinks,900);
                densitySum1 = densitySum1 + density;
                densityNum1 = densityNum1 + 1;

                %车辆数据采集
                vehicleData = RealTimeVehicleData(netVehicles,step);
                
                %% 收集PET数据
                % 车辆按车道和位置进行分类(用于PET计算)
                [vehicleDataLane1PET, vehicleDataLane2PET, vehicleDataLane3PET]...
                    = SortByLaneAndLinkCoord(vehicleData, 880, 910);
                % 1车道PET计算
                vehicleDataLane1PETNum = size(vehicleDataLane1PET,1);
                allStepVehiclePETNumber(1,step) = vehicleDataLane1PETNum;                % add in 2021-12-26
                %排序
                if(vehicleDataLane1PETNum >1)
                    vehicleDataSort = VehicleLaneSort(vehicleDataLane1PET);
                    vehicleDataLane1PET = vehicleDataSort;
                end
                %计算PET
                if(vehicleDataLane1PETNum ~= 0)
                    % modify on 2022-1-4
                    [invadeTimeLane1Number, invadeTimeLane1, invadeTimeNumber1,PETSum1, PETSumNumber1]...
                        = CalculatePET(vehicleDataLane1PET, invadeTimeLane1Number, invadeTimeLane1, invadeTimeNumber1, PETSum1, PETSumNumber1, step, allStepVehiclePETNumber,1);
                end

                % 2车道PET计算
                vehicleDataLane2PETNum = size(vehicleDataLane2PET,1);
                allStepVehiclePETNumber(2,step) = vehicleDataLane2PETNum;                % add in 2021-12-26
                %排序
                if(vehicleDataLane2PETNum >1)
                    vehicleDataSort = VehicleLaneSort(vehicleDataLane2PET);
                    vehicleDataLane2PET = vehicleDataSort;
                end
                %计算PET
                if(vehicleDataLane2PETNum ~= 0)
                    [invadeTimeLane2Number, invadeTimeLane2, invadeTimeNumber2,PETSum1, PETSumNumber1]...
                        = CalculatePET(vehicleDataLane2PET, invadeTimeLane2Number, invadeTimeLane2, invadeTimeNumber2, PETSum1, PETSumNumber1, step, allStepVehiclePETNumber,2);
                end


                % 3车道PET计算
                vehicleDataLane3PETNum = size(vehicleDataLane3PET,1);
                allStepVehiclePETNumber(3,step) = vehicleDataLane3PETNum;                % add in 2021-12-26
                %排序
                if(vehicleDataLane3PETNum >1)
                    vehicleDataSort = VehicleLaneSort(vehicleDataLane3PET);
                    vehicleDataLane3PET = vehicleDataSort;
                end
                %计算PET
                if(vehicleDataLane3PETNum ~= 0)
                    [invadeTimeLane3Number, invadeTimeLane3, invadeTimeNumber3,PETSum1, PETSumNumber1]...
                        = CalculatePET(vehicleDataLane3PET, invadeTimeLane3Number, invadeTimeLane3, invadeTimeNumber3, PETSum1, PETSumNumber1, step, allStepVehiclePETNumber,3);
                end
                %统计PET超过阈值的次数
                if((vehicleDataLane1PETNum + vehicleDataLane2PETNum + vehicleDataLane3PETNum) ~= 0)
                    PETTimes = OverValueTime(PETSum1,PETSumNumber1,step,1);
                else
                    PETTimes = 0;
                end

                PETTimesSum1 = PETTimesSum1 + PETTimes;                
            end
            
            
            %% 600秒时进行限速控制
            if(step == 600)
                
                %确定当前状态
                densityAverage1 = densitySum1 / densityNum1;
                state1 = AgentStateChoose(densityAverage1);
                
                %基于softmax模型进行动作选择
                action = Agent_ActionChosseBySoftMax(Qtable, state1, 100);

                speedLimit = AgentActionChoose(action);
                
                %减速区域设置
                ReducedSpeedSettings(netReducedSpeedAreas,reducedSpeedAreasCount,speedLimit);
                
            end
%                         %选择限速值(探索和利用可以优化)
%                         if rand > explorationRate
%                             [~,action] = max(Qtable(state,:));
%                         else
%                             action = randi(size(Qtable,2));
%                         end
%             
            %% 900秒到1200秒，收集限速后的路段信息
            if(step >= 900 && step < 1200 && mod(step,60) == 0)
                %采集路段密度信息
                density = AgentTrafficFlowInformationInLink(netLinks,900);
                densitySum2 = densitySum2 + density;
                densityNum2 = densityNum2 + 1;
                
                %车辆数据采集
                vehicleData = RealTimeVehicleData(netVehicles,step);
                % 车辆按车道和位置进行分类(用于PET计算)
                [vehicleDataLane1PET, vehicleDataLane2PET, vehicleDataLane3PET]...
                    = SortByLaneAndLinkCoord(vehicleData, 880, 910);
                
                %PET计算
                % 1车道PET计算
                vehicleDataLane1PETNum = size(vehicleDataLane1PET,1);
                allStepVehiclePETNumber(1,step) = vehicleDataLane1PETNum;                % add in 2021-12-26
                %排序
                if(vehicleDataLane1PETNum >1)
                    vehicleDataSort = VehicleLaneSort(vehicleDataLane1PET);
                    vehicleDataLane1PET = vehicleDataSort;
                end
                %计算PET
                if(vehicleDataLane1PETNum ~= 0)
                    % modify on 2022-1-4
                    [invadeTimeLane1Number, invadeTimeLane1, invadeTimeNumber1,PETSum, PETSumNumber]...
                        = CalculatePET(vehicleDataLane1PET, invadeTimeLane1Number, invadeTimeLane1, invadeTimeNumber1, PETSum, PETSumNumber, step, allStepVehiclePETNumber,1);
                end
                
                
                % 2车道PET计算
                vehicleDataLane2PETNum = size(vehicleDataLane2PET,1);
                allStepVehiclePETNumber(2,step) = vehicleDataLane2PETNum;                % add in 2021-12-26
                %排序
                if(vehicleDataLane2PETNum >1)
                    vehicleDataSort = VehicleLaneSort(vehicleDataLane2PET);
                    vehicleDataLane2PET = vehicleDataSort;
                end
                %计算PET
                if(vehicleDataLane2PETNum ~= 0)
                    [invadeTimeLane2Number, invadeTimeLane2, invadeTimeNumber2,PETSum, PETSumNumber]...
                        = CalculatePET(vehicleDataLane2PET, invadeTimeLane2Number, invadeTimeLane2, invadeTimeNumber2, PETSum, PETSumNumber, step, allStepVehiclePETNumber,2);
                end
                
                
                % 3车道PET计算
                vehicleDataLane3PETNum = size(vehicleDataLane3PET,1);
                allStepVehiclePETNumber(3,step) = vehicleDataLane3PETNum;                % add in 2021-12-26
                %排序
                if(vehicleDataLane3PETNum >1)
                    vehicleDataSort = VehicleLaneSort(vehicleDataLane3PET);
                    vehicleDataLane3PET = vehicleDataSort;
                end
                %计算PET
                if(vehicleDataLane3PETNum ~= 0)
                    [invadeTimeLane3Number, invadeTimeLane3, invadeTimeNumber3,PETSum, PETSumNumber]...
                        = CalculatePET(vehicleDataLane3PET, invadeTimeLane3Number, invadeTimeLane3, invadeTimeNumber3, PETSum, PETSumNumber, step, allStepVehiclePETNumber,3);
                end
                %统计PET超过阈值的次数
                if((vehicleDataLane1PETNum + vehicleDataLane2PETNum + vehicleDataLane3PETNum) ~= 0)
                    PETTimes = OverValueTime(PETSum2,PETSumNumber2,step,1);
                else
                    PETTimes = 0;
                end
                
                PETTimesSum2 = PETTimesSum2 + PETTimes;
                
              %% 收集TTC数据
                %收集路网上车辆数据，用于TTC
                
                [vehicleDataLane1TTC, vehicleDataLane2TTC, vehicleDataLane3TTC]= SortByLaneAndLinkCoord(vehicleData, 700, 880);
                %车道1TTC计算
                vehicleDataLane1TTCNumber = size(vehicleDataLane1TTC,1);
                %对收集到的车辆进行排序
                if vehicleDataLane1TTCNumber > 1
                    vehicleDataSort =  VehicleLaneSort(vehicleDataLane1TTC);
                    vehicleDataLane1TTC = vehicleDataSort;
                    %计算TTC
                    [TTCSum, TTCSumNumber] = CalculateTTC(TTCSum,TTCSumNumber,vehicleDataLane1TTC,step);
                end
                
                %车道2TTC计算
                vehicleDataLane2TTCNumber = size(vehicleDataLane2TTC,1);
                %对收集到的车辆进行排序
                if vehicleDataLane2TTCNumber > 1
                    vehicleDataSort =  VehicleLaneSort(vehicleDataLane2TTC);
                    vehicleDataLane2TTC = vehicleDataSort;
                    %计算TTC
                    [TTCSum, TTCSumNumber] = CalculateTTC(TTCSum,TTCSumNumber,vehicleDataLane2TTC,step);
                end
                
                %车道3TTC计算
                vehicleDataLane3TTCNumber = size(vehicleDataLane3TTC,1);
                %对收集到的车辆进行排序
                if vehicleDataLane3TTCNumber > 1
                    vehicleDataSort =  VehicleLaneSort(vehicleDataLane3TTC);
                    vehicleDataLane3TTC = vehicleDataSort;
                    %计算TTC
                    [TTCSum, TTCSumNumber] = CalculateTTC(TTCSum,TTCSumNumber,vehicleDataLane3TTC,step);
                end
                
                %统计TTC超过阈值的次数
                if((vehicleDataLane1TTCNumber + vehicleDataLane2TTCNumber + vehicleDataLane3TTCNumber) ~= 0)
                    TTCTimes = OverValueTime(TTCSum,TTCSumNumber,step,-1);
                else
                    TTCTimes = 0;
                end
                TTCTimseSum = TTCTimseSum + TTCTimes;

            end
            
            %更新Q表
            if (step == 1200)
                %确定当前状态
                densityAverage2 = densitySum2 / densityNum2;
                state2 = AgentStateChoose(densityAverage2);
                
                %根据事故风险设置reward
                reward = agentRewardChoose(PETTimesSum1,PETTimesSum2, densityAverage2);
                
                %更新Q表
                Qtable(state1,action) = Qtable(state1,action) + ...
                    learningRate*(reward + discountFactor * max(Qtable(state2,:)) - Qtable(state1,action));
            end
            
            %区间进行到1500秒时，清空输入的车流量
            if(step == 1200)
                volume1 = 0;
                volume2 = 0;
                vehicleInput1.set('AttValue', 'Volume',volume1);
                vehicleInput2.set('AttValue', 'Volume',volume2);
            end
            
           step = step + 1;
        end
        vissimSimulation.Stop;
        %保存Q表
        AgentSaveQtable(Qtabledirection,Qtable);
        
        
        %% 修改与3.30
        if(mod(tti,100) == 0)
            %作PET图；
            
            %作TTC图；
            
        end
        
        
    end
end













































