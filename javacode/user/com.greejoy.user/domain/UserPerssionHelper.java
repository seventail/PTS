package com.greejoy.user.domain;

import com.greejoy.gtip.module.rbac.domain.User;
import com.greejoy.station.domain.Station;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Mythos_Q
 * Date: 15-11-11
 * Time: 上午10:42
 * To change this template use File | Settings | File Templates.
 */
public class UserPerssionHelper {
    private User user;
    private List<Station> stationList;
    private List<UserXPerssion> userXPerssionList;

    public List<UserXPerssion> getUserXPerssionList() {
        return userXPerssionList;
    }

    public void setUserXPerssionList(List<UserXPerssion> userXPerssionList) {
        this.userXPerssionList = userXPerssionList;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<Station> getStationList() {
        return stationList;
    }

    public void setStationList(List<Station> stationList) {
        this.stationList = stationList;
    }
}
