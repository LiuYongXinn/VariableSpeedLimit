%% 获取该路段的平均速度
% 输入
% netLinks          : VISSIM的Link接口 
% linkLocation      : 路段上要获取的位置
% 输出
% densitySum        : 该路段四车道的密度
%%
function averageSpeed = TrafficFlowSpeedInLink_v3(netLinks)
    

    speedTmp1 = 0;
    speedUpstreamLabel = 0;
    
    speedTmp2 = 0;
    speedSceneLabel = 0;
    
    speedTmp4 = 0;
    speedDownStreamLabel= 0;
    
    
    
    
    %上游密度数据
    linkLabel1 =  netLinks.GetLinkByNumber(1);
    link1LaneNum = linkLabel1.AttValue('NUMLANES');
    if(link1LaneNum ~= 0)
        for i = 1 : link1LaneNum
            %获取每一个车道的密度信息
            speed1 = linkLabel1.GetSegmentResult("speed",0,500,i);
            %若该车道收集到密度信息，则统计
            if(~(speed1 == 0))
                speedTmp1 = speedTmp1 + speed1;
                speedUpstreamLabel = speedUpstreamLabel + 1;
            end
        end
    end
    
    

    
    %场景区密度数据
    %1表示主干道
    linkLabel2 = netLinks.GetLinkByNumber(2);

    link2LaneNum = linkLabel2.AttValue('NUMLANES');   
    if(link2LaneNum ~= 0)
        for li = 1 : link2LaneNum
            %获取每一个车道的密度信息
            speed2 = linkLabel2.GetSegmentResult("SPEED",0,0,li);
            %若该车道收集到密度信息，则统计
            if(~(speed2 == 0))
                speedTmp2 = speedTmp2 + speed2;
                speedSceneLabel = speedSceneLabel + 1;
            end
        end
    end
    
    % 下游密度数据
    linkLabel4 = netLinks.GetLinkByNumber(4);

    link4LaneNum = linkLabel4.AttValue('NUMLANES');
    if(link4LaneNum ~= 0)
        for li = 1 : link4LaneNum
            %获取每一个车道的密度信息
            speed4 = linkLabel4.GetSegmentResult("speed",0,0,li);
            %若该车道收集到密度信息，则统计
            if(~(speed4 == 0))
                speedTmp4 = speedTmp4 + speed4;
                speedDownStreamLabel = speedDownStreamLabel + 1;
            end
        end
    end
    
    
    
    
 
    if(speedUpstreamLabel ~= 0)
        averagespeed1 = speedTmp1 / speedUpstreamLabel;
    else
        averagespeed1 = 0;
    end

    if(speedSceneLabel ~= 0)
        averagespeed2 = speedTmp2 / speedSceneLabel;
    else
        averagespeed2 = 0;
    end
    if(speedDownStreamLabel ~= 0)
        averagespeed4 = speedTmp4 / speedDownStreamLabel;
    else
        averagespeed4 = 0;
    end
    
    
    
    if(averagespeed1 ~= 0 || averagespeed2 ~= 0 || averagespeed4 ~= 0)
        averageSpeed = averagespeed1* 0.2 + averagespeed2 * 0.6 + averagespeed4 * 0.2;
    else
        averageSpeed = 0;
    end
    


end

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    