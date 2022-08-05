package com.vissim.pojo;

import com.baomidou.mybatisplus.annotation.TableName;

@TableName("intermediate_connection")
public class IntermediateConnection {
    private int densityBefore;
    private int densityAfter;
    private int speedLimit;
    private int sceneLimit;
    private int randSeed;


    public IntermediateConnection() {
    }

    public IntermediateConnection(int densityBefore, int densityAfter, int speedLimit, int sceneLimit, int randSeed) {
        this.densityBefore = densityBefore;
        this.densityAfter = densityAfter;
        this.speedLimit = speedLimit;
        this.sceneLimit = sceneLimit;
        this.randSeed = randSeed;
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
}
