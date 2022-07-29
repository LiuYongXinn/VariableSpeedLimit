%% 统计TTC的次数
function TTCSum = CountTTCSum_v3(TTCCounts, TTCCountsNum)
TTClength = TTCCountsNum - 1;
TTCSum = 0;

for i = 1 : TTClength
    oneTTC = TTCCounts(i,4);
    if(oneTTC <= 4.14)
        TTCSum = TTCSum + 1;
    end
end
end