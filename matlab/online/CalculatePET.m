%% ���㳵��PET
   %invadeTime          : �洢����Խ��������ʱ�̵�����
   %invadeTimeNumber    : Խ�������ߵ���ʼ������
   %vehicleData         : ��������
   %laneDataNunmber     ������
   %PETLane             : �����ϳ���PET����
   %PETNumber           : ����
   %PETTimse            : PET������ֵ�Ĵ�������ֵ��4.14
%%
function [invadeTimeNumber,invadeTime,laneDataNumber,PETLane,PETNumber] = ...
    CalculatePET(vehicleData,invadeTimeNumberIn,invadeTimeIn,laneDataNumberIn,PETLaneIn,PETNumberIn,step1, allStepVehiclePETNumber,lane)
    

    vehicleDataNum = size(vehicleData,1);
    
    %��¼ǰ10��ͨ���ĳ�����                   add in 2021-12-26
    lastVehicleNumer = 0;
    for i = 1 : 10
        lastVehicleNumer = lastVehicleNumer + allStepVehiclePETNumber(lane,step1-i);
        if(step1-i == 0)
           break; 
        end
    end
    
    %����ظ�����ʼ����λ��
    if(laneDataNumberIn- lastVehicleNumer <= 0)
       startNumber = 1; 
    else
        startNumber = laneDataNumberIn- lastVehicleNumer;
    end
    
    
    for vdi = 1 : vehicleDataNum
        %����ÿһ����Խ�������ߵ�ʱ��
        [id, step, vehicleinvadeTime] = CalculateInvadeTime(vehicleData(vdi,2),vehicleData(vdi,3),vehicleData(vdi,4),vehicleData(vdi,5));
        invadeTimeTemp = [id, step, vehicleinvadeTime];
        %��ǣ����ڼ�¼�����Ƿ��ظ�����
        labelI = 1;
        
        %��һ�μ�⵽����
        if laneDataNumberIn == 0
            invadeTimeIn(invadeTimeNumberIn,:) = invadeTimeTemp;
            invadeTimeNumberIn = invadeTimeNumberIn + 1;
            laneDataNumberIn = laneDataNumberIn + 1;
        %�����⵽�ĳ����У�һ������invadeTime���Ѿ����ڣ���ɾ��������
        elseif laneDataNumberIn > 0
            
            for itj = startNumber : laneDataNumberIn
               if id == invadeTimeIn(itj,1)
                  invadeTimeTemp = [];
                  labelI = 0;
               end   
            end
            %������Ϊ��һ�γ��֣���labelI = 1�������ݵ���invadeTime
            if(labelI)
                invadeTimeIn(invadeTimeNumberIn,:) = invadeTimeTemp;
                invadeTimeNumberIn = invadeTimeNumberIn + 1;
                %�����⣬
                laneDataNumberIn = laneDataNumberIn + 1;
            end
            
            % ����PET
            if laneDataNumberIn >1 && labelI == 1
                [vehicleId1,vehicleId2,vehiclePET] = ...
                    OneVehiclePET(invadeTimeIn(invadeTimeNumberIn-1,1),invadeTimeIn(invadeTimeNumberIn-1,3),...
                    invadeTimeIn(invadeTimeNumberIn-2,1),invadeTimeIn(invadeTimeNumberIn-2,3));
                
                %����PET����
                PETTemp = [step1, vehicleId1, vehicleId2, vehiclePET];
                PETLaneIn(PETNumberIn,:) = PETTemp;
                PETNumberIn = PETNumberIn + 1;
            end
        end
    end
 
    
    %��������
    invadeTimeNumber = invadeTimeNumberIn;
    invadeTime = invadeTimeIn;
    laneDataNumber = laneDataNumberIn;
    PETLane = PETLaneIn;
    PETNumber = PETNumberIn;

end

%% ����ͨ�������ߵ�ʱ��
function [Id,Step,invadeTime] = CalculateInvadeTime(Step1,ID1,speedkmh1,Linkcoord1)
    %input          
    %Step1          ����¼ʱ��������ʱ��
    %ID1            ����¼ʱ������ID
    %Speed1         ����¼ʱ�������ٶ�
    %Linkcoord1     ����¼ʱ������λ��
    %output
    %Id             ��Խ��������ʱ������ID
    %Step           ����¼ʱ��������ʱ��
    %T              ������Խ�������ߵ�ʱ��

    global invadeLine;
    distance = Linkcoord1 - invadeLine;
    speedms1 = (speedkmh1 * 1000)/(60*60);
    beyondTime = distance / speedms1;
    
    invadeTime = Step1 - beyondTime;
    Id = ID1;
    Step = Step1;
end


%% ÿ��������PET����
function [vehicle1Id,vehicle2Id,PET] = OneVehiclePET(Id1,T1,Id2,T2)
    %input
    %Id1            ����ID
    %T1             ����ͨ�������ߵ�ʱ��
    %Id2            ��ǰ��ID
    %T2             ��ǰ��ͨ�������ߵ�ʱ��
    %output
    %vehicle1_Id    ����ID
    %vehicle2_Id    ��ǰ��ID
    %PET            ������֮���PET
    
    PET = T1 - T2;
    vehicle1Id = Id1;
    vehicle2Id = Id2;   
end