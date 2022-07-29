%% 统计学习过程中的某次仿真的平均速度、平均密度和平均流量
% linkEvaluation = [volume, denstiy, averageSpeed, simulationTime, laneNumber, ...
%   LinkNumber, SegmentStartCoordinate, SegmentEndCoordinate]
%%
function averageDensity = AgentAverageSpeedFLowCalculate_2248(linkEvaluation)

    lineNum =  size(linkEvaluation,1);
    rowNum = size(linkEvaluation,2);
    link2Data= zeros(lineNum,rowNum);
    link2Num = 1;
    %提取路段2的路网数据
    for lei = 1 : lineNum
        linkNumer = linkEvaluation(lei, 6);
        if(linkNumer ~= 2)
            continue;
        end
        linkCoord = linkEvaluation(lei, 7);
        if(linkCoord ~= 0)
            continue;
        end
        link2Data(link2Num, :) = linkEvaluation(lei,:);
        link2Num = link2Num + 1;
    end
    link2Num = link2Num - 1;
    link2Data(all(link2Data == 0,2), :) = [];
    
    
     %提取900-1200秒的车辆数据
     vhNum = link2Num;
     vehicleData = zeros(vhNum, rowNum);
     vdLabel = 1;
     
     for vdi = 1 : vhNum
         simulationTime = link2Data(vdi, 4);
         if(~(simulationTime >= 900 && simulationTime <= 1200))
            continue;
         end
        vehicleData(vdLabel, :) = link2Data(vdi,:);
        vdLabel = vdLabel + 1;
         
     end
     vehicleData(all(vehicleData == 0,2), :) = [];
     vdLabel = vdLabel - 1;
     
     %统计本次仿真的平均速度和平均密度

     averageDensitySum = 0;
     aveDLabel = 0;

     
     %平均速度、平均密度和平均流量的累加
     for vdj = 1 : vdLabel
         oneDensity = vehicleData(vdj,2);
         %去除密度为0的数据
         if (oneDensity ~= 0)
             averageDensitySum = averageDensitySum + oneDensity;
             aveDLabel = aveDLabel + 1;
         end

     end
     
      %平均速度、平均密度和平均流量
      averageDensity = averageDensitySum / aveDLabel;

%     lineNum =  size(linkEvaluation,1);
%     rowNum = size(linkEvaluation,2);
%     link2Data= zeros(lineNum,rowNum);
%     link2Num = 1;
%     %提取路段2的路网数据
%     for lei = 1 : lineNum
%         linkNumer = linkEvaluation(lei, 6);
%         if(linkNumer ~= 2)
%             continue;
%         end
%         linkCoord = linkEvaluation(lei, 7);
%         if(linkCoord ~= 0)
%             continue;
%         end
%         link2Data(link2Num, :) = linkEvaluation(lei,:);
%         link2Num = link2Num + 1;
%     end
%     link2Num = link2Num - 1;
%     link2Data(all(link2Data == 0,2), :) = [];
%     
%     
%      %提取900-1200秒的车辆数据
%      vhNum = link2Num;
%      vehicleData = zeros(vhNum, rowNum);
%      vdLabel = 1;
%      
%      for vdi = 1 : vhNum
%          simulationTime = link2Data(vdi, 4);
%          if(~(simulationTime >= 900 && simulationTime <= 1200))
%             continue;
%          end
%         vehicleData(vdLabel, :) = link2Data(vdi,:);
%         vdLabel = vdLabel + 1;
%          
%      end
%      vehicleData(all(vehicleData == 0,2), :) = [];
%      vdLabel = vdLabel - 1;
%      
%      %统计本次仿真的平均速度和平均密度
%      averageSpeedSum = 0;
%      aveSLabel = 0;
%      averageDensitySum = 0;
%      aveDLabel = 0;
%      averageVolumeSum = 0;
%      aveVLabel = 0;
%      
%      %平均速度、平均密度和平均流量的累加
%      for vdj = 1 : vdLabel
%          oneVolume = vehicleData(vdj,1);
%          oneDensity = vehicleData(vdj,2);
%          oneSpeed = vehicleData(vdj, 3);
%          %去除速度为0的数据
%          if(oneSpeed ~= 0)
%              averageSpeedSum = averageSpeedSum + oneSpeed;
%              aveSLabel = aveSLabel + 1;
%          end
%          %去除密度为0的数据
%          if (oneDensity ~= 0)
%              averageDensitySum = averageDensitySum + oneDensity;
%              aveDLabel = aveDLabel + 1;
%          end
%          %去除流量为0的数据
%          if(oneVolume ~= 0)
%             averageVolumeSum = averageVolumeSum + oneVolume;
%             aveVLabel = aveVLabel + 1;
%          end
%      end
%      
%       %平均速度、平均密度和平均流量
%       averageSpeed = averageSpeedSum / aveSLabel;
%       averageDensity = averageDensitySum / aveDLabel;
%       averageVolume = averageVolumeSum / aveVLabel;
end
