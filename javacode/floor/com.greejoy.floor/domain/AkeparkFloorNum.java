package com.greejoy.floor.domain;

import com.greejoy.gtip.persistence.domain.BaseDomain;
import com.greejoy.station.domain.Station;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;

/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-11-3
 * Time: 下午1:51
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "t_akepark_floor_num")
public class AkeparkFloorNum extends BaseDomain<AkeparkFloorNum>{
    private int akeparkFloor;
    private int floorNum;
    private Station station;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "station_id")
    public Station getStation() {
        return station;
    }

    public void setStation(Station station) {
        this.station = station;
    }

    @Basic
    public int getAkeparkFloor() {
        return akeparkFloor;
    }

    public void setAkeparkFloor(int akeparkFloor) {
        this.akeparkFloor = akeparkFloor;
    }

    @Basic
    public int getFloorNum() {
        return floorNum;
    }

    public void setFloorNum(int floorNum) {
        this.floorNum = floorNum;
    }

    @Transactional
    public static int getByFloorNum(int floor_num,long station_id){
        String hql="select akeparkFloor from AkeparkFloorNum where floorNum=:floor_num and station.id=:station_id";
        Object object= sessionFactory.getCurrentSession().createQuery(hql).setInteger("floor_num",floor_num).setLong("station_id",station_id).uniqueResult();
        return object==null?0:((Number)object).intValue();
    }
    @Transactional
    public static AkeparkFloorNum getByAkeparkFloor(int akeparkFloor){
        String hql="from AkeparkFloorNum where akeparkFloor=:akeparkFloor";
        return (AkeparkFloorNum)sessionFactory.getCurrentSession().createQuery(hql).setInteger("akeparkFloor",akeparkFloor).uniqueResult();
    }
}
