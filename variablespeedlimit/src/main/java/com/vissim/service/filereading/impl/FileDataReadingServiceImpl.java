package com.vissim.service.filereading.impl;

import com.vissim.pojo.IntermediateConnection;
import com.vissim.pojo.VehicleData;
import com.vissim.service.filereading.FileDataReadingService;
import org.springframework.stereotype.Service;

import java.io.*;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;

@Service
public class FileDataReadingServiceImpl implements FileDataReadingService {


    @Override
    public IntermediateConnection readUniversalData(String strFile, int speedLimit, int sceneLimit, int randSeed) {
        return null;
    }

    @Override
    public List<String> readVehicleData(String strFile) {
        List<String> fileData = new ArrayList<>();

        try {
            File file = new File(strFile);
            if(file.isFile() && file.exists()){
                InputStreamReader isr = new InputStreamReader(Files.newInputStream(file.toPath()), StandardCharsets.UTF_8);
                BufferedReader br = new BufferedReader(isr);
                String lineTxt;
                int num = 0;
                while ((lineTxt = br.readLine()) != null){
                    num++;
                    if(num <= 21){
                        continue;
                    }
                    fileData.add(lineTxt);
                }
                br.close();
            }else {
                throw new RuntimeException("文件不存在！");
            }
        } catch (Exception e) {
           throw new RuntimeException("文件读取错误！");
        }
        return fileData;
    }


    @Override
    public List<Double[]> vehicleDataStringToNumber(List<String> vehiclesData) {
        List<Double[]> vehiclesDataNum = new ArrayList<>();
        for (String vehicleStr: vehiclesData) {
            String[] vehicleStrArr = vehicleStr.split(";");
            Double[] vehicleDouble = new Double[vehicleStrArr.length - 1];
            for (int i = 0; i < vehicleStrArr.length - 1; i++) {
                vehicleDouble[i] = Double.valueOf(vehicleStrArr[i]);
            }
            vehiclesDataNum.add(vehicleDouble);
        }
        return vehiclesDataNum;
    }

    @Override
    public List<VehicleData> vehicleDataToAfterAndBefore(List<Double> vehiclesData, IntermediateConnection intermediateConnection) {
        return null;
    }


}
