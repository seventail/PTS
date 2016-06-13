package com.greejoy.floor.domain;

import com.greejoy.car.domain.Detector;
import com.greejoy.gtip.component.Page;
import com.greejoy.gtip.component.support.Asserts;
import com.greejoy.gtip.module.base.domain.FieldModifyDetail;
import com.greejoy.gtip.persistence.domain.Addable;
import com.greejoy.gtip.persistence.domain.BaseDomain;
import com.greejoy.gtip.persistence.domain.Domain;
import com.greejoy.gtip.persistence.domain.Modifiable;
import com.greejoy.gtip.util.EqualsUtils;
import com.greejoy.station.domain.Station;
import com.greejoy.user.domain.UserXPerssion;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-10-9
 * Time: 上午11:55
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Domain(name = "楼层")
@Table(name = "t_floor")
public class Floor extends BaseDomain<Floor> implements Addable,Modifiable<Floor>{

    private Station station;        //所属场站
    private int floor_num;         //楼层
    private int parking_lot;      //楼层的停车位数
    private byte [] floor_plan;   // 楼层的平面图
    private List<Detector> detectorList;
    private List<UserXPerssion> userXPerssion;

    @OneToMany(mappedBy = "floor" ,cascade = CascadeType.REMOVE)
    @LazyCollection(LazyCollectionOption.EXTRA)
    public List<Detector> getDetectorList() {
        return detectorList;
    }

    public void setDetectorList(List<Detector> detectorList) {
        this.detectorList = detectorList;
    }

    @OneToMany(mappedBy = "floor" ,cascade = CascadeType.REMOVE)
    @LazyCollection(LazyCollectionOption.EXTRA)
    public List<UserXPerssion> getUserXPerssion() {
        return userXPerssion;
    }

    public void setUserXPerssion(List<UserXPerssion> userXPerssion) {
        this.userXPerssion = userXPerssion;
    }

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
    public int getParking_lot() {
        return parking_lot;
    }

    public void setParking_lot(int parking_lot) {
        this.parking_lot = parking_lot;
    }

    @Lob
    @Column(name = "floor_plan",length = 1000000)
    public byte[] getFloor_plan() {
        return floor_plan;
    }

    public void setFloor_plan(byte[] floor_plan) {
        this.floor_plan = floor_plan;
    }

    public static List<Floor> listByPage(Page page, long station_id,Object[] floor_ids) {
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Floor.class);
        Order order = Order.asc("id");
        if (station_id != 0) {
            detachedCriteria.add(Restrictions.eq("station.id", station_id));
        }
        if(floor_ids.length>0){
            detachedCriteria.add(Restrictions.in("id",floor_ids));
        }
        return listByCriteria(detachedCriteria, page, order);
    }

    public void add() {
        boolean canAdd = canAdd();
        Asserts.assertTrue(canAdd, validateAdd());
        save();
    }

    @Override
    public List<FieldModifyDetail> modifyTo(Floor other) {
        List<FieldModifyDetail> fieldModifyDetailList = new ArrayList<FieldModifyDetail>();
        if (!EqualsUtils.equals(getParking_lot(), other.getParking_lot())) {
            fieldModifyDetailList.add(new FieldModifyDetail("parking_lot", "楼层", String.valueOf(getParking_lot()),String.valueOf(other.getParking_lot())));
            setParking_lot(other.getParking_lot());
        }
        if (!EqualsUtils.equals(getFloor_plan(), other.getFloor_plan())) {
            fieldModifyDetailList.add(new FieldModifyDetail("floor_plan", "停车位数", String.valueOf(getFloor_num()),String.valueOf(other.getFloor_num())));
            setFloor_plan(other.getFloor_plan());
        }

        return fieldModifyDetailList;
    }

    @Transactional
    public static List<Floor> listByFloorNum(long station_id){
        String hql = "from Floor where station=:station_id";
         return sessionFactory.getCurrentSession().createQuery(hql).setLong("station_id", station_id).list();
    }

    @Transactional
    public static Floor getByNum(long station_id,int floor_num){
        String hql="from Floor where floor_num=:floor_num and station.id=:station_id";
        return (Floor)sessionFactory.getCurrentSession().createQuery(hql).setLong("station_id",station_id).setInteger("floor_num",floor_num).uniqueResult();
    }

    @Transactional
    public static List<Floor> getFloorByStation(long station_id){
        String hql="from Floor where station.id=:station_id order by cast(floor_num as integer) ";
        return sessionFactory.getCurrentSession().createQuery(hql).setLong("station_id",station_id).list();
    }

}
