%% 计算车辆越过侵入线的时间
%[Lane,Step, ID,Speed, LinkCoord, Link]

function [id,stepTime,invadeTime] = CalculateInvadeTime_v3(vehicleData)


stepTime = vehicleData(1,2);
id = vehicleData(1,3);
speedkmh = vehicleData(1,4);
linkcoord = vehicleData(1,5);

global invadeLine;
distance = linkcoord - invadeLine;
speedms = (speedkmh * 1000)/(60*60);
beyondTime = distance / speedms;
invadeTime = stepTime - beyondTime;

end



