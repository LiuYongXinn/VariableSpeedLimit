function vehicle_sort = agent_sort(vehicle_lane)
    number = size(vehicle_lane,1);
    vehicle_sort_temp = zeros(number,5);
    
    for i = 1 : number
       for j = 1 : (number - 1)
           if vehicle_lane(j,5) < vehicle_lane(j+1,5)
              for z = 1 : 5
                  vehicle_sort_temp(1,z) = vehicle_lane(j,z);
                  vehicle_lane(j,z) = vehicle_lane(j+1,z);
                  vehicle_lane(j+1,z) = vehicle_sort_temp(1,z);
              end
           end
       end
    end
    
    vehicle_sort = vehicle_lane;
    
end