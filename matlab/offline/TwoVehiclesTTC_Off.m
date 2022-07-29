%% 相邻两辆车的TTC计算
function [ID1, ID2, TTC, time, lane] = TwoVehiclesTTC_Off(vehicle1,vehicle2)
    global invadeLine_Off
    
    %当前时刻
    time = vehicle1(1,3);
    
    %所在车道
    lane = vehicle1(1,1);
    
    %前车数据
    ID1 = vehicle1(1,2);
    speed1 = vehicle1(1,4);
    linkCoord1 = vehicle2(1,5);
    distance1 = invadeLine_Off - linkCoord1;
    beyondTime1 = distance1 / speed1;
    
    %后车数据
    ID2 = vehicle2(1,2);
    speed2 = vehicle2(1,4);
    linkCoord2 = vehicle2(1,5);
    distance2 = invadeLine_Off - linkCoord2;
    beyondTime2 = distance2 / speed2;

    %TTC计算
    TTC = beyondTime2 - beyondTime1;

end