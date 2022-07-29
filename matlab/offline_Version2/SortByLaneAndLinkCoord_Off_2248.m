%% 车辆按路段、车道及距离进行排序
% 输入
% vehicleData       : 车辆数据
% vehicleData = [laneNumber, VehicleNumber, simulationTime, speed, linkCoordinate, ...
%           acceleartion, startTime, speedDifference, followingDIstance, leadingVehicle, linkNumber]
% startLinkCoord    : 路段开始位置
% endLinkCoord      : 路段结束位置
% 输出
% vehicleDataLane1  : 车道1的车辆数据
% vehicleDataLane2  : 车道2的车辆数据
% vehicleDataLane3  : 车道3的车辆数据
% vehicleDataLane4  : 车道4的车辆数据
%%
function [vehicleDataLane1, vehicleDataLane2, vehicleDataLane3, vehicleDataLane4] = ...
    SortByLaneAndLinkCoord_Off_2248(vehicleData,startLinkCoord,endLinkCoord,linkNum)
    
    %车辆数据行数
    lineNumber = size(vehicleData,1);
    rowNumber = size(vehicleData, 2);
    
    %提取linkNum路段的车辆数据
    vehicleDataByLink = zeros(lineNumber,rowNumber);
    vdblNum = 1;
    for lni = 1 : lineNumber
        if(vehicleData(lni, 11) == linkNum)
            vehicleDataByLink(vdblNum, :) = vehicleData(lni, :);
            vdblNum = vdblNum + 1;
        end
    end
    vdblNum = vdblNum - 1;
    vehicleDataByLink(all(vehicleDataByLink == 0, 2), :) = [];
    
    % 提取 0-300米的车辆数据
    vehicleDataByCoord = zeros(vdblNum, rowNumber);
    vdbcNum = 1;
    for lni = 1 : vdblNum
        vehicleLinkCoord = vehicleDataByLink(lni, 5);
        if(vehicleLinkCoord >= startLinkCoord && vehicleLinkCoord < endLinkCoord)
            vehicleDataByCoord(vdbcNum, :) = vehicleDataByLink(lni, :);
            vdbcNum = vdbcNum + 1;
        end
    end
    vdbcNum = vdbcNum - 1;
    vehicleDataByCoord(all(vehicleDataByCoord == 0, 2), :) = [];
    
    %按车道排序
    vehicleDataByLane1 = zeros(vdbcNum, rowNumber);
    vdbl1 = 1;
    vehicleDataByLane2 = zeros(vdbcNum, rowNumber);
    vdbl2 = 1;
    vehicleDataByLane3 = zeros(vdbcNum, rowNumber);
    vdbl3 = 1;
    vehicleDataByLane4 = zeros(vdbcNum, rowNumber);
    vdbl4 = 1;
    for lni = 1 : vdbcNum 
       vehicleLane = vehicleDataByCoord(lni,1);
       if(vehicleLane == 1)
          vehicleDataByLane1(vdbl1,:) = vehicleDataByCoord(lni,:);
          vdbl1 = vdbl1 + 1;
       elseif(vehicleLane == 2)
           vehicleDataByLane2(vdbl2,:) = vehicleDataByCoord(lni,:);
           vdbl2 = vdbl2 + 1;
       elseif(vehicleLane == 3)
           vehicleDataByLane3(vdbl3,:) = vehicleDataByCoord(lni,:);
           vdbl3 = vdbl3 + 1;
       elseif(vehicleLane == 4)
             vehicleDataByLane4(vdbl4,:) = vehicleDataByCoord(lni,:);
           vdbl4 = vdbl4 + 1;
       end
    end
    vehicleDataByLane1(all(vehicleDataByLane1 == 0,2),:) = [];
    vehicleDataByLane2(all(vehicleDataByLane2 == 0,2),:) = [];
    vehicleDataByLane3(all(vehicleDataByLane3 == 0,2),:) = [];
    vehicleDataByLane4(all(vehicleDataByLane4 == 0,2),:) = [];

    
    vehicleDataLane1 = vehicleDataByLane1;
    vehicleDataLane2 = vehicleDataByLane2;
    vehicleDataLane3 = vehicleDataByLane3;
    vehicleDataLane4 = vehicleDataByLane4;
end