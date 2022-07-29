function vehicle_lane = agent_vehicle_PET_sort(lane_line_max, vehicle_lane)
    %input
    %lane_line_max  ： 车辆数据矩阵的行数
    %vehicle_line   ： 车辆数据矩阵
    %output
    %vehicle_lane   ：排序完成的车辆数据矩阵
    
    vehicle_lane_temp = zeros(1,5);
    for i = 1:lane_line_max
        for j = 1 :(lane_line_max-i)
            if vehicle_lane(j,5) < vehicle_lane(j+1,5)
                for z = 1:5
                    vehicle_lane_temp(1,z) = vehicle_lane(j,z);
                    vehicle_lane(j,z) = vehicle_lane(j+1,z);
                    vehicle_lane(j+1,z) = vehicle_lane_temp(1,z);
                end
            end
        end
    end
end
