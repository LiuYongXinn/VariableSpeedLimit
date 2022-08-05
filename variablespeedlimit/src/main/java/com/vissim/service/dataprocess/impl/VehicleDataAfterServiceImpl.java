package com.vissim.service.dataprocess.impl;

import com.vissim.mapper.VehicleDataAfterMapper;
import com.vissim.service.dataprocess.VehicleDataAfterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class VehicleDataAfterServiceImpl implements VehicleDataAfterService {
    @Autowired
    VehicleDataAfterMapper vehicleDataAfterMapper;



}
