%% 基于密度选择动作

%%
function  [speedLimit, volume] = ActionChooseOnline_2248(Qtable, density)
    %动作集
    speedSet = [30,40,50,60,70,80,90,100,120];
    volumeSet = [200,400,600,800,100];

    %确定当前密度所对应的状态
    state = StateChooseOnline_2248(density);

    oneStateQvalue = Qtable(state, :);
    [~, action] = max(oneStateQvalue);
    
    volumeAction = mod(action, 5);
    speedAction = mod(action, 9);
    if(volumeAction == 0)
        volumeAction = 5;
    end
    if(speedAction == 0)
        speedAction = 9;
    end
    
    
    volume = volumeSet(1, volumeAction);
    speedLimit = speedSet(1, speedAction);

end