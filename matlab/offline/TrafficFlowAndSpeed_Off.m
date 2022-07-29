%% 流量速度关系
%trafficeFlow = (time,trafficFlow)
%averageSpeed = (time, averageSpeed)

function trafficFlowSpeed = TrafficFlowAndSpeed_Off(trafficFlow, averageSpeed)
    lineNum = size(trafficFlow,1);
    trafficFlowSpeed = zeros(lineNum,3);
    
    for lni = 1 : lineNum
        trafficFlowSpeed(lni,1) = trafficFlow(lni,1);
        trafficFlowSpeed(lni,2) = trafficFlow(lni,2);
        trafficFlowSpeed(lni,3) = averageSpeed(lni,2);
    end

    trafficFlowSpeed(all(trafficFlowSpeed == 0,2),:) = [];
    
end