%% DOCUMENT TITLE
% 计算整个仿真过程中，施加控制后的平均速度和平均密度

%%
function [averageSpeed, averageDensity] = AgentAverageSpeedFLowCalculate(linkEvaluation)

    %提取900-1200秒的车辆数据
    linkEvaluationNum = size(linkEvaluation,1);
    vehicleDataByTime = zeros(linkEvaluationNum, 7);
    vdtLabel = 1;
    for lei = 1 : linkEvaluationNum
        simulationTime = linkEvaluation(lei,5);
        
        if(~(simulationTime >= 900 && simulationTime <= 1200))
            continue;
        end
        
        vehicleDataByTime(vdtLabel, :) = linkEvaluation(lei, :);
        vdtLabel = vdtLabel + 1;
    end
    vehicleDataByTime(all(vehicleDataByTime == 0,2),:) = [];
    
    
    %提取 700 到 900 米之间的车辆数据
    vdTimeNum = size(vehicleDataByTime,1);
    vehicleData = zeros(vdTimeNum, 7);
    vdLabel = 1;
    
    for dti = 1 : vdTimeNum
       linkCoord = vehicleDataByTime(dti, 2);
        
       if(~(linkCoord > 700 && linkCoord < 900))
           continue;
       end
       
       vehicleData(vdLabel,:) = vehicleDataByTime(dti, :);
       vdLabel = vdLabel + 1;
    end
    vehicleData(all(vehicleData == 0, 2), : ) = [];
    
    %统计本次仿真的平均速度和平均密度
    vehicleDataLabel = size(vehicleData, 1);
    averageSpeedSum = 0;
    aveSLabel = 0;
    averageDensitySum = 0;
    aveDLabel = 0;
    
    %平均速度、平均密度的累加
    for vdj = 1 : vehicleDataLabel
        oneSpeed = vehicleData(vdj,4);
        oneDensity = vehicleData(vdj,3);
        %去除速度为0的数据
        if(oneSpeed ~= 0)
            averageSpeedSum = averageSpeedSum + oneSpeed;
            aveSLabel = aveSLabel + 1;
        end
        %去除密度为0的数据
        if (oneDensity ~= 0)
            averageDensitySum = averageDensitySum + oneDensity;
            aveDLabel = aveDLabel + 1; 
        end
    end
    
    %平均速度和平均密度
    averageSpeed = averageSpeedSum / aveSLabel;
    averageDensity = averageDensitySum / aveDLabel;

end