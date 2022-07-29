%% 平均车流量
%linkEvaluation = (volume, linkCoordinate, density, average speed, time, link number, lane number)

function trafficFlow = TrafficFlowCalculate_Off(linkEvaluation)

    linkEvaluationNum = size(linkEvaluation,1);
    vehicleData = zeros(linkEvaluationNum,7);
    vehicleDataLabel = 1;


    %提取700m到900米之间的车辆数据
    for lei = 1 : linkEvaluationNum
        linkCoord = linkEvaluation(lei,2);
        %剔除linkcoord不在700米到900米之间的车辆数据
        if(~(linkCoord > 700 && linkCoord  < 900))
            continue;
        end
        %保存数据
        vehicleData(vehicleDataLabel,:) = linkEvaluation(lei,:);
        vehicleDataLabel = vehicleDataLabel + 1;
    end
    vehicleData(all(vehicleData == 0,2),:) = [];
    
    
    %求700m到800m的流量
    trafficFlowNumber = size(vehicleData,1);
    trafficFlow = zeros(trafficFlowNumber,2);
    trafficFlowLabel = 1;
    
    
    for tfi = 1 : 3 : trafficFlowNumber
       %三车道的流量流量累加
       trafficFlowSum = vehicleData(tfi,1) + vehicleData(tfi+1,1) + vehicleData(tfi+2,1);
       time = vehicleData(tfi,5);
       
       
       trafficFlow(trafficFlowLabel,1) = time;
       trafficFlow(trafficFlowLabel,2) = trafficFlowSum;
       trafficFlowLabel = trafficFlowLabel + 1;
    end
    
    
    trafficFlow(all(trafficFlow == 0,2), :) = [];
    
end