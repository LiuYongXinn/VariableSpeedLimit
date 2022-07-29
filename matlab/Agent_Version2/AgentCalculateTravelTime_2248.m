%% 计算训练过程中的平均行程时间
% 输入
% travelTimes ：本次仿真的行程时间数据
% 输出
% averageTravelTime ：本次仿真的平均行程时间

%%
function averageTravelTime = AgentCalculateTravelTime_2248(travelTimes)
    ttSize = size(travelTimes, 1);
    startLabel = 0;
    for i = 1:ttSize
        if(travelTimes(i,1) == 900)
            startLabel = i;
            break;
        end
    end
    
    ttLabel = 0;
    ttSum = 0;
    for i = startLabel : ttSize
        oneTravelTime = travelTimes(i, 2);
        if(oneTravelTime ~= 0)
            ttSum = ttSum + oneTravelTime;
            ttLabel = ttLabel + 1;
        end
    end

    if(ttLabel ~= 0)
        averageTravelTime = ttSum / ttLabel;
    else
        averageTravelTime = 0;
    end
end