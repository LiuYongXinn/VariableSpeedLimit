package com.vissim.service.impl;

import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.Dispatch;
import com.jacob.com.EnumVariant;
import com.jacob.com.Variant;
import com.vissim.pojo.Vehicle;
import com.vissim.pojo.WeatherEnum;
import com.vissim.service.NetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
@ConfigurationProperties(prefix = "net")
public class NetServiceImpl implements NetService {

    @Autowired
    VissimConnectServiceServiceImpl vissimConnectServiceImpl;
    private ActiveXComponent net;
    private ActiveXComponent links;
    private ActiveXComponent nodes;
    private ActiveXComponent drivingBehaviorParSets;
    private ActiveXComponent vehicleInputs;
    private ActiveXComponent vehicles;
    private ActiveXComponent desiredSpeedDecisions;
    private ActiveXComponent reducedSpeedAreas;
    private ActiveXComponent dataCollections;
    private ActiveXComponent queueCounters;
    private ActiveXComponent travelTimes;
    private ActiveXComponent delays;

    private WeatherEnum weatherEnum;


    public NetServiceImpl(VissimConnectServiceServiceImpl vissimConnectServiceImpl) {
        net = vissimConnectServiceImpl.getNet();
        //设置net下的二级接口
        links = net.invokeGetComponent("Links");
        nodes = net.invokeGetComponent("Nodes");
        drivingBehaviorParSets = net.invokeGetComponent("DrivingBehaviorParSets");
        vehicleInputs = net.invokeGetComponent("VehicleInputs");
        vehicles = net.invokeGetComponent("Vehicles");
        desiredSpeedDecisions = net.invokeGetComponent("DesiredSpeedDecisions");
        reducedSpeedAreas = net.invokeGetComponent("ReducedSpeedAreas");
        dataCollections = net.invokeGetComponent("DataCollections");
        queueCounters = net.invokeGetComponent("queueCounters");
        travelTimes = net.invokeGetComponent("TravelTimes");
        delays = net.invokeGetComponent("Delays");
    }

    /**
     * 设置上游限速区的动作
     * @param limitSpeed 上游限速区的限速值
     */
    @Override
    public void setSpeedLimitAreaAction(Integer limitSpeed) {
        for (int i = 1; i <= 3; i++) {
            this.setReduceAreaByNo(i, limitSpeed, 10);
            this.setReduceAreaByNo(i, limitSpeed, 20);
        }

    }

    /**
     * 设置场景区的动作
     * @param action 场景区的动作值,即场景区的限速值
     */
    @Override
    public void setSceneAction(Integer action) {
        int count = Dispatch.get(reducedSpeedAreas, "Count").getInt();
        for (int i = 4; i <= count ; i++) {
            this.setReduceAreaByNo(i, action, 10);
            this.setReduceAreaByNo(i, action, 20);
        }
    }


    /**
     * 按编号设置单个减速区域启动时间
     * @param no 减速区域的编号
     * @param startTime 减速区域开始限速的启动时间
     */
    @Override
    public void setReduceAreaStartTimeByNo(Integer no, Integer startTime) {
        ActiveXComponent area = reducedSpeedAreas.invokeGetComponent("GetReducedSpeedAreaByNumber", new Variant(no));
        Dispatch.invoke(area, "AttValue", Dispatch.Put, new Object[]{"TimeFrom", startTime}, new int[1]);
    }


    /**
     * 设置场景所有减速区域启动时间
     * @param startTime 启动时间
     */
    @Override
    public void setReduceAreaStartTime(Integer startTime) {
        int count = Dispatch.get(reducedSpeedAreas, "Count").getInt();
        for (int i = 1; i <= count; i++) {
            this.setReduceAreaStartTimeByNo(i, startTime);
        }
    }


    /**
     * 根据id设置减速区域速度
     * @param no 减速区域的编号
     * @param limitSpeed 减速区域的限速值
     * @param vehicleType 减速区域中车辆的类型编号
     */
    public void setReduceAreaByNo(Integer no, Integer limitSpeed, Integer vehicleType){
        ActiveXComponent area = reducedSpeedAreas.invokeGetComponent("GetReducedSpeedAreaByNumber", new Variant(no));
        Dispatch.invoke(area, "AttValue1", Dispatch.Put, new Object[]{"DesiredSpeed",vehicleType, limitSpeed}, new int[1]);
    }


