package com.vissim.service.dataprocess;

import com.vissim.mapper.VehicleDataBeforeMapper;
import com.vissim.pojo.VehicleDataBefore;
import org.springframework.beans.factory.annotation.Autowired;

public interface VehicleDataBeforeService {

    void insertVehicleDataBefore(VehicleDataBefore vehicleData);

}
