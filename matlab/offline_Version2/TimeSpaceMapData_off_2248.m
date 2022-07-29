%% 车辆轨迹数据提取
 % 车辆记录 vissimUnifiedName.fzp
 % vehicleData = [laneNumber,       VehicleNumber,      simulationTime,     speed,          linkCoordinate,     acceleartion, ...
%                 startTime,        speedDifference,    followingDIstance,  leadingVehicle, linkNumber]
% [linkNum, laneNum, simulationTime, vehicleNumber, linkCoordinate]


%%
function  [M, keySet, vehicleCount] = TimeSpaceMapData_off_2248(vehicleData, link, time)
    vdLine = size(vehicleData,1);
    vehicleDataByLink = zeros(vdLine, 5);
    vdLinkLabel = 1;
    
    %提取link车道的车辆
    for i = 1 : vdLine
        linkNum = vehicleData(i, 11);
        if(linkNum == link)
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
    
    %提取time时间段内的车辆数据
    vehicleDataByTime = zeros(vdLinkLabel, 5);
    vdTLabel = 1;
    
    for i = 1 : vdLinkLabel
        vdTime = vehicleDataByLink(i, 3);
        if(vdTime >= time(1,1) && vdTime <= 1200)
            vehicleDataByTime(vdTLabel, :) = vehicleDataByLink(i, :);
            vdTLabel =  vdTLabel + 1;
        end
    end
    
    
    
    
    %将车辆数据按车辆编号分类  
    vtsize = size(vehicleDataByTime, 1);
    valueSet = zeros(vtsize, 5);
    valueSet(1,1) = 2;
    M = containers.Map(0,valueSet);
    for i = 1 : vtsize
        vehicleNum = vehicleDataByTime(i,4);
        if(isKey(M,vehicleNum))
            %如果该车辆已经存在,则将数据导入
            vehicleValue = M(vehicleNum);
            label = vehicleValue(1,1);
            vehicleValue(label, :) = vehicleDataByTime(i,:);
            vehicleValue(1,1) = label + 1;
            M(vehicleNum) = vehicleValue;
    
        else
            %如果该车辆没有存在,则添加该车辆
            M(vehicleNum) = valueSet;
        end
    end
    remove(M,0);
    
    %获取M中包含的车辆数及车辆编号
    vehicleCount = length(M);
    keySet = cell2mat(keys(M));
    
    for i = 1 : vehicleCount
        keyNum = keySet(i);
        valueSet = M(keyNum);
        valueSet(1,:) = [];
        valueSet(all(valueSet == 0,2),:) = [];
        M(keyNum) = valueSet;
    end
end




