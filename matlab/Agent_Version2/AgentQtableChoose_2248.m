%% 根据不同的天气条件选择不同的Q表
% 输入
% QtablePathName        ：存储Q表的路径
% userWeatherChooseRL   ：用户选择的Q表
% 输出 
% Qtable                ：Q表输出
% Qtabledirection       ：Q表的具体路径
%% 
function [Qtable,Qtabledirection] = AgentQtableChoose_2248(QtablePathName,userWeatherChooseRL, rewardFunctionChoose)
    %选择Q表
    switch userWeatherChooseRL
        case 1
            QtableName = "ClearQtable";
        case 2
            QtableName = "FogQtable";
        case 3
            QtableName = "SnowQtable";
        case 4
            QtableName = "LightRainQtable";
        case 5
            QtableName = "ModerateQtable";
        case 6
            QtableName = "HeavyRainQtable";
    end
    
    rewardChooStr = int2str(rewardFunctionChoose);
    QtableFileName = strcat(QtableName, rewardChooStr,".txt");
    
    Qtabledirection = strcat(QtablePathName,QtableFileName);
    Qtable = load(Qtabledirection);
    
end