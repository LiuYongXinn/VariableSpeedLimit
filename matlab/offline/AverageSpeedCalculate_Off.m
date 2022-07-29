%% 三车道的平均速度
%linkEvaluation = (volume, linkCoordinate, density, average speed, time, link number, lane number)


function averageSpeed = AverageSpeedCalculate_Off(linkEvaluation)

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
    
    vehicleData(all(vehicleData == 0,2),:) = [];
    
%     %按车道分类的参数定义
%     vehicleDataLaneNum = vehicleDataNumber - 1;
%     vehicleDataLane1 = zeros(vehicleDataLaneNum,7);
%     vehicleDataLane1Number = 1;
%     vehicleDataLane2 = zeros(vehicleDataLaneNum,7);
%     vehicleDataLane2Number = 2;
%     vehicleDataLane3 = zeros(vehicleDataLaneNum,7);
%     vehicleDataLane3Number = 3;
%     
%     
%     %将车辆按车道分类
%     for vdi = 1 : vehicleDataLaneNum
%         %车道1
%         if(vehicleData(vdi,7) == 1)
%             vehicleDataLane1(vehicleDataLane1Number,:) = vehicleData(vdi,:);
%             vehicleDataLane1Number = vehicleDataLane1Number + 1;
%         %车道2    
%         elseif(vehicleData(vdi,7) == 2)
%             vehicleDataLane2(vehicleDataLane2Number,:) = vehicleData(vdi,:);
%             vehicleDataLane2Number = vehicleDataLane2Number + 1; 
%         %车道3
%         elseif(vehicleData(vdi,7) == 3)
%             vehicleDataLane3(vehicleDataLane3Number,:) = vehicleData(vdi,:);
%             vehicleDataLane3Number = vehicleDataLane3Number + 1;     
%         end
%     end
%     
%     %删除全零行
%     vehicleDataLane1(all(vehicleDataLane1 == 0,2),:) = [];
%     vehicleDataLane2(all(vehicleDataLane2 == 0,2),:) = [];
%     vehicleDataLane3(all(vehicleDataLane3 == 0,2),:) = [];
    
    %求700m到800m路段的平均速度
    averageSpeedNumber = size(vehicleData,1);
    averageSpeed = zeros(averageSpeedNumber, 2);
    averageSpeedLabel = 1;
    
    for asi = 1 : 3 :averageSpeedNumber
        %三个车道的速度累加
        averageSpeedSum = vehicleData(asi,4) +  vehicleData(asi+2,4) + vehicleData(asi+2,4); 
        laneNum = 3;
        %时刻
        time = vehicleData(asi,5);
        
        %如果有车道速度为0，则忽略该车道
        for tmpi = asi :asi+2
            if(vehicleData(tmpi,4) == 0)
                laneNum = laneNum - 1;
            end
        end
        
        %如果三车道均为0，则该路段速度为0
        if(laneNum == 0)
            oneAverageSpeed = 0;
        elseif(laneNum ~= 0)
            oneAverageSpeed = averageSpeedSum / laneNum;
        end
        
        %保存数据
        averageSpeed(averageSpeedLabel,1) = time;
        averageSpeed(averageSpeedLabel,2) = oneAverageSpeed;
        averageSpeedLabel = averageSpeedLabel + 1;
    end
    
    averageSpeed(all(averageSpeed == 0,2),:) = [];
 


end