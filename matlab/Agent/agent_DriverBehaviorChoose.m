
function behaviorDecision = agent_DriverBehaviorChoose(weatherChoose)
     weather = DriverBehavior();
     
     switch weatherChoose
         case 1
             behaviorDecision = weather{1};
         case 2
             behaviorDecision = weather{2};
         case 3
             behaviorDecision = weather{3};
         case 4
             behaviorDecision = weather{4};
         case 5
             behaviorDecision = weather{5};
         case 6
             behaviorDecision = weather{6};
     end
     


end


%% 定义不同天气条件下的驾驶行为
function weather = DriverBehavior()
   
    clear = [4.2, 0.7, 12.7, -24.6, 0, 0.9, 1.7, 1.0, 1.4, 0.1];
    fog = [4.2, 1.0, 12.9, -21.9, 0.0, 1.1, 2.2, 1.6, 2.9, 0.2];
    veryLightRain = [4.6, 0.9, 13.5, -23.5, -0.1, 1.1, 2.0, 1.1, 1.5, 0.2];
    ligthRain = [4.2, 0.8, 11.7, -24.8, 0.0, 0.9, 1.5, 1.2, 1.1, 0.1];
    moderateRain = [3.8, 0.7, 13.5, -24.4, -0.1, 0.7, 1.5, 1.4, 1.0, 0.1];
    heavyRain = [4.4, 0.7, 12.4, -21.0, -0.1, 1.0, 2.4, 1.2, 1.8, 0.1];
    weather = {clear,fog,veryLightRain,ligthRain,moderateRain,heavyRain};
end