%% 统计TTC的次数
% 输入
% Lane1Data     :车道1的TTC数据
% Lane2Data     :车道1的TTC数据
% Lane3Data     :车道1的TTC数据
% Lane4Data     :车道1的TTC数据
% 输出
% TTCStatistics : 当前路段的车道数据
%%
function TTCStatistics = AgentTTCStatisticsForThreeLane_2248(lane1Data,lane2Data,lane3Data)

    lane1Times = oneLaneStatistic(lane1Data);
    lane2Times = oneLaneStatistic(lane2Data);
    lane3Times = oneLaneStatistic(lane3Data);
    
    
    TTCStatistics = lane1Times + lane2Times + lane3Times;
end
%% 统计单车道的冲突次数
function times = oneLaneStatistic(laneData)
    laneNum = size(laneData,1);
    times = 0;
    for lni = 1 : laneNum
        TTC = laneData(lni,3);
        if(TTC < 4.14)
            times = times + 1;
        end
    end
end
