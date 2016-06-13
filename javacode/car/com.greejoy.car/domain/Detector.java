package com.greejoy.car.domain;

import com.greejoy.floor.domain.Floor;
import com.greejoy.gtip.component.support.Asserts;
import com.greejoy.gtip.module.base.domain.FieldModifyDetail;
import com.greejoy.gtip.persistence.domain.Addable;
import com.greejoy.gtip.persistence.domain.BaseDomain;
import com.greejoy.gtip.persistence.domain.Domain;
import com.greejoy.gtip.persistence.domain.Modifiable;
import com.greejoy.gtip.util.EqualsUtils;
import com.greejoy.station.domain.Station;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-10-27
 * Time: 上午10:02
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Domain(name = "探头")
@Table(name = "t_detector")
public class Detector extends BaseDomain<Detector> implements Addable,Modifiable<Detector>{
    private String itemNo;     //探头编号
    private boolean occupied; //占用状态
    private Floor floor;       //楼层
    private String place;        //探头所在图上位置，从左往右，从上到下

    @Basic
    public String getItemNo() {
        return itemNo;
    }

    public void setItemNo(String itemNo) {
        this.itemNo = itemNo;
    }

    @Basic
    public boolean isOccupied() {
        return occupied;
    }

    public void setOccupied(boolean occupied) {
        this.occupied = occupied;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "floor_id")
    public Floor getFloor() {
        return floor;
    }

    public void setFloor(Floor floor) {
        this.floor = floor;
    }

    @Basic
    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }

    public void add() {
        boolean canAdd = canAdd();
        Asserts.assertTrue(canAdd, validateAdd());
        save();
    }

    @Override
    public List<FieldModifyDetail> modifyTo(Detector other) {
        List<FieldModifyDetail> fieldModifyDetailList = new ArrayList<FieldModifyDetail>();
        if (!EqualsUtils.equals(getItemNo(), other.getItemNo())) {
            fieldModifyDetailList.add(new FieldModifyDetail("itemNo", "探头编号", getItemNo(),other.getItemNo()));
            setItemNo(other.getItemNo());
        }
        return fieldModifyDetailList;
    }

    @Transactional
    public static List<Detector> getByFloor(long floor_id,long station_id){
        String hql="from Detector where floor_id=:floor_id and station_id=:station_id";
        return sessionFactory.getCurrentSession().createQuery(hql).setLong("floor_id", floor_id).setLong("station_id",station_id).list();
    }

    @Transactional
    public static Detector getByPlace(long floor_id,String place){
        String hql="from Detector where floor_id=:floor_id and place=:place";
        return (Detector)sessionFactory.getCurrentSession().createQuery(hql).setLong("floor_id", floor_id).setString("place",place).uniqueResult();
    }
}
