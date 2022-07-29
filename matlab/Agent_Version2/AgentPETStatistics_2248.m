%% PET次数统计
% 输入
% Lane1Data         ：车道1的车辆数据
% Lane2Data         ：车道2的车辆数据
% Lane3Data         ：车道3的车辆数据
% Lane4Data         ：车道4的车辆数据
%  PETData = [id1, id2, time, lane, twoVehiclePET]
% 输出
% PETStatistics     ：路段不同冲突的PET次数
%% 
function PETStatistics = AgentPETStatistics_2248(lane1Data, lane2Data, lane3Data,lane4Data)

    lane1Times = oneLaneStatistic(lane1Data);
    lane2Times = oneLaneStatistic(lane2Data);
    lane3Times = oneLaneStatistic(lane3Data);
    lane4Times = oneLaneStatistic(lane4Data);


    PETStatistics = lane1Times + lane2Times + lane3Times + lane4Times;
    
end

%% 单一车道的PET统计
function times = oneLaneStatistic(laneData)
    laneNum = size(laneData,1);
    times = 0;
    for lni = 1 : laneNum
        PET = laneData(lni,5);
        if(PET < 4.14)
            times = times + 1;
        end
    end
end
