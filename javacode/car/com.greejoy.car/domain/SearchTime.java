package com.greejoy.car.domain;

import com.greejoy.gtip.component.support.Asserts;
import com.greejoy.gtip.module.base.domain.FieldModifyDetail;
import com.greejoy.gtip.persistence.domain.Addable;
import com.greejoy.gtip.persistence.domain.BaseDomain;
import com.greejoy.gtip.persistence.domain.Domain;
import com.greejoy.gtip.persistence.domain.Modifiable;

import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by CZJiang on 2015/12/28.
 */
@Entity
@Domain(name = "车辆查询时间")
@Table(name = "t_search_time")
public class SearchTime extends BaseDomain<SearchTime> implements Addable,Modifiable<SearchTime> {

    private int day;

    public int getDay() {
        return day;
    }

    public void setDay(int day) {
        this.day = day;
    }

    public void add() {
        boolean canAdd = canAdd();
        Asserts.assertTrue(canAdd, validateAdd());
        save();
    }

    public List<FieldModifyDetail> modifyTo(SearchTime other) {
        List<FieldModifyDetail> fieldModifyDetailList=new ArrayList<FieldModifyDetail>();
        return fieldModifyDetailList;
    }

}
