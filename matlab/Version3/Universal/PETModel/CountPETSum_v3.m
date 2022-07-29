%% 计算PET次数
function PETSum = CountPETSum_v3(PETCounts,PETCountNum)
length = PETCountNum - 1;
PETSum = 0;

for i = 1 : length
    onePET = PETCounts(i,4);
    if(onePET <= 4.14)
        PETSum = PETSum + 1;
    end
end

end