package com.vissim.service.vissimService;

import com.jacob.activeX.ActiveXComponent;

public interface VissimConnectService {

    void initVissim();

    ActiveXComponent getVissim();

    ActiveXComponent getSimulation();

    ActiveXComponent getNet();

    ActiveXComponent getEvaluation();


}
