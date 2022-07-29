%% ºıÀŸ«¯”Ú…Ë÷√
function ReducedSpeedSettings(netReducedSpeedAreas,reducedSpeedAreasCount,reducedSpeed)
    
    for rsaci = 1:3
        reduceSpeedArea = netReducedSpeedAreas.GetReducedSpeedAreaByNumber(rsaci);
        reduceSpeedArea.set('AttValue1', 'DESIREDSPEED', 10,reducedSpeed);
        reduceSpeedArea.set('AttValue1', 'DESIREDSPEED', 20,reducedSpeed);
    end
    
end

