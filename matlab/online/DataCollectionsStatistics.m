%% 在线评价数据收集

function dataCollections = DataCollectionsStatistics(netDataCollections, dataCollectionsCount)
    dataCollectionsTemp = zeros(dataCollectionsCount, 3);
    
    for dci = 1 : dataCollectionsCount
        dataCollectionDot = netDataCollections.GetDataCollectionByNumber(dci);
        
        % 收集车辆数
        nVehiclesSum = dataCollectionDot.GetResult("NVEHICLES","SUM",0);
        %收集占有率
        %occupancyRateSum = dataCollectionDot.GetResult("OCCUPANCYRATE","SUM",0);
        % 收集排队数据
        queueDelTimeMean=dataCollectionDot.GetResult("QUEUEDELTIME","MEAN",0);
        % 收集速度
        speedMean = dataCollectionDot.GetResult("SPEED","MEAN",0);
        
        dataCollectionsTemp(dci,:) = [nVehiclesSum, queueDelTimeMean, speedMean];
    end
    dataCollections = dataCollectionsTemp;
end