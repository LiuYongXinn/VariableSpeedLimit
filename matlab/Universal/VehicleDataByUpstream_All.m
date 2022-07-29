%% 采集上游车辆数据
% vehicleData : 上游车辆数据
%
%
%%
function vehicleData = VehicleDataByUpstream_All(netVehicles, step)
    % vehicleData = [Lane,Step, ID,Speed, LinkCoord, Link]
    vehicleData = AgentRealTimeVehicleData_2248(netVehicles,step,1);
    vehicleNum = size(vehicleData,1);
    %采集500米以后的车辆数据
    for i = 1 : vehicleNum
        linkCoord = vehicleData(i, 5);
        if(linkCoord < 500)
            vehicleData(i,:) = zeros(1,6);
        end
        
    end
    vehicleData(all(vehicleData == 0,2), :) = [];
        

end
