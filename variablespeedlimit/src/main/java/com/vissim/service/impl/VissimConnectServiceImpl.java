package com.vissim.service.impl;

import com.jacob.activeX.ActiveXComponent;
import com.vissim.service.VissimConnectService;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;


@Service
@ConfigurationProperties(prefix = "vissim")
public class VissimConnectServiceImpl implements VissimConnectService {

    private String filePath;
    private String fileName;
    private ActiveXComponent vissim;
    private ActiveXComponent simulation;
    private ActiveXComponent net;


    private ActiveXComponent evaluation;



    public VissimConnectServiceImpl() {
        initVissim();
    }

    /**
     * 根据场景路径初始化VISSIM的各个接口
     */

    public void initVissim(){
        //获取vissim连接端口
        vissim = new ActiveXComponent("VISSIM.vissim.430");

        //设置一级接口
        net =  vissim.invokeGetComponent("Net");
        simulation = vissim.invokeGetComponent("Simulation");
        evaluation = vissim.invokeGetComponent("Evaluation");

    }
    @PostConstruct
    public void connectModel(){
        //导入vissim场景
        String iniPath = filePath + fileName + ".ini";
        String inpPath = filePath + fileName + ".inp";
        vissim.invoke("LoadNet", inpPath);
        vissim.invoke("LoadLayout", iniPath);
    }

    public String getFilePath() {
        return filePath;
    }

    public String getFileName() {
        return fileName;
    }

    public ActiveXComponent getVissim() {
        return vissim;
    }

    public ActiveXComponent getSimulation() {
        return simulation;
    }

    public ActiveXComponent getNet() {
        return net;
    }

    public ActiveXComponent getEvaluation() {
        return evaluation;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public void setVissim(ActiveXComponent vissim) {
        this.vissim = vissim;
    }

    public void setSimulation(ActiveXComponent simulation) {
        this.simulation = simulation;
    }

    public void setNet(ActiveXComponent net) {
        this.net = net;
    }

    public void setEvaluation(ActiveXComponent evaluation) {
        this.evaluation = evaluation;
    }


}
