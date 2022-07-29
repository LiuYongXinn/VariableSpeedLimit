%降雨量的划分

function rainfallLabel = RainfallDetermination(userRainfall)
    %雨量等级划分
    %零星小雨
    veryLightRainStart = 0;
    veryLightRainEnd = 0.1;
    %小雨
    LightRainStart = 0.1;
    LightRainEnd = 9.9;
    %中雨
    ModerateRainStart= 10;
    ModerateRainEnd= 24.9;
    %大雨
    HeavyRainStart = 25.0;
    
    %判断所处天气条件
    %零星小雨
    if(userRainfall> veryLightRainStart && userRainfall <= veryLightRainEnd)
        rainfallLabel = 3;
    
    %小雨    
    elseif(userRainfall> LightRainStart && userRainfall <=LightRainEnd)
        rainfallLabel = 4;
        
    %中雨    
    elseif(userRainfall >= ModerateRainStart && userRainfall <= ModerateRainEnd)
        rainfallLabel = 5;
    %大雨    
    elseif(userRainfall > HeavyRainStart)
        rainfallLabel = 6;
        
    else
        rainfallLabel = 1;
    end

end