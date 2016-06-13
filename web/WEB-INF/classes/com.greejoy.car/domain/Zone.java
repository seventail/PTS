package com.greejoy.car.domain;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-11-6
 * Time: 下午5:00
 * To change this template use File | Settings | File Templates.
 */
public class Zone{
    private String zone_num;
    private List<Detector> detectorList;

    public String getZone_num() {
        return zone_num;
    }

    public void setZone_num(String zone_num) {
        this.zone_num = zone_num;
    }

    public List<Detector> getDetectorList() {
        return detectorList;
    }

    public void setDetectorList(List<Detector> detectorList) {
        this.detectorList = detectorList;
    }
}
