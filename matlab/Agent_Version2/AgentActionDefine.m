%% 强化学习动作集
% 输入
% scenesChoose：场景选择
% 输出
% limitSet : 限速区动作
% motionSet ：场景区动作
%%
function [limitSet,motionSet] = AgentActionDefine(scenesChoose)
%     speedSet = [0,1,2,3,4,5,6,7,8; 30,40,50,60,70,80,90,100,120];
%     volumeSet = [0,1,2,3,4 ;200,400,600,800,100];
    limitSet = [60,70,80,90,100,110,120];
    if(strcmp(scenesChoose, "confluence"))
        %合流区
        motionSet = [200,400,600,800,1000];
    elseif(strcmp(scenesChoose, "tunnel"))
        %隧道
        motionSet = [60,70,80,90,100];
    elseif(strcmp(scenesChoose, "bridge"))
        %桥梁
        motionSet = [80,90,100,110,120];
    elseif(strcmp(scenesChoose, "turning"))
        %转弯
        motionSet = zeros(1,5);
    elseif(strcmp(scenesChoose, "construction"))
        %施工区
        motionSet = [80,90,100,110,120];
    else
        motionSet = zeros(1,5);
    end
    
end