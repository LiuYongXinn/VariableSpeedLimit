%% 流量密度、流量速度图
% 输入
% trafficFlow           ：平均流量
% averageDensity        ：平均密度
% speed                 ：平均速度
% 输出
% trafficFlowDensity    ：流量密度
% trafficFlowSpeed      ：流量速度
%%
function [trafficFlowDensity, trafficFlowSpeed] = TrafficFlowAndDensity_Off_2248(trafficFlow, averageDensity,averageSpeed)
lineNum = size(trafficFlow,1);
trafficFlowDensity = zeros(lineNum,3);
trafficFlowSpeed = zeros(lineNum, 3);

for lni = 1 : lineNum
    %流量密度
    trafficFlowDensity(lni,1) = trafficFlow(lni,1);
    trafficFlowDensity(lni,2) = trafficFlow(lni,2);
    trafficFlowDensity(lni,3) = averageDensity(lni,2);
    
    %流量速度
    trafficFlowSpeed(lni,1) = trafficFlow(lni,1);
    trafficFlowSpeed(lni,2) = trafficFlow(lni,2);
    trafficFlowSpeed(lni,3) = averageSpeed(lni,2);
    
end

trafficFlowDensity(all(trafficFlowDensity == 0,2),:) = [];
trafficFlowSpeed(all(trafficFlowSpeed == 0,2), :) = [];
end