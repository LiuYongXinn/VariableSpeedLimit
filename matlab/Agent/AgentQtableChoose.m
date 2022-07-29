%% 根据不同的天气条件选择不同的Q表

function [Qtable,Qtabledirection] = AgentQtableChoose(QtablePathName,userWeatherChooseRL)

    %选择Q表
    switch userWeatherChooseRL
        case 1
            QtableFileName = "ClearQtable.txt";
        case 2
            QtableFileName = "FogQtable.txt";
        case 3
            QtableFileName = "VeryLightRainQtable.txt";
        case 4
            QtableFileName = "LightRainQtable.txt";
        case 5
            QtableFileName = "ModerateQtable.txt";
        case 6
            QtableFileName = "HeavyRainQtable.txt";
    end
    
    Qtabledirection = strcat(QtablePathName,QtableFileName);
    Qtable = load(Qtabledirection);
    
end