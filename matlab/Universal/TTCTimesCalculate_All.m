%% 仿真过程TTC数据采集

%%
function TTCTimes = TTCTimesCalculate_All(step, vehicleDataLane1, vehicleDataLane2, vehicleDataLane3, vehicleDataLane4)
global TTCSum TTCSumNumber;

%一车道TTC计算
vehicleDataLane1Num = size(vehicleDataLane1,1);
OneLaneTTCCTimesalculate_All(step, vehicleDataLane1,vehicleDataLane1Num);
%二车道TTC计算
vehicleDataLane2Num = size(vehicleDataLane2,1);
OneLaneTTCCTimesalculate_All(step, vehicleDataLane2,vehicleDataLane2Num);

%路段车辆数
vehicleDataSum = vehicleDataLane1Num + vehicleDataLane2Num;


%如果三车道存在,则进行操作
if(exist("vehicleDataLane3","var"))
    vehicleDataLane3Num = size(vehicleDataLane3,1);
    OneLaneTTCCTimesalculate_All(step, vehicleDataLane3, vehicleDataLane3Num);
    vehicleDataSum = vehicleDataSum + vehicleDataLane3Num;
end

%如果四车道存在,则进行操作
if(exist("vehicleDataLane4","var"))
    vehicleDataLane4Num = size(vehicleDataLane4,1);
    OneLaneTTCCTimesalculate_All(step, vehicleDataLane4, vehicleDataLane4Num);
    vehicleDataSum = vehicleDataSum + vehicleDataLane4Num;
end


if(vehicleDataSum ~= 0)
    TTCTimes = OverValueTime(TTCSum,TTCSumNumber,step,-1);
else
    TTCTimes = 0;
end

end