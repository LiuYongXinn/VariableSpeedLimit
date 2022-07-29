%% 三车道的平均速度、平均流量和平均密度
% 输入
% link : 所求的路段
% linkEvaluation : 路段上的数据
%  % linkEvaluation = [volume, denstiy, averageSpeed, simulationTime, laneNumber, ...
%   LinkNumber, SegmentStartCoordinate, SegmentEndCoordinate]
% 输出
% averageSpeed ：平均速度
%%
function [averageSpeed,trafficFlow,averageDensity] = SpeedVolumeDensityCalculate_Off_2248(linkEvaluation)
    lineNum =  size(linkEvaluation,1);
    rowNum = size(linkEvaluation,2);
    link2Data= zeros(lineNum,rowNum);
    link2Num = 1;
    %提取路段2的路网数据
    for lei = 1 : lineNum
        linkNumer = linkEvaluation(lei, 6);
        if(linkNumer ~= 2)
            continue;
        end
        linkCoord = linkEvaluation(lei, 7);
        if(linkCoord ~= 0)
            continue;
        end
        link2Data(link2Num, :) = linkEvaluation(lei,:);
        link2Num = link2Num + 1;
    end
    link2Num = link2Num - 1;
    link2Data(all(link2Data == 0,2), :) = [];

    %求路段的平均速度
    averageSpeedNumber = size(link2Data,1);
    averageSpeed = zeros(averageSpeedNumber, 2);
    averageSpeedLabel = 1;
    %路段的平均密度
    averageDensityNumber = size(link2Data,1);
    averageDensity = zeros(averageDensityNumber,2);
    averageDensityLabel = 1;
    %路段的流量
    trafficFlowNumber = size(link2Data,1);
    trafficFlow = zeros(trafficFlowNumber,2);
    trafficFlowLabel = 1;


    for asi = 1 : 4 :link2Num
        %时刻
        time = link2Data(asi,4);
        oneAverageSpeed = AverageSpeedCalculate(link2Data(asi,:),link2Data(asi+1,:),link2Data(asi+2,:),link2Data(asi+3,:));
        oneAverageDensity = DensityCalculate(link2Data(asi,:),link2Data(asi+1,:),link2Data(asi+2,:),link2Data(asi+3,:));
        trafficFlowSum = VolumeCalculate(link2Data(asi,:),link2Data(asi+1,:),link2Data(asi+2,:),link2Data(asi+3,:));
        
        
        %保存数据
        averageSpeed(averageSpeedLabel,1) = time;
        averageSpeed(averageSpeedLabel,2) = oneAverageSpeed;
        averageSpeedLabel = averageSpeedLabel + 1;
        
        averageDensity(averageDensityLabel,1) = time;
        averageDensity(averageDensityLabel,2) = oneAverageDensity;
        averageDensityLabel = averageDensityLabel + 1;
        
        trafficFlow(trafficFlowLabel,1) = time;
        trafficFlow(trafficFlowLabel,2) = trafficFlowSum;
        trafficFlowLabel = trafficFlowLabel + 1;
    end
    
    averageSpeed(all(averageSpeed == 0,2),:) = [];
    averageDensity(all(averageDensity == 0,2),:) = [];
    trafficFlow(all(trafficFlow == 0,2), :) = [];
end

%% 计算四个车道的平均速度
function averageSpeed = AverageSpeedCalculate(lane1Data,lane2Data,lane3Data,lane4Data)
    laneLabel = 0;
    speedSum = 0;
    %一车道速度
    if(lane1Data(1,3) ~= 0)
        speedSum = speedSum + lane1Data(1,3);
        laneLabel = laneLabel + 1;
    end
    %二车道速度
    if(lane2Data(1,3) ~= 0)
        speedSum = speedSum + lane2Data(1,3);
        laneLabel = laneLabel + 1;
    end
    %三车道速度
    if(lane3Data(1,3) ~= 0)
        speedSum = speedSum + lane3Data(1,3);
        laneLabel = laneLabel + 1;
    end
    %三车道速度
    if(lane4Data(1,3) ~= 0)
        speedSum = speedSum + lane4Data(1,3);
        laneLabel = laneLabel + 1;
    end
    
    %求平均速度
    if(laneLabel ~= 0)
       averageSpeed = speedSum / laneLabel;
    else
        averageSpeed = 0;
    end
end

%% 计算四个车道的平均密度
function density = DensityCalculate(lane1Data,lane2Data,lane3Data,lane4Data)
    laneLabel = 0;
    densitySum = 0;
    
    %一车道密度
    if(lane1Data(1,2) ~= 0)
        densitySum = densitySum + lane1Data(1,2);
        laneLabel = laneLabel + 1;
    end
    %二车道密度
    if(lane2Data(1,2) ~= 0)
        densitySum = densitySum + lane2Data(1,2);
        laneLabel = laneLabel + 1;
    end
    %三车道密度
    if(lane3Data(1,2) ~= 0)
        densitySum = densitySum + lane3Data(1,2);
        laneLabel = laneLabel + 1;
    end
    %四车道密度
    if(lane4Data(1,2) ~= 0)
        densitySum = densitySum + lane4Data(1,2);
        laneLabel = laneLabel + 1;
    end

    %求密度
    if(laneLabel ~= 0)
       density = densitySum / laneLabel;
    else
        density = 0;
    end
end

%% 计算四个车道的流量
function volume = VolumeCalculate(lane1Data,lane2Data,lane3Data,lane4Data)
    volume = lane1Data(1,1) + lane2Data(1,1) + lane3Data(1,1) + lane4Data(1,1);
end











