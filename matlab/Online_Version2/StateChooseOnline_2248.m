%% 交通流量状态去欸的那个

%%
function [state] = StateChooseOnline_2248(density)
    if density <= 10
        state = 1;
    elseif density>10 && density <= 15
        state = 2;
    elseif density >15 && density <= 20
        state = 3;
    elseif density >20 && density <= 25
        state = 4;
    elseif density >25 && density <= 30
        state = 5;
    elseif density >30 && density <= 32.5
        state = 6;
    elseif density >32.5 && density <= 35
        state = 7;
    elseif density >35 && density <= 37.5
        state = 8;
    elseif density >37.5 && density <= 40
        state = 9;
    elseif density >40 && density <= 42.5
        state = 10;
    elseif density >42.5 && density <= 45
        state = 11;
    elseif density >45 && density <= 47.5
        state = 12;
    elseif density >47.5 && density <= 50
        state = 13;
    elseif density >50 && density <= 55
        state = 14;
    elseif density >55 && density <= 60
        state = 15;
    elseif density >60 && density <= 65
        state = 16;
    elseif density >65 && density <= 70
        state = 17;
    elseif density >75 && density <= 80
        state = 18;
    elseif density > 80
        state = 19;
    end
    













end