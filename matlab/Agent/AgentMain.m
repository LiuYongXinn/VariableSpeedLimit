%% 参数定义
%% vissim连接
vissim_com=actxserver('VISSIM.vissim.430');
% vissim_com.SetWindow(16,0,500,700);
vissim_com.LoadNet('E:\文档\VISSIM\test3\test3.inp');
vissim_com.LoadLayout('E:\文档\VISSIM\test3\vissim.ini');

%% 定义
vnet = vissim_com.Net;
sim = vissim_com.Simulation;
veval = vissim_com.Evaluation;
vveh = vnet.Vehicles;
links = vnet.Links;                            

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
link_count = links.Count;                     
%% 不同天气下的驾驶行为模型
dbpss = vnet.DrivingBehaviorParSets;        %车辆行为
dbps_freeway = dbpss.GetDrivingBehaviorParSetByNumber(3);


% 用户选择 需可改变（未做）
userWeatherChoose = 3;

behaviorDecision = agent_DriverBehaviorChoose(userWeatherChoose);
disp(behaviorDecision)
dbps_freeway.set('AttValue','CC0',behaviorDecision(1));
dbps_freeway.set('AttValue','CC1',behaviorDecision(2));
dbps_freeway.set('AttValue','CC2',behaviorDecision(3));
dbps_freeway.set('AttValue','CC3',behaviorDecision(4));
dbps_freeway.set('AttValue','CC4',behaviorDecision(5));
dbps_freeway.set('AttValue','CC5',behaviorDecision(6));
dbps_freeway.set('AttValue','CC6',behaviorDecision(7));
dbps_freeway.set('AttValue','CC7',behaviorDecision(8));
dbps_freeway.set('AttValue','CC8',behaviorDecision(9));
dbps_freeway.set('AttValue','CC9',behaviorDecision(10));


%% 仿真参数的设置
evaluation_time = 1500;                      %仿真时间
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

%% 打开评价指标

veval.set('AttValue','DATACOLLECTION',true);                    %打开数据采集
veval.DataCollectionEvaluation.set('AttValue','FILE',true);
veval.DataCollectionEvaluation.set('AttValue','COMPILED',true);

veval.set('AttValue','TRAVELTIME',true);                        %打开行程时间
veval.TravelTimeEvaluation.set('AttValue','FILE',true);
veval.TravelTimeEvaluation.set('AttValue','COMPILED',true);

veval.set('AttValue','QUEUECOUNTER',true);                      %打开排队长度
veval.QueueCounterEvaluation.set('AttValue','FILE',true);

veval.set('AttValue','DELAY',true);                             %打开延误
veval.DelayEvaluation.set('AttValue','FILE',true);
veval.DelayEvaluation.set('AttValue','COMPILED',true);

veval.set('AttValue','VEHICLERECORD',true);                     %打开车流记录

veval.set('AttValue','LINK',true);                              %打开路段评价

%% 车辆数据存储
vehicle_data1_lane1 = zeros(evaluation_time * 6000,5); %记录车辆的数据
vehicle_data1_lane1_number = 1;
vehicle_data1_lane2 = zeros(evaluation_time * 6000,5); %记录车辆的数据
vehicle_data1_lane2_number = 1;
vehicle_data1_lane3 = zeros(evaluation_time * 6000,5); %记录车辆的数据
vehicle_data1_lane3_number = 1;

vehicle_data2_lane1 = zeros(evaluation_time * 6000,5); %记录车辆的数据
vehicle_data2_lane1_number = 1;
vehicle_data2_lane2 = zeros(evaluation_time * 6000,5); %记录车辆的数据
vehicle_data2_lane2_number = 1;
vehicle_data2_lane3 = zeros(evaluation_time * 6000,5); %记录车辆的数据
vehicle_data2_lane3_number = 1;

invade_Time = zeros(1000,3);                %车辆越过侵入线的时刻
invade_Time_number = 1;
invade_Time_max = 0;                        %越过侵入线的起始车辆数
PET_sum = zeros(1000,3);                    %在线PET数据
PET_sum_number = 1;


%% 强化学习参数设置                                      
% 学习率
learningRate = 0.8;
%折扣率
discountFactor = 0.8;
%初始化Q表
Qtable = agent_QtableChoose(userWeatherChoose);
%利用
explorationRate = 0.8;

