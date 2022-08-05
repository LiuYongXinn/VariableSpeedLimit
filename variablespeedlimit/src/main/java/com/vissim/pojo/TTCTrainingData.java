package com.vissim.pojo;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;

@TableName("ttc_training_data")
public class TTCTrainingData {
    private int densityBefore;
    private int densityAfter;
    private int speedLimit;
    private int sceneLimit;
    private int randSeed;
    @TableField("ttc_before")
    private int TTCBefore;
    @TableField("ttc_after")
    private int TTCAfter;


    public TTCTrainingData() {
    }

    public TTCTrainingData(int densityBefore, int densityAfter, int speedLimit, int sceneLimit,
                           int randSeed, int TTCBefore, int TTCAfter) {
        this.densityBefore = densityBefore;
        this.densityAfter = densityAfter;
        this.speedLimit = speedLimit;
        this.sceneLimit = sceneLimit;
        this.randSeed = randSeed;
        this.TTCBefore = TTCBefore;
        this.TTCAfter = TTCAfter;
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

    public int getTTCBefore() {
        return TTCBefore;
    }

    public void setTTCBefore(int TTCBefore) {
        this.TTCBefore = TTCBefore;
    }

    public int getTTCAfter() {
        return TTCAfter;
    }

    public void setTTCAfter(int TTCAfter) {
        this.TTCAfter = TTCAfter;
    }

    @Override
    public String toString() {
        return "TTCTrainingData{" +
                "densityBefore=" + densityBefore +
                ", densityAfter=" + densityAfter +
                ", speedLimit=" + speedLimit +
                ", sceneLimit=" + sceneLimit +
                ", randSeed=" + randSeed +
                ", TTCBefore=" + TTCBefore +
                ", TTCAfter=" + TTCAfter +
                '}';
    }
}
