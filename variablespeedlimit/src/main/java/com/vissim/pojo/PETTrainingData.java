package com.vissim.pojo;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;

@TableName("pet_training_data")
public class PETTrainingData {
    private int densityBefore;
    private int densityAfter;
    private int speedLimit;
    private int sceneLimit;
    private int randSeed;
    @TableField("pet_before")
    private int PETBefore;
    @TableField("pet_after")
    private int PETAfter;


    public PETTrainingData(int densityBefore, int densityAfter, int speedLimit, int sceneLimit, int randSeed, int PETBefore, int PETAfter) {
        this.densityBefore = densityBefore;
        this.densityAfter = densityAfter;
        this.speedLimit = speedLimit;
        this.sceneLimit = sceneLimit;
        this.randSeed = randSeed;
        this.PETBefore = PETBefore;
        this.PETAfter = PETAfter;
    }

    public PETTrainingData() {
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

    public int getPETBefore() {
        return PETBefore;
    }

    public void setPETBefore(int PETBefore) {
        this.PETBefore = PETBefore;
    }

    public int getPETAfter() {
        return PETAfter;
    }

    public void setPETAfter(int PETAfter) {
        this.PETAfter = PETAfter;
    }

    @Override
    public String toString() {
        return "PETTrainingData{" +
                "densityBefore=" + densityBefore +
                ", densityAfter=" + densityAfter +
                ", speedLimit=" + speedLimit +
                ", sceneLimit=" + sceneLimit +
                ", randSeed=" + randSeed +
                ", PETBefore=" + PETBefore +
                ", PETAfter=" + PETAfter +
                '}';
    }
}
