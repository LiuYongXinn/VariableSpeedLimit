%% 车道上车辆的平均速度

function speedAverage = LaneAvreageSpeed(dataCollections,dataCollectionsCount)
    speedSum = 0;
    speedNumber = 0;
    %累加每个车道的车速
    for smi = 1 : dataCollectionsCount
        %如果该车道收集到车辆信息，则记录
        if( dataCollections(smi,3) ~= 0)
            speedSum = speedSum + dataCollections(smi,3);
            speedNumber = speedNumber + 1;
        end
    end
    %如果有车道统计到车辆信息，则求平均速度
    if(speedNumber ~= 0)
        speedAverage = speedSum / speedNumber;
    %如果没有车道统计到车辆信息，则返回0
    elseif(speedNumber == 0)
        speedAverage = 0;
    end

    
end