%% 某一车道PET统计

function [invadeTimeNum,allInvadeTimes,PETCounts,PETCountNum] = ...
    OneLanePETTimesCalculate_All_v3(vehicleData, stepTime, invadeTimeNum, allInvadeTimes,PETCounts,PETCountNum,vehicleMap)

vehicleDataNum = size(vehicleData, 1);
%排序
if(vehicleDataNum > 1)
    vehicleData = AgentVehicleLaneSort_2248(vehicleData);
end

if(vehicleDataNum ~= 0)
    [invadeTimeNum,allInvadeTimes,PETCounts,PETCountNum] = ...
        CalculatePET_All_v3(vehicleData,invadeTimeNum,allInvadeTimes,stepTime,vehicleMap,PETCounts,PETCountNum);
    
end
end