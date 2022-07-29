%% 统计车辆加速度的变化的次数
% vehicleData = [laneNumber, VehicleNumber, simulationTime, speed, linkCoordinate, acceleartion, ...
%                startTime, speedDifference, followingDIstance, leadingVehicle, linkNumber]


%%
function AgentCountAccelerationChangeTime_2248(vehicleData)
    vdLine = size(vehicleData,1);
    vehicleDataByLink = zeros(vdLine, 5);
    vdLinkLabel = 1;

    %提取link车道的车辆
    for i = 1 : vdLine
        linkNum = vehicleData(i, 11);
        if(linkNum == 1 || linkNum == 2)
            laneNum = vehicleData(i, 1);
            vehicleNumber = vehicleData(i, 2);
            simulationTime = vehicleData(i, 3);
            linkCoordinate = vehicleData(i, 5);
            vehicleDataByLink(vdLinkLabel, :) = [linkNum, laneNum, simulationTime, vehicleNumber, linkCoordinate];
            vdLinkLabel = vdLinkLabel + 1;
        end
    end
    vehicleDataByLink(all( vehicleDataByLink == 0,2), :) = [];
    vdLinkLabel =   vdLinkLabel - 1;
    
    
    vehicleSum = cell{}


end