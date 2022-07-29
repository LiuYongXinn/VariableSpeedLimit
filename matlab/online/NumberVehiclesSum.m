%% 获取车道上通过车辆数

function vehiclesSum = NumberVehiclesSum(dataCollections,dataCollectionsCount)
    vehiclesSumTemp = 0;

    
    %累加每个车道的车辆
    for vni = 1 : dataCollectionsCount
        vehiclesSumTemp = vehiclesSumTemp + dataCollections(vni,1);
    end
    
    vehiclesSum = vehiclesSumTemp;
    
end