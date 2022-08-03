package com.vissim.controller;

import com.vissim.pojo.Vehicle;
import com.vissim.pojo.WeatherEnum;
import com.vissim.service.NetService;
import com.vissim.service.SimulationService;
import com.vissim.service.VissimConnectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import java.util.Arrays;
import java.util.List;

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
