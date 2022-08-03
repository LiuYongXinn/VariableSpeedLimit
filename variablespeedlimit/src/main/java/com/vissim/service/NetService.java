package com.vissim.service;

import com.jacob.activeX.ActiveXComponent;
import com.vissim.pojo.Vehicle;
import com.vissim.pojo.WeatherEnum;

import java.util.List;

public interface NetService {


    //设置限速区的动作
    void setSpeedLimitAreaAction(Integer limitSpeed);

    //设置场景区的动作
    void setSceneAction(Integer action);

    //根据ID设置减速区域开始限速时间
    void setReduceAreaStartTimeByNo(Integer no, Integer startTime);

    //设置仿真场景减速区域启动时间
    void setReduceAreaStartTime(Integer startTime);


    //根据Id获取单车道减速区域
    void setReduceAreaByNo(Integer no, Integer limitSpeed, Integer vehicleType);


    //设置流量
    void setVehicleInputByNo(Integer no, Integer volume);

    //获取当前时刻道路的车辆数据
    List<Vehicle> getVehiclesByStep(Integer step);

    //获取当前时刻得交通流数据
    void getLinkInfoByStep(int step);

    //根据天气条件设置仿真场景的驾驶行为
    void setDrivingBehavior(WeatherEnum weather);

    //获取当前天气条件的驾驶行为
    Double[] getDrivingBehavior();


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
