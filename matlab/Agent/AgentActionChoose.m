function [volume,speedLimit] = AgentActionChoose(action, speedSet, motionSet)
    speedLength = size(speedSet, 2);
    

    speedAction = mod(action, speedLength);
    volumeAction = fix(action/speedLength)+1;
    
    if(speedAction == 0)
        speedAction = speedLength;
        volumeAction = volumeAction - 1;
    end
    
    volume = motionSet(1, volumeAction);
    speedLimit = speedSet(1, speedAction);
end