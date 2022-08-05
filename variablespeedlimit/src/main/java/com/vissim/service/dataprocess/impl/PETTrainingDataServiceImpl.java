package com.vissim.service.dataprocess.impl;

import com.vissim.mapper.PETTrainingDataMapper;
import com.vissim.service.dataprocess.PETTrainingDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PETTrainingDataServiceImpl implements PETTrainingDataService {

    @Autowired
    PETTrainingDataMapper petTrainingDataMapper;

}
