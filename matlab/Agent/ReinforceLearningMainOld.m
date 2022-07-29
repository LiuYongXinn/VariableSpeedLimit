function ReinforceLearningMainOld...
    (vissimFileName,vissimPathName,vissimUnifiedName,trafficRainFileName,trafficRainPathName)

    %% vissim连接
    vissim_com=actxserver('VISSIM.vissim.430');
    % vissim_com.SetWindow(16,0,500,700);
    vissim_com.LoadNet('C:\Users\55034\Documents\VariableSpeedLimit\test3\test3.inp');
    vissim_com.LoadLayout('C:\Users\55034\Documents\VariableSpeedLimit\test3\vissim.ini');

    %% 定义
    vnet = vissim_com.Net;
    sim = vissim_com.Simulation;
    veval = vissim_com.Evaluation;
    vveh = vnet.Vehicles;
    links = vnet.Links;                             %add  10.27


    TTims = vnet.TravelTimes;                   %行程时间
    Qcouts = vnet.QueueCounters;                %排队时间采集
    ReducedSpeed = vnet.ReducedSpeedAreas;      %减速带
    DCs = vnet.DataCollections;                 %数据采集
    Delays = vnet.Delays;                       %延误

    tt_count = TTims.Count;                     %计数
    rd_c = ReducedSpeed.count;
    dc_count = DCs.Count;
    Delays_count = Delays.Count;
    qcout_number = Qcouts.Count;
    link_count = links.Count;                       %add  10.27


    dbpss = vnet.DrivingBehaviorParSets;        %车辆行为
    dbps_freeway = dbpss.GetDrivingBehaviorParSetByNumber(3);

    evaluation_time = 1500;                      %仿真时间





    %% 仿真参数的设置
    period_time = evaluation_time;
    sim.set('Period', period_time);
    new_resolution = 1;
    sim.set('Resolution',new_resolution);
    new_speed = 1;
    sim.set('Speed',new_speed);


    %% 设置车流量

    volume1 = 0;
    volume2 = 0;

    vehiclin_1 = vnet.VehicleInputs.GetVehicleInputByNumber(1);     %车辆输入1
    vehiclin_2 = vnet.VehicleInputs.GetVehicleInputByNumber(2);     %车辆输入2
    vehiclin_1.set('AttValue', 'Volume',volume1);                      %设置车流量
    vehiclin_2.set('AttValue', 'Volume',volume2);

    vehiclin_1.set('AttValue', 'TIMEUNTIL',evaluation_time);


    %% 减速区域设置

    for i = 1:rd_c
        RSA = ReducedSpeed.GetReducedSpeedAreaByNumber(i);
        RSA.set('AttValue1', 'DESIREDSPEED', 10,120);
        RSA.set('AttValue1', 'DESIREDSPEED', 20,120);
    end

