%% 计算车辆越过侵入线的位置
function invadeTime = XXXCalculateInvadeTime(vehicleData,invadeLine)
    
    %对车辆进行排序
    vehicleDataSort = VehicleLaneSort(vehicleData);
    
    %计算车辆通过侵入线的时刻
    vehicleDataSortNum = size(vehicleDataSort,1);
    invadeTimeTemp = zeros(vehicleDataSortNum,3);
    
    for iti = 1 : vehicleDataSortNum
        %车辆驶过侵入线的距离
        distance = vehicleDataSort(iti,5) - invadeLine;
        %计算该距离所需时间
        beyondTime = distance / vehicleDataSort(iti,4);
        %计算通过侵入线的时间
        invadeTime = vehicleDataSort(iti,2) - beyondTime;
        
        %保存数据
        invadeTimeTemp(iti,1) = vehicleDataSort(iti,3);
        invadeTimeTemp(iti,2) = vehicleDataSort(iti,2);
        invadeTimeTemp(iti,3) = invadeTime;
    end
    
    invadeTime = invadeTimeTemp;

end



