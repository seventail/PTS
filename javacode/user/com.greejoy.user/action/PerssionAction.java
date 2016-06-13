package com.greejoy.user.action;

import com.greejoy.base.interceptor.RbacInterceptor;
import com.greejoy.floor.domain.Floor;
import com.greejoy.gtip.module.rbac.domain.User;
import com.greejoy.gtip.web.Action;
import com.greejoy.gtip.web.support.UrlSupport;
import com.greejoy.station.domain.Station;
import com.greejoy.user.domain.UserXPerssion;
import com.greejoy.user.domain.UserXStation;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-10-30
 * Time: 上午9:52
 * To change this template use File | Settings | File Templates.
 */
@Action
public class PerssionAction extends UrlSupport{
    private String chk_value;

    public String index(){
        List<Station> stationList= RbacInterceptor.floorIntercept();
        User user=User.get(User.class,idx);
        setContextValue("user",user);
        setContextValue("stationList",stationList);
        return "index";
    }
    public String add(){
        long station_id=0;
        User user= User.get(User.class,idx);
        String[] values=chk_value.split("\\.");//字符串为1.1-1.1-2.1-3.2.2-4.2-5格式，有-的是楼层，前面为场站ID，后面为楼层ID
        UserXStation userXStation=UserXStation.getByUserId(user.getId());
        if(userXStation!=null){
            station_id=userXStation.getStation().getId();
        }
        boolean flag=false;
        UserXPerssion.deleteByUserId(user.getId());
        if(!chk_value.equals("")){
            for(String str:values){
                if(str.contains("-")){
                    String[] value=str.split("-");
                    Station station=Station.get(Station.class,Long.valueOf(value[0]));
                    Floor floor=Floor.get(Floor.class,Long.valueOf(value[1]));
                    UserXPerssion userXPerssion=new UserXPerssion();
                    userXPerssion.setUser_id(user.getId());
                    userXPerssion.setStation(station);
                    userXPerssion.setFloor(floor);
                    userXPerssion.add();
                }else{
                    long str_value=Long.valueOf(str);
                    if(station_id==str_value){
                        flag=true;
                    }
                    Station station=Station.get(Station.class,str_value);
                    UserXPerssion userXPerssion=new UserXPerssion();
                    userXPerssion.setUser_id(user.getId());
                    userXPerssion.setStation(station);
                    userXPerssion.add();
                }
            }
        }
        if((!flag)&&(userXStation!=null)){
            userXStation.delete();
        }
        return "index";
    }

    public String getChk_value() {
        return chk_value;
    }

    public void setChk_value(String chk_value) {
        this.chk_value = chk_value;
    }
}
