function [vehicleDataLane1, vehicleDataLane2, vehicleDataLane3] = SortByLaneAndLinkCoord_Off(vehicleData,startLinkCoord,endLinkCoord)
    %车辆数据行数
    lineNumber = size(vehicleData,1);
    
    %存储每个车道上符合要求的车辆数据
    vehicleDataLane1Tmp = zeros(lineNumber,7);
    vehicleDataLane1Num = 1;
    vehicleDataLane2Tmp = zeros(lineNumber,7);
    vehicleDataLane2Num = 1;
    vehicleDataLane3Tmp = zeros(lineNumber,7);
    vehicleDataLane3Num = 1;
    
    %按位置和车道将车辆数据进行归类
    for lni = 1 : lineNumber
       %提取位置大于startLinkCoord且小于endLinkCoord的车辆数据
       if(vehicleData(lni, 5) > startLinkCoord && vehicleData(lni,5)<endLinkCoord)
           %车道1上的车辆数据
           if(vehicleData(lni,1) == 1)
               vehicleDataLane1Tmp(vehicleDataLane1Num,:) = vehicleData(lni,:);
               vehicleDataLane1Num = vehicleDataLane1Num + 1;
           %车道2上的车辆数据
           elseif(vehicleData(lni,1) == 2)
               vehicleDataLane2Tmp(vehicleDataLane2Num,:) = vehicleData(lni,:);
               vehicleDataLane2Num = vehicleDataLane2Num + 1;
           %车道3上的车辆数据    
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