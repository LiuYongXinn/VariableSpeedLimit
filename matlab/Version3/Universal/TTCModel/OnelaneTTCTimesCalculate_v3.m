%% 单车道TTC计算
function [TTCCounts,TTCCountNum] = OnelaneTTCTimesCalculate_v3(stepTime, vehicleData,TTCCounts,TTCCountNum)
vdLength = size(vehicleData, 1);
if(vdLength <= 1)
    return;
end

%排序
vehicleData = VehicleLaneSort_2248(vehicleData);

for vdi = 1 : vdLength-1
    %计算每两辆车之间的TTC
    [idFront, idRear, vehicleTTC] = OneVehicleTTC_v3(vehicleData(vdi,:),vehicleData(vdi+1,:));
    vehicleTTCTemp = [stepTime, idFront, idRear, vehicleTTC];
    %保存TTC数据
    TTCCounts(TTCCountNum,:) = vehicleTTCTemp;
    TTCCountNum = TTCCountNum + 1;
end

end



