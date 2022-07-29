%% 离线文件的数据提取
% 输入
% vissimPathName        : 文件路径
% vissimUnifiedName     : 文件名称
% 输出
% vehicleData           : 车辆数据
% travelTimes           ：旅行时间数据
% linkEvaluation        ：道路数据
% queueLengthRecord     ：排队长度数据
% dataCollection        ：数据采集点收集的数据
%%
function [vehicleData, travelTimes, linkEvaluation, queueLengthRecord,dataCollection] ...
    = FileDataExtract_Off_2248(vissimPathName,vissimUnifiedName)
    
    % 车辆记录 vissimUnifiedName.fzp
    % vehicleData = [laneNumber, VehicleNumber, simulationTime, speed, linkCoordinate, acceleartion, startTime, speedDifference, followingDIstance, leadingVehicle, linkNumber]
    fzpPwd = strcat(vissimPathName,vissimUnifiedName,'.fzp');
    fzpOpen = fopen(fzpPwd);   
    %提取车辆记录
    fzpCell = textscan(fzpOpen,'%f %f %f %f %f %f %f %f %f %f %f %*[^\n]','HeaderLines',20,'Delimiter',';');     
    fclose(fzpOpen);
    %保存车辆数据
    vehicleData = cell2mat(fzpCell);
    

    % 旅行时间 vissimUnifiedName.rsz
    % travelTimes = [step, travelTimes, vehicleNumber]
    rszPwd = strcat(vissimPathName,vissimUnifiedName,'.rsz');
    rszOpen = fopen(rszPwd);
    %提取数据
    rszCell = textscan(rszOpen,'%f %f %f %*[^\n]','HeaderLines',12,'Delimiter',';');
    fclose(rszOpen);
    %保存旅行时间数据
    travelTimes = cell2mat(rszCell);
    
    
    % 道路评价 vissimUnifiedName.str
    % linkEvaluation = [volume, denstiy, averageSpeed, simulationTime, laneNumber, LinkNumber, SegmentStartCoordinate, SegmentEndCoordinate]
    strPwd = strcat(vissimPathName,vissimUnifiedName,'.str');
    strOpen = fopen(strPwd);
    %提取数据
    strCell = textscan(strOpen,'%f %f %f %f %f %f %f %f %*[^\n]','HeaderLines',26,'Delimiter',';');
    fclose(strOpen);
    %保存旅行时间数据
    linkEvaluation = cell2mat(strCell);
    
    
    
    %排队长度 vissimUnifiedName.stz
    % queueLengthRecord = [time, averageQueueLength1, maxQueueLength1,stopNum1, averageQueueLength2, maxQueueLength2, stopNum2];
    stzPwd = strcat(vissimPathName,vissimUnifiedName,'.stz');
    stzOpen = fopen(stzPwd);
    %提取数据
    stzCell = textscan(stzOpen,'%f %f %f %f %f %f %f %*[^\n]','HeaderLines',16,'Delimiter',';');
    fclose(stzOpen);
    %保存旅行时间数据
    queueLengthRecord = cell2mat(stzCell);
    
    
    %数据采集点数据 vissimUnifiedName.mer
    % dataCollection = [dot, enterTime, leaverTime, vehicleNo, vehicleType, line, speed, acceleration, occupancy, persionNum, queueTime, vehicleLength]
    merPwd = strcat(vissimPathName,vissimUnifiedName,'.mer');
    merOpen = fopen(merPwd);
    %提取数据
    merCell = textscan(merOpen,'%f %f %f %f %f %f %f %f %f %f %f %f %*[^\n]','HeaderLines',15);
    fclose(merOpen);
    %保存旅行时间数据
    dataCollection = cell2mat(merCell);
    
end
