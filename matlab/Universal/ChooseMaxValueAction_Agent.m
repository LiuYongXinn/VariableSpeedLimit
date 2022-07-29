%% 选择价值最大的Q值

function action = ChooseMaxValueAction_Agent(Qtable, state)
    tempValues = Qtable(state,:);
    maxValue = max(tempValues);
    action = find(tempValues == maxValue);
    if(size(action,2) > 1)
        action = action(1,1);
    end
    
end