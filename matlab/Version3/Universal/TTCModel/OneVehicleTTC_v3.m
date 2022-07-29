%% 计算每两车辆之间的TTC
function [idFront, idRear, TTC] = OneVehicleTTC_v3(vehicleDataFront, vehicleDataRear)
global invadeLine

idFront = vehicleDataFront(1,3);
speedkmhFront = vehicleDataFront(1,4);
linkCoordFront = vehicleDataFront(1,5);

idRear = vehicleDataRear(1,3);
speedkmhRear = vehicleDataRear(1,4);
linkCoordRear = vehicleDataRear(1,5);


%前车数据
distanceFront = invadeLine - linkCoordFront;
speedmsFront = (speedkmhFront * 1000)/(60*60);
timeFront = distanceFront / speedmsFront;

%后车数据
distanceRear = invadeLine - linkCoordRear;
speedmsRear = (speedkmhRear * 1000)/(60*60);
timeRear = distanceRear / speedmsRear;

%计算TTC
if speedkmhRear > speedkmhFront
    TTC = timeRear - timeFront;
else
    TTC = 1000000;
end


end