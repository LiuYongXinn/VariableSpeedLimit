package com.vissim.pojo;


import jdk.nashorn.internal.runtime.regexp.joni.ast.StringNode;

/**
 * 仿真过程得车辆数据
 */
public class Vehicle {
    private Integer id;
    private Integer link;
    private Double linkCoordinate;
    private Integer lane;
    private Double speed;
    private Integer step;

    public Vehicle() {
    }


    public Vehicle(Integer id, Integer link, Double linkCoordinate, Integer lane, Double speed, Integer step) {
        this.id = id;
        this.link = link;
        this.linkCoordinate = linkCoordinate;
        this.lane = lane;
        this.speed = speed;
        this.step = step;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getLink() {
        return link;
    }

    public void setLink(Integer link) {
        this.link = link;
    }

    public Double getLinkCoordinate() {
        return linkCoordinate;
    }

    public void setLinkCoordinate(Double linkCoordinate) {
        this.linkCoordinate = linkCoordinate;
    }

    public Integer getLane() {
        return lane;
    }

    public void setLane(Integer lane) {
        this.lane = lane;
    }

    public Double getSpeed() {
        return speed;
    }

    public void setSpeed(Double speed) {
        this.speed = speed;
    }

    public Integer getStep() {
        return step;
    }

    public void setStep(Integer step) {
        this.step = step;
    }

    @Override
    public String toString() {
        return "Vehicle{" +
                "id=" + id +
                ", link=" + link +
                ", linkCoordinate=" + linkCoordinate +
                ", lane=" + lane +
                ", speed=" + speed +
                ", step=" + step  +
                '}';
    }
}
