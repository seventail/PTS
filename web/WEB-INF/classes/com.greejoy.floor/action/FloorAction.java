package com.greejoy.floor.action;

import com.greejoy.base.action.BusAction;
import com.greejoy.base.interceptor.RbacInterceptor;
import com.greejoy.car.domain.Detector;
import com.greejoy.floor.domain.Floor;
import com.greejoy.gtip.component.json.AjaxSupport;
import com.greejoy.gtip.module.rbac.domain.User;
import com.greejoy.gtip.module.rbac.support.helper.UserHelper;
import com.greejoy.gtip.web.Action;
import com.greejoy.gtip.web.support.UrlSupport;
import com.greejoy.station.action.BindingStationAction;
import com.greejoy.station.domain.Station;
import com.greejoy.user.domain.UserXPerssion;
import com.greejoy.user.domain.UserXStation;
import org.apache.struts2.ServletActionContext;

import java.io.File;
import java.util.ArrayList;
import java.util.List;


/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-10-9
 * Time: 下午12:09
 * To change this template use File | Settings | File Templates.
 */
@Action
public class FloorAction extends UrlSupport{
    private File file;
    private Floor floor;
    private long station_id;
    private int floor_num;
    private int parking_lot;
    private String chk_value;

    public String index(){
        createPage();
        User user=UserHelper.getCurrentLoginUser();
        Object[] floor_ids=new Object[0];
        if(!Station.isSystemUser()){
            floor_ids=UserXPerssion.getPerssionByUserId(user.getId());
        }
        List<Floor> floorList=Floor.listByPage(page,station_id,floor_ids);
        List<Station> stationList=Station.getByUserId();
        setContextValue("floorList",floorList);
        setContextValue("stationList",stationList);
        return "index";
    }

    public String add(){
        floor=new Floor();
        Station station=Station.get(Station.class,station_id);
        List<Floor> floorList=Floor.listByFloorNum(station_id);
        User user=UserHelper.getCurrentLoginUser();
        for(Floor f:floorList){
            if(f.getFloor_num()==floor_num){
                AjaxSupport.sendFailText("该楼层已经存在！请添加其他楼层。",null);
                return NONE;
            }
        }
        floor.setFloor_num(floor_num);
        floor.setParking_lot(parking_lot);
        floor.setStation(station);
        UserXPerssion userXPerssion=new UserXPerssion();
        userXPerssion.setUser_id(user.getId());
        userXPerssion.setStation(station);
        userXPerssion.setFloor(floor);
        floor.add();
        userXPerssion.add();
        for(int i=1;i<=parking_lot;i++){
            Detector detector=new Detector();
            detector.setFloor(floor);
            detector.setPlace("lou"+floor_num+"-"+i);
            detector.setOccupied(false);
            detector.add();
        }
        return "addTr";
    }

    public String beforeUpdate(){
        floor=Floor.get(Floor.class,idx);
        return "beforeUpdate";
    }

    public String update(){
        if(!RbacInterceptor.floorIntercept(idx)){
            return RbacInterceptor.fail();
        }
        Floor floorE=Floor.get(Floor.class,idx);
        floor=new Floor();
        floor.setParking_lot(parking_lot);
        List<Detector> detectorList=floorE.getDetectorList();
        for(Detector detector:detectorList){
            detector.delete();
        }
        String infor = floorE.update(floor);
        String result = getText("station.update.success");
        saveOperationLog("station.update", result, infor);
        floor=Floor.get(Floor.class,idx);
        return "updateTr";
    }

    public String delete(){
        String[] values=chk_value.split("\\.");
        if(values.length>0){
            for(String value:values){
                if(!RbacInterceptor.floorIntercept(Long.valueOf(value))){
                    return RbacInterceptor.fail();
                }
                floor=Floor.get(Floor.class,Long.valueOf(value));
                floor.delete();
            }
        }
        AjaxSupport.sendSuccessText(null,"success");
        return AJAX_RESULT;
    }
    public Floor getFloor() {

        return floor;
    }

    public void setFloor(Floor floor) {
        this.floor = floor;
    }

    public File getFile() {
        return file;
    }

    public void setFile(File file) {
        this.file = file;
    }

    public long getStation_id() {
        return station_id;
    }

    public void setStation_id(long station_id) {
        this.station_id = station_id;
    }

    public int getFloor_num() {
        return floor_num;
    }

    public void setFloor_num(int floor_num) {
        this.floor_num = floor_num;
    }

    public int getParking_lot() {
        return parking_lot;
    }

    public void setParking_lot(int parking_lot) {
        this.parking_lot = parking_lot;
    }

    public String getChk_value() {
        return chk_value;
    }

    public void setChk_value(String chk_value) {
        this.chk_value = chk_value;
    }
}
