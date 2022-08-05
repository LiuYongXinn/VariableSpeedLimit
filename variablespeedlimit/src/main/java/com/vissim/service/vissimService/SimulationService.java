package com.vissim.service.vissimService;

import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.Dispatch;

public interface SimulationService {

    void initSimulation();

    void initRandomSeed(Integer randomSeed);

    void initSimulationTime(Integer simulationTime);

    void initResolution(Integer resolution);

    void initSimulationSpeed(Integer simulationSpeed);

    //开始仿真
    void RunContinuous();

    //单步执行仿真
    void RunSingleStep();

    //终止仿真
    void Stop();


    void setSimulationTime(Integer simulationTime);


    void setRandomSeed(Integer randomSeed);


    void setResolution(Integer resolution);


    void setSpeed(Integer speed);


    void setSimulation(ActiveXComponent simulation);

    ActiveXComponent getSimulation();

}
