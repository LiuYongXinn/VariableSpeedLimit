%% TTC计算
% 输入
% TTCSumIn          ： 所有时刻的TTC总和
% TTCSumNumberIn    ： TTC总和标签
% vehicleDataIn     ： 车辆数据
% step              ： 仿真时刻
% 输出
% TTCSum            ：  当前时刻及之前的时刻的TTC总和
% TTCSumNumber      ：  总和标签
%%
function [TTCSum,TTCSumNumber] = AgentCalculateTTC_2248(TTCSumIn, TTCSumNumberIn,vehicleDataIn, step)
    vehicleDataNumber = size(vehicleDataIn,1);
    for vdi = 1 : vehicleDataNumber-1
        %计算每两辆车之间的TTC
        [id1,id2,vehicleTTC] = OneVehicleTTC(vehicleDataIn(vdi,3),vehicleDataIn(vdi,4),vehicleDataIn(vdi,5),...
            vehicleDataIn(vdi+1,3),vehicleDataIn(vdi+1,4),vehicleDataIn(vdi+1,5));
        vehicleTTCTemp = [step, id1,id2,vehicleTTC];
        %保存TTC数据
        TTCSumIn(TTCSumNumberIn,:) = vehicleTTCTemp;
        TTCSumNumberIn = TTCSumNumberIn + 1;
    end

    TTCSum = TTCSumIn;
    TTCSumNumber = TTCSumNumberIn;
end


%% 计算每两车辆之间的TTC
function [vehicle1Id, vehicle2Id, vehicleTTC] = OneVehicleTTC(id1,speedkmh1,linkCoord1,id2,speedkmh2,linkCoord2)
    global invadeLine;

    %前车数据
    vehicle1Id = id1;
    distance1 = invadeLine - linkCoord1;
    speedms1 = (speedkmh1 * 1000)/(60*60);
    time1 = distance1 / speedms1;

    %后车数据
    vehicle2Id = id2;
    distance2 = invadeLine - linkCoord2;
    speedms2 = (speedkmh2 * 1000)/(60*60);
    time2 = distance2 / speedms2;

    %计算TTC
    if speedkmh2 > speedkmh1
        vehicleTTC = time2 - time1;
    else
        vehicleTTC = 1000000;
    end


end