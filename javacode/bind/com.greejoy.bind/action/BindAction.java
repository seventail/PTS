package com.greejoy.bind.action;

import com.greejoy.gtip.web.support.BaseAction;
import com.greejoy.station.domain.Station;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-10-15
 * Time: 下午1:15
 * To change this template use File | Settings | File Templates.
 */
public class BindAction extends BaseAction{

    public String bindStation(){
        List<Station> stationList=Station.listAll(Station.class);
        setContextValue("stationList",stationList);
        return "beforeBinding";
    }
}