    /**
     * 设置车辆输入流量
     * @param no vehicleInput的编号, 1代表主干道,2表示匝道
     * @param volume 输入的车流量
     */
    @Override
    public void setVehicleInputByNo(Integer no, Integer volume) {
        ActiveXComponent vehicleInput = vehicleInputs.invokeGetComponent("GetVehicleInputByNumber", new Variant(no));
        Dispatch.invoke(vehicleInput,"AttValue", Dispatch.Put, new Object[]{"Volume", volume}, new int[1]);
    }


    /**
     * 查询当前时刻得车辆数据
     * @param step 当前时刻
     * @return 包含路网上当前时刻所有车辆数据的集合
     */
    @Override
    public List<Vehicle> getVehiclesByStep(Integer step) {
        List<Vehicle> vehicleList = new ArrayList<>();
        Variant newEnum = Dispatch.get(vehicles, "_NewEnum");
        EnumVariant vehiclesEnum = newEnum.toEnumVariant();
        while (vehiclesEnum.hasMoreElements()){
            Dispatch vehicleDispatch = vehiclesEnum.nextElement().toDispatch();
            Vehicle vehicle = new Vehicle();
            vehicle.setId(Dispatch.invoke(vehicleDispatch, "AttValue", Dispatch.Get, new Object[]{"ID"}, new int[1]).getInt());
            vehicle.setSpeed(Dispatch.invoke(vehicleDispatch, "AttValue", Dispatch.Get, new Object[]{"Speed"}, new int[1]).getDouble());
            vehicle.setLane(Dispatch.invoke(vehicleDispatch, "AttValue", Dispatch.Get, new Object[]{"Lane"}, new int[1]).getInt());
            vehicle.setLink(Dispatch.invoke(vehicleDispatch, "AttValue", Dispatch.Get, new Object[]{"Link"}, new int[1]).getInt());
            vehicle.setLinkCoordinate(Dispatch.invoke(vehicleDispatch, "AttValue", Dispatch.Get, new Object[]{"LINKCOORD"}, new int[1]).getDouble());
            vehicle.setStep(step);
            vehicleList.add(vehicle);
        }
        return vehicleList;
    }


    /**
     * 根据天气条件设置高速公路场景的驾驶行为
     * @param weather 包含驾驶行为参数的天气条件枚举类
     */
    @Override
    public void setDrivingBehavior(WeatherEnum weather) {
        //保存当前的天气
        this.weatherEnum = weather;

        int weatherIndex = weather.getWeatherIndex();
        //获取所有的道路
        EnumVariant linkEnum = Dispatch.get(links, "_NewEnum").toEnumVariant();
        while (linkEnum.hasMoreElements()){
            Dispatch link = linkEnum.nextElement().toDispatch();
            Dispatch.invoke(link, "AttValue", Dispatch.Put, new Object[]{"TYPE", weatherIndex}, new int[1]);
        }

    }

