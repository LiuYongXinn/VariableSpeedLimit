package com.vissim.controller;

import com.vissim.pojo.WeatherEnum;
import com.vissim.service.vissimService.EvaluationService;
import com.vissim.service.vissimService.NetService;
import com.vissim.service.vissimService.SimulationService;
import com.vissim.service.vissimService.VissimConnectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

/**
 * 施工区场景
 */
@Controller
public class ConstructionArea {

    @Autowired
    VissimConnectService vissimConnectService;
    @Autowired
    SimulationService simulationService;
    @Autowired
    NetService netService;

    @Autowired
    EvaluationService evaluationService;


    public void Simulation(int simulationTime, int randSeed, int volume, int speedLimitAction, int sceneAction){
        int step = 1;
        //实施控制的时间
        int controlTime  = simulationTime / 2;

        try {
            //仿真参数设置
            simulationService.initRandomSeed(randSeed);
            simulationService.initSimulationTime(simulationTime);
            netService.setVehicleInputByNo(1, volume);
            netService.setReduceAreaStartTime(controlTime);
            netService.setDrivingBehavior(WeatherEnum.LIGHT_RAIN);

            //开始仿真
            while (step <= simulationTime){
                simulationService.RunSingleStep();
                //实施控制
                if (step == controlTime){
                    netService.setSpeedLimitAreaAction(speedLimitAction);
                    netService.setSceneAction(sceneAction);
                }
                step++;
            }
        } finally {
            //结束仿真
            simulationService.Stop();
        }

    }




}
