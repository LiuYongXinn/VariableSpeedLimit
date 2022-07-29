%% 驾驶行为选择

function behaviorDecision = DriverBehaviorChoose(weatherChoose)
     weather = DriverBehavior();
     %weather = {clear,fog,snow,ligthRain,moderateRain,heavyRain};
       
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
