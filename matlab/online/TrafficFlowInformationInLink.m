%% 获取该路段的平均流量、平均密度和平均速度

function [trafficVolume, trafficVolumeSum, trafficVolumeSumNumber,...
          averageSpeed, averageSpeedSum, averageSpeedSumNumber]    = TrafficFlowInformationInLink(netLinks, step,linkLocation, ...
                                                                                                  trafficVolumeSum,trafficVolumeSumNumber,lastVolume,...
                                                                                                  averageSpeedSum, averageSpeedSumNumber, lastSpeed)
    %如果步长不为60的倍数，则不统计
    if(mod(step, 60) ~= 0)
        trafficVolume(1,1) = step;
        trafficVolume(1,2) = lastVolume(1,2);
        averageSpeed(1,1) =step;
        averageSpeed(1,2) = lastSpeed(1,2);
        
        return 
    end
    

    %1表示主干道
    linkLabel = netLinks.GetLinkByNumber(1);
    volumeTmp = 0;
    trafficVolume = zeros(1,2);
    
    speedTmp = 0;
    averageSpeed = zeros(1,2);
    %速度标志
    speedLabel = 3;
    
    %获取路段信息
    for li = 1 : 3      % 1-3车道

        %获取速度信息
        speed = linkLabel.GetSegmentResult("SPEED",0,linkLocation,li);
        speedTmp = speedTmp + speed;
        if(speed == 0)
            speedLabel = speedLabel - 1;
        end
        
        %获取流量信息
        volume = linkLabel.GetSegmentResult("VOLUME",0,linkLocation,li);
        volumeTmp = volumeTmp + volume;

    end
    
    %速度统计
    %如果有车道统计到速度数据，则求三车道的平均速度（若车道没有统计到车速，则忽略该车到）
    if(speedLabel ~= 0)
        speedTmp = speedTmp / speedLabel;
    end
    %保存速度
    averageSpeed(1,1) = step;
    averageSpeed(1,2) = speedTmp;

    %流量统计
    trafficVolume(1,1) = step;
    trafficVolume(1,2) = volumeTmp;

    trafficVolumeSum(trafficVolumeSumNumber,:) = trafficVolume;
    trafficVolumeSumNumber = trafficVolumeSumNumber + 1;
    averageSpeedSum(averageSpeedSumNumber,:) = averageSpeed;
    averageSpeedSumNumber = averageSpeedSumNumber + 1;
    
end