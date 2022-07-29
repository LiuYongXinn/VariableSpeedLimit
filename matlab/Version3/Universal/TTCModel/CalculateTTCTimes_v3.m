%% TTC计算
function [TTCCounts,TTCCountNum] = CalculateTTCTimes_v3(stepTime, TTCCounts,TTCCountNum,vehiclesDataLane1,vehiclesDataLane2,vehiclesDataLane3,vehiclesDataLane4)
%一车道
[TTCCounts,TTCCountNum] = OnelaneTTCTimesCalculate_v3(stepTime, vehiclesDataLane1,TTCCounts,TTCCountNum);
%二车道
[TTCCounts,TTCCountNum] = OnelaneTTCTimesCalculate_v3(stepTime, vehiclesDataLane2,TTCCounts,TTCCountNum);

if(exist("vehiclesDataLane3","var"))
    [TTCCounts,TTCCountNum] = OnelaneTTCTimesCalculate_v3(stepTime, vehiclesDataLane3,TTCCounts,TTCCountNum);
end
if(exist("vehiclesDataLane4","var"))
    [TTCCounts,TTCCountNum] = OnelaneTTCTimesCalculate_v3(stepTime, vehiclesDataLane4,TTCCounts,TTCCountNum);
end

end
