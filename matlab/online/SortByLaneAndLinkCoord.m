%% 将车辆按位置和车道进行分类
function [vehicleDataLane1, vehicleDataLane2, vehicleDataLane3] = SortByLaneAndLinkCoord(vehicleData, startLinkCoord, endLinkCoord)

    lineNumber = size(vehicleData,1);
    vehicleDataLane1Tmp = zeros(lineNumber,5);
    vehicleDataLane1Num = 1;
    vehicleDataLane2Tmp = zeros(lineNumber,5);
    vehicleDataLane2Num = 1;
    vehicleDataLane3Tmp = zeros(lineNumber,5);
    vehicleDataLane3Num = 1;
    
    %按位置和车道将车辆归类
    for lni = 1:lineNumber
        if(vehicleData(lni,5) > startLinkCoord && vehicleData(lni,5) < endLinkCoord)
            if(vehicleData(lni,1) == 1)
                vehicleDataLane1Tmp(vehicleDataLane1Num,:) = vehicleData(lni,:);
                vehicleDataLane1Num = vehicleDataLane1Num + 1;
            elseif(vehicleData(lni,1) == 2)
                vehicleDataLane2Tmp(vehicleDataLane3Num,:) = vehicleData(lni,:);
                vehicleDataLane2Num = vehicleDataLane2Num + 1;
            elseif(vehicleData(lni,1) == 3)
                vehicleDataLane3Tmp(vehicleDataLane3Num,:) = vehicleData(lni,:);
                vehicleDataLane3Num = vehicleDataLane3Num + 1;
            end
        end
    end

    %删除全零行
    vehicleDataLane1Tmp(all(vehicleDataLane1Tmp == 0,2),:) = [];
    vehicleDataLane2Tmp(all(vehicleDataLane2Tmp == 0,2),:) = [];
    vehicleDataLane3Tmp(all(vehicleDataLane3Tmp == 0,2),:) = [];
    
    %数据导出
    vehicleDataLane1 = vehicleDataLane1Tmp;
    vehicleDataLane2 = vehicleDataLane2Tmp;
    vehicleDataLane3 = vehicleDataLane3Tmp;
    
end