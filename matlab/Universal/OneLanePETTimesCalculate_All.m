%% 单车道越过冲突线时间、车辆数统计

%%
function [invadeTimeLaneNumber,invadeTimeLane,invadeTimeNumber] = ...
    OneLanePETTimesCalculate_All(vehicleData, lane, step, invadeTimeLaneNumber, invadeTimeLane,invadeTimeNumber)

global allStepVehiclePETNumber;
%%一车道PET
vehicleDaNum = size(vehicleData,1);
%辅助PET计算，统计当前时刻及前10秒之内的车辆数据
allStepVehiclePETNumber(lane,step) = vehicleDaNum;
%排序(按距离排序)
if(vehicleDaNum > 1)
    vehicleData = AgentVehicleLaneSort_2248(vehicleData);
end
% PET计算
if(vehicleDaNum ~= 0)
    [invadeTimeLaneNumber,invadeTimeLane,invadeTimeNumber] = ...
        CalculatePET_All(vehicleData,invadeTimeLaneNumber, invadeTimeLane, invadeTimeNumber,step,lane);
end

end

