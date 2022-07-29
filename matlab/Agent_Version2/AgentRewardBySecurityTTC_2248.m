%% 面向安全的回报函数TTC
% 输入参数：
% numTTC1：限速前的PET次数
% numTTC2：限速后的PET次数
%
% 输出参数：
% reward：回报函数的值
%

%%
function reward = AgentRewardBySecurityTTC_2248(numTTC1,numTTC2)
    %事故风险变化比例
    PC = (numTTC2 - numTTC1) / numTTC1;
    
    if(numTTC1 ~= 0)
        %惩罚因子
        y = -100;
        
        if PC <= 0
            reward = (-PC) * 100 ;
        elseif PC > 0
            reward = (-PC) * 100 + y;
        else
            reward = 0;
        end
    elseif(numTTC1 == 0 && numTTC2 ~= 0)
        reward = -100;
    elseif(numTTC1 == 0 && numTTC2 == 0)
        reward = 0;
    end
    
end