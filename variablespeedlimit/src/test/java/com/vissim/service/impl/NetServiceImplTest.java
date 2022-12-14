package com.vissim.service.impl;

import com.jacob.activeX.ActiveXComponent;
import com.vissim.service.vissimService.NetService;
import com.vissim.service.vissimService.impl.VissimConnectServiceImpl;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class NetServiceImplTest {

    @Autowired
    VissimConnectServiceImpl vissimConnectServiceImpl;

    @Autowired
    NetService netService;

    @Test
    public void testNet(){
        ActiveXComponent net = netService.getNet();
        System.out.println(net);
    }



    @Test
    public void testGetDesiredSpeedDecisionByNo(){
        netService.setReduceAreaByNo(3, 1000, 10);
    }

    @Test
    public void testSetVehicleInputByVolume(){
        netService.setVehicleInputByNo(1, 3000);
    }


    @Test
    public void testGetVehiclesInSimulation(){



    }






}