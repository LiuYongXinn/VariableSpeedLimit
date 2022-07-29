%设定时间内的次数或
% PeriodTimeStatistics(queueMean(1,1), travelTimes(1,1), averageSpeed,TTCTimes,PETTimes)
function PeriodTimeStatistics(queueMean, travelTime, TTCTimes, PETTimes)
    %% 汇总每60秒的数据
    global label;
    global PETTimesTmp PETTimesSum;
    global TTCTimesTmp TTCTimesSum;
    global queueLengthTmp queueLengthSum queueLengthLabel;
    global travelTimeTmp travelTimeSum travelTimeLabel;

    %PET次数统计
    PETTimesTmp = PETTimesTmp + PETTimes;
    
    %TTC次数统计
    TTCTimesTmp = TTCTimesTmp + TTCTimes;
    
    %排队长度统计
    queueLengthTmp = queueLengthTmp + queueMean;
    %该时刻获取到排队长度的信息
    if(queueMean ~= 0)
        queueLengthLabel = queueLengthLabel + 1;
    end
    
    %旅行时间统计
    travelTimeTmp = travelTimeTmp + travelTime;
    %该时刻获取到旅行时间的信息
    if(travelTime ~= 0)
        travelTimeLabel = travelTimeLabel + 1;
    end
    
    %统计次数标志
    label = label + 1;
    
    
    %% 统计次数到60次时
    if(label == 60)
        label = 0;
        
        PETTimesSum = PETTimesTmp;
        PETTimesTmp = 0;
        
        TTCTimesSum = TTCTimesTmp;
        TTCTimesTmp = 0;
        
        if(queueLengthLabel == 0)
            queueLengthSum = 0;
        else
            queueLengthSum = queueLengthTmp / queueLengthLabel;
        end
        queueLengthTmp = 0;

        if(travelTimeLabel == 0)
           travelTimeSum = 0;
        else
            travelTimeSum = travelTimeTmp / travelTimeLabel;
        end
        travelTimeTmp = 0;
 
    end


end






























