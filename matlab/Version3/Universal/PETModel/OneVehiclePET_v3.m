
%% 每两辆车的PET计算
function [vehicleLaterId,vehicleFrontId,PET] = OneVehiclePET_v3(allInvadeTimes, invadeTimeNumber)

invadeTimeLater = allInvadeTimes(invadeTimeNumber-1, 3);
invadeTimeFront = allInvadeTimes(invadeTimeNumber-2, 3);

PET = invadeTimeLater - invadeTimeFront;
vehicleLaterId = allInvadeTimes(invadeTimeNumber - 1, 1);
vehicleFrontId = allInvadeTimes(invadeTimeNumber - 2, 1);


end
