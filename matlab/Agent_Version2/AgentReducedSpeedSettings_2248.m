%% 减速区域设置
% 输入
% netReducedSpeedAreas          :  VISSIM的减速区域速度COM接口
% reducedSpeedAreasCount        ： VISSIM减速区域的数量
% reducedSpeed                  ： 限速值
%%
function AgentReducedSpeedSettings_2248(netReducedSpeedAreas,reducedSpeedAreasCount,reducedSpeed)
    
    for rsaci = 1:reducedSpeedAreasCount
        reduceSpeedArea = netReducedSpeedAreas.GetReducedSpeedAreaByNumber(rsaci);
        reduceSpeedArea.set('AttValue1', 'DESIREDSPEED', 10,reducedSpeed);
        reduceSpeedArea.set('AttValue1', 'DESIREDSPEED', 20,reducedSpeed);
    end
    
end
