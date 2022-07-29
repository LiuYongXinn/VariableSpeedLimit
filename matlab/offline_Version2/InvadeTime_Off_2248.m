%% 计算车辆通过侵入线的时间
% 输入
% vehicleData   ：车辆数据
% vehicleData = [laneNumber, VehicleNumber, simulationTime, speed, linkCoordinate, ...
%   acceleartion, startTime, speedDifference, followingDIstance, leadingVehicle, linkNumber]
% 输出
% invadeTime    ：通过侵入线的时间
% invadeTime = [id, time, lane, invadeTime]
function invadeTime = InvadeTime_Off_2248(vehicleData)
    vehicleDataNum = size(vehicleData,1);
    %存储侵入时间数据
    invadeTimeTmp = zeros(vehicleDataNum,4);
    invadeTimeNumber = 1;
    
    for vdi = 1 : vehicleDataNum
        %计算每辆车通过侵入线的时间
        [id, time, lane, oneVehicleInvadeTime] = OneVehicleInvadeTime_Off(vehicleData(vdi,:));
        %保存数据
        invadeTimeTmp(invadeTimeNumber,:) = [id, time, lane, oneVehicleInvadeTime];
        invadeTimeNumber = invadeTimeNumber + 1;
    end
    
    %将数组颠倒，按步长从大到小排序
    invadeTimeTmpReverse = flipud(invadeTimeTmp);
    reverseNum = size(invadeTimeTmpReverse,1);
    
     %删除重复出现数据
    for iti = 1 : reverseNum-1
        %获取车辆id和步长
        IdTmp = invadeTimeTmpReverse(iti,1);
        %判断是否有重复
        for itj = iti + 1 : reverseNum
           if(invadeTimeTmpReverse(itj,1) == IdTmp)
               invadeTimeTmpReverse(iti,:) = zeros(1,4);
               break;
           end
        end
    end
    invadeTimeTmpReverse(all(invadeTimeTmpReverse == 0,2), :) = [];
    
    %将数组还原
    invadeTime = flipud(invadeTimeTmpReverse);
end


%% 单一车辆侵入时间计算
function [id, time, lane, invadeTime] = OneVehicleInvadeTime_Off(vehicleData)
    %侵入线位置
    global invadeLine_Off
    
    %获取车辆数据
    lane = vehicleData(1,1);
    id = vehicleData(1,2);
    time = vehicleData(1,3);
    speed= vehicleData(1,4);
    linkCoord = vehicleData(1,5);
    
    %车辆驶过侵入线的距离
    distance = linkCoord - invadeLine_Off;
    %车辆试过侵入线的时间
    beyondTime = distance / speed;
    %侵入时间
    invadeTime = time - beyondTime;
    
end