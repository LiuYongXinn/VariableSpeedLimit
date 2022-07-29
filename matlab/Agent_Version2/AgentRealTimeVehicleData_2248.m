%% 获取主干道上实时车辆数据

%% 获取主干道上实时车辆数据
% 输入
% netVehicles   ：VISSIM的COM接口
% step          ：仿真时刻
% link          : 需要采集数据的路段
% 输出
% vehicleData   ：车辆数据[Lane,Step, ID,Speed, LinkCoord, Link]
%%
function vehicleData = AgentRealTimeVehicleData_2248(netVehicles,step,link)
    %当前路网上的车辆数
    vehiclesCount = netVehicles.Count;
    vehicleDataTmp = zeros(vehiclesCount,6);

    %车辆数据标签
    label = 1;
    if(vehiclesCount ~= 0)
        %获取每一辆车的数据
        for vdi = 1 : vehiclesCount
            singleCar = netVehicles.Item(vdi);
            linkTemp = singleCar.AttValue('LINK');
            if(linkTemp ~= link)
                continue
            end
            vehicleDataTmp(label,1) = singleCar.AttValue('LANE');
            vehicleDataTmp(label,2) = step;
            vehicleDataTmp(label,3) = singleCar.AttValue('ID');
            vehicleDataTmp(label,4) = singleCar.AttValue('SPEED');
            vehicleDataTmp(label,5) = singleCar.AttValue('LINKCOORD');
            vehicleDataTmp(label,6) = linkTemp;
            label = label + 1;
        end
    end
    vehicleDataTmp(all(vehicleDataTmp == 0,2),:) = [];
    vehicleData = vehicleDataTmp;

end

