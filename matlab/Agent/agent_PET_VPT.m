%% PET超过阈值次数计算
    %input：PET
    %output：PET次数


function numPET = agent_PET_VPT(PET)
    num = size(PET,1);
    traffic_accidents = 0;
    serious_conflicts = 0;
    general_conflicts = 0;
    minor_conflicts = 0;

    
    for i = 1 : num
        if PET(i,3) <= 0
            traffic_accidents = traffic_accidents + 1;
        elseif PET(i,3) >0 && PET(i,3) <= 1.35
           serious_conflicts = serious_conflicts + 1;
        elseif PET(i,3) > 1.35 && PET(i,3) <= 2.08
            general_conflicts = general_conflicts + 1;
        elseif PET(i,3) > 2.37 && PET(i,3) <= 4.14
            minor_conflicts = minor_conflicts + 1;
        end
    end
    
    numPET = traffic_accidents + serious_conflicts + minor_conflicts;

end