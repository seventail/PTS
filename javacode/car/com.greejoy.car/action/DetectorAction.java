package com.greejoy.car.action;

import com.greejoy.car.dao.lmp.CarDaoImp;
import com.greejoy.car.domain.Detector;
import com.greejoy.floor.domain.AkeparkFloorNum;
import com.greejoy.floor.domain.Floor;
import com.greejoy.gtip.component.json.AjaxSupport;
import com.greejoy.gtip.module.rbac.domain.User;
import com.greejoy.gtip.module.rbac.support.helper.UserHelper;
import com.greejoy.gtip.web.Action;
import com.greejoy.gtip.web.support.UrlSupport;
import com.greejoy.station.domain.Station;
import com.greejoy.user.domain.UserXStation;
import org.apache.struts2.ServletActionContext;
import org.omg.CORBA.PUBLIC_MEMBER;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-10-27
 * Time: 上午10:11
 * To change this template use File | Settings | File Templates.
 */
@Action
public class DetectorAction extends UrlSupport{
    private String place;
    private String itemNo;
    private int floor_num;
    private String zone;

    public String getItemByZone(){
        Station station=Station.getStationByUser();
        CarDaoImp carDaoImp=new CarDaoImp();
        carDaoImp.setAKEPARKUrl(station);
        int floorNum=AkeparkFloorNum.getByFloorNum(floor_num,station.getId());
        List addressList=carDaoImp.getAddressByZone(floorNum, zone);
        AjaxSupport.sendSuccessText(null,addressList,"id","name","specialNum");
        return AJAX_RESULT;
    }

    public String getZoneByPlace(){
        Station station=Station.getStationByUser();
        CarDaoImp carDaoImp=new CarDaoImp();
        carDaoImp.setAKEPARKUrl(station);
        String place_sub=place.substring(3,place.length());
        String[] str=place_sub.split("-");
        int floor_num=Integer.valueOf(str[0]);
        Floor floor=Floor.getByNum(station.getId(),floor_num);
        String itemNo=Detector.getByPlace(floor.getId(),place).getItemNo();
        String zone=carDaoImp.getZoneByItem(itemNo);
        AjaxSupport.sendSuccessText(null,zone);
        return AJAX_RESULT;
    }

    public String add(){
        Station station=Station.getStationByUser();
        String place_sub=place.substring(3,place.length());
        String[] str=place_sub.split("-");
        int floor_num=Integer.valueOf(str[0]);
        Floor floor=Floor.getByNum(station.getId(),floor_num);
        Detector detector=Detector.getByPlace(floor.getId(),place);
        detector.setItemNo(itemNo);
        detector.update();
        CarDaoImp carDaoImp=new CarDaoImp();
        carDaoImp.setAKEPARKUrl(station);
        if(carDaoImp.getOccupiedByItemNo(itemNo)){
            AjaxSupport.sendSuccessText(null,"true");
        }else {
            AjaxSupport.sendSuccessText(null,"false");
        }
        return AJAX_RESULT;
    }
    public String beforeUpdate(){
        return "beforeUpdate";
    }
    public String update(){
        return NONE;
    }
    public String delete(){
        return NONE;
    }

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }

    public String getItemNo() {
        return itemNo;
    }

    public void setItemNo(String itemNo) {
        this.itemNo = itemNo;
    }

    public int getFloor_num() {
        return floor_num;
    }

    public void setFloor_num(int floor_num) {
        this.floor_num = floor_num;
    }

    public String getZone() {
        return zone;
    }

    public void setZone(String zone) {
        this.zone = zone;
    }
}
