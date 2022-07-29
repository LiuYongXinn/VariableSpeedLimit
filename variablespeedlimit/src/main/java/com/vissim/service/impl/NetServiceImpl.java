package com.vissim.service.impl;

import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.Dispatch;
import com.jacob.com.Variant;
import com.vissim.service.NetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

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


    public void getDesiredSpeedDecisionByNo(Integer no, Integer limitSpeed, Integer vehicleType){
        ActiveXComponent area = reducedSpeedAreas.invokeGetComponent("GetReducedSpeedAreaByNumber", new Variant(no));
        Dispatch.invoke(area, "AttValue1", Dispatch.Put, new Object[]{"DesiredSpeed",vehicleType, limitSpeed}, new int[1]);
    }

    @Override
    public void setVehicleInputByNo(Integer no, Integer volume) {
        ActiveXComponent vehicleInput = vehicleInputs.invokeGetComponent("GetVehicleInputByNumber", new Variant(no));
        Dispatch.invoke(vehicleInput,"AttValue", Dispatch.Put, new Object[]{"Volume", volume}, new int[1]);
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


}
