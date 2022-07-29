%% 获取主干道上实时车辆数据
function vehicleData = RealTimeVehicleData(netVehicles,step)
    
    %当前路网上的车辆数
    vehiclesCount = netVehicles.Count;  
    vehicleDataTmp = zeros(vehiclesCount,5);
    %获取每一辆车的数据
    for vdi = 1 : vehiclesCount
        singleCar = netVehicles.Item(vdi);
        vehicleDataTmp(vdi,1) = singleCar.AttValue('LANE');
        vehicleDataTmp(vdi,2) = step;
        vehicleDataTmp(vdi,3) = singleCar.AttValue('ID');
        vehicleDataTmp(vdi,4) = singleCar.AttValue('SPEED');
        vehicleDataTmp(vdi,5) = singleCar.AttValue('LINKCOORD');
    end
    vehicleData = vehicleDataTmp;
end