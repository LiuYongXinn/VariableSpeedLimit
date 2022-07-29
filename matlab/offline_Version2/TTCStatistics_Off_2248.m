%% 统计TTC的次数
% 输入
% Lane1Data     :车道1的TTC数据
% Lane2Data     :车道1的TTC数据
% Lane3Data     :车道1的TTC数据
% Lane4Data     :车道1的TTC数据
% 输出
% TTCStatistics : 当前路段的车道数据
%%
function TTCStatistics = TTCStatistics_Off_2248(lane1Data,lane2Data,lane3Data,lane4Data)

    %一车道的冲突次数统计
    [accidentTimes1, seriousTimes1, commonTimes1, slightTimes1] = oneLaneStatistic(lane1Data);
    %二车道的冲突次数统计
    [accidentTimes2, seriousTimes2, commonTimes2, slightTimes2] = oneLaneStatistic(lane2Data);
    %三车道的冲突次数统计
    [accidentTimes3, seriousTimes3, commonTimes3, slightTimes3] = oneLaneStatistic(lane3Data);
    %四车道的冲突次数统计
    [accidentTimes4, seriousTimes4, commonTimes4, slightTimes4] = oneLaneStatistic(lane4Data);

    %交通事故
    accidentTimes = accidentTimes1 + accidentTimes2 + accidentTimes3 + accidentTimes4;
    %严重冲突次数
    seriousTimes = seriousTimes1 + seriousTimes2 + seriousTimes3 + seriousTimes4;
    %一般冲突次数
    commonTimes = commonTimes1 + commonTimes2 + commonTimes3 + commonTimes4;
    %轻微冲突次数
    slightTimes = slightTimes1 + slightTimes2 + slightTimes3 + slightTimes4;
    
    
    TTCStatistics = [seriousTimes,commonTimes,slightTimes,accidentTimes];
end
 
%统计单车道的冲突次数
function [accidentTimes, seriousTimes, commonTimes, slightTimes] = oneLaneStatistic(laneData)
    laneNum = size(laneData,1);
    accidentTimes = 0;
    seriousTimes = 0;
    commonTimes = 0;
    slightTimes = 0;
    for lni = 1 : laneNum
        TTC = laneData(lni,3);
        if( TTC <= 0)
            accidentTimes = accidentTimes + 1;
        elseif(TTC > 0 && TTC <= 0.35)
            seriousTimes = seriousTimes + 1;
        elseif(TTC > 0.35 && TTC <= 1.08)
            commonTimes =  commonTimes + 1;
        elseif(TTC > 1.08 && TTC <= 4.14)
            slightTimes = slightTimes + 1;
        end
    end
%     for lni = 1 : laneNum
%         TTC = laneData(lni,3);
%         if( TTC <= 0)
%             accidentTimes = accidentTimes + 1;
%         elseif(TTC > 0 && TTC <= 1.35)
%             seriousTimes = seriousTimes + 1;
%         elseif(TTC > 0.1 && TTC <= 2.08)
%             commonTimes =  commonTimes + 1;
%         elseif(TTC > 0.2 && TTC <= 4.14)
%             slightTimes = slightTimes + 1;
%         end
%     end
end
