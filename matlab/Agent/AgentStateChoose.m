function [state] = AgentStateChoose(density)
    if density <= 3
        state = 1;
    elseif density>3 && density <= 6
        state = 2;
    elseif density >6 && density <= 9
        state = 3;
    elseif density >9 && density <= 12
        state = 4;
    elseif density >12 && density <= 13.5
        state = 5;
    elseif density >13.5 && density <= 15
        state = 6;
    elseif density >15 && density <= 15.75
        state = 7;
    elseif density >15.75 && density <= 16.5
        state = 8;
    elseif density >16.5 && density <= 17.25
        state = 9;
    elseif density >17.25 && density <= 18
        state = 10;
    elseif density >18 && density <= 18.75
        state = 11;
    elseif density >18.75 && density <= 19.5
        state = 12;
    elseif density >19.5 && density <= 21
        state = 13;
    elseif density >21 && density <= 24
        state = 14;
    elseif density >24 && density <= 27
        state = 15;
    elseif density >27 && density <= 30
        state = 16;
    elseif density >30 && density <= 33
        state = 17;
    elseif density >33 && density <= 36
        state = 18;
    elseif density > 36
        state = 19;
    end
    













end