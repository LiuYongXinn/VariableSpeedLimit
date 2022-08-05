package com.vissim.service.dataprocess.impl;

import com.vissim.mapper.DensityTrainingDataMapper;
import com.vissim.service.dataprocess.DensityTrainingDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DensityTrainingDataServiceImpl implements DensityTrainingDataService {

    @Autowired
    DensityTrainingDataMapper densityTrainingDataMapper;
}
