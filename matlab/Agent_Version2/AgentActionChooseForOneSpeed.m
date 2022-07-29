function speedLimit = AgentActionChooseForOneSpeed(action, speedSet)
    speedAction = mod(action, 9);
    if(speedAction == 0)
        speedAction = 9;
    end
    speedLimit = speedSet(1, speedAction);
end