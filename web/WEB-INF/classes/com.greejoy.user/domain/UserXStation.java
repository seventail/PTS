package com.greejoy.user.domain;

import com.greejoy.gtip.component.support.Asserts;
import com.greejoy.gtip.module.base.domain.FieldModifyDetail;
import com.greejoy.gtip.module.rbac.domain.User;
import com.greejoy.gtip.persistence.domain.Addable;
import com.greejoy.gtip.persistence.domain.BaseDomain;
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
 * Date: 15-11-5
 * Time: 下午2:21
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "t_user_station")
public class UserXStation extends BaseDomain<UserXStation> implements Addable,Modifiable<UserXStation> {
    private long user_id;
    private Station station;

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

     public void add() {
        boolean canAdd = canAdd();
        Asserts.assertTrue(canAdd, validateAdd());
        save();
    }

    @Override
    public List<FieldModifyDetail> modifyTo(UserXStation other) {
        List<FieldModifyDetail> fieldModifyDetailList = new ArrayList<FieldModifyDetail>();
        if (!EqualsUtils.equalsEntity(getStation(), other.getStation())) {
            fieldModifyDetailList.add(new FieldModifyDetail("station", "场站", getStation() != null ? String.valueOf(getStation().getId()) : null, other.getStation() != null ? String.valueOf(other.getStation()) : null));
            setStation(other.getStation());
        }
        return fieldModifyDetailList;
    }

    @Transactional
    public static UserXStation getByUserId(long user_id){
        String hql="from UserXStation where user_id=:user_id";
        return (UserXStation)sessionFactory.getCurrentSession().createQuery(hql).setLong("user_id",user_id).uniqueResult();
    }

    @Transactional
    public static void deleteByUserId(long user_id){
        String sql="delete from t_user_station where user_id=:user_id";
        sessionFactory.getCurrentSession().createSQLQuery(sql).setLong("user_id",user_id).executeUpdate();
    }

    @Transactional
    public static boolean getByUserIdAndStationId(long user_id,long stationId){
        String hql="from UserXStation where user_id=:user_id and station.id = :stationId";
        List list = sessionFactory.getCurrentSession().createQuery(hql).setLong("user_id",user_id).setLong("stationId",stationId).list();
        return list.size()>0?true:false;
    }
}
