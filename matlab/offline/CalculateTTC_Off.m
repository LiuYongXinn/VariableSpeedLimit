%% 计算TTC
%vehicleData = (Lane number, Vehicle number, Simulation Time, Speed, Link corrdinate, Acceleration, Start time)
% TTC = (ID1, ID2, oneVehicleTTC, time, lane)

function TTC = CalculateTTC_Off(vehicleData)
    %获取行数
    lineNumber = size(vehicleData,1);
    TTCTmp = zeros(lineNumber,5);
    TTCNum = 1;
    
    for lni = 1 : lineNumber-1
        %判断前后两辆车是否在同一时刻
        if(~(vehicleData(lni,3) == vehicleData(lni+1,3)))
            continue;
        end
        %判断后车速度是否大于前车速度
        if(~(vehicleData(lni,4) > vehicleData(lni+1,4)))
            continue;
        end
        
        %相邻两辆车的TTC
        [ID1, ID2, oneVehicleTTC, time, lane] = TwoVehiclesTTC_Off(vehicleData(lni,:),vehicleData(lni+1,:));
        
        %保存TTC数据
        TTCTmp(TTCNum,:) = [ID1, ID2, oneVehicleTTC, time, lane]; 
        TTCNum = TTCNum + 1;
        
    end
    %删除TTC全零行
    TTCTmp(all(TTCTmp == 0,2),:) = [];
    
    %删除重复出现的数据
    TTCTmpNum = size(TTCTmp,1);
    
    for tni = TTCTmpNum : -1 : 2
        %从后往前检查，如果出现重复，则删除后面出现的数据
        vehicleID1 = TTCTmp(tni,1);
        vehicleID2 = TTCTmp(tni,2);
        for tnj = tni-1 : -1 :1
            if(vehicleID1 == TTCTmp(tnj,1) && vehicleID2 == TTCTmp(tnj,2))
                TTCTmp(tni,:) = zeros(1,5);
                break;
            end
        end
    end
    
    %删除TTC全零行
    TTCTmp(all(TTCTmp == 0,2),:) = [];
    
    
    %导出数据
    TTC = TTCTmp;
    
end

