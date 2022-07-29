function action = ActionChooseForBaseTraining(Qtable, state,T, QtableNums)
    
    tableWith = size(Qtable, 2);
    oneEValue = zeros(1,tableWith);
    eValueSum = 0;

    
    for tli = 1 : tableWith
       actionQvalue = Qtable(state, tli);
       actionNums = QtableNums(state,tli);
       if(actionQvalue == 0 || actionNums < 5)
         action = tli;
         return;
       end
       oneEValue(1,tli) = exp(actionQvalue / T);
       eValueSum = oneEValue(1,tli)+ eValueSum;
    end
    
    
    %计算动作的累加概率
    actionP = zeros(1, tableWith);
    actionP(1,1) = oneEValue(1,1)/eValueSum;
    for api = 2 : tableWith
        actionP(1,api) =actionP(1,api-1)+ (oneEValue(1,api) / eValueSum);
    end
    %选择动作
    action = BinarySearch(actionP, rand);

end


function actionLabel = BinarySearch(arr, num)
   arrLength = size(arr,2); 
   for i = 1 : arrLength
       if(num <= arr(1,i))
           break;
       end
   end
  actionLabel = i;
    
%     left = 1;
%     right = size(arr,2);
%     
%     while(left <= right)
%         mid = int8(left+ (right - left) / 2);
%         if(num >= arr(mid))
%             left = mid + 1;
%         elseif(num < arr(mid))
%             right = mid - 1;
%         end
%     end
%     
%     %输出动作选择标签
%     actionLabel = right + 1;
end