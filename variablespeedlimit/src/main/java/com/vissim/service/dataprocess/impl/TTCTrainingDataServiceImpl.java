package com.vissim.service.dataprocess.impl;

import com.vissim.mapper.TTCTrainingDataMapper;
import com.vissim.service.dataprocess.TTCTrainingDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TTCTrainingDataServiceImpl implements TTCTrainingDataService {

    @Autowired
    TTCTrainingDataMapper ttcTrainingDataMapper;

}
