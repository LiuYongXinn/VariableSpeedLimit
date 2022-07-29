%% 车辆输出设置
function VehicleInputsSetting(netVehicleInputs,mainVolume,auxiliaryVolume,evaluationTime,evaluationTimeLabel)

    %主干道
    vehicleInputsLink1 = netVehicleInputs.GetVehicleInputByNumber(1);
    %设置主干道车流量
    vehicleInputsLink1.set('AttValue', 'Volume',mainVolume);
    %匝道
    vehicleInputsLink2 = netVehicleInputs.GetVehicleInputByNumber(2);
    %设置匝道车流量
    vehicleInputsLink2.set('AttValue', 'Volume',auxiliaryVolume);
    
    if(evaluationTimeLabel == 1)
        vehicleInputsLink1.set('AttValue', 'TIMEUNTIL',evaluationTime);
        vehicleInputsLink2.set('AttValue', 'TIMEUNTIL',evaluationTime);
    end

end