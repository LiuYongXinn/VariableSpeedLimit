function Qtable = agent_QtableChoose(userWeatherChoose)
    switch userWeatherChoose
        case 1
            Qtable = load("ClearQtable.txt");
             
        case 2
            Qtable = load("FogQtable.txt");
        case 3
            Qtable = load("VeryLightRainQtable.txt");
        case 4
            Qtable = load("LightRainQtable.txt");
        case 5
            Qtable = load("ModerateQtable.txt");
        case 6
            Qtable = load("HeavyRainQtable.txt");
    end
    
end