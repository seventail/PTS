package com.greejoy.car.dao;

import com.greejoy.car.domain.CarFloor;
import com.greejoy.station.domain.Station;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-10-26
 * Time: 下午10:03
 * To change this template use File | Settings | File Templates.
 */
public interface CarDao {
    public List<CarFloor> getScreen(Station station);
}
