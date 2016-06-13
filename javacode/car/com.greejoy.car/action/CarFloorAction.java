package com.greejoy.car.action;

import com.greejoy.car.dao.lmp.CarDaoImp;
import com.greejoy.car.domain.*;
import com.greejoy.floor.domain.AkeparkFloorNum;
import com.greejoy.floor.domain.Floor;
import com.greejoy.gtip.component.json.AjaxSupport;
import com.greejoy.gtip.module.rbac.domain.User;
import com.greejoy.gtip.module.rbac.support.helper.UserHelper;
import com.greejoy.gtip.web.Action;
import com.greejoy.gtip.web.support.UrlSupport;
import com.greejoy.station.domain.Station;
import com.greejoy.user.domain.UserXPerssion;
import com.greejoy.user.domain.UserXStation;
import org.apache.struts2.ServletActionContext;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-10-26
 * Time: 下午9:46
 * To change this template use File | Settings | File Templates.
 */
@Action
public class CarFloorAction extends UrlSupport{
    private int floor_num;
    public String carFloor(){
        Station station=Station.getStationByUser();
        User user=UserHelper.getCurrentLoginUser();
        List<Detector> detectorList=Floor.getByNum(station.getId(),floor_num).getDetectorList();
        CarDaoImp carDaoImp=new CarDaoImp();
        carDaoImp.setAKEPARKUrl(station);
        int floorNum=AkeparkFloorNum.getByFloorNum(floor_num,station.getId());
        detectorList=carDaoImp.getDetector(detectorList,floorNum);
        CarFloor carFloor=carDaoImp.getScreen(floor_num, floorNum);
        List<Floor> floorList=new ArrayList<Floor>();
        if(user.isSysUser()||user.getUsername().equals("admin")){
            floorList=Floor.getFloorByStation(station.getId());
        }else{
            List<UserXPerssion> userXPerssionList=UserXPerssion.getByUserIdStationId(user.getId(),station.getId());
            for(UserXPerssion userXPerssion:userXPerssionList){
                floorList.add(userXPerssion.getFloor());
            }
        }
        List controllerList=carDaoImp.getControllerAll(floorNum);
        List<CameraIp> cameraIpList=CameraIp.getCameraIpByFloor(floorNum,station.getId());
        carDaoImp.setImgofCarUrl(station );
        List<SearchTime> searchTimeList=SearchTime.listAll(SearchTime.class);
        int num=0;
        if(searchTimeList.size()==0){
            num=15;
        }else {
            num=searchTimeList.get(0).getDay();
        }
        List list=carDaoImp.getCarInfoByIP(cameraIpList,num);
        setContextValue("list",list);
        setContextValue("controllerList",controllerList);
        setContextValue("floorList",floorList);
        setContextValue("detectorList",detectorList);
        setContextValue("carFloor",carFloor);
        return "carFloor";
    }

    public int getFloor_num() {
        return floor_num;
    }

    public void setFloor_num(int floor_num) {
        this.floor_num = floor_num;
    }

}
