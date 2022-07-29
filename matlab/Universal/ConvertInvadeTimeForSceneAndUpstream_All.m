%% 安全冲突计算转换辅助函数

% 上游或场景 -> 通用
% 上游 -> 通用     ： -1 
% 场景 -> 通用     ：  1

% 通用 -> 场景或上游
% 通用 -> 上游     ： -2
% 通用 -> 场景     ：  2


%%
function ConvertInvadeTimeForSceneAndUpstream_All(choose,invadeLineSet)

%通用数据
global invadeLine;
global allStepVehiclePETNumber
global invadeTimeLane1 invadeTimeLane2 invadeTimeLane3 invadeTimeLane4
global invadeTimeLane1Number invadeTimeLane2Number invadeTimeLane3Number invadeTimeLane4Number
global invadeTimeNumber1 invadeTimeNumber2 invadeTimeNumber3 invadeTimeNumber4
global PETSum PETSumNumber

%场景区数据
global allStepVehiclePETNumberScene
global invadeTimeLane1Scene invadeTimeLane2Scene invadeTimeLane3Scene invadeTimeLane4Scene
global invadeTimeLane1NumberScene invadeTimeLane2NumberScene invadeTimeLane3NumberScene invadeTimeLane4NumberScene
global invadeTimeNumber1Scene invadeTimeNumber2Scene invadeTimeNumber3Scene invadeTimeNumber4Scene
global PETSumScene PETSumNumberScene
%上游数据
global allStepVehiclePETNumberUpstream
global invadeTimeLane1Upstream invadeTimeLane2Upstream invadeTimeLane3Upstream invadeTimeLane4Upstream
global invadeTimeLane1NumberUpstream invadeTimeLane2NumberUpstream invadeTimeLane3NumberUpstream invadeTimeLane4NumberUpstream
global invadeTimeNumber1Upstream invadeTimeNumber2Upstream invadeTimeNumber3Upstream invadeTimeNumber4Upstream
global PETSumUpstream PETSumNumberUpstream
if(choose == 1)
    %场景区 -> 通用
    invadeLine = invadeLineSet;
    allStepVehiclePETNumber = allStepVehiclePETNumberScene;
    invadeTimeLane1 = invadeTimeLane1Scene ;
    invadeTimeLane2 = invadeTimeLane2Scene ;
    invadeTimeLane3 = invadeTimeLane3Scene ;
    invadeTimeLane4 = invadeTimeLane4Scene ;
    invadeTimeLane1Number = invadeTimeLane1NumberScene;
    invadeTimeLane2Number = invadeTimeLane2NumberScene;
    invadeTimeLane3Number = invadeTimeLane3NumberScene;
    invadeTimeLane4Number = invadeTimeLane4NumberScene;
    invadeTimeNumber1 = invadeTimeNumber1Scene;
    invadeTimeNumber2 =  invadeTimeNumber2Scene;
    invadeTimeNumber3 =  invadeTimeNumber3Scene;
    invadeTimeNumber4 =  invadeTimeNumber4Scene;
    PETSum = PETSumScene;
    PETSumNumber = PETSumNumberScene;
elseif(choose == 2)
    % 通用 -> 场景
    allStepVehiclePETNumberScene = allStepVehiclePETNumber;
    invadeTimeLane1Scene = invadeTimeLane1 ;
    invadeTimeLane2Scene = invadeTimeLane2 ;
    invadeTimeLane3Scene = invadeTimeLane3 ;
    invadeTimeLane4Scene = invadeTimeLane4 ;
    invadeTimeLane1NumberScene = invadeTimeLane1Number;
    invadeTimeLane2NumberScene = invadeTimeLane2Number;
    invadeTimeLane3NumberScene = invadeTimeLane3Number;
    invadeTimeLane4NumberScene = invadeTimeLane4Number;
    invadeTimeNumber1Scene = invadeTimeNumber1;
    invadeTimeNumber2Scene =  invadeTimeNumber2;
    invadeTimeNumber3Scene =  invadeTimeNumber3;
    invadeTimeNumber4Scene =  invadeTimeNumber4;
    PETSumNumberScene = PETSumNumber;
    PETSumScene = PETSum;
    
elseif(choose == -1)
    %上游 -> 通用
    invadeLine = 1000;
    allStepVehiclePETNumber = allStepVehiclePETNumberUpstream;
    invadeTimeLane1 = invadeTimeLane1Upstream;
    invadeTimeLane2 = invadeTimeLane2Upstream;
    invadeTimeLane3 = invadeTimeLane3Upstream;
    invadeTimeLane4 = invadeTimeLane4Upstream;
    invadeTimeLane1Number = invadeTimeLane1NumberUpstream;
    invadeTimeLane2Number = invadeTimeLane2NumberUpstream;
    invadeTimeLane3Number = invadeTimeLane3NumberUpstream;
    invadeTimeLane4Number = invadeTimeLane4NumberUpstream;
    invadeTimeNumber1 = invadeTimeNumber1Upstream;
    invadeTimeNumber2 =  invadeTimeNumber2Upstream;
    invadeTimeNumber3 =  invadeTimeNumber3Upstream;
    invadeTimeNumber4 =  invadeTimeNumber4Upstream;
    PETSum = PETSumUpstream;
    PETSumNumber = PETSumNumberUpstream;
elseif(choose == -2)
   % 通用 -> 上游
    allStepVehiclePETNumberUpstream = allStepVehiclePETNumber;
    invadeTimeLane1Upstream = invadeTimeLane1 ;
    invadeTimeLane2Upstream = invadeTimeLane2 ;
    invadeTimeLane3Upstream = invadeTimeLane3 ;
    invadeTimeLane4Upstream = invadeTimeLane4 ;
    invadeTimeLane1NumberUpstream = invadeTimeLane1Number;
    invadeTimeLane2NumberUpstream = invadeTimeLane2Number;
    invadeTimeLane3NumberUpstream = invadeTimeLane3Number;
    invadeTimeLane4NumberUpstream = invadeTimeLane4Number;
    invadeTimeNumber1Upstream = invadeTimeNumber1;
    invadeTimeNumber2Upstream =  invadeTimeNumber2;
    invadeTimeNumber3Upstream =  invadeTimeNumber3;
    invadeTimeNumber4Upstream =  invadeTimeNumber4;
    PETSumUpstream = PETSum;
    PETSumNumberUpstream = PETSumNumber;
end




end

































