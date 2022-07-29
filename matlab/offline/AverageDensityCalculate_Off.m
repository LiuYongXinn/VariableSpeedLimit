%% 三车道平均密度
%linkEvaluation = (volume, linkCoordinate, density, average speed, time, link number, lane number)

function averageDensity = AverageDensityCalculate_Off(linkEvaluation)

    linkEvaluationNum = size(linkEvaluation,1);
    vehicleData = zeros(linkEvaluationNum,7);
    vehicleDataLabel = 1;

    %提取700m到900米之间的车辆数据
    for lei = 1 : linkEvaluationNum
        linkCoord = linkEvaluation(lei,2);
        %剔除linkcoord不在700米到900米之间的车辆数据
        if(~(linkCoord > 700 && linkCoord  < 900))
            continue;
        end
        %保存数据
        vehicleData(vehicleDataLabel,:) = linkEvaluation(lei,:);
        vehicleDataLabel = vehicleDataLabel + 1;
    end
    %删除全零行
    vehicleData(all(vehicleData == 0,2),:) = [];
    
    %求700m到800m路段的平均密度
    averageDensityNumber = size(vehicleData,1);
    averageDensity = zeros(averageDensityNumber,2);
    averageDensityLabel = 1;
    
    for adi = 1 : 3 :averageDensityNumber
       %三车道密度累加
       densitySum = vehicleData(adi,3)+vehicleData(adi+2,3)+vehicleData(adi+2,3);
       laneNum = 3;
       %时刻
       time = vehicleData(adi,5);
       
       %如果车道密度为0，则忽略该车道
        for tmpi = adi : adi+2
            if(vehicleData(tmpi,3) == 0)
                laneNum = laneNum - 1;
            end
        end
        
        %如果三车道均为0，则该路段密度为0
        if(laneNum == 0)
            oneAverageDensity = 0;
        elseif(laneNum ~= 0)
           oneAverageDensity = densitySum / laneNum; 
        end
        
        %保存数据
        averageDensity(averageDensityLabel,1) = time;
        averageDensity(averageDensityLabel,2) = oneAverageDensity;
        averageDensityLabel = averageDensityLabel + 1;

    end
    
    %删除全零行
    averageDensity(all(averageDensity == 0,2),:) = [];

    
end