%% 某一车道PET计算

function [invadeTimeNum,allInvadeTimes,PETCounts,PETCountNum] = ...
    CalculatePET_All_v3(vehicleData,invadeTimeNum,allInvadeTimes,stepTime,vehicleMap,PETCounts,PETCountNum)

vehicleDataNum = size(vehicleData,1);

%获取当前step中的每一辆车的数
for vdi = 1 : vehicleDataNum
    vehicleId = vehicleData(vdi, 3);
    %如果当前车辆Id已经被记录,则跳过该车辆
    if(isKey(vehicleMap, vehicleId))
        vehicleMap(vehicleId) = vehicleMap(vehicleId) + 1;
        continue;
    end
    %将该车辆存入vehicleMap
    vehicleMap(vehicleId) = 1;
    
    %计算该车辆通过侵入线的时间
    [vehicleId,stepTime,invadeTime] = CalculateInvadeTime_v3(vehicleData(vdi,:));
    allInvadeTimes(invadeTimeNum, :) = [vehicleId,stepTime,invadeTime];
    invadeTimeNum = invadeTimeNum + 1;
    
    %计算车辆的PET
    if(invadeTimeNum > 2)
        [vehicle1Id,vehicle2Id,oneVehiclePET] = OneVehiclePET_v3(allInvadeTimes, invadeTimeNum);
        PETCounts(PETCountNum,:) = [stepTime, vehicle1Id,vehicle2Id, oneVehiclePET];
        PETCountNum = PETCountNum + 1;
    end
    
end

end






