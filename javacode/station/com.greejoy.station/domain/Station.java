package com.greejoy.station.domain;

import com.greejoy.car.domain.CameraIp;
import com.greejoy.floor.domain.AkeparkFloorNum;
import com.greejoy.user.domain.UserXPerssion;
import com.greejoy.floor.domain.Floor;
import com.greejoy.gtip.component.Page;
import com.greejoy.gtip.component.support.Asserts;
import com.greejoy.gtip.module.base.domain.FieldModifyDetail;
import com.greejoy.gtip.module.rbac.domain.User;
import com.greejoy.gtip.module.rbac.support.helper.UserHelper;
import com.greejoy.gtip.persistence.domain.Addable;
import com.greejoy.gtip.persistence.domain.BaseDomain;
import com.greejoy.gtip.persistence.domain.Domain;
import com.greejoy.gtip.persistence.domain.Modifiable;
import com.greejoy.gtip.util.EqualsUtils;
import com.greejoy.user.domain.UserXStation;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.util.StringUtils;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-10-9
 * Time: 上午11:04
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Domain(name = "场站信息")
@Table(name = "t_station")
public class Station extends BaseDomain<Station> implements Addable,Modifiable<Station>{

    private String name;             // 场站名称
    private String address;         //场站地址
    private String station_ip;     //场站数据库IP地址
    private int station_port;     //场站数据库端口
    private int parking_total;    //场站的总停车位数
    private List<Floor> floorList;  // 场站下所有的楼层信息
    private List<UserXPerssion> userXPerssionList;
    private List<UserXStation> userXStationList;
    private List<AkeparkFloorNum> akeparkFloorNumList;
    private List<CameraIp> cameraIpList;

    @OneToMany(mappedBy = "station" ,cascade = CascadeType.REMOVE)
    @LazyCollection(LazyCollectionOption.EXTRA)
    public List<CameraIp> getCameraIpList() {
        return cameraIpList;
    }

    public void setCameraIpList(List<CameraIp> cameraIpList) {
        this.cameraIpList = cameraIpList;
    }

    @OneToMany(mappedBy = "station" ,cascade = CascadeType.REMOVE)
    @LazyCollection(LazyCollectionOption.EXTRA)
    public List<AkeparkFloorNum> getAkeparkFloorNumList() {
        return akeparkFloorNumList;
    }

    public void setAkeparkFloorNumList(List<AkeparkFloorNum> akeparkFloorNumList) {
        this.akeparkFloorNumList = akeparkFloorNumList;
    }

    @OneToMany(mappedBy = "station" ,cascade = CascadeType.REMOVE)
    @LazyCollection(LazyCollectionOption.EXTRA)
    public List<UserXPerssion> getUserXPerssionList() {
        return userXPerssionList;
    }

    public void setUserXPerssionList(List<UserXPerssion> userXPerssionList) {
        this.userXPerssionList = userXPerssionList;
    }

    @OneToMany(mappedBy = "station" ,cascade = CascadeType.REMOVE)
    @LazyCollection(LazyCollectionOption.EXTRA)
    public List<UserXStation> getUserXStationList() {
        return userXStationList;
    }

    public void setUserXStationList(List<UserXStation> userXStationList) {
        this.userXStationList = userXStationList;
    }

    @Basic
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Basic
    public String getStation_ip() {
        return station_ip;
    }

    public void setStation_ip(String station_ip) {
        this.station_ip = station_ip;
    }

    @Basic
    public int getStation_port() {
        return station_port;
    }

    public void setStation_port(int station_port) {
        this.station_port = station_port;
    }

    @Basic
    public int getParking_total() {
        return parking_total;
    }

    public void setParking_total(int parking_total) {
        this.parking_total = parking_total;
    }

    @OneToMany(mappedBy = "station" ,cascade = CascadeType.REMOVE)
    @LazyCollection(LazyCollectionOption.EXTRA)
    public List<Floor> getFloorList() {
        return floorList;
    }

    public void setFloorList(List<Floor> floorList) {
        this.floorList = floorList;
    }


    public void add() {
        boolean canAdd = canAdd();
        Asserts.assertTrue(canAdd, validateAdd());
        save();
    }

    public static List<Station> listByPage(Page page, String name, long idx) {
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Station.class);
        Order order = Order.asc("id");
        if (StringUtils.hasText(name)) {
            detachedCriteria.add(Restrictions.like("name", name, MatchMode.ANYWHERE));
        }
        if (idx != 0) {
            detachedCriteria.add(Restrictions.eq("id", idx));
        }
        return listByCriteria(detachedCriteria, page, order);
    }

    @Override
    public List<FieldModifyDetail> modifyTo(Station other) {
        List<FieldModifyDetail> fieldModifyDetailList = new ArrayList<FieldModifyDetail>();
        if (!EqualsUtils.equals(getName(), other.getName())) {
            fieldModifyDetailList.add(new FieldModifyDetail("name", "姓名", getName(), other.getName()));
            setName(other.getName());
        }
        if (!EqualsUtils.equals(getAddress(), other.getAddress())) {
            fieldModifyDetailList.add(new FieldModifyDetail("address", "地址", getAddress(), other.getAddress()));
            setAddress(other.getAddress());
        }
        if (!EqualsUtils.equals(getStation_ip(), other.getStation_ip())) {
            fieldModifyDetailList.add(new FieldModifyDetail("station_ip","数据库IP地址", getStation_ip(), other.getStation_ip()));
            setStation_ip(other.getStation_ip());
        }
        if (!EqualsUtils.equals(getStation_port(), other.getStation_port())) {
            fieldModifyDetailList.add(new FieldModifyDetail("station_port","数据库端口", String.valueOf(getStation_port()), String.valueOf(other.getStation_port())));
            setStation_port(other.getStation_port());
        }
        if (!EqualsUtils.equals(getParking_total(), other.getParking_total())) {
            fieldModifyDetailList.add(new FieldModifyDetail("parking_total","停车位", String.valueOf(getParking_total()), String.valueOf(other.getParking_total())));
            setParking_total(other.getParking_total());
        }
        return fieldModifyDetailList;
    }

    public static boolean isSystemUser(){
        User user=UserHelper.getCurrentLoginUser();
        if(user.isSysUser()){
            return true;
        }
        if(user.getUsername().equals("admin")){
            return true;
        }
        return false;
    }

    public static List<Station> getByUserId(){
        List<Station> stationList=new ArrayList<Station>();
        if(isSystemUser()){
            stationList=Station.listAll(Station.class);
            return stationList;
        }
        User user= UserHelper.getCurrentLoginUser();
        List<UserXPerssion> userXPerssionList=UserXPerssion.getByUserIdFloorIsNull(user.getId());
        for(UserXPerssion userXPerssion:userXPerssionList){
            stationList.add(userXPerssion.getStation());
        }
        return stationList;
    }
    public static Station getStationByUser(){
        User user= UserHelper.getCurrentLoginUser();
        UserXStation userXStation=UserXStation.getByUserId(user.getId());
        Station station=userXStation.getStation();
        return station;
    }

}
