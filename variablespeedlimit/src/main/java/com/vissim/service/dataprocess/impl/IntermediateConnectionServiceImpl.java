package com.vissim.service.dataprocess.impl;

import com.vissim.mapper.IntermediateConnectionMapper;
import com.vissim.service.dataprocess.IntermediateConnectionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class IntermediateConnectionServiceImpl implements IntermediateConnectionService {

    @Autowired
    IntermediateConnectionMapper intermediateConnectionMapper;
}
