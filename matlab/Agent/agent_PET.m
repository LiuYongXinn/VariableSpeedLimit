%% agent PET计算
    %input:  每个步长路网上的所有车辆
    %output： PET

function PET_data = agent_PET(vehicle_lane1,vehicle_lane2,vehicle_lane3)
%% 删除重复出现的车辆数据
    %vehicle_PET(LANE,STEP,ID,SPEED,LINKCOORD)
    lane1_num = size(vehicle_lane1,1);
    lane2_num = size(vehicle_lane2,1);
    lane3_num = size(vehicle_lane3,1);
    
    %可优化
    vehicle_lane1 = agent_delete_repetition(vehicle_lane1,lane1_num);
    vehicle_lane2 = agent_delete_repetition(vehicle_lane2,lane2_num);
    vehicle_lane3 = agent_delete_repetition(vehicle_lane3,lane3_num);
    
    
%% 计算车辆通过侵入线的时间
    %invadetime = [ID,Step,invadetime]
    lane1_invadetime = agent_lane_invadetime_compute(vehicle_lane1);
    lane2_invadetime = agent_lane_invadetime_compute(vehicle_lane2);
    lane3_invadetime = agent_lane_invadetime_compute(vehicle_lane3);
    
%% 计算PET
    lane1_PET = lane_PET(lane1_invadetime);
    lane2_PET = lane_PET(lane2_invadetime);
    lane3_PET = lane_PET(lane3_invadetime);
    
%% 合并PET数据
    lane1_PET_num = size(lane1_PET,1);
    lane2_PET_num = size(lane2_PET,1);
    lane3_PET_num = size(lane3_PET,1);
    
    PET_data_max = lane1_PET_num + lane2_PET_num + lane3_PET_num;
    
    PET_data_temp = zeros(PET_data_max,3);
    PET_data_number = 1;
    
    for i = 1 : lane1_PET_num
        PET_data_temp(PET_data_number,:) = lane1_PET(i,:);
        PET_data_number = PET_data_number + 1;
    end
    
    for i = 1 : lane2_PET_num
        PET_data_temp(PET_data_number,:) = lane2_PET(i,:);
        PET_data_number = PET_data_number + 1;
    end
    
    for i = 1 : lane3_PET_num
        PET_data_temp(PET_data_number,:) = lane3_PET(i,:);
        PET_data_number = PET_data_number + 1;
    end

    PET_data = PET_data_temp;


end

%% 计算侵入时间
function lane_invadetime = agent_lane_invadetime_compute(vehicle_lane)
    %vehicle_PET(LANE,STEP,ID,SPEED,LINKCOORD)  
    invade_line = 750;

    number = size(vehicle_lane,1);
    lane_invadetime_temp = zeros(number,5);
    invadetime_num = 1;
    
    for i = 1 : number
        distance = vehicle_lane(i,5) - invade_line;
        beyond_time = distance / vehicle_lane(i,4);
        invade_time = vehicle_lane(i,2) - beyond_time;
        
        lane_invadetime_temp(invadetime_num,1) = vehicle_lane(i,3);
        lane_invadetime_temp(invadetime_num,2) = vehicle_lane(i,2);
        lane_invadetime_temp(invadetime_num,3) = invade_time;
        invadetime_num = invadetime_num + 1;
    end
 
    lane_invadetime = lane_invadetime_temp; 
end


%% 删除重复的车辆数据
function vehicle_data = agent_delete_repetition(vehicle_lane,number)
    for i = 1 : number-1
        for j = (i+1) : number
            if vehicle_lane(j,3) == vehicle_lane(i,3)
                vehicle_lane(j,:) = zeros(1,5);
            end
        end
    end
    vehicle_lane(all(vehicle_lane == 0,2),:) = [];

    vehicle_data = vehicle_lane;
end


%% 计算PET
function lane_PET = lane_PET(invadetime)
    %invadetime = [ID,Step,invadetime]
    number = size(invadetime,1);
    PET_temp = zeros(number,3);
    PET_number = 1;
    
    for i = 1: (number-1)
        PET = invadetime(i+1,3)- invadetime(i,3);
        PET_temp(PET_number,1) = invadetime(i,1);
        PET_temp(PET_number,2) = invadetime(i+1,1);
        PET_temp(PET_number,3) = PET;
        PET_number = PET_number + 1;
    end

    PET_temp(all(PET_temp == 0,2),:) = [];
    lane_PET = PET_temp;

end


































