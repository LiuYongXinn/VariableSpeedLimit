package com.vissim.pojo;

import com.baomidou.mybatisplus.annotation.TableName;

/**
 * 控制后的车辆数据
 */

@TableName("vehicle_data_after")
public class VehicleDataAfter extends VehicleData{
    private int densityBefore;
    private int densityAfter;
    private int speedLimit;
    private int sceneLimit;
    private int randSeed;
    private int simulationTime;
    private int vehicleNumber;
    private int linkNumber;
    private int laneNumber;
    private double speed;
    private double linkCoordinate;
    private int leadingVehicle;
    private double speedDifference;
    private double followingDistance;


    public VehicleDataAfter() {
    }

    public VehicleDataAfter(int speedLimit, int sceneLimit, int randSeed, int simulationTime, int vehicleNumber,
                            int linkNumber, int laneNumber, double speed, double linkCoordinate, int leadingVehicle,
                            double speedDifference, double followingDistance) {
        this.speedLimit = speedLimit;
        this.sceneLimit = sceneLimit;
        this.randSeed = randSeed;
        this.simulationTime = simulationTime;
        this.vehicleNumber = vehicleNumber;
        this.linkNumber = linkNumber;
        this.laneNumber = laneNumber;
        this.speed = speed;
        this.linkCoordinate = linkCoordinate;
        this.leadingVehicle = leadingVehicle;
        this.speedDifference = speedDifference;
        this.followingDistance = followingDistance;
    }

    public VehicleDataAfter(int densityBefore, int densityAfter, int speedLimit, int sceneLimit, int randSeed,
                            int simulationTime, int vehicleNumber, int linkNumber, int laneNumber, double speed,
                            double linkCoordinate, int leadingVehicle, double speedDifference, double followingDistance) {
        this.densityBefore = densityBefore;
        this.densityAfter = densityAfter;
        this.speedLimit = speedLimit;
        this.sceneLimit = sceneLimit;
        this.randSeed = randSeed;
        this.simulationTime = simulationTime;
        this.vehicleNumber = vehicleNumber;
        this.linkNumber = linkNumber;
        this.laneNumber = laneNumber;
        this.speed = speed;
        this.linkCoordinate = linkCoordinate;
        this.leadingVehicle = leadingVehicle;
        this.speedDifference = speedDifference;
        this.followingDistance = followingDistance;
    }


    public int getDensityBefore() {
        return densityBefore;
    }

    public void setDensityBefore(int densityBefore) {
        this.densityBefore = densityBefore;
    }

    public int getDensityAfter() {
        return densityAfter;
    }

    public void setDensityAfter(int densityAfter) {
        this.densityAfter = densityAfter;
    }

    public int getSpeedLimit() {
        return speedLimit;
    }

    public void setSpeedLimit(int speedLimit) {
        this.speedLimit = speedLimit;
    }

    public int getSceneLimit() {
        return sceneLimit;
    }

    public void setSceneLimit(int sceneLimit) {
        this.sceneLimit = sceneLimit;
    }

    public int getRandSeed() {
        return randSeed;
    }

    public void setRandSeed(int randSeed) {
        this.randSeed = randSeed;
    }

    public int getSimulationTime() {
        return simulationTime;
    }

    public void setSimulationTime(int simulationTime) {
        this.simulationTime = simulationTime;
    }

    public int getVehicleNumber() {
        return vehicleNumber;
    }

    public void setVehicleNumber(int vehicleNumber) {
        this.vehicleNumber = vehicleNumber;
    }

    public int getLinkNumber() {
        return linkNumber;
    }

    public void setLinkNumber(int linkNumber) {
        this.linkNumber = linkNumber;
    }

    public int getLaneNumber() {
        return laneNumber;
    }

    public void setLaneNumber(int laneNumber) {
        this.laneNumber = laneNumber;
    }

    public double getSpeed() {
        return speed;
    }

    public void setSpeed(double speed) {
        this.speed = speed;
    }

    public double getLinkCoordinate() {
        return linkCoordinate;
    }

    public void setLinkCoordinate(double linkCoordinate) {
        this.linkCoordinate = linkCoordinate;
    }

    public int getLeadingVehicle() {
        return leadingVehicle;
    }

    public void setLeadingVehicle(int leadingVehicle) {
        this.leadingVehicle = leadingVehicle;
    }

    public double getSpeedDifference() {
        return speedDifference;
    }

    public void setSpeedDifference(double speedDifference) {
        this.speedDifference = speedDifference;
    }

    public double getFollowingDistance() {
        return followingDistance;
    }

    public void setFollowingDistance(double followingDistance) {
        this.followingDistance = followingDistance;
    }

    @Override
    public String toString() {
        return "VehicleDataAfter{" +
                "densityBefore=" + densityBefore +
                ", densityAfter=" + densityAfter +
                ", speedLimit=" + speedLimit +
                ", sceneLimit=" + sceneLimit +
                ", randSeed=" + randSeed +
                ", simulationTime=" + simulationTime +
                ", vehicleNumber=" + vehicleNumber +
                ", linkNumber=" + linkNumber +
                ", laneNumber=" + laneNumber +
                ", speed=" + speed +
                ", linkCoordinate=" + linkCoordinate +
                ", leadingVehicle=" + leadingVehicle +
                ", speedDifference=" + speedDifference +
                ", followingDistance=" + followingDistance +
                '}';
    }
}
