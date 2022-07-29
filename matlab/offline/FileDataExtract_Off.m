function [vehicleData, travelTimes, linkEvaluation, queueLengthRecord,...
          dataCollection] = FileDataExtract_Off(vissimPathName,vissimUnifiedName)

      
    %% 车辆记录 test3.fzp
    %fzpPwd = [pwd,'\test3.fzp'];
    fzpPwd = strcat(vissimPathName,vissimUnifiedName,'.fzp');
    fzpOpen = fopen(fzpPwd);
    %提取车辆记录
    fzpCell = textscan(fzpOpen,'%f %f %f %f %f %f %f %*[^\n]','HeaderLines',16,'Delimiter',';');     
    fclose(fzpOpen);
    %保存车辆数据
    vehicleData = cell2mat(fzpCell);
    
    
    %% 旅行时间 test3.rsz
    %rszPwd = [pwd,'\test3.rsz'];
    rszPwd = strcat(vissimPathName,vissimUnifiedName,'.rsz');
    rszOpen = fopen(rszPwd);
    %提取数据
    rszCell = textscan(rszOpen,'%f %f %f %*[^\n]','HeaderLines',12,'Delimiter',';');
    fclose(rszOpen);
    %保存旅行时间数据
    travelTimes = cell2mat(rszCell);
    
    
    %% 道路评价 test3.str
    %strPwd = [pwd,'\test3.str'];
    strPwd = strcat(vissimPathName,vissimUnifiedName,'.str');
    strOpen = fopen(strPwd);
    %提取数据
    strCell = textscan(strOpen,'%f %f %f %f %f %f %f %*[^\n]','HeaderLines',25,'Delimiter',';');
    fclose(strOpen);
    %保存旅行时间数据
    linkEvaluation = cell2mat(strCell);
    
    
    %% 排队长度 test3.stz
    %stzPwd = [pwd,'\test3.stz'];
    stzPwd = strcat(vissimPathName,vissimUnifiedName,'.stz');
    stzOpen = fopen(stzPwd);
    %提取数据
    stzCell = textscan(stzOpen,'%f %f %f %f %f %f %f %*[^\n]','HeaderLines',16,'Delimiter',';');
    fclose(stzOpen);
    %保存旅行时间数据
    queueLengthRecord = cell2mat(stzCell);
    
    
    %% 数据采集点 test3.mer (Raw Data)
    %merPwd = [pwd,'\test3.mer'];
    merPwd = strcat(vissimPathName,vissimUnifiedName,'.mer');
    merOpen = fopen(merPwd);
    %提取数据
    merCell = textscan(merOpen,'%f %f %f %f %f %f %f %f %f %f %f %f %*[^\n]','HeaderLines',15);
    fclose(merOpen);
    %保存旅行时间数据
    dataCollection = cell2mat(merCell);
    
end