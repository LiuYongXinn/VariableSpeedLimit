package com.vissim.service;

import com.jacob.activeX.ActiveXComponent;

public interface VissimConnectService {

    void initVissim();

    ActiveXComponent getSimulation();

    ActiveXComponent getNet();

    ActiveXComponent getEvaluation();


}
