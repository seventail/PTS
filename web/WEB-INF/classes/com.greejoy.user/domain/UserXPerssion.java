package com.greejoy.user.domain;

import com.greejoy.floor.domain.Floor;
import com.greejoy.gtip.component.support.Asserts;
import com.greejoy.gtip.module.base.domain.FieldModifyDetail;
import com.greejoy.gtip.persistence.domain.Addable;
import com.greejoy.gtip.persistence.domain.BaseDomain;
import com.greejoy.gtip.persistence.domain.Domain;
import com.greejoy.gtip.persistence.domain.Modifiable;
import com.greejoy.gtip.util.EqualsUtils;
import com.greejoy.station.domain.Station;
import org.omg.CORBA.PUBLIC_MEMBER;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-10-10
 * Time: 上午11:51
 * To change this template use File | Settings | File Templates.
 */

@Entity
@Domain(name = "权限")
@Table(name = "t_userXPerssion")
public class UserXPerssion extends BaseDomain<UserXPerssion> implements Addable,Modifiable<UserXPerssion>{

    private long user_id ;
    private Station station;
    private Floor floor;

    @Basic
    public long getUser_id() {
        return user_id;
    }

    public void setUser_id(long user_id) {
        this.user_id = user_id;
    }

    @JoinColumn(name = "station_id")
    @ManyToOne(fetch = FetchType.LAZY)
    public Station getStation() {
        return station;
    }

    public void setStation(Station station) {
        this.station = station;
    }

    @JoinColumn(name = "floor_id")
    @ManyToOne(fetch = FetchType.LAZY)
    public Floor getFloor() {
        return floor;
    }

    public void setFloor(Floor floor) {
        this.floor = floor;
    }

    public void add() {
        boolean canAdd = canAdd();
        Asserts.assertTrue(canAdd, validateAdd());
        save();
    }

    @Override
    public List<FieldModifyDetail> modifyTo(UserXPerssion other) {
        List<FieldModifyDetail> fieldModifyDetailList = new ArrayList<FieldModifyDetail>();
        if (!EqualsUtils.equalsEntity(getStation(), other.getStation())) {
            fieldModifyDetailList.add(new FieldModifyDetail("station", "场站", getStation() != null ? String.valueOf(getStation().getId()) : null, other.getStation() != null ? String.valueOf(other.getStation()) : null));
            setStation(other.getStation());
        }
        if (!EqualsUtils.equalsEntity(getFloor(), other.getFloor())) {
            fieldModifyDetailList.add(new FieldModifyDetail("floor", "楼层", getFloor() != null ? String.valueOf(getFloor().getId()) : null, other.getFloor() != null ? String.valueOf(other.getFloor()) : null));
            setFloor(other.getFloor());
        }
        return fieldModifyDetailList;
    }

    @Transactional
    public static List<UserXPerssion> getByUserId(long id){
        String hql = "from UserXPerssion where user_id=:user_id and floor is not null";
        return sessionFactory.getCurrentSession().createQuery(hql).setLong("user_id", id).list();
    }

    @Transactional
    public static Object[] getPerssionByUserId(long id){
        String hql = "select floor.id from UserXPerssion where user_id=:user_id and floor is not null";
        return sessionFactory.getCurrentSession().createQuery(hql).setLong("user_id", id).list().toArray(new Object[1]);
    }

    @Transactional
    public static List<UserXPerssion> getByUserIdFloorIsNull(long id){
        String hql = "from UserXPerssion where user_id=:user_id and floor is null";
        return sessionFactory.getCurrentSession().createQuery(hql).setLong("user_id", id).list();
    }

    @Transactional
    public static List<UserXPerssion> getByUserIdStationId(long user_id,long station_id){
        String hql = "from UserXPerssion where user_id=:user_id and station.id=:station_id and floor is not null order by cast(floor.floor_num as integer)";
        return sessionFactory.getCurrentSession().createQuery(hql).setLong("user_id",user_id).setLong("station_id",station_id).list();
    }

    @Transactional
    public static UserXPerssion getByUserIdStationIdFloorId(long user_id,long station_id,long floor_id){
        String hql = "from UserXPerssion where user_id=:user_id and station.id=:station_id and floor.id=:floor_id";
        return (UserXPerssion)sessionFactory.getCurrentSession().createQuery(hql).setLong("user_id", user_id).setLong("station_id",station_id).setLong("floor_id",floor_id).uniqueResult();
    }

    @Transactional
    public static void deleteByUserId(long user_id){
        String sql="delete from t_userXPerssion where user_id=:user_id";
        sessionFactory.getCurrentSession().createSQLQuery(sql).setLong("user_id",user_id).executeUpdate();
    }

}
