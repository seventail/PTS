package com.greejoy.base.data;

import com.greejoy.car.domain.CameraIp;
import com.greejoy.user.domain.UserXPerssion;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by CZJiang on 2016/2/26.
 */
public class StaticResource {
    public static List<UserXPerssion> perssionList=new ArrayList<UserXPerssion>();
    public static Map<String,Integer> akeparkMap=new HashMap<String, Integer>();
    public static List<CameraIp> cameraList=new ArrayList<CameraIp>();
}
