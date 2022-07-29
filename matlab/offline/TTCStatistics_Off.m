%% TTC次数统计
% TTC = (ID1, ID2, oneVehicleTTC, time, lane)

function TTCStatistics = TTCStatistics_Off(Lane1Data,Lane2Data,Lane3Data)
    lane1Num = size(Lane1Data,1);
    lane2Num = size(Lane2Data,1);
    lane3Num = size(Lane3Data,1);
    
    seriousTimes = 0;
    commonTimes = 0;
    slightTimes = 0;
    accidentTimes = 0;
        
%      for lni = 1 : lane1Num
%         TTC = Lane1Data(lni,3);
%         if( TTC <= 0)
%             accidentTimes = accidentTimes + 1;
%         elseif(TTC > 0 && TTC <= 1.35)
%             seriousTimes = seriousTimes + 1;
%         elseif(TTC > 1.35 && TTC <= 2.08)
%             commonTimes =  commonTimes + 1;
%         elseif(TTC > 2.08 && TTC <= 4.14)
%             slightTimes = slightTimes + 1;
%         end
%     end
%     
    

    %统计1车道
    for lni = 1 : lane1Num
        TTC = Lane1Data(lni,3);
        if( TTC <= 0)
            accidentTimes = accidentTimes + 1;
        elseif(TTC > 0 && TTC <= 0.1)
            seriousTimes = seriousTimes + 1;
        elseif(TTC > 0.1 && TTC <= 0.2)
            commonTimes =  commonTimes + 1;
        elseif(TTC > 0.2 && TTC <= 0.3)
            slightTimes = slightTimes + 1;
        end
    end
    
    %统计2车道
    for lni = 1 : lane2Num
        TTC = Lane2Data(lni,3);
        if( TTC <= 0)
            accidentTimes = accidentTimes + 1;
        elseif(TTC > 0 && TTC <= 0.1)
            seriousTimes = seriousTimes + 1;
        elseif(TTC > 0.1 && TTC <= 0.2)
            commonTimes =  commonTimes + 1;
        elseif(TTC > 0.2 && TTC <= 0.3)
            slightTimes = slightTimes + 1;
        end
    end
    
    
    %统计一车道
    for lni = 1 : lane3Num
        TTC = Lane3Data(lni,3);
        if( TTC <= 0)
            accidentTimes = accidentTimes + 1;
        elseif(TTC > 0 && TTC <= 0.1)
            seriousTimes = seriousTimes + 1;
        elseif(TTC > 0.1 && TTC <= 0.2)
            commonTimes =  commonTimes + 1;
        elseif(TTC > 0.2 && TTC <= 0.3)
            slightTimes = slightTimes + 1;
        end
    end
    
    TTCStatistics = [seriousTimes,commonTimes,slightTimes,accidentTimes];

end