package com.vissim.service.dataprocess.impl;

import com.vissim.mapper.VehicleDataBeforeMapper;
import com.vissim.pojo.VehicleDataBefore;
import com.vissim.service.dataprocess.VehicleDataBeforeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class VehicleDataBeforeServiceImpl implements VehicleDataBeforeService {

    @Autowired
    VehicleDataBeforeMapper vehicleDataBeforeMapper;

    public void insertVehicleDataBefore(VehicleDataBefore vehicleData){
        vehicleDataBeforeMapper.insert(vehicleData);
    }


}
