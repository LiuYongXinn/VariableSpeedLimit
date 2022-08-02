package com.vissim.service;

import com.jacob.activeX.ActiveXComponent;

public interface NetService {



    //根据Id获取单车道减速区域
    void getDesiredSpeedDecisionByNo(Integer no, Integer limitSpeed, Integer vehicleType);

    //设置流量
    void setVehicleInputByNo(Integer no, Integer volume);

    //获取当前时刻道路的车辆数据
    void getVehiclesInSimulation();


    ActiveXComponent getNet();
    ActiveXComponent getLinks();
    ActiveXComponent getNodes();
    ActiveXComponent getDrivingBehaviorParSets();
    ActiveXComponent getVehicleInputs();
    ActiveXComponent getVehicles();
    ActiveXComponent getDesiredSpeedDecisions();
    ActiveXComponent getReducedSpeedAreas();
    ActiveXComponent getDataCollections();
    ActiveXComponent getQueueCounters();
    ActiveXComponent getTravelTimes();
    ActiveXComponent getDelays();






}
