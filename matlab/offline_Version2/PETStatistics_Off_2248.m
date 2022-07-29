%% PET次数统计
% 输入
% Lane1Data         ：车道1的车辆数据
% Lane2Data         ：车道2的车辆数据
% Lane3Data         ：车道3的车辆数据
% Lane4Data         ：车道4的车辆数据
%  PETData = [id1, id2, time, lane, twoVehiclePET]
% 输出
% PETStatistics     ：路段不同冲突的PET次数
%% 
function PETStatistics = PETStatistics_Off_2248(Lane1Data, Lane2Data, Lane3Data,Lane4Data)
    [accidentTimes1, seriousTimes1, commonTimes1, slightTimes1] = oneLanePETStatistic(Lane1Data);
    [accidentTimes2, seriousTimes2, commonTimes2, slightTimes2] = oneLanePETStatistic(Lane2Data);
    [accidentTimes3, seriousTimes3, commonTimes3, slightTimes3] = oneLanePETStatistic(Lane3Data);
    [accidentTimes4, seriousTimes4, commonTimes4, slightTimes4] = oneLanePETStatistic(Lane4Data);

    seriousTimes = seriousTimes1 + seriousTimes2 + seriousTimes3 + seriousTimes4;
    commonTimes = commonTimes1 + commonTimes2 + commonTimes3 + commonTimes4;
    slightTimes = slightTimes1 + slightTimes2 + slightTimes3 + slightTimes4;
    accidentTimes = accidentTimes1 + accidentTimes2 + accidentTimes3 + accidentTimes4;
    
    PETStatistics = [seriousTimes,commonTimes,slightTimes,accidentTimes];

end

%% 单一车道的PET统计
function [accidentTimes, seriousTimes, commonTimes, slightTimes] = oneLanePETStatistic(LaneData)
    %交通事故
    accidentTimes = 0;
    %严重冲突
    seriousTimes = 0;
    %一般冲突
    commonTimes = 0;
    %轻微冲突
    slightTimes = 0;
    
    laneNum = size(LaneData,1);
    for lni = 1 : laneNum
        PET = LaneData(lni,5);
        if( PET <= 0)
            accidentTimes = accidentTimes + 1;
        elseif(PET > 0 && PET <= 1.35)
            seriousTimes = seriousTimes + 1;
        elseif(PET > 1.35 && PET <= 2.08)
            commonTimes =  commonTimes + 1;
        elseif(PET > 2.08 && PET <= 4.14)
            slightTimes = slightTimes + 1;
        end
    end
end

