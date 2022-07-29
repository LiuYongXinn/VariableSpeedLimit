%% 收集路段上固定位置的车辆数据
function vehicleData = CollectVehicleData_All_v3(netVehicles, step, link, startPosition, endPosition)
% vehicleData = [Lane,Step, ID,Speed, LinkCoord, Link]
vehicleData = AgentRealTimeVehicleData_2248(netVehicles,step,link);
vehicleNum = size(vehicleData,1);
%采集500米以后的车辆数据
for i = 1 : vehicleNum
    linkCoord = vehicleData(i, 5);
    if(~(linkCoord >= startPosition && linkCoord <= endPosition))
        vehicleData(i,:) = zeros(1,6);
    end
    
end
vehicleData(all(vehicleData == 0,2), :) = [];


end
