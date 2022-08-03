package com.vissim.service.impl;

import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.Dispatch;
import com.vissim.service.SimulationService;
import com.vissim.service.VissimConnectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;

/**
 * 设置仿真时间simulation
 * 设置随机种子
 * 仿真开始与结束
 * 设置仿真速度
 * 设置仿真精度
 *
 */
@Service
@ConfigurationProperties(prefix = "simulation")
public class SimulationServiceImpl implements SimulationService {

    @Autowired
    VissimConnectService vissimConnectService;

    private ActiveXComponent simulation;
    private Integer simulationTime;
    private Integer randomSeed;
    private Integer resolution;
    private Integer speed;


    public SimulationServiceImpl(VissimConnectService vissimConnectService) {
        simulation = vissimConnectService.getSimulation();
    }

    @PostConstruct
    public void initSimulation(){

        Dispatch.put(simulation, "RandomSeed", randomSeed);
        Dispatch.put(simulation,"Period", simulationTime);
        Dispatch.put(simulation, "Resolution", resolution);
        Dispatch.put(simulation, "Speed", speed);
    }


    public void initRandomSeed(Integer randomSeed){
        this.randomSeed = randomSeed;
        Dispatch.put(simulation, "RandomSeed", randomSeed);
    }

    public void initSimulationTime(Integer simulationTime){
        this.simulationTime = simulationTime;
        Dispatch.put(simulation,"Period", simulationTime);
    }

    public void initResolution(Integer resolution){
        this.resolution = resolution;
        Dispatch.put(simulation, "Resolution", resolution);
    }

    public void initSimulationSpeed(Integer speed){
        this.speed = speed;
        Dispatch.put(simulation, "Speed", speed);
    }

    //开始仿真
    public void RunContinuous(){
        Dispatch.call(simulation, "RunContinuous");
    }
    //单步执行仿真
    public void RunSingleStep(){
        Dispatch.call(simulation, "RunSingleStep");
    }

    //终止仿真
    public void Stop(){
        Dispatch.call(simulation, "Stop");
    }

    public Integer getSimulationTime() {
        return simulationTime;
    }

    public void setSimulationTime(Integer simulationTime) {
        this.simulationTime = simulationTime;
    }

    public Integer getRandomSeed() {
        return randomSeed;
    }

    public void setRandomSeed(Integer randomSeed) {
        this.randomSeed = randomSeed;
    }

    public Integer getResolution() {
        return resolution;
    }

    public void setResolution(Integer resolution) {
        this.resolution = resolution;
    }

    public Integer getSpeed() {
        return speed;
    }

    public void setSpeed(Integer speed) {
        this.speed = speed;
    }

    public ActiveXComponent getSimulation() {
        return simulation;
    }

    public void setSimulation(ActiveXComponent simulation) {
        this.simulation = simulation;
    }

}
