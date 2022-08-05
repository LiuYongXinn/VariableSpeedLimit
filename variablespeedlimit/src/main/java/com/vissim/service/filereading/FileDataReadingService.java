package com.vissim.service.filereading;

import com.vissim.pojo.IntermediateConnection;
import com.vissim.pojo.VehicleData;
import com.vissim.pojo.VehicleDataBefore;

import java.util.List;

public interface FileDataReadingService {

    /**
     * 获取通用的数据，如控制前交通流密度、控制后交通流密度、限速区限速值，场景区限速值、随机种子
     * @param strFile 读取密度文件的路径
     * @param speedLimit 限速区的限速值
     * @param sceneLimit 场景区的限速值
     * @param randSeed 随机种子
     * @return 返回通用数据对象
     */
    IntermediateConnection readUniversalData(String strFile , int speedLimit, int sceneLimit, int randSeed);

    /**
     * 读取车辆数据文件
     * @param strFile 车辆数据文件*.fzp路径
     * @return 包含当前仿真所有的车辆数据集合
     */
    List<String> readVehicleData(String strFile);


    /**
     * 将车辆数据从字符串转换成数组集合
     * @param vehiclesData 包含所有车辆数据的字符串集合
     * @return 包含所有车辆数据的数组集合
     */
    List<Double[]> vehicleDataStringToNumber(List<String> vehiclesData);


    /**
     * 将包含所有车辆数据的数组集合归类到vehicleDataBefore和vehicleDataAfter之中
     * @param vehiclesData 包含所有车辆数据的数据集合
     * @param intermediateConnection 当次仿真的通用数据对象
     * @return 返回控制前和控制后的数据对象集合
     */
    List<VehicleData> vehicleDataToAfterAndBefore(List<Double> vehiclesData, IntermediateConnection intermediateConnection);







}
