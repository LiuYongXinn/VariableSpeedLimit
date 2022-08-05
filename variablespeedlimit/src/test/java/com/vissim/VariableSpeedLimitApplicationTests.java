package com.vissim;

import com.vissim.controller.ConstructionArea;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class VariableSpeedLimitApplicationTests {

    @Autowired
    ConstructionArea constructionArea;

    @Test
    void simulationFramework() {
        int simulationTime = 1000;
        int randSeed = 60;
        int volume = 3000;
        int speedLimitAction = 50;
        int sceneAction = 70;
        constructionArea.Simulation(simulationTime, randSeed, volume, speedLimitAction, sceneAction);
    }


}
