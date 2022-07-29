%% PET的计算
%invadeTimeData = [id, time, lane, invadeTime] 
% PETData = [id1, id2, time, lane, twoVehiclePET]
function PETData = CalculatePET_Off(invadeTimeData)
    %获取车辆数据行数
    invadeTimeNum = size(invadeTimeData,1);
    
    PETDataTmp = zeros(invadeTimeNum,5);
    PETDataNum = 1;
    
    for iti = 1 : invadeTimeNum-1
        time = invadeTimeData(iti,2);
        lane = invadeTimeData(iti,3);
        
        id1 = invadeTimeData(iti,1);
        invadeTime1 = invadeTimeData(iti,4);
        
        id2 = invadeTimeData(iti+1,1);
        invadeTime2 = invadeTimeData(iti+1,4);
        
        twoVehiclePET = invadeTime2 - invadeTime1;
        
        PETDataTmp(PETDataNum,:) = [id1, id2, time, lane, twoVehiclePET];
        PETDataNum = PETDataNum + 1;
    end
    
    PETDataTmp(all(PETDataTmp == 0,2),:) = [];
    

    PETData = PETDataTmp;

end







