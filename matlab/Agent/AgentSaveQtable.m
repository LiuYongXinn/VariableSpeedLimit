%% 保存Q表

function AgentSaveQtable(Qtabledirection,Qtable)
    
    save(Qtabledirection,'Qtable','-ascii');

end