%% 文件数据提取
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
function [vehicleData,linkEvaluation, travelTimes] = AgentFileDataExtract_2248(vissimPathName,vissimUnifiedName)

    % 车辆记录 vissimUnifiedName.fzp
    % vehicleData = [laneNumber, VehicleNumber, simulationTime, speed, linkCoordinate, acceleartion, startTime, speedDifference, followingDIstance, leadingVehicle, linkNumber]
    fzpPwd = strcat(vissimPathName,vissimUnifiedName,'.fzp');
    fzpOpen = fopen(fzpPwd);
    %提取车辆记录
    fzpCell = textscan(fzpOpen,'%f %f %f %f %f %f %f %f %f %f %f %*[^\n]','HeaderLines',20,'Delimiter',';');
    fclose(fzpOpen);
    %保存车辆数据
    vehicleData = cell2mat(fzpCell);


    % 道路评价 vissimUnifiedName.str
    % linkEvaluation = [volume, denstiy, averageSpeed, simulationTime, laneNumber, LinkNumber, SegmentStartCoordinate, SegmentEndCoordinate]
    strPwd = strcat(vissimPathName,vissimUnifiedName,'.str');
    strOpen = fopen(strPwd);
    %提取数据
    strCell = textscan(strOpen,'%f %f %f %f %f %f %f %f %*[^\n]','HeaderLines',26,'Delimiter',';');
    fclose(strOpen);
    %保存旅行时间数据
    linkEvaluation = cell2mat(strCell);
    
    %% 旅行时间 test3.rsz
    %rszPwd = [pwd,'\test3.rsz'];
    rszPwd = strcat(vissimPathName,vissimUnifiedName,'.rsz');
    rszOpen = fopen(rszPwd);
    %提取数据
    rszCell = textscan(rszOpen,'%f %f %f %*[^\n]','HeaderLines',12,'Delimiter',';');
    fclose(rszOpen);
    %保存旅行时间数据
    travelTimes = cell2mat(rszCell);

end
