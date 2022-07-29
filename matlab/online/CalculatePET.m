%% 计算车辆PET
   %invadeTime          : 存储车辆越过侵入线时刻的数据
   %invadeTimeNumber    : 越过侵入线的起始车辆数
   %vehicleData         : 车辆数据
   %laneDataNunmber     ：计数
   %PETLane             : 车道上车辆PET数据
   %PETNumber           : 计数
   %PETTimse            : PET超过阈值的次数，阈值：4.14
%%
function [invadeTimeNumber,invadeTime,laneDataNumber,PETLane,PETNumber] = ...
    CalculatePET(vehicleData,invadeTimeNumberIn,invadeTimeIn,laneDataNumberIn,PETLaneIn,PETNumberIn,step1, allStepVehiclePETNumber,lane)
    

    vehicleDataNum = size(vehicleData,1);
    
    %记录前10秒通过的车辆数                   add in 2021-12-26
    lastVehicleNumer = 0;
    for i = 1 : 10
        lastVehicleNumer = lastVehicleNumer + allStepVehiclePETNumber(lane,step1-i);
        if(step1-i == 0)
           break; 
        end
    end
    
    %检查重复的起始索引位置
    if(laneDataNumberIn- lastVehicleNumer <= 0)
       startNumber = 1; 
    else
        startNumber = laneDataNumberIn- lastVehicleNumer;
    end
    
    
    for vdi = 1 : vehicleDataNum
        %计算每一车辆越过侵入线的时刻
        [id, step, vehicleinvadeTime] = CalculateInvadeTime(vehicleData(vdi,2),vehicleData(vdi,3),vehicleData(vdi,4),vehicleData(vdi,5));
        invadeTimeTemp = [id, step, vehicleinvadeTime];
        %标记，用于记录车辆是否重复出现
        labelI = 1;
        
        %第一次检测到车辆
        if laneDataNumberIn == 0
            invadeTimeIn(invadeTimeNumberIn,:) = invadeTimeTemp;
            invadeTimeNumberIn = invadeTimeNumberIn + 1;
            laneDataNumberIn = laneDataNumberIn + 1;
        %后面检测到的车辆中，一辆车在invadeTime中已经存在，则删除改数据
        elseif laneDataNumberIn > 0
            
            for itj = startNumber : laneDataNumberIn
               if id == invadeTimeIn(itj,1)
                  invadeTimeTemp = [];
                  labelI = 0;
               end   
            end
            %若车辆为第一次出现，即labelI = 1，则将数据导入invadeTime
            if(labelI)
                invadeTimeIn(invadeTimeNumberIn,:) = invadeTimeTemp;
                invadeTimeNumberIn = invadeTimeNumberIn + 1;
                %有问题，
                laneDataNumberIn = laneDataNumberIn + 1;
            end
            
            % 计算PET
            if laneDataNumberIn >1 && labelI == 1
                [vehicleId1,vehicleId2,vehiclePET] = ...
                    OneVehiclePET(invadeTimeIn(invadeTimeNumberIn-1,1),invadeTimeIn(invadeTimeNumberIn-1,3),...
                    invadeTimeIn(invadeTimeNumberIn-2,1),invadeTimeIn(invadeTimeNumberIn-2,3));
                
                %保存PET数据
                PETTemp = [step1, vehicleId1, vehicleId2, vehiclePET];
                PETLaneIn(PETNumberIn,:) = PETTemp;
                PETNumberIn = PETNumberIn + 1;
            end
        end
    end
 
    
    %导出数据
    invadeTimeNumber = invadeTimeNumberIn;
    invadeTime = invadeTimeIn;
    laneDataNumber = laneDataNumberIn;
    PETLane = PETLaneIn;
    PETNumber = PETNumberIn;

end

%% 车辆通过侵入线的时刻
function [Id,Step,invadeTime] = CalculateInvadeTime(Step1,ID1,speedkmh1,Linkcoord1)
    %input          
    %Step1          ：记录时车辆所处时间
    %ID1            ：记录时车辆的ID
    %Speed1         ：记录时车辆的速度
    %Linkcoord1     ：记录时车辆的位置
    %output
    %Id             ：越过侵入线时车辆的ID
    %Step           ：记录时车辆所处时间
    %T              ：车辆越过侵入线的时刻

    global invadeLine;
    distance = Linkcoord1 - invadeLine;
    speedms1 = (speedkmh1 * 1000)/(60*60);
    beyondTime = distance / speedms1;
    
    invadeTime = Step1 - beyondTime;
    Id = ID1;
    Step = Step1;
end


%% 每两辆车的PET计算
function [vehicle1Id,vehicle2Id,PET] = OneVehiclePET(Id1,T1,Id2,T2)
    %input
    %Id1            ：后车ID
    %T1             ：后车通过侵入线的时间
    %Id2            ：前车ID
    %T2             ：前车通过侵入线的时间
    %output
    %vehicle1_Id    ：后车ID
    %vehicle2_Id    ：前车ID
    %PET            ：两车之间的PET
    
    PET = T1 - T2;
    vehicle1Id = Id1;
    vehicle2Id = Id2;   
end