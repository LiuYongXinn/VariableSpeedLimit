package com.vissim.service.filereading.impl;

import com.vissim.service.filereading.FileDataReadingService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;


@SpringBootTest
class FileDataReadingServiceImplTest {

    @Autowired
    FileDataReadingService fileDataReadingService;

    @Test
    void readVehicleData() {
        String strFile = "E:\\JAVALearn\\VariableSpeedLimit\\vissim\\LaneClose\\laneclose.fzp";
        List<String> fileData = fileDataReadingService.readVehicleData(strFile);
        List<Double[]> vehiclesDataDouble = fileDataReadingService.vehicleDataStringToNumber(fileData);


    }
}