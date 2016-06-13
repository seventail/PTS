package com.greejoy.car.action;

import com.greejoy.car.dao.lmp.CarDaoImp;
import com.greejoy.car.domain.CameraIp;
import com.greejoy.car.domain.CarInfo;
import com.greejoy.car.domain.CarStopInfo;
import com.greejoy.car.domain.SearchTime;
import com.greejoy.floor.domain.AkeparkFloorNum;
import com.greejoy.floor.domain.Floor;
import com.greejoy.gtip.component.json.AjaxSupport;
import com.greejoy.gtip.module.rbac.domain.User;
import com.greejoy.gtip.module.rbac.support.helper.UserHelper;
import com.greejoy.gtip.web.Action;
import com.greejoy.gtip.web.support.UrlSupport;
import com.greejoy.station.domain.Station;
import com.greejoy.user.domain.UserXPerssion;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-10-26
 * Time: 下午9:31
 * To change this template use File | Settings | File Templates.
 */
@Action
public class CarSearchAction extends UrlSupport{
    private int floorNum;
    private String busPlate;
    private String busNo;
    private String stopDate;
    private int carListSize;

    public String carSearch(){
        int day;
        createPage();
        page.setPageSize(24);
        Station station=Station.getStationByUser();
        User user= UserHelper.getCurrentLoginUser();
        List<CarInfo> carInfoList=new ArrayList<CarInfo>();
        CarDaoImp carDaoImp=new CarDaoImp();
        carDaoImp.setImgofCarUrl(station );
        List<SearchTime> searchTimeList=SearchTime.listAll(SearchTime.class);
        if(searchTimeList.size()==0){
            day=15;
        }else {
            day=searchTimeList.get(0).getDay();
        }
        if(!carDaoImp.textConnection()){
            return "connectionError";
        }
        List<UserXPerssion> userXPerssionList=UserXPerssion.getByUserIdStationId(user.getId(),station.getId());
        List<Floor> floorList=new ArrayList<Floor>();
        for(UserXPerssion userXPerssion:userXPerssionList){
            floorList.add(userXPerssion.getFloor());
        }
        if(floorNum==0){
            floorNum=1;
        }
        int num=AkeparkFloorNum.getByFloorNum(floorNum,station.getId());
        if(num!=0){
            List<CameraIp> cameraIpList=CameraIp.getCameraIpByFloor(num,station.getId());
            carInfoList=carDaoImp.getCarInfo(cameraIpList,floorNum,page,day);
        }
        carListSize=carInfoList.size();
        setContextValue("carInfoList",carInfoList);
        setContextValue("floorList", floorList);
        return "carSearch";
    }

    public String beforeSearch(){
        if((!busNo.equals(""))&(!busPlate.equals(""))){
            String str=CarInfo.getCarByPlate(busPlate);
            if(!busNo.equals(str)){
                AjaxSupport.sendSuccessText(null,"ERROR");
            }
        }
        AjaxSupport.sendSuccessText(null,"success");
        return AJAX_RESULT;
    }

    public  String search(){
        Station station=Station.getStationByUser();
        CarDaoImp carDaoImp=new CarDaoImp();
        carDaoImp.setMonitorUrl(station);
        Date date=new Date();
        if(!stopDate.equals("")){
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
            try{
                date=sdf.parse(stopDate);
                stopDate=sdf.format(date);
            }catch (Exception e){
                e.printStackTrace();
                return NONE;
            }
        }
        if(busPlate.equals("")&&(!busNo.equals(""))){
            CarInfo carInfo=CarInfo.geCarByBusNo(busNo);
            if(carInfo!=null){
                busPlate=CarInfo.geCarByBusNo(busNo).getBusPlate();
            }
        }
        List<CameraIp> cameraIpList=CameraIp.getCameraIpByPassagewayIsNot();
        List<CarInfo> carInfoList=carDaoImp.getByBusnoBusplateDate(busPlate,date,cameraIpList);
        setContextValue("carInfoList",carInfoList);
        return "carSearch";
    }

    public String carStopTen(){
        int flag=2;
        Station station=Station.getStationByUser();
        CarDaoImp carDaoImp=new CarDaoImp();
        carDaoImp.setMonitorUrl(station);
        List<CarStopInfo> carStopInfoList=new ArrayList<CarStopInfo>();
        List<CarStopInfo> carStopList=new ArrayList<CarStopInfo>();
        try{
            carStopList=carDaoImp.getStopInfo(busPlate);
        }catch (Exception e){
            AjaxSupport.sendFailText("获取失败！",null);
            return AJAX_RESULT;
        }
        for(int i=0;i<carStopList.size();i++){
            CarStopInfo carStopInfo=carStopList.get(i);
            if(carStopInfo.isPassageway()){
                if(flag!=2){
                    if(flag==0){
                        CarStopInfo lastCar= carStopInfoList.get(carStopInfoList.size()-1);
                        lastCar.setStartDate(carStopInfo.getTimeID());
                        lastCar.setFloor_num(carStopInfo.getFloor_num());
                        long diff = lastCar.getOutDate().getTime() - lastCar.getStartDate().getTime();
                        long days = diff / (1000 * 60 * 60 );
                        lastCar.setStopTime((int)days);
                    }
                }else {
                    carStopInfo.setStartDate(carStopInfo.getTimeID());
                    carStopInfoList.add(carStopInfo);
                }
                flag=1;
            }else {
                if(flag!=2){
                    if(flag==1){
                        carStopInfo.setOutDate(carStopInfo.getTimeID());
                        carStopInfoList.add(carStopInfo);
                    }
                }else{
                    carStopInfo.setOutDate(carStopInfo.getTimeID());
                    carStopInfoList.add(carStopInfo);
                }
                flag=0;
            }
            if(carStopInfoList.size()==10)
                break;
        }
        setContextValue("carStopInfoList",carStopInfoList);
        return "carTop10";
    }

    public String getBusNo() {
        return busNo;
    }

    public void setBusNo(String busNo) {
        this.busNo = busNo;
    }

    public int getFloorNum() {
        return floorNum;
    }

    public void setFloorNum(int floorNum) {
        this.floorNum = floorNum;
    }

    public String getBusPlate() {
        return busPlate;
    }

    public void setBusPlate(String busPlate) {
        this.busPlate = busPlate;
    }

    public String getStopDate() {
        return stopDate;
    }

    public void setStopDate(String stopDate) {
        this.stopDate = stopDate;
    }

    public int getCarListSize() {
        return carListSize;
    }

    public void setCarListSize(int carListSize) {
        this.carListSize = carListSize;
    }
}
