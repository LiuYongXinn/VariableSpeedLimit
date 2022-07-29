%% 获取该路段的平均密度
% 输入
% netLinks          : VISSIM的Link接口 
% linkLocation      : 路段上要获取的位置
% 输出
% densitySum        : 该路段四车道的密度
%%
function averageDensity = AgentTrafficFlowInformationInLink_2248(netLinks,linkNum)


    linkLabel1 =  netLinks.GetLinkByNumber(1);
    link1LaneNum = linkLabel1.AttValue('NUMLANES');
    linkLabel2 = netLinks.GetLinkByNumber(2);
    link2LaneNum = linkLabel2.AttValue('NUMLANES');
    
    laneNums = link1LaneNum+link2LaneNum;
    densityTmp = zeros(laneNums,1);
    dtNum = 1;

    

    %上游密度数据
    if(link1LaneNum ~= 0)
        for i = 1 : link1LaneNum
            %获取每一个车道的密度信息
            density1 = linkLabel1.GetSegmentResult("DENSITY",0,0,i);
            densityTmp(dtNum,1) = density1;
            dtNum = dtNum + 1;
        end
    end
    
    
    %场景区密度数据
    %1表示主干道


  
    if(link2LaneNum ~= 0)
        for li = 1 : link2LaneNum
            %获取每一个车道的密度信息
            density2 = linkLabel2.GetSegmentResult("DENSITY",0,0,li);
            %若该车道收集到密度信息，则统计
            densityTmp(dtNum,1) = density2;
            dtNum = dtNum + 1;
        end
    end
    
    
    maxDensity = densityTmp(1,1);
    for i = 2 : laneNums
        if(densityTmp(i,1) > maxDensity)
            maxDensity = densityTmp(i,1);
        end
    end
    
    averageDensity = maxDensity;
    
%     %如果有车道统计到密度信息，densitySum为n车道密度和/n车道；若路段没有统计到密度信息，则densitySum为0
%     if(densityLabel ~= 0)
%         averageDensity1 = densityTmp1 / densityLabel;
%     else
%         averageDensity1 = 0;
%     end
% 
%     if(densitySceneLabel ~= 0)
%         averageDensity2 = densityTmp2 / densitySceneLabel;
%     else
%         averageDensity2 = 0;
%     end
%     if(densityDownStreamLabel ~= 0)
%         averageDensity4 = densityTmp4 / densityDownStreamLabel;
%     else
%         averageDensity4 = 0;
%     end
%     
%     
%    densityMax = max(averageDensity1, averageDensity2);
%    averageDensity = max(averageDensity4, densityMax);
%     


end

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    