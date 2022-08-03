package com.vissim.service.impl;

import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.Dispatch;
import com.jacob.com.Variant;
import com.vissim.service.EvaluationService;
import com.vissim.service.VissimConnectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;

@Service
@ConfigurationProperties(prefix = "evaluation")
public class EvaluationServiceImpl implements EvaluationService {

    @Autowired
    VissimConnectService vissimConnectService;

    private ActiveXComponent evaluation;
    private ActiveXComponent linkEvaluation;
    private ActiveXComponent dataCollectionEvaluation;
    private ActiveXComponent queueCounterEvaluation;
    private ActiveXComponent travelTimeEvaluation;
    private ActiveXComponent delayEvaluation;



    public EvaluationServiceImpl(VissimConnectService vissimConnectService) {

        evaluation = vissimConnectService.getEvaluation();
        //设置evaluation下的二级接口
        linkEvaluation = evaluation.invokeGetComponent("LinkEvaluation");
        dataCollectionEvaluation = evaluation.invokeGetComponent("DataCollectionEvaluation");
        queueCounterEvaluation = evaluation.invokeGetComponent("QueueCounterEvaluation");
        travelTimeEvaluation = evaluation.invokeGetComponent("TravelTimeEvaluation");
        delayEvaluation = evaluation.invokeGetComponent("DelayEvaluation");


    }

    /**
     * 打开评价文件输入，使VISSIM将数据保存到离线文件中
     */
    @PostConstruct
    public void openEvaluationFile(){
        Dispatch.invoke(evaluation, "AttValue", Dispatch.Put, new Object[]{"Link", true},new int[1]);
        Dispatch.invoke(evaluation, "AttValue", Dispatch.Put, new Object[]{"DataCollection", true},new int[1]);
        Dispatch.invoke(evaluation, "AttValue", Dispatch.Put, new Object[]{"TRAVELTIME", true},new int[1]);
        Dispatch.invoke(evaluation, "AttValue", Dispatch.Put, new Object[]{"QUEUECOUNTER", true},new int[1]);
        Dispatch.invoke(evaluation, "AttValue", Dispatch.Put, new Object[]{"DELAY", true},new int[1]);
        Dispatch.invoke(evaluation, "AttValue", Dispatch.Put, new Object[]{"VEHICLERECORD", true},new int[1]);

        openDelayEvaluation();
        openDataCollectionEvaluation();
        openQueueCounterEvaluation();
        openTravelTimeEvaluation();
        openLinkEvaluation(300, 900, 60);
    }


    /**
     * 打开数据采集评价文件
     */
    public void openDataCollectionEvaluation(){
        Dispatch.invoke(dataCollectionEvaluation, "AttValue", Dispatch.Put, new Object[]{"Compiled", true}, new int[1]);
        Dispatch.invoke(dataCollectionEvaluation, "AttValue", Dispatch.Put, new Object[]{"File", true}, new int[1]);
        Dispatch.invoke(dataCollectionEvaluation, "AttValue", Dispatch.Put, new Object[]{"Raw", true}, new int[1]);
    }

    /**
     * 打开延误时间评价文件
     */
    public void openDelayEvaluation(){
        Dispatch.invoke(delayEvaluation, "AttValue", Dispatch.Put, new Object[]{"Compiled", true}, new int[1]);
        Dispatch.invoke(delayEvaluation, "AttValue", Dispatch.Put, new Object[]{"File", true}, new int[1]);
        Dispatch.invoke(delayEvaluation, "AttValue", Dispatch.Put, new Object[]{"Raw", true}, new int[1]);
    }

    /**
     * 打开排队长度评价文件
     */
    public void openQueueCounterEvaluation(){
        Dispatch.invoke(queueCounterEvaluation, "AttValue", Dispatch.Put, new Object[]{"File", true}, new int[1]);
    }

    /**
     * 打开旅行时间评价文件
     */
    public void openTravelTimeEvaluation(){
        Dispatch.invoke(travelTimeEvaluation, "AttValue", Dispatch.Put, new Object[]{"Compiled", true}, new int[1]);
        Dispatch.invoke(travelTimeEvaluation, "AttValue", Dispatch.Put, new Object[]{"File", true}, new int[1]);
        Dispatch.invoke(travelTimeEvaluation, "AttValue", Dispatch.Put, new Object[]{"Raw", true}, new int[1]);
    }

    /**
     * 打开路段评价文件
     */
    public void openLinkEvaluation(int startTime, int endTime, int intervalTime){
        Dispatch.invoke(linkEvaluation, "AttValue", Dispatch.Put, new Object[]{"File", true}, new int[1]);
        //数据采集时间间隔
        Dispatch.invoke(linkEvaluation, "AttValue", Dispatch.Put, new Object[]{"Interval", intervalTime}, new int[1]);
        //数据采集第一秒
        Dispatch.invoke(linkEvaluation, "AttValue", Dispatch.Put, new Object[]{"from", startTime}, new int[1]);
        //数据采集最后一秒
        Dispatch.invoke(linkEvaluation, "AttValue", Dispatch.Put, new Object[]{"Until", endTime}, new int[1]);
        //每条车道独立的数据采集器
        Dispatch.invoke(linkEvaluation, "AttValue", Dispatch.Put, new Object[]{"PerLane", true}, new int[1]);
    }


    public ActiveXComponent getEvaluation() {
        return evaluation;
    }

    public void setEvaluation(ActiveXComponent evaluation) {
        this.evaluation = evaluation;
    }

    public ActiveXComponent getLinkEvaluation() {
        return linkEvaluation;
    }

    public void setLinkEvaluation(ActiveXComponent linkEvaluation) {
        this.linkEvaluation = linkEvaluation;
    }

    public ActiveXComponent getDataCollectionEvaluation() {
        return dataCollectionEvaluation;
    }

    public void setDataCollectionEvaluation(ActiveXComponent dataCollectionEvaluation) {
        this.dataCollectionEvaluation = dataCollectionEvaluation;
    }

    public ActiveXComponent getQueueCounterEvaluation() {
        return queueCounterEvaluation;
    }

    public void setQueueCounterEvaluation(ActiveXComponent queueCounterEvaluation) {
        this.queueCounterEvaluation = queueCounterEvaluation;
    }

    public ActiveXComponent getTravelTimeEvaluation() {
        return travelTimeEvaluation;
    }

    public void setTravelTimeEvaluation(ActiveXComponent travelTimeEvaluation) {
        this.travelTimeEvaluation = travelTimeEvaluation;
    }

    public ActiveXComponent getDelayEvaluation() {
        return delayEvaluation;
    }

    public void setDelayEvaluation(ActiveXComponent delayEvaluation) {
        this.delayEvaluation = delayEvaluation;
    }
}
