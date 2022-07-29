function [speedLimit1, speedLimit2] = AgentActionChooseForTwoSpeed(action, speedSet1)
    speedAction = mod(action, 9);
    if(speedAction == 0)
        speedAction = 9;
    end
    speedLimit1 = speedSet1(1, speedAction);
    
    speedAction = mod(action, 5);
    if(speedAction == 0)
        speedAction = 5;
    end
    speedLimit2 = speedSet2(1, speedAction);
end