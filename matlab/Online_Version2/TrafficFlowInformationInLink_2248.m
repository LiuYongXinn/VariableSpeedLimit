%% 获取该路段的平均流量、平均密度和平均速度
% 输入
% netLinks                  : VISSIM的COM接口，提取路段信息
% linkNum                   : 哪个路段
% step                      : 仿真时刻
% trafficVolumeSum          : 所有时刻的流量
% trafficVolumeSumNumber    : 流量总和标签
% lastVolume                : 上一秒的流量
% averageSpeedSum           : 所有时刻的平均速度
% averageSpeedSumNumber     : 平均速度标签
% lastSpeed                 : 上一秒的平均速度
%  
% 输出
% trafficVolume             ：当前时刻的交通流量
% trafficVolumeSum          ：当前时刻及之前的流量
% trafficVolumeSumNumber    ：流量总和标签
% averageSpeed              ：当前时刻的平均速度
% averageSpeedSum           ：当前时刻及之前的平均速度
% averageSpeedSumNumber     ：平均速度标签
%
%说明
% TODO ：主函数将流量速度总和声明为全局变量


%%
function [trafficVolume,averageSpeed]= TrafficFlowInformationInLink_2248...
    (netLinks, step,lastVolume,lastSpeed,linkNum)

    global averageSpeedSum averageSpeedSumNumber trafficVolumeSum trafficVolumeSumNumber    

    %步长不为60的倍数，不统计
    if(mod(step, 60)~= 0)
        trafficVolume(1,1) = step;
        trafficVolume(1,2) = lastVolume(1,2);
        averageSpeed(1,1) =step;
        averageSpeed(1,2) = lastSpeed(1,2);
        return
    end
    
    %获取该linkNum路段的接口
    linkLabel = netLinks.GetLinkByNumber(linkNum);
    
    
    volumeTmp = 0;
    trafficVolume = zeros(1,2);
    speedTmp = 0;
    averageSpeed = zeros(1,2);
    
    %速度标志
    speedLabel = 4;
    
    %获取路段上四个车道的车辆信息
    for li = 1 : 4
        %平均速度信息
        speed = linkLabel.GetSegmentResult("SPEED",0,0,li);
        speedTmp = speedTmp + speed;
        if(speed == 0)
            speedLabel = speedLabel - 1;
        end
        
        %获取流量信息
        volume = linkLabel.GetSegmentResult("VOLUME",0,0,li);
        volumeTmp = volumeTmp + volume;
        
        
        
    end
    
    %速度统计
    %如果有车道统计到速度数据，则求三车道的平均速度（若车道没有统计到车速，则忽略该车道）
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