    /**
     * 获取当前天气条件下高速公路的驾驶模型参数
     * @return 包含cc0-cc9的模型参数数组
     */
    @Override
    public Double[] getDrivingBehavior() {

        //获取高速公路的驾驶行为模型
        ActiveXComponent drivingBehavior = drivingBehaviorParSets.invokeGetComponent("GetDrivingBehaviorParSetByNumber", new Variant(weatherEnum.getWeatherIndex()));
        //获取驾驶行为模型参数
        double cc0 = Dispatch.invoke(drivingBehavior, "AttValue", Dispatch.Get, new Object[]{"CC0"}, new int[1]).getDouble();
        double cc1 = Dispatch.invoke(drivingBehavior, "AttValue", Dispatch.Get, new Object[]{"CC1"}, new int[1]).getDouble();
        double cc2 = Dispatch.invoke(drivingBehavior, "AttValue", Dispatch.Get, new Object[]{"CC2"}, new int[1]).getDouble();
        double cc3 = Dispatch.invoke(drivingBehavior, "AttValue", Dispatch.Get, new Object[]{"CC3"}, new int[1]).getDouble();
        double cc4 = Dispatch.invoke(drivingBehavior, "AttValue", Dispatch.Get, new Object[]{"CC4"}, new int[1]).getDouble();
        double cc5 = Dispatch.invoke(drivingBehavior, "AttValue", Dispatch.Get, new Object[]{"CC5"}, new int[1]).getDouble();
        double cc6 = Dispatch.invoke(drivingBehavior, "AttValue", Dispatch.Get, new Object[]{"CC6"}, new int[1]).getDouble();
        double cc7 = Dispatch.invoke(drivingBehavior, "AttValue", Dispatch.Get, new Object[]{"CC7"}, new int[1]).getDouble();
        double cc8 = Dispatch.invoke(drivingBehavior, "AttValue", Dispatch.Get, new Object[]{"CC8"}, new int[1]).getDouble();
        double cc9 = Dispatch.invoke(drivingBehavior, "AttValue", Dispatch.Get, new Object[]{"CC9"}, new int[1]).getDouble();

        return new Double[]{cc0, cc1, cc2, cc3, cc4, cc5, cc6, cc7, cc8, cc9};

    }



    @Override
    public void getLinkInfoByStep(int step) {
        System.out.println("尚未完善");
    }


    public ActiveXComponent getNet() {
        return net;
    }

    public void setNet(ActiveXComponent net) {
        this.net = net;
    }

    public ActiveXComponent getLinks() {
        return links;
    }

    public void setLinks(ActiveXComponent links) {
        this.links = links;
    }

    public ActiveXComponent getNodes() {
        return nodes;
    }

    public void setNodes(ActiveXComponent nodes) {
        this.nodes = nodes;
    }

    public ActiveXComponent getDrivingBehaviorParSets() {
        return drivingBehaviorParSets;
    }

    public void setDrivingBehaviorParSets(ActiveXComponent drivingBehaviorParSets) {
        this.drivingBehaviorParSets = drivingBehaviorParSets;
    }

    public ActiveXComponent getVehicleInputs() {
        return vehicleInputs;
    }

    public void setVehicleInputs(ActiveXComponent vehicleInputs) {
        this.vehicleInputs = vehicleInputs;
    }

    public ActiveXComponent getVehicles() {
        return vehicles;
    }

    public void setVehicles(ActiveXComponent vehicles) {
        this.vehicles = vehicles;
    }

    public ActiveXComponent getDesiredSpeedDecisions() {
        return desiredSpeedDecisions;
    }

    public void setDesiredSpeedDecisions(ActiveXComponent desiredSpeedDecisions) {
        this.desiredSpeedDecisions = desiredSpeedDecisions;
    }

    public ActiveXComponent getReducedSpeedAreas() {
        return reducedSpeedAreas;
    }

    public void setReducedSpeedAreas(ActiveXComponent reducedSpeedAreas) {
        this.reducedSpeedAreas = reducedSpeedAreas;
    }

    public ActiveXComponent getDataCollections() {
        return dataCollections;
    }

    public void setDataCollections(ActiveXComponent dataCollections) {
        this.dataCollections = dataCollections;
    }

    public ActiveXComponent getQueueCounters() {
        return queueCounters;
    }

    public void setQueueCounters(ActiveXComponent queueCounters) {
        this.queueCounters = queueCounters;
    }

    public ActiveXComponent getTravelTimes() {
        return travelTimes;
    }

    public void setTravelTimes(ActiveXComponent travelTimes) {
        this.travelTimes = travelTimes;
    }

    public ActiveXComponent getDelays() {
        return delays;
    }

    public void setDelays(ActiveXComponent delays) {
        this.delays = delays;
    }

    public WeatherEnum getWeatherEnum() {
        return weatherEnum;
    }

    public void setWeatherEnum(WeatherEnum weatherEnum) {
        this.weatherEnum = weatherEnum;
    }
}
