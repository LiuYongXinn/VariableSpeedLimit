%% 统计超过阈值的次数
% 输入
% PETTimes  : PET超过阈值的次数，阈值：4.14
% 输出 
% Times     ：低于阈值的次数
%%
function Times = AgentOverValueTime_2248(vehicleData,vehicleDataNumer,step,label)
    %label为1则进行PET统计，label为-1则进行TTC统计
    if(label == 1)
       overValue = 4.14; 
    elseif(label == -1)
       overValue = 1.4;
    end
    Timestemp = 0;
    
    %统计阈值(ni起始值可以优化)
    for ni = 1 : vehicleDataNumer
        %如果该数据的时刻为step且数据低于阈值，则统计
        if(vehicleData(ni,1) == step && vehicleData(ni,4) <= overValue)
            Timestemp = Timestemp + 1;
        %如果矩阵出现全零行，意味着统计结束，退出循环。
        elseif(vehicleData(ni,1) == 0 && vehicleData(ni,2) == 0 && vehicleData(ni,3) == 0 && vehicleData(ni,4) == 0)
            break;
        end  
    end
    
    %导出数据
    Times = Timestemp;
    
   
end