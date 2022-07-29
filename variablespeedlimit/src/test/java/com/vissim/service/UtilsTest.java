package com.vissim.service;

import com.jacob.activeX.ActiveXComponent;
import com.vissim.service.impl.NetServiceImpl;
import com.vissim.service.impl.SimulationServiceImpl;
import com.vissim.service.impl.VissimConnectServiceServiceImpl;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;


@SpringBootTest
class UtilsTest {

    @Autowired
    VissimConnectServiceServiceImpl vissimConnectServiceImpl;

    @Autowired
    SimulationService simulationService;

    @Autowired
    NetService netService;


    @Test
    public void testSimulation(){

        ActiveXComponent simulation = simulationService.getSimulation();



    }


}