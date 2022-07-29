%设置减速区域开始时间
function SetStartTimeForReduceArea(netReducedSpeedAreas, startTime)
    rdACounts =  netReducedSpeedAreas.Count;
    
    for i = 1 : rdACounts
        reduceSpeedArea = netReducedSpeedAreas.GetReducedSpeedAreaByNumber(i);
        reduceSpeedArea.set('AttValue', 'TIMEFROM', startTime);
    end

end