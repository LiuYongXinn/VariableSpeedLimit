function reward = AgentRewardChoose(numPET1,numPET2)

    reward = AgentRewardBySecurity(numPET1,numPET2);
%     reward = rewardSecurity;
    %rewardEfficency = AgentRewardByEfficiency(density);
    
   % reward = rewardSecurity * securityScale + efficienyScale * rewardEfficency; 
end


%     if density <= 10
%         reward = -10;
%     elseif density>10 && density <= 15
%         reward = -8;
%     elseif density >15 && density <= 20
%         reward = -6;
%     elseif density >20 && density <= 25
%         reward = -4;
%     elseif density >25 && density <= 30
%         reward = -2;
%     elseif density >30 && density <= 32.5
%         reward = 0;
%     elseif density >32.5 && density <= 35
%         reward = 10;
%     elseif density >35 && density <= 37.5
%         reward = 20;
%     elseif density >37.5 && density <= 40
%         reward = 10;
%     elseif density >40 && density <= 42.5
%         reward = 0;
%     elseif density >42.5 && density <= 45
%         reward = -2;
%     elseif density >45 && density <= 47.5
%         reward = -4;
%     elseif density >47.5 && density <= 50
%         reward = -6;
%     elseif density >50 && density <= 55
%         reward = -8;
%     elseif density >55 && density <= 60
%         reward = -10;
%     elseif density >60 && density <= 65
%         reward = -15;
%     elseif density >65 && density <= 70
%         reward = -20;
%     elseif density >75 && density <= 80
%         reward = -25;
%     elseif density > 80
%         reward = -30;
%     end