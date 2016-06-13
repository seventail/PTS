package com.greejoy.chart.action;

import com.greejoy.base.data.StaticResource;
import com.greejoy.car.dao.lmp.CarDaoImp;
import com.greejoy.car.domain.CameraIp;
import com.greejoy.car.domain.CarFloor;
import com.greejoy.chart.util.ChartUtil;
import com.greejoy.floor.domain.AkeparkFloorNum;
import com.greejoy.floor.domain.Floor;
import com.greejoy.gtip.module.rbac.domain.User;
import com.greejoy.gtip.module.rbac.support.helper.UserHelper;
import com.greejoy.gtip.web.Action;
import com.greejoy.gtip.web.support.UrlSupport;
import com.greejoy.station.domain.Station;
import com.greejoy.user.domain.UserXPerssion;
import org.apache.struts2.ServletActionContext;
import org.jfree.chart.ChartUtilities;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-10-26
 * Time: 下午9:26
 * To change this template use File | Settings | File Templates.
 */
@Action
public class ChartAction extends UrlSupport{
    private String startTime;
    private String endTime;
    private int month;
    private int year;
    private int floor_num;
    private String imgName;

    public String chart(){
        CarDaoImp carDaoImp=new CarDaoImp();
        User user= UserHelper.getCurrentLoginUser();
        List<CarFloor> carFloorList=new ArrayList<CarFloor>();
        List<Integer> floorList=new ArrayList<Integer>();
        Station station=Station.getStationByUser();
        carDaoImp.setAKEPARKUrl(station);
        if(!carDaoImp.textConnection()){
            return "connectionError";
        }
        List<UserXPerssion> userXPerssionList=UserXPerssion.getByUserIdStationId(user.getId(),station.getId());
        for(UserXPerssion userXPerssion:userXPerssionList){
            int floor_num=userXPerssion.getFloor().getFloor_num();
            floorList.add(floor_num);
            int floorNum=AkeparkFloorNum.getByFloorNum(floor_num,station.getId());
            CarFloor carFloor=carDaoImp.getScreen(floor_num, floorNum);
            carFloorList.add(carFloor);
        }
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
        imgName=sdf.format(new Date());
        ChartUtil chartUtil=new ChartUtil();
        chartUtil.deleteFile();
        File file=new File(ServletActionContext.getServletContext().getRealPath("/") + "images/company/"+imgName+".png");
        OutputStream os = null;
        try{
            os = new FileOutputStream(file);
            ChartUtilities.writeChartAsPNG(os, chartUtil.getChartImg(carFloorList), 839, 378);
        }catch (IOException e){
            e.printStackTrace();
        }finally {
            if(os!=null){
                try{
                    os.close();
                }catch (IOException e){

                }
            }
        }
        Calendar calendar=Calendar.getInstance();
        int nowYear=calendar.get(Calendar.YEAR);
        List yearList=new ArrayList();
        for(int i=nowYear;i>=nowYear-10;i--){
            yearList.add(i);
        }
        setContextValue("yearList",yearList);
        setContextValue("floorList",floorList);
        return "chart";
    }

    public String statistical(){
        Calendar calendar=Calendar.getInstance();
        int flag=0;
        if(year==0){
            year= calendar.get(Calendar.YEAR);
        }
        if(month!=0){
            flag=1;
        }
        User user= UserHelper.getCurrentLoginUser();
        Station station=Station.getStationByUser();
        List<Integer> floorList=new ArrayList<Integer>();
        long user_id=user.getId();
        long station_id=station.getId();
        int floorNum=AkeparkFloorNum.getByFloorNum(floor_num,station_id);
        List<UserXPerssion> userXPerssionList=UserXPerssion.getByUserIdStationId(user_id,station.getId());
        for(UserXPerssion userXPerssion:userXPerssionList){
            int num=userXPerssion.getFloor().getFloor_num();
            floorList.add(num);
        }
        CarDaoImp carDaoImp=new CarDaoImp();
        carDaoImp.setMonitorUrl(station);
        Map<String,Integer> numList=new TreeMap<String,Integer>();
        numList=carDaoImp.getCarInfoByDetector(year,month,floorNum);
        imgName=new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss").format(new Date());
        ChartUtil chartUtil=new ChartUtil();
        chartUtil.deleteFile();
        File file=new File(ServletActionContext.getServletContext().getRealPath("/") + "images/company/"+imgName+".png");
        OutputStream os = null;
        try{
            os = new FileOutputStream(file);
            ChartUtilities.writeChartAsPNG(os, chartUtil.getChartDate(numList,flag), 839, 378);
        }catch (IOException e){
            e.printStackTrace();
        }finally {
            if(os!=null){
                try{
                    os.close();
                }catch (IOException e){

                }
            }
        }
        int nowYear=calendar.get(Calendar.YEAR);
        List yearList=new ArrayList();
        for(int i=nowYear;i>=nowYear-10;i--){
            yearList.add(i);
        }
        setContextValue("yearList",yearList);
        setContextValue("floorList",floorList);
        return "statistical";
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public String getImgName() {
        return imgName;
    }

    public void setImgName(String imgName) {
        this.imgName = imgName;
    }

    public int getFloor_num() {
        return floor_num;
    }

    public void setFloor_num(int floor_num) {
        this.floor_num = floor_num;
    }
}
