%% 每时刻路段冲突次数统计

%% 
function PETTimes = PETTimesCalculate_All(step, vehicleDataLane1, vehicleDataLane2, vehicleDataLane3, vehicleDataLane4)
%车辆越过侵入线的时刻
global invadeTimeLane1 invadeTimeLane2
%辅助数
global invadeTimeLane1Number invadeTimeLane2Number 
%越过侵入先的起始车辆
global invadeTimeNumber1 invadeTimeNumber2 
global PETSumNumber PETSum;

%统计一、二、三车道的车辆数
lane1PETNum = size(vehicleDataLane1,1);
lane2PETNum = size(vehicleDataLane2,1);



%%一车道PET
[invadeTimeLane1Number, invadeTimeLane1,invadeTimeNumber1] =...
    OneLanePETTimesCalculate_All(vehicleDataLane1, 1, step, invadeTimeLane1Number, invadeTimeLane1,invadeTimeNumber1);

%%二车道PET
[invadeTimeLane2Number, invadeTimeLane2,invadeTimeNumber2] =...
    OneLanePETTimesCalculate_All(vehicleDataLane2, 2, step, invadeTimeLane2Number, invadeTimeLane2,invadeTimeNumber2);

%统计路段的车辆数
allLanePETTimes = lane1PETNum + lane2PETNum;


%如果存在第四车道，则将第三车道纳入统计，否则只计算二车道
if(exist("vehicleDataLane3", "var"))
    global invadeTimeLane3 invadeTimeLane3Number invadeTimeNumber3
    
    lane3PETNum = size(vehicleDataLane3,1);
    %%三车道PET
    [invadeTimeLane3Number, invadeTimeLane3,invadeTimeNumber3] =...
        OneLanePETTimesCalculate_All(vehicleDataLane3, 3, step, invadeTimeLane3Number, invadeTimeLane3,invadeTimeNumber3);
    allLanePETTimes = allLanePETTimes +  + lane3PETNum;
end

%如果存在第四车道，则将第四车道纳入统计，否则只计算三车道
if(exist("vehicleDataLane4", "var"))
    global  invadeTimeLane4 invadeTimeLane4Number invadeTimeNumber4
    %%四车道PET
    [invadeTimeLane4Number, invadeTimeLane4,invadeTimeNumber4] =...
        OneLanePETTimesCalculate_All(vehicleDataLane4, 4, step, invadeTimeLane4Number, invadeTimeLane4,invadeTimeNumber4);
    %统计第四车道的车辆数
    lane4PETNum = size(vehicleDataLane4,1);
    %计算路段的车辆数
    allLanePETTimes = allLanePETTimes+ lane4PETNum;
end


%统计PET次数
if( allLanePETTimes ~= 0)
    PETTimes = AgentOverValueTime_2248(PETSum,PETSumNumber,step,1);
else
    PETTimes = 0;
end

    
end