package com.greejoy.car.action;

import com.greejoy.car.dao.lmp.CarDaoImp;
import com.greejoy.car.domain.CarFloor;
import com.greejoy.gtip.web.Action;
import com.greejoy.gtip.web.support.UrlSupport;
import com.greejoy.station.domain.Station;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-10-26
 * Time: 下午9:30
 * To change this template use File | Settings | File Templates.
 */
@Action
public class CarAllAction extends UrlSupport{
    public String carAll(){
        Station station=Station.getStationByUser();
        CarDaoImp carDaoImp=new CarDaoImp();
        carDaoImp.setAKEPARKUrl(station);
        if(!carDaoImp.textConnection()){
            return "connectionError";
        }
        List<CarFloor> carFloorList=carDaoImp.getScreen(station);
        setContextValue("carFloorList",carFloorList);
        return "carAll";
    }
}
