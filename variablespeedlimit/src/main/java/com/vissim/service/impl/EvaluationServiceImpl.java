package com.vissim.service.impl;

import com.jacob.activeX.ActiveXComponent;
import com.vissim.service.EvaluationService;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "evaluation")
public class EvaluationServiceImpl implements EvaluationService {

    private ActiveXComponent evaluation;
    private ActiveXComponent linkEvaluation;
    private ActiveXComponent dataCollectionEvaluation;
    private ActiveXComponent queueCounterEvaluation;
    private ActiveXComponent travelTimeEvaluation;
    private ActiveXComponent delayEvaluation;



    public EvaluationServiceImpl(VissimConnectServiceServiceImpl vissimConnectServiceImpl) {

        ActiveXComponent evaluation = vissimConnectServiceImpl.getEvaluation();
        //设置evaluation下的二级接口
        linkEvaluation = evaluation.invokeGetComponent("LinkEvaluation");
        dataCollectionEvaluation = evaluation.invokeGetComponent("DataCollectionEvaluation");
        queueCounterEvaluation = evaluation.invokeGetComponent("QueueCounterEvaluation");
        travelTimeEvaluation = evaluation.invokeGetComponent("TravelTimeEvaluation");
        delayEvaluation = evaluation.invokeGetComponent("DelayEvaluation");
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