%     %% 打开评价指标
% 
%     veval.set('AttValue','DATACOLLECTION',true);                    %打开数据采集
%     veval.DataCollectionEvaluation.set('AttValue','FILE',true);
%     veval.DataCollectionEvaluation.set('AttValue','COMPILED',true);
% 
%     veval.set('AttValue','TRAVELTIME',true);                        %打开行程时间
%     veval.TravelTimeEvaluation.set('AttValue','FILE',true);
%     veval.TravelTimeEvaluation.set('AttValue','COMPILED',true);
% 
%     veval.set('AttValue','QUEUECOUNTER',true);                      %打开排队长度
%     veval.QueueCounterEvaluation.set('AttValue','FILE',true);
% 
%     veval.set('AttValue','DELAY',true);                             %打开延误
%     veval.DelayEvaluation.set('AttValue','FILE',true);
%     veval.DelayEvaluation.set('AttValue','COMPILED',true);
% 
%     veval.set('AttValue','VEHICLERECORD',true);                     %打开车流记录
% 
%     veval.set('AttValue','LINK',true);                              %打开路段评价

    %% 参数                                      add     10.27
    % 学习率
    learning_rate = 0.8;
    %折扣率
    discount_factor = 0.8;
    %初始化Q表
    Qtable = zeros(17,10); 

    %利用
    exploration_rate = 0.8;



    vehicle_data1 = zeros(evaluation_time * 6000,5); %记录车辆的数据
    vehicle_data1_number = 1;
    vehicle_data2 = zeros(evaluation_time * 6000,5); %记录车辆的数据
    vehicle_data2_number = 1;

    %车道1车辆数据
    vehicle_lane1 = zeros(evaluation_time * 6000,5);
    vehicle_lane1_num = 1;
    %车道2车辆数据
    vehicle_lane2 = zeros(evaluation_time * 6000,5);
    vehicle_lane2_num = 1;
    %车道3车辆数据
    vehicle_lane3 = zeros(evaluation_time * 6000,5);
    vehicle_lane3_num = 1;




    invade_Time = zeros(1000,3);                %车辆越过侵入线的时刻
    invade_Time_number = 1;
    invade_Time_max = 0;                        %越过侵入线的起始车辆数
    PET_sum = zeros(1000,3);                    %在线PET数据
    PET_sum_number = 1;


    for n = 1:500
        %% 主循环
        step = 1;

        linkn = zeros(evaluation_time * 3 ,6);
        linknumber = 1;
        density_sum1 = 0;
        density_num1 = 0;
        density_sum2 = 0;
        density_num2 = 0;
        while step < period_time*new_resolution
            sim.RunSingleStep;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %当区间内进行到50秒时，设置随机车流量
            if step == 1
                volume1 = randi(40)* 100;
                volume2 = randi(20)* 100;
                vehiclin_1.set('AttValue', 'Volume',volume1);
                vehiclin_2.set('AttValue', 'Volume',volume2);
            end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            %当区间内进行到300秒时，进行限速控制
            if step >= 300 && step <= 600
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                if rem(step,60) == 0
                    density = 0;
                    %获取路段信息 (密度)
                    for link_i = 1 : 3
                        link1 = links.GetLinkByNumber(1);

                        linkDensity = link1.GetSegmentResult("DENSITY",0,740,link_i);
                        %linkVolume = link1.GetSegmentResult("VOLUME",0,740,link_i);
                        %linkSpeed = link1.GetSegmentResult("SPEED",0,740,link_i);
                        density = density + linkDensity;
                    end
                    density = density / 3;
                    disp([step density])
                    density_sum1 = density_sum1 + density;
                    density_num1 = density_num1 + 1;
                end

                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %单一车辆数据
                vehicles_number = vveh.Count;                       %路网上现有车辆数
                if vehicles_number ~= 0

                    %收集路网上的车辆的数据
                    for i = 1:vehicles_number                          
                        number_vehicle = vissim_com.Net.Vehicles.Item(i);
                        vehicle_data1(vehicle_data1_number,1) = number_vehicle.AttValue('LANE');
                        vehicle_data1(vehicle_data1_number,2) = step;
                        vehicle_data1(vehicle_data1_number,3) = number_vehicle.AttValue('ID');
                        vehicle_data1(vehicle_data1_number,4) = number_vehicle.AttValue('SPEED');
                        vehicle_data1(vehicle_data1_number,5) = number_vehicle.AttValue('LINKCOORD');
                        vehicle_data1_number = vehicle_data1_number + 1;
                    end




                end



                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                if step == 600


                    % 计算PET
                    vehicle_data1(all(vehicle_data1 == 0,2),:) = [];
                    PET1 = agent_PET(vehicle_data1,(vehicle_data1_number-1));       

                    % 计算超过阈值的PET次数
                    numPET1 = agent_PET_VPT(PET1);


                    %确定当前状态
                    density_average1 = density_sum1 / density_num1;
                    state = agent_state_choose(density_average1);

                    %选择限速值
                    if rand > exploration_rate
                        [~,action] = max(Qtable(state,:));
                    else
                        %（未做）
                        action = randi(size(Qtable,2));
                    end
                    speed_limit = agent_action_choose(action);


                    %减速区域设置
                    for i = 1:rd_c
                        RSA = ReducedSpeed.GetReducedSpeedAreaByNumber(i);
                        RSA.set('AttValue1', 'DESIREDSPEED', 10,speed_limit);
                        RSA.set('AttValue1', 'DESIREDSPEED', 20,speed_limit);
                    end

                end

                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            %当区间进行到600秒时，进行新状态的记录
            if step >= 900 && step <= 1200

                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                %获取路段信息 (密度)
                if rem(step,60) == 0
                    density = 0;
                    %获取路段信息 (密度)
                    for link_i = 1 : 3
                        link1 = links.GetLinkByNumber(1);

                        linkDensity = link1.GetSegmentResult("DENSITY",0,740,link_i);
                        %linkVolume = link1.GetSegmentResult("VOLUME",0,740,link_i);
                        %linkSpeed = link1.GetSegmentResult("SPEED",0,740,link_i);
                        density = density + linkDensity;
                    end
                    density = density / 3;
                    disp([step density])
                    density_sum2 = density_sum2 + density;
                    density_num2 = density_num2 + 1;
                end

                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %单一车辆数据
                vehicles_number = vveh.Count;                       %路网上现有车辆数
                for i = 1:vehicles_number                           %收集路网上的车辆的数据
                    number_vehicle = vissim_com.Net.Vehicles.Item(i);
                    vehicle_data2(vehicle_data2_number,1) = number_vehicle.AttValue('LANE');
                    vehicle_data2(vehicle_data2_number,2) = step;
                    vehicle_data2(vehicle_data2_number,3) = number_vehicle.AttValue('ID');
                    vehicle_data2(vehicle_data2_number,4) = number_vehicle.AttValue('SPEED');
                    vehicle_data2(vehicle_data2_number,5) = number_vehicle.AttValue('LINKCOORD');
                    vehicle_data2_number = vehicle_data2_number + 1;
                end


                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                if step == 1200

                    %确定当前状态
                    density_average2 = density_sum2 / density_num2;
                    state_new = agent_state_choose(density_average2);


                    %计算PET
                    vehicle_data2(all(vehicle_data2 == 0,2),:) = [];
                    PET2 = agent_PET(vehicle_data2,(vehicle_data2_number-1));

                    %计算超过阈值的PET次数
                    numPET2 = agent_PET_VPT(PET2);



                    %根据事故风险设置reward
                    reward = agent_reward_choose(numPET1,numPET2);


                    %更新Q表
                    Qtable(state,action) = Qtable(state,action) + ...
                        learning_rate*(reward + discount_factor * max(Qtable(state_new,:)) - Qtable(state,action));
                end

                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            %当区间进行到1500秒时，清空输入车流量
            if step ==  1500

                vehiclin_1.set('AttValue', 'Volume',0);
                vehiclin_2.set('AttValue', 'Volume',0);

                for i = 1:rd_c
                    RSA = ReducedSpeed.GetReducedSpeedAreaByNumber(i);
                    RSA.set('AttValue1', 'DESIREDSPEED', 10,120);
                    RSA.set('AttValue1', 'DESIREDSPEED', 20,120);
                end

            end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            step = step+1;
        end
        sim.Stop
        save('Qtable.txt','Qtable','-ascii')
    end

end
