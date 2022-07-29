%% 将车辆按位置和车道进行分类
% 输入
% vehicleData       : 车道上当前时刻的车辆数据
% 
% 输出
% vehicleDataLane1  : 第一车道的车辆数据
% vehicleDataLane2  : 第二车道的车辆数据
% vehicleDataLane3  : 第三车道的车辆数据
%% 
function [vehicleDataLane1, vehicleDataLane2, vehicleDataLane3, vehicleDataLane4] = ...
        AgentSortByLaneAndLinkCoordOnline_2248(vehicleData)
    

    lineNumber = size(vehicleData,1);
    vehicleDataLane1Tmp = zeros(lineNumber,6);
    vehicleDataLane1Num = 1;
    vehicleDataLane2Tmp = zeros(lineNumber,6);
    vehicleDataLane2Num = 1;
    vehicleDataLane3Tmp = zeros(lineNumber,6);
    vehicleDataLane3Num = 1;
    
    vehicleDataLane4Tmp = zeros(lineNumber,6);
    vehicleDataLane4Num = 1;
    
    %按车道将车辆归类
    for lni = 1:lineNumber
        if(vehicleData(lni,1) == 1)
            vehicleDataLane1Tmp(vehicleDataLane1Num,:) = vehicleData(lni,:);
            vehicleDataLane1Num = vehicleDataLane1Num + 1;
        elseif(vehicleData(lni,1) == 2)
            vehicleDataLane2Tmp(vehicleDataLane3Num,:) = vehicleData(lni,:);
            vehicleDataLane2Num = vehicleDataLane2Num + 1;
        elseif(vehicleData(lni,1) == 3)
            vehicleDataLane3Tmp(vehicleDataLane3Num,:) = vehicleData(lni,:);
            vehicleDataLane3Num = vehicleDataLane3Num + 1;
        elseif(vehicleData(lni,1) == 4)
            vehicleDataLane4Tmp(vehicleDataLane4Num,:) = vehicleData(lni,:);
            vehicleDataLane4Num = vehicleDataLane4Num + 1;
        end
    end
    %删除全零行
    vehicleDataLane1Tmp(all(vehicleDataLane1Tmp == 0,2),:) = [];
    vehicleDataLane2Tmp(all(vehicleDataLane2Tmp == 0,2),:) = [];
    vehicleDataLane3Tmp(all(vehicleDataLane3Tmp == 0,2),:) = [];
    vehicleDataLane4Tmp(all(vehicleDataLane4Tmp == 0,2),:) = [];
    
    %数据导出
    vehicleDataLane1 = vehicleDataLane1Tmp;
    vehicleDataLane2 = vehicleDataLane2Tmp;
    vehicleDataLane3 = vehicleDataLane3Tmp;
    vehicleDataLane4 = vehicleDataLane4Tmp;
    
end
