%% 面向通行效率提升的回报函数
% 输入参数：
% density：当前改变后的密度
%
% 输出参数：
% reward：回报函数的值
%
% 调用说明：
%不同交通流密度对应的回报函数服从泊松分布
%
%
% 版本: v1.0  2022-3-29       @author：alex
%% 函数
function reward = AgentRewardByEfficiency(density)
    %将密度取整
    density = round(density);
    %泊松分布参数
    miu = 10^1;
    lanta = 17;
    eLanta = exp(-density);
    lantaMiu = lanta^density;
    densityFactorial = factorial(density);
    %计算回报函数
    reward = miu * lantaMiu * eLanta / densityFactorial;
    if( density >= 8 && density <= 11)
        reward = reward + 1000;
    elseif(density > 16)
        reward = reward - 1000;
    end
end