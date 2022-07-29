%%从按距离远到近对车辆进行排序
% 输入
% vehicleData       : 未排序的车辆数据
% 输出
% vehicleDataSort   ：按距离排好序的车辆数据

%%
function vehicleDataSort = VehicleLaneSort_2248(vehicleData)
    vehicleDataNum = size(vehicleData,1);
    vehicleLaneTemp = zeros(1,6);

    for vdi = 1 : vehicleDataNum
        for vdj = 1 : (vehicleDataNum-vdi)
            if(vehicleData(vdj,5) < vehicleData(vdj+1,5))
                for vdz = 1 : 6
                    vehicleLaneTemp(1,vdz) = vehicleData(vdj,vdz);
                    vehicleData(vdj,vdz) = vehicleData(vdj+1,vdz);
                    vehicleData(vdj+1,vdz) = vehicleLaneTemp(1,vdz);
                end
            end
        end
    end
    
    vehicleDataSort = vehicleData;
end