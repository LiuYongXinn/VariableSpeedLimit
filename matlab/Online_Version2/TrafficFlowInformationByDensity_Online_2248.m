%% 获取该路段的平均密度
% 输入
% netLinks          : VISSIM的Link接口 
% linkLocation      : 路段上要获取的位置
% 输出
% densitySum        : 该路段四车道的密度
%%
function averageDensity = TrafficFlowInformationByDensity_Online_2248(netLinks,linkNum)
    %1表示主干道
    linkLabel = netLinks.GetLinkByNumber(linkNum);
    densityTmp = 0;
    densityLaneLabel = 0;
    
    for li = 1 : 4
        %获取每一个车道的密度信息
        density = linkLabel.GetSegmentResult("DENSITY",0,0,li);
        %若该车道收集到密度信息，则统计
        if(~(density == 0))
            densityTmp = densityTmp + density;
            densityLaneLabel = densityLaneLabel + 1;
        end
    end
    
    %如果有车道统计到密度信息，densitySum为n车道密度和/n车道；若路段没有统计到密度信息，则densitySum为0
    if(densityLaneLabel ~= 0)
        averageDensity = densityTmp / densityLaneLabel;
    else
        averageDensity = 0;
    end

end