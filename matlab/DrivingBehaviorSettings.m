%% 车辆驾驶行为设置
function [CC0, CC1, CC2, CC3, CC4, CC5, CC6, CC7, CC8, CC9] = ...
                                        DrivingBehaviorSettings(netDrivingBehaviorParSets, userWeatherChoose)
                                    
    freewayDrivingBehavior = netDrivingBehaviorParSets.GetDrivingBehaviorParSetByNumber(3);
    behaviorDecision = DriverBehaviorChoose(userWeatherChoose);
    
    %设置驾驶行为
    freewayDrivingBehavior.set('AttValue','CC0',behaviorDecision(1));
    freewayDrivingBehavior.set('AttValue','CC1',behaviorDecision(2));
    freewayDrivingBehavior.set('AttValue','CC2',behaviorDecision(3));
    freewayDrivingBehavior.set('AttValue','CC3',behaviorDecision(4));
    freewayDrivingBehavior.set('AttValue','CC4',behaviorDecision(5));
    freewayDrivingBehavior.set('AttValue','CC5',behaviorDecision(6));
    freewayDrivingBehavior.set('AttValue','CC6',behaviorDecision(7));
    freewayDrivingBehavior.set('AttValue','CC7',behaviorDecision(8));
    freewayDrivingBehavior.set('AttValue','CC8',behaviorDecision(9));
    freewayDrivingBehavior.set('AttValue','CC9',behaviorDecision(10));
    
    %获取当前驾驶行为
    CC0 = freewayDrivingBehavior.get('AttValue','CC0');
    CC1 = freewayDrivingBehavior.get('AttValue','CC1');
    CC2 = freewayDrivingBehavior.get('AttValue','CC2');
    CC3 = freewayDrivingBehavior.get('AttValue','CC3');
    CC4 = freewayDrivingBehavior.get('AttValue','CC4');
    CC5 = freewayDrivingBehavior.get('AttValue','CC5');
    CC6 = freewayDrivingBehavior.get('AttValue','CC6');
    CC7 = freewayDrivingBehavior.get('AttValue','CC7');
    CC8 = freewayDrivingBehavior.get('AttValue','CC8');
    CC9 = freewayDrivingBehavior.get('AttValue','CC9');
    
end




