%% 旅行时间和车辆数统计

function travelTime = TravelTimeStatistics(netTravelTime,travelTimeCount, step)
    travelTimeTemp = zeros(travelTimeCount,2);
    
    for tti = 1 : travelTimeCount
        dot = netTravelTime.GetTravelTimeByNumber(1);

         %行程时间检测
        travelTime = dot.GetResult(step,"TRAVELTIME","",0);
        travelTimeTemp(tti,1) = travelTime;
        %通过的车辆数检测
        vehicleNumber = dot.GetResult(step,"NVEHICLES","",0);  
        travelTimeTemp(tti,2) = vehicleNumber;
    end
    travelTime = travelTimeTemp;
    
end