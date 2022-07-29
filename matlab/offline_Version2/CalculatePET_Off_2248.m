%% PET计算
% 输入
% vehicleData       ：车辆数据
% 输出
% PETData           ：PET数据
% PETData = [id1, id2, time, lane, twoVehiclePET]
%%
function PETData = CalculatePET_Off_2248(vehicleData)
    %计算车辆通过侵入线的时间
    invadeTimeData = InvadeTime_Off_2248(vehicleData);
    invadeTimeNum = size(invadeTimeData,1);
    %PET数据
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

