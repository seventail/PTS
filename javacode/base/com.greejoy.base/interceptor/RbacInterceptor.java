package com.greejoy.base.interceptor;

import com.greejoy.floor.domain.Floor;
import com.greejoy.gtip.module.rbac.support.helper.UserHelper;
import com.greejoy.user.domain.UserXPerssion;
import com.greejoy.gtip.component.json.AjaxSupport;
import com.greejoy.gtip.module.rbac.domain.User;
import com.greejoy.station.domain.Station;
import com.greejoy.user.domain.UserXStation;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import org.apache.struts2.ServletActionContext;
import com.opensymphony.xwork2.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-10-16
 * Time: 下午1:17
 * To change this template use File | Settings | File Templates.
 */
public class RbacInterceptor extends AbstractInterceptor{

    public String intercept(ActionInvocation actionInvocation) throws Exception {
        HttpSession session = ServletActionContext.getRequest().getSession();
        User user = (User) session.getAttribute(User.CURRENT_LOGIN_USER);
        UserXStation userXStation=UserXStation.getByUserId(user.getId());
        if(userXStation!=null){
            return actionInvocation.invoke();
        }else {
            return stationFail();
        }
    }

    public static boolean floorIntercept(long floor_id){
        User user = UserHelper.getCurrentLoginUser();
        UserXStation userXStation=UserXStation.getByUserId(user.getId());
        if(user.isSysUser()||user.getUsername().equals("admin")){
            return true;
        }
        if(userXStation==null){
            return false;
        }
        UserXPerssion userXPerssion=UserXPerssion.getByUserIdStationIdFloorId(user.getId(),userXStation.getStation().getId(),floor_id);
        if (userXPerssion==null){
            return false;
        }
        return true;
    }

    public static List<Station> floorIntercept(){
        List<Station> stationList=new ArrayList<Station>();
        HttpSession session = ServletActionContext.getRequest().getSession();
        User user = (User) session.getAttribute(User.CURRENT_LOGIN_USER);
        if(user.isSysUser()||user.getUsername().equals("admin")){
            stationList=Station.listAll(Station.class);
            return stationList;
        }else {
            List<UserXPerssion> userXPerssionList=UserXPerssion.getByUserId(user.getId());
            for(UserXPerssion userXPerssion:userXPerssionList){
                Station stationX=userXPerssion.getStation();
                if(stationList.size()==0){
                    List<Floor> floorList=new ArrayList<Floor>();
                    floorList.add(userXPerssion.getFloor());
                    stationX.setFloorList(floorList);
                    stationList.add(stationX);
                }else{
                    for(Station station:stationList){
                        if(stationX.getId()==station.getId()){
                            station.getFloorList().add(userXPerssion.getFloor());
                        }else {
                            List<Floor> floorList=new ArrayList<Floor>();
                            floorList.add(userXPerssion.getFloor());
                            stationX.setFloorList(floorList);
                            stationList.add(stationX);
                        }
                    }
                }

            }
        }
        return stationList;
    }

    public String stationFail(){
        HttpServletRequest request = ServletActionContext.getRequest();
        if(request.getParameter("ajax") != null) {
            AjaxSupport.sendFailText("没有绑定场站,请先在右上角绑定场站后再进行该操作",null);
            return Action.NONE;
        }
        return "stationFail";
    }

    public static String fail() {
        HttpServletRequest request = ServletActionContext.getRequest();
        if(request.getParameter("ajax") != null) {
            AjaxSupport.sendFailText("权限验证失败,你没有权限进行该操作",null);
            return Action.NONE;
        }
        return "stationFail";
    }
}
