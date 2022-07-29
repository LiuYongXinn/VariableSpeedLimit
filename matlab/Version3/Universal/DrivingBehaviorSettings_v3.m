%% 根据天气条件设置不同的驾驶行为

function DrivingBehaviorSettings_v3(netLinks,userWeatherChooseRL)
 
linkCount = netLinks.Count;
for i = 1 : linkCount
    linkTemp = netLinks.Item(i);
    linkTemp.set('AttValue', 'TYPE', userWeatherChooseRL);
end

end