%% 施工区、桥梁和隧道的减速区域设置
function AgentReducedSpeedSettingsForCLoseBridgeTunnel_2248(netReducedSpeedAreas,reducedSpeed)
    
    for rsaci = 4:6
        reduceSpeedArea = netReducedSpeedAreas.GetReducedSpeedAreaByNumber(rsaci);
        reduceSpeedArea.set('AttValue1', 'DESIREDSPEED', 10,reducedSpeed);
        reduceSpeedArea.set('AttValue1', 'DESIREDSPEED', 20,reducedSpeed);
    end
    
end