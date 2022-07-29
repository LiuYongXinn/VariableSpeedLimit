%% 面向安全的回报函数
% 输入参数：
% numPET1：限速前的PET次数
% numPET2：限速后的PET次数
%
% 输出参数：
% reward：回报函数的值
%%
function reward = AgentRewardBySecurity(numPET1,numPET2)
    %事故风险变化比例
    PC = (numPET2 - numPET1) / numPET1;
    
    if(numPET1 ~= 0)
        %惩罚因子
        y = -100;
        
        if PC <= 0
            reward = (-PC) * 100 ;
        elseif PC > 0
            reward = (-PC) * 100 + y;
        else
            reward = 0;
        end
    elseif(numPET1 == 0 && numPET2 ~= 0)
        reward = -100;
    elseif(numPET1 == 0 && numPET2 == 0)
        reward = 0;
    end
end