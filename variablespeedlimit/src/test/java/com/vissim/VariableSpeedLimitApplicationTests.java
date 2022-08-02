package com.vissim;

import com.jacob.activeX.ActiveXComponent;
import com.vissim.service.NetService;
import com.vissim.service.SimulationService;
import com.vissim.service.VissimConnectService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class VariableSpeedLimitApplicationTests {

    @Autowired
    VissimConnectService vissimConnectService;
    @Autowired
    SimulationService simulationService;
    @Autowired
    NetService netService;




    @Test
    void simulationFramework() {
        int step = 1;
        int simulationTime = 1000;
        int randSeed = 10;
        int volume = 3000;
        simulationService.initRandomSeed(randSeed);
        simulationService.initSimulationTime(simulationTime);

        netService.setVehicleInputByNo(1, volume);

        try {
            while (step <= simulationTime){
                simulationService.RunSingleStep();

                System.out.println("step = " + step);
                if(step >= 10){
                    netService.getVehiclesInSimulation();

                }


                step++;
            }
        } finally {
            simulationService.Stop();
        }











    }

}
