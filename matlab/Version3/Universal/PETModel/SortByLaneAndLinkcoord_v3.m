%% 将车辆数据按车道和位置进行分类
function [vehicleDataLane1, vehicleDataLane2, vehicleDataLane3,vehicleDataLane4] = SortByLaneAndLinkcoord_v3(vehicleData,laneNum)

lineNumber = size(vehicleData,1);
vehicleDataLane1Tmp = zeros(lineNumber,6);
vehicleDataLane1Num = 1;
vehicleDataLane2Tmp = zeros(lineNumber,6);
vehicleDataLane2Num = 1;
if(laneNum >= 3)
    vehicleDataLane3Tmp = zeros(lineNumber,6);
    vehicleDataLane3Num = 1;
end
if(laneNum >= 4)
    vehicleDataLane4Tmp = zeros(lineNumber,6);
    vehicleDataLane4Num = 1;
end

%按车道将车辆归类
for lni = 1:lineNumber
    if(vehicleData(lni,1) == 1)
        vehicleDataLane1Tmp(vehicleDataLane1Num,:) = vehicleData(lni,:);
        vehicleDataLane1Num = vehicleDataLane1Num + 1;
    elseif(vehicleData(lni,1) == 2)
        vehicleDataLane2Tmp(vehicleDataLane2Num,:) = vehicleData(lni,:);
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
%数据导出
vehicleDataLane1 = vehicleDataLane1Tmp;
vehicleDataLane2 = vehicleDataLane2Tmp;

%如果三车存在,则输出
if(laneNum >= 3)
    vehicleDataLane3Tmp(all(vehicleDataLane3Tmp == 0,2),:) = [];
    vehicleDataLane3 = vehicleDataLane3Tmp;
end
%如果四车道存在,则输出
if(laneNum >= 4)
    vehicleDataLane4Tmp(all(vehicleDataLane4Tmp == 0,2),:) = [];
    vehicleDataLane4 = vehicleDataLane4Tmp;
end

end
