%% VISSIM连接和参数设置
function [vissim_com, vissimNet, vissimEvaluation, vissimSimulation,...
          netVehicleInputs, netDataCollections, netTravelTime, netDelay,...
          netQueueCounters, netDrivingBehaviorParSets, netReducedSpeedAreas,...
          netVehicles, netLinks]   =  VissimConnect(evaluationTime,vissimFileName,vissimPathName,vissimUnifiedName)
    %% vissim与matlab连接
    vissim_com=actxserver('VISSIM.vissim.430');
    %inpPwd = [pwd,'\test3.inp'];
    %iniPwd = [pwd,'\vissim.ini'];
    
    inpPwd = strcat(vissimPathName,vissimFileName);                         % modify on 2021-1-9
    iniPwd = strcat(vissimPathName,vissimUnifiedName,'.ini');               % modify on 2021-1-9
    vissim_com.LoadNet(inpPwd);
    vissim_com.LoadLayout(iniPwd);
    
    
    %% vissim二次开发COM接口
    vissimNet = vissim_com.Net;
    vissimEvaluation = vissim_com.Evaluation;
    vissimSimulation = vissim_com.Simulation;
    
    % 通行时间统计
    netTravelTime = vissimNet.TravelTimes;
    
    % 排队统计
    netQueueCounters = vissimNet.QueueCounters;
    
    % 减速带
    netReducedSpeedAreas = vissimNet.ReducedSpeedAreas;
    
    % 数据收集
    netDataCollections = vissimNet.DataCollections;
    
    % 延迟统计
    netDelay = vissimNet.Delays;
    
    % 设置车辆行为
    netDrivingBehaviorParSets = vissimNet.DrivingBehaviorParSets;
    
    % 车辆输入
    netVehicleInputs = vissimNet.VehicleInputs;

    % 车辆数据
    netVehicles = vissimNet.Vehicles;
    
    % 道路评价(add in 2021-12-24)
    netLinks = vissimNet.Links;
    
    

    %% 仿真参数设置
    periodTime = evaluationTime;
    vissimSimulation.set('Period',periodTime);
    newResolution = 1;
    vissimSimulation.set('Resolution',newResolution);
    newSpeed = 1;
    vissimSimulation.set('Speed',newSpeed);
    randSeed = randi(100);
    vissimSimulation.set('RandomSeed', randSeed);
    
    
    %% 评价指标
    
    %打开数据采集
    vissimEvaluation.set('AttValue','DATACOLLECTION',true);                    
    vissimEvaluation.DataCollectionEvaluation.set('AttValue','FILE',true);
    vissimEvaluation.DataCollectionEvaluation.set('AttValue','COMPILED',true);
    
    %打开行程时间
    vissimEvaluation.set('AttValue','TRAVELTIME',true);                        
    vissimEvaluation.TravelTimeEvaluation.set('AttValue','FILE',true);
    vissimEvaluation.TravelTimeEvaluation.set('AttValue','COMPILED',true);
    
    %打开排队长度
    vissimEvaluation.set('AttValue','QUEUECOUNTER',true);                      
    vissimEvaluation.QueueCounterEvaluation.set('AttValue','FILE',true);
    
    %打开延误
    vissimEvaluation.set('AttValue','DELAY',true);                             
    vissimEvaluation.DelayEvaluation.set('AttValue','FILE',true);
    vissimEvaluation.DelayEvaluation.set('AttValue','COMPILED',true);
    
    %打开车流记录
    vissimEvaluation.set('AttValue','VEHICLERECORD',true);         
    
    %打开路段评价(add in 2021-12-24)
    vissimEvaluation.set('AttValue','LINK',true);
    
    
end


