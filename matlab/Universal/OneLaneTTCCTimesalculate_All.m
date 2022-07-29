%% 仿真过程单车道TTC数据采集


%%
function OneLaneTTCCTimesalculate_All(step, vehicleData,vehicleDataNum )
global TTCSum TTCSumNumber;

if(vehicleDataNum > 1)
    vehicleData = VehicleLaneSort_2248(vehicleData);
end
%一车道TTC计算
if(vehicleDataNum > 1)
    [TTCSum, TTCSumNumber] = CalculateTTC_2248(TTCSum,TTCSumNumber,vehicleData,step);
end

end
