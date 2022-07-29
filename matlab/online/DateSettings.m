% pwd : 保存时间、降雨量和车流量数据的excel文件的地址


%secondRainVolumeData : 关于步长、降雨量、车流量的数据矩阵
%   secondRainVolumeData = [step, rainfall, volume]

function secondRainVolumeData = DateSettings(trafficRainPathName,trafficRainFileName)
    %% 导入excel数据
    opts = spreadsheetImportOptions("NumVariables", 3);
    % 指定工作表和范围
    opts.Sheet = "Sheet1";
    % 指定列名称和类型
    opts.VariableNames = ["dateTime", "rainFall", "volume"];
    opts.VariableTypes = ["datetime", "double", "double"];
    % 指定变量属性
    opts = setvaropts(opts, "dateTime", "InputFormat", "");

    % 导入数据
    %excelPwd = [pwd,'\test.xlsx'];
    excelPwd = strcat(trafficRainPathName,trafficRainFileName);
    excelData = readtable(excelPwd, opts, "UseExcel", false);
    %删除第一行的标题
    excelData(1,:) = [];


    %% 将导入数据的时间进行处理
    % excel存储数据的行数
    excelLength = size(excelData,1);
    % 步长对0时对应的天气情况
    startTime = excelData.dateTime(1);
    %时刻数据 存储数组
    timeData = zeros(excelLength,6);

    for tdi = 1 : excelLength
        % 不同时刻与第一时刻的时间差
        timeInterval = excelData.dateTime(tdi) -startTime;
        timeData(tdi,:) = datevec(timeInterval);
    end

    %将数据四舍五入到整型
    timeData = round(timeData);

    %% 将时间转换成秒
    %时间、降雨量、流量 存储数组
    secondRainVolumeData = zeros(excelLength,3);

    for srvi = 1 : excelLength
        %获取时、分、秒
        excelHour = timeData(srvi,4);
        excelMinute = timeData(srvi,5);
        excelSecond = timeData(srvi,6);

        %将时分秒转换成秒
        secondRainVolumeData(srvi,1) = (excelHour * 60 * 60) + (excelMinute * 60) + excelSecond;
        %提取对应时刻的降雨量和车流量
        secondRainVolumeData(srvi,2) = excelData.rainFall(srvi);
        secondRainVolumeData(srvi,3) = round(excelData.volume(srvi));
    end
end