%交通流仿真次数
for n = 1 : 1000
    step = 1;
    linknumber = 1;
    densitySum1 = 0;
    densityNum1 = 0;
    densitySum2 = 0;
    densityNum2 = 0;
    PETNum1 = 0;
    PETNum2 = 0;
    
    %交通流仿真
    while step < period_time*new_resolution   
        %% 50秒的时候，设置随机车流量
        if step == 50
            volume1 = randi(50)* 100;
            volume2 = randi(20)* 100;
            vehiclin_1.set('AttValue', 'Volume',volume1);
            vehiclin_2.set('AttValue', 'Volume',volume2);
        end
        
        %% 在300秒到600秒之间，收集交通流的密度，并计算冲突次数
        if step >= 300 && step < 600
            %收集交通流的密度数据，每60秒收集一次
            if rem(step,60) == 0
                %收集路网上的800m到900m处的车辆密度
                density = DensityCollection(links);
                densitySum1 = densitySum1 + density;
                densityNum1 = densityNum1 + 1;
            end
            
            %收集路网上的车辆数据(800,900)
            vehicleDataLane1 = VehiclaDataCollection(vveh);
            vehicleDataLane2 = VehiclaDataCollection(vveh);
            vehicleDataLane3 = VehiclaDataCollection(vveh);
            
            %计算PET冲突
            PETLane1Times = PETTimesCalculate(vehicleDataLane1);
            PETLane2Times = PETTimesCalculate(vehicleDataLane2);
            PETLane3Times = PETTimesCalculate(vehicleDataLane3);
            
            %统计PET次数
            PETNum1 = PETNum1 + PETLane1Times + PETLane2Times + PETLane3Times;
            
        end
        
       %% 600秒的时候，根据当前状态选择一个限速值
        if step == 600
            %确定限速前的交通流状态
            densityAverage1 = densitySum1 / densityNum1;
            %状态选择
            oldState = AgentStateChoose(densityAverage1);
            
            %选择限速值
            if rand > explorationRate
                %利用
                [~,action] = max(Qtable(oldState,:));
            else
                %探索
                action = randi(size(Qtable,2));
            end
            
            %限速值
            speedLimit = AgentActionChoose(action);
            
            %减速区域速度设置
            for i = 1:rd_c
                RSA = ReducedSpeed.GetReducedSpeedAreaByNumber(i);
                RSA.set('AttValue1', 'DESIREDSPEED', 10,speedLimit);
                RSA.set('AttValue1', 'DESIREDSPEED', 20,speedLimit);
            end
            
        end
        
        %% 900秒到1200秒之间，继续收集交通流的流量、密度，并计算冲突次数
        if step >= 900 && step <= 1200
            %收集交通流的密度数据，每60秒收集一次
            if rem(step,60) == 0
                %收集路网上的800m到900m处的车辆密度
                density = DensityCollection(links);
                densitySum2 = densitySum2 + density;
                densityNum2 = densityNum2 + 1;
            end
            
            %收集路网上的车辆数据(800m到900m)
            vehicleDataLane1 = VehiclaDataCollection(vveh);
            vehicleDataLane2 = VehiclaDataCollection(vveh);
            vehicleDataLane3 = VehiclaDataCollection(vveh);
            
            %计算每车道PET冲突次数
            PETLane1Times = PETTimesCalculate(vehicleDataLane1);
            PETLane2Times = PETTimesCalculate(vehicleDataLane2);
            PETLane3Times = PETTimesCalculate(vehicleDataLane3);
            
            %统计PET次数
            PETNum2 = PETNum2 + PETLane1Times + PETLane2Times + PETLane3Times;
            
        end
        
        %% 1200秒的时候，计算状态-动作对所产生的价值，同时更新Q表
        if step == 1200
            %确定限速后的交通流状态
            densityAverage2 = density_sum2 / density_num2;
            newState = CgentStateChoose(densityAverage2);
            
            %根据状态前后的冲突次数来设置奖励值
            reward = AgentRewardChoose(PETNum1,PETNum2);
            
            %更新Q表
              Qtable(oldState,action)...
                  = Qtable(oldState,action) + learningRate*(reward + discountFactor * max(Qtable(newState,:)) - Qtable(oldState,action));
        end

    end
  
    sim.Stop
    save('Qtable.txt','Qtable','-ascii');
end
    










