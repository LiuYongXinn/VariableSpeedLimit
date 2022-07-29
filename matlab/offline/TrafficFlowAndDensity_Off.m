%% 流量密度图

function trafficFlowDensity = TrafficFlowAndDensity_Off(trafficFlow, averageDensity)
    lineNum = size(trafficFlow,1);
    trafficFlowDensity = zeros(lineNum,3);
    
    for lni = 1 : lineNum
        trafficFlowDensity(lni,1) = trafficFlow(lni,1);
        trafficFlowDensity(lni,2) = trafficFlow(lni,2);
        trafficFlowDensity(lni,3) = averageDensity(lni,2);
    end

    trafficFlowDensity(all(trafficFlowDensity == 0,2),:) = [];
end