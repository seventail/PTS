package com.greejoy.car.domain;

import com.greejoy.gtip.component.Page;
import com.greejoy.gtip.component.support.Asserts;
import com.greejoy.gtip.module.base.domain.FieldModifyDetail;
import com.greejoy.gtip.persistence.domain.Addable;
import com.greejoy.gtip.persistence.domain.BaseDomain;
import com.greejoy.gtip.persistence.domain.Modifiable;
import com.greejoy.gtip.util.EqualsUtils;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-11-7
 * Time: 下午2:08
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "t_carinfo")
public class CarInfo extends BaseDomain<CarInfo> implements Addable,Modifiable<CarInfo> {
    private String busNo;       //自编号
    private String busPlate;    // 车牌号
    private Date stopDate;     //停车时间
    private int floor_num;     //停车楼层
    private String jsBusType;   //品牌型号
    private String lx;           //车辆类型
    private String coNo;
    private String busCrewno;     //车队编号
    private long bus_id;

    @Basic
    public int getFloor_num() {
        return floor_num;
    }

    public void setFloor_num(int floor_num) {
        this.floor_num = floor_num;
    }

    @Basic
    public String getBusNo() {
        return busNo;
    }

    public void setBusNo(String busNo) {
        this.busNo = busNo;
    }

    @Basic
    public String getBusPlate() {
        return busPlate;
    }

    public void setBusPlate(String busPlate) {
        this.busPlate = busPlate;
    }

    @Basic
    public Date getStopDate() {
        return stopDate;
    }

    public void setStopDate(Date stopDate) {
        this.stopDate = stopDate;
    }

    @Basic
    public String getJsBusType() {
        return jsBusType;
    }

    public void setJsBusType(String jsBusType) {
        this.jsBusType = jsBusType;
    }

    @Basic
    public String getLx() {
        return lx;
    }

    public void setLx(String lx) {
        this.lx = lx;
    }

    @Basic
    public String getCoNo() {
        return coNo;
    }

    public void setCoNo(String coNo) {
        this.coNo = coNo;
    }

    @Basic
    public String getBusCrewno() {
        return busCrewno;
    }

    public void setBusCrewno(String busCrewno) {
        this.busCrewno = busCrewno;
    }

    @Basic
    public long getBus_id() {
        return bus_id;
    }

    public void setBus_id(long bus_id) {
        this.bus_id = bus_id;
    }

    public void add() {
        boolean canAdd = canAdd();
        Asserts.assertTrue(canAdd, validateAdd());
        save();
    }

    @Override
    public List<FieldModifyDetail> modifyTo(CarInfo other) {
        List<FieldModifyDetail> fieldModifyDetailList = new ArrayList<FieldModifyDetail>();
        if (!EqualsUtils.equals(getLx(), other.getLx())) {
            fieldModifyDetailList.add(new FieldModifyDetail("lx", "车辆类型", getLx(),other.getLx()));
            setLx(other.getLx());
        }
        if (!EqualsUtils.equals(getJsBusType(), other.getJsBusType())) {
            fieldModifyDetailList.add(new FieldModifyDetail("jsBusType", "品牌型号", getJsBusType(),other.getJsBusType()));
            setJsBusType(other.getJsBusType());
        }
        if (!EqualsUtils.equals(getBusCrewno(), other.getBusCrewno())) {
            fieldModifyDetailList.add(new FieldModifyDetail("busCrewno", "车队编号", getBusCrewno(),other.getBusCrewno()));
            setBusCrewno(other.getBusCrewno());
        }
        return fieldModifyDetailList;
    }

    public static List<CarInfo> listByPage(Page page, String busNo, long idx) {
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(CarInfo.class);
        Order order = Order.asc("id");
        if (StringUtils.hasText(busNo)) {
            detachedCriteria.add(Restrictions.like("busNo", busNo, MatchMode.ANYWHERE));
        }
        if (idx != 0) {
            detachedCriteria.add(Restrictions.eq("id", idx));
        }
        return listByCriteria(detachedCriteria, page, order);
    }

    /*@Transactional
    public static CarInfo getCarByPlate(String busPlate){
        String hql="from CarInfo where busPlate=:busPlate";
        return (CarInfo)sessionFactory.getCurrentSession().createQuery(hql).setString("busPlate",busPlate).uniqueResult();
    }  */

    @Transactional
    public static String getCarByPlate(String busPlate){
        String hql="select busNo from CarInfo where busPlate=:busPlate";
        List<String> list = sessionFactory.getCurrentSession().createQuery(hql).setString("busPlate",busPlate).list();
        return list.size()>0?list.get(0):null;
    }

    @Transactional
    public static CarInfo geCarByBusNo(String busNo){
        String hql="from CarInfo where busNo=:busNo";
        List<CarInfo> carInfoList=sessionFactory.getCurrentSession().createQuery(hql).setString("busNo",busNo).list();
        return carInfoList.size()>0?carInfoList.get(0):null;
    }

    @Transactional
    public static long getLastCarInfo(){
        String hql="select max(c.bus_id) from CarInfo c";
        return ((Number)sessionFactory.getCurrentSession().createQuery(hql).uniqueResult()).longValue();
    }

    @Transactional
    public static long getCarInfoNum(){
        String hql="select count(*) from CarInfo";
        return ((Number)sessionFactory.getCurrentSession().createQuery(hql).uniqueResult()).longValue();
    }
}
