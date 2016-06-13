package com.greejoy.car.domain;

import com.greejoy.gtip.persistence.domain.BaseDomain;
import com.greejoy.station.domain.Station;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-11-7
 * Time: 下午1:07
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "t_camera_ip")
public class CameraIp extends BaseDomain<CameraIp>{
    private Station station;
    private int floor_num;
    private String cameraIp;
    private boolean passageway;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "station_id")
    public Station getStation() {
        return station;
    }

    public void setStation(Station station) {
        this.station = station;
    }

    @Basic
    public int getFloor_num() {
        return floor_num;
    }

    public void setFloor_num(int floor_num) {
        this.floor_num = floor_num;
    }

    @Basic
    public String getCameraIp() {
        return cameraIp;
    }

    public void setCameraIp(String cameraIp) {
        this.cameraIp = cameraIp;
    }
    @Basic
    public boolean isPassageway() {
        return passageway;
    }

    public void setPassageway(boolean passageway) {
        this.passageway = passageway;
    }

    @Transactional
    public static CameraIp byFloor(int floor_num,long station_id){
        String hql="from CameraIp where floor_num=:floor_num and station.id=:station_id";
        return (CameraIp)sessionFactory.getCurrentSession().createQuery(hql).setInteger("floor_num",floor_num).setLong("station_id",station_id).uniqueResult();
    }

    @Transactional
    public static List<CameraIp> getCameraIpByFloor(int floor_num,long station_id){
        String hql="from CameraIp where floor_num=:floor_num and station.id=:station_id and passageway =1";
        return sessionFactory.getCurrentSession().createQuery(hql).setInteger("floor_num",floor_num).setLong("station_id",station_id).list();
    }

    @Transactional
    public static List<CameraIp> getByFloorPassageway(int floor_num,long station_id){
        String hql="from CameraIp where floor_num=:floor_num and station.id=:station_id and passageway =0";
        return sessionFactory.getCurrentSession().createQuery(hql).setInteger("floor_num",floor_num).setLong("station_id",station_id).list();
    }

    @Transactional
    public static List<CameraIp> getByFloor(int floor_num,long station_id){
        String hql="from CameraIp where floor_num=:floor_num and station.id=:station_id";
        return sessionFactory.getCurrentSession().createQuery(hql).setInteger("floor_num",floor_num).setLong("station_id",station_id).list();
    }

    @Transactional
    public static CameraIp getCameraIpByIp(String cameraIp){
        String hql="from CameraIp where cameraIp=:cameraIp";
        return (CameraIp)sessionFactory.getCurrentSession().createQuery(hql).setString("cameraIp",cameraIp).uniqueResult();
    }

    @Transactional
    public static List<CameraIp> getCameraIpByPassagewayIsNot(){
        String hql="from CameraIp where  passageway =1";
        return sessionFactory.getCurrentSession().createQuery(hql).list();
    }
}
