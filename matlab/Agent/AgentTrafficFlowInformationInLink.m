%% 获取该路段的平均密度
function densitySum = AgentTrafficFlowInformationInLink(netLinks,linkLocation)
    %1表示主干道
    linkLabel = netLinks.GetLinkByNumber(1);
    densityTmp = 0;
    densityLaneLabel = 0;
    
    for li = 1 : 3
        %获取每一个车道的密度信息
        density = linkLabel.GetSegmentResult("DENSITY",0,linkLocation,li);
        %若该车道收集到密度信息，则统计
        if(~(density == 0))
            densityTmp = densityTmp + density;
            densityLaneLabel = densityLaneLabel + 1;
        end
    end
    
    %如果有车道统计到密度信息，densitySum为n车道密度和/n车道；若路段没有统计到密度信息，则densitySum为0
    if(densityLaneLabel ~= 0)
        densitySum = densityTmp / densityLaneLabel;
    else
        densitySum = 0;
    end

end