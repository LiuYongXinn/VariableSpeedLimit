package com.vissim.service.dataprocess.impl;

import com.vissim.pojo.VehicleDataBefore;
import com.vissim.service.dataprocess.VehicleDataBeforeService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class VehicleDataBeforeServiceImplTest {

    @Autowired
    VehicleDataBeforeService vehicleDataBeforeService;

    @Test
    public void testInsertVehicleDataBefore(){
        VehicleDataBefore vehicleData = new VehicleDataBefore(1,1,1,1,1,1,
                1,1,1,1,1,1,1,1);
        vehicleDataBeforeService.insertVehicleDataBefore(vehicleData);
    }
}