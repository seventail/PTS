package com.greejoy.car.domain;

import com.greejoy.gtip.persistence.domain.BaseDomain;

import java.util.Date;

/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-11-7
 * Time: 下午8:43
 * To change this template use File | Settings | File Templates.
 */
public class CarStopInfo{
    private String plateNo;
    private Date timeID;
    private Date startDate;
    private Date outDate;
    private int floor_num;
    private int stopTime;
    private String s_ip;
    private boolean passageway;

    public boolean isPassageway() {
        return passageway;
    }

    public void setPassageway(boolean passageway) {
        this.passageway = passageway;
    }

    public Date getTimeID() {
        return timeID;
    }

    public void setTimeID(Date timeID) {
        this.timeID = timeID;
    }

    public String getS_ip() {
        return s_ip;
    }

    public void setS_ip(String s_ip) {
        this.s_ip = s_ip;
    }

    public String getPlateNo() {
        return plateNo;
    }

    public void setPlateNo(String plateNo) {
        this.plateNo = plateNo;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getOutDate() {
        return outDate;
    }

    public void setOutDate(Date outDate) {
        this.outDate = outDate;
    }

    public int getFloor_num() {
        return floor_num;
    }

    public void setFloor_num(int floor_num) {
        this.floor_num = floor_num;
    }

    public int getStopTime() {
        return stopTime;
    }

    public void setStopTime(int stopTime) {
        this.stopTime = stopTime;
    }
}
