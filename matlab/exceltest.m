%% 设置每个日期下的流量和天气情况
% formatIn = 'dd/mmm/yyyy HH:MM:SS';
% DateString = {'2021/12/27 20:01:00'};
% datenum(DateString,formatIn)
% DateVector = datevec(B) %时间处理成年月日时分秒分开
% function DateSettings()



opts = spreadsheetImportOptions("NumVariables", 3);

% % 指定工作表和范围
opts.Sheet = "Sheet1";

% 指定列名称和类型
opts.VariableNames = ["dateTime", "rainFall", "volume"];
opts.VariableTypes = ["datetime", "double", "double"];

% 指定变量属性
opts = setvaropts(opts, "dateTime", "InputFormat", "");

% 导入数据
test = readtable("E:\文档\NewVSL\test.xlsx", opts, "UseExcel", false);
test(1,:) = [];

formatIn = 'dd/mmm/yyyy HH:MM:SS';

A = datenum(test.dateTime,formatIn);


