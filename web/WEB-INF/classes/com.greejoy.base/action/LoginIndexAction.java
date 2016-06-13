package com.greejoy.base.action;

import com.greejoy.gtip.module.rbac.domain.User;
import com.greejoy.gtip.module.rbac.support.helper.UserHelper;
import com.greejoy.gtip.web.Action;
import com.greejoy.gtip.web.support.UrlSupport;
import com.greejoy.station.domain.Station;
import com.greejoy.user.domain.UserXPerssion;
import com.greejoy.user.domain.UserXStation;
import org.apache.struts2.ServletActionContext;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-11-5
 * Time: 下午3:21
 * To change this template use File | Settings | File Templates.
 */
@Action
public class LoginIndexAction extends UrlSupport{
    public String getTop(){
        String station_name="";
        User user=UserHelper.getCurrentLoginUser();
        UserXStation userXStation=UserXStation.getByUserId(user.getId());
        if(userXStation!=null){
            station_name=userXStation.getStation().getName();
        }else {
            station_name="场站绑定";
        }
        setContextValue("station_name",station_name);
        return "top";
    }
    public String getLeft(){
        boolean flag=false;
        User user=UserHelper.getCurrentLoginUser();
        if(user.isSysUser()||user.getUsername().equals("admin")){
            flag=true;
        }
        setContextValue("flag",flag);
        return "left";
    }
}
