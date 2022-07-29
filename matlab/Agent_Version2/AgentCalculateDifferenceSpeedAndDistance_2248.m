%% 求平均相对速度和平均相对位置
% 输入
% vehicleData = [laneNumber, VehicleNumber, simulationTime, speed, linkCoordinate, acceleartion, startTime, speedDifference, followingDIstance, leadingVehicle, linkNumber]
% vehicleData : 车辆数据
% 输出
% distanceDiffer ：平均相对距离
% speedDiffer ： 平均相对速度
%%
function [distanceDiffer,speedDiffer] = AgentCalculateDifferenceSpeedAndDistance_2248(vehicleData)
    distanceSum = 0;
    disLabel = 0;
    speedSum = 0;
    speLabel = 0;
    vdNum = size(vehicleData, 1);
    
    
    for vdi = 1 : vdNum
        
        distance = vehicleData(vdi, 9);
        speed = vehicleData(vdi,8);
        
        if(speed ~= 0)
            speedSum = speedSum + speed;
            speLabel = speLabel + 1;
        end
        
        if(distance ~= 0)
            distanceSum = distanceSum + distance;
            disLabel = disLabel + 1;
        end
        
    end
   
    distanceDiffer = distanceSum / disLabel;
    speedDiffer = speedSum / speLabel;

end
