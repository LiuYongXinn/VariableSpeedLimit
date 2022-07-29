%% 场景TTC收集
function [TTCCounts, TTCCountNum] = CollectSceneTTC_v3(netVehicles, stepTime,TTCCounts,TTCCountNum)
    global invadeLine;
    
    %获取车辆数据
    %上游
    invadeLine = 1000;
    vehicleData = CollectVehicleData_All_v3(netVehicles, stepTime, 1, 500, 1000);
    [vehiclesDataLane1, vehiclesDataLane2, vehiclesDataLane3]...
        = SortByLaneAndLinkcoord_v3(vehicleData,3);
    [TTCCounts,TTCCountNum] = CalculateTTCTimes_v3...
        (stepTime, TTCCounts,TTCCountNum,vehiclesDataLane1,vehiclesDataLane2,vehiclesDataLane3);


    %场景
    invadeLine = 300;
    vehicleData = CollectVehicleData_All_v3(netVehicles, stepTime, 2, 0, 300);
    [vehiclesDataLane1, vehiclesDataLane2, vehiclesDataLane3,vehiclesDataLane4]...
        = SortByLaneAndLinkcoord_v3(vehicleData,4);
    [TTCCounts,TTCCountNum] = CalculateTTCTimes_v3...
        (stepTime, TTCCounts,TTCCountNum,vehiclesDataLane1,vehiclesDataLane2,vehiclesDataLane3,vehiclesDataLane4);


    %下游
    invadeLine = 100;
    vehicleData = CollectVehicleData_All_v3(netVehicles, stepTime, 4, 0, 100);
    [vehiclesDataLane1, vehiclesDataLane2, vehiclesDataLane3]...
        = SortByLaneAndLinkcoord_v3(vehicleData,3);
    [TTCCounts,TTCCountNum] = CalculateTTCTimes_v3...
        (stepTime, TTCCounts,TTCCountNum,vehiclesDataLane1,vehiclesDataLane2,vehiclesDataLane3);



end