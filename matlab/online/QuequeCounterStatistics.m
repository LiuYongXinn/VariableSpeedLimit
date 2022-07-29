%% 排队长度统计

function queueMean = QuequeCounterStatistics(netQueueCounters, queueCountersCount, step)
    queueMeanTemp = zeros(queueCountersCount,1);
    for qci = 1 : queueCountersCount
        queueCounterDot = netQueueCounters.GetQueueCounterByNumber(qci);
        % MEAN 平均排队长度    MAX 最大排队长度  NSTOPS 排队区域的停车次数
        queueMeanTemp(qci,1) = queueCounterDot.GetResult(step,'MEAN');
    end
    queueMean = queueMeanTemp;
    
end