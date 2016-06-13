package com.greejoy.station.action;

import com.greejoy.gtip.component.json.AjaxSupport;
import com.greejoy.gtip.module.rbac.domain.User;
import com.greejoy.gtip.module.rbac.support.helper.UserHelper;
import com.greejoy.gtip.web.Action;
import com.greejoy.gtip.web.support.UrlSupport;
import com.greejoy.station.domain.Station;
import com.greejoy.user.domain.UserXStation;
import org.apache.struts2.ServletActionContext;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-10-26
 * Time: 下午1:24
 * To change this template use File | Settings | File Templates.
 */
@Action
public class BindingStationAction extends UrlSupport{

    public String beforeBinding(){
        Station station=new Station();
        List<Station> stationList=Station.getByUserId();
        User user= UserHelper.getCurrentLoginUser();
        UserXStation userXStation=UserXStation.getByUserId(user.getId());
        if(userXStation!=null){
            station=userXStation.getStation();
        }
        setContextValue("station",station);
        setContextValue("stationList",stationList);
        return "beforeBinding";
    }

    public String bindingStation(){
        Station station=Station.get(Station.class,idx);
        User user= UserHelper.getCurrentLoginUser();
        UserXStation userXStationE=UserXStation.getByUserId(user.getId());
        UserXStation userXStation=new UserXStation();
        userXStation.setUser_id(user.getId());
        userXStation.setStation(station);
        if(userXStationE==null){
            userXStation.add();
        }else {
            userXStationE.update(userXStation);
        }
        AjaxSupport.sendSuccessText(null,"success");
        return AJAX_RESULT;
    }
}
