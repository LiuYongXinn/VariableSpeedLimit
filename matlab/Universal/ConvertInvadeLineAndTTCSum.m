%% TTC场景转换
% 上游或场景 -> 通用
% 上游 -> 通用     ： -1 
% 场景 -> 通用     ：  1

% 通用 -> 场景或上游
% 通用 -> 上游     ： -2
% 通用 -> 场景     ：  2


%%
function ConvertInvadeLineAndTTCSum(choose, invadeLineSet)
    global invadeLine
    global TTCSum TTCSumNumber;
    global TTCSumScene TTCSumNumberScene;
    global TTCSumUpstream TTCSumNumberUpstream;
    if(choose == 1)
        %场景区 -> 通用
        invadeLine = invadeLineSet;
        TTCSum = TTCSumScene;
        TTCSumNumber = TTCSumNumberScene;
    elseif(choose == -1)
        %上游 -> 通用
        invadeLine = 1000;
        TTCSum = TTCSumUpstream;
        TTCSumNumber = TTCSumNumberUpstream;
        
    elseif(choose == 2)
        % 通用 -> 场景
        TTCSumScene = TTCSum;
        TTCSumNumberScene = TTCSumNumber;
    elseif(choose == -2)
        % 通用 -> 上游
        TTCSumUpstream = TTCSum;
        TTCSumNumberUpstream = TTCSumNumber;
       
    end
    


end