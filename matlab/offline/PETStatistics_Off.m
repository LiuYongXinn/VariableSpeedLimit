%% PET次数统计
% PETData = [id1, id2, time, lane, twoVehiclePET]

function PETStatistics = PETStatistics_Off(Lane1Data, Lane2Data, Lane3Data)
    lane1Num = size(Lane1Data,1);
    lane2Num = size(Lane2Data,2);
    lane3Num = size(Lane3Data,3);
    
%         for lni = 1 : lane2Num
%         PET = Lane1Data(lni,5);
%         if( PET <= 0)
%             accidentTimes = accidentTimes + 1;
%         elseif(PET > 0 && PET <= 1.35)
%             seriousTimes = seriousTimes + 1;
%         elseif(PET > 1.35 && PET <= 2.08)
%             commonTimes =  commonTimes + 1;
%         elseif(PET > 2.08 && PET <= 4.14)
%             slightTimes = slightTimes + 1;
%         end
%     end
    
    
   
    %统计1车道
    for lni = 1 : lane1Num
        PET = Lane1Data(lni,5);
        if( PET <= 0)
            accidentTimes = accidentTimes + 1;
        elseif(PET > 0 && PET <= 1.05)
            seriousTimes = seriousTimes + 1;
        elseif(PET > 1.35 && PET <= 2.08)
            commonTimes =  commonTimes + 1;
        elseif(PET > 2.08 && PET <= 3.14)
            slightTimes = slightTimes + 1;
        end
    end

    for lni = 1 : lane2Num
        PET = Lane1Data(lni,5);
        if( PET <= 0)
            accidentTimes = accidentTimes + 1;
        elseif(PET > 0 && PET <= 1.05)
            seriousTimes = seriousTimes + 1;
        elseif(PET > 1.35 && PET <= 2.08)
            commonTimes =  commonTimes + 1;
        elseif(PET > 2.08 && PET <= 3.14)
            slightTimes = slightTimes + 1;
        end
    end
    
    for lni = 1 : lane3Num
        PET = Lane1Data(lni,5);
        if( PET <= 0)
            accidentTimes = accidentTimes + 1;
        elseif(PET > 0 && PET <= 1.05)
            seriousTimes = seriousTimes + 1;
        elseif(PET > 1.35 && PET <= 2.08)
            commonTimes =  commonTimes + 1;
        elseif(PET > 2.08 && PET <= 3.14)
            slightTimes = slightTimes + 1;
        end
    end
    
    PETStatistics = [seriousTimes,commonTimes,slightTimes,accidentTimes];
    
    
end