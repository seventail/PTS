package com.greejoy.user.action;

import com.greejoy.base.interceptor.RbacInterceptor;
import com.greejoy.floor.domain.Floor;
import com.greejoy.gtip.component.json.AjaxSupport;
import com.greejoy.gtip.component.support.Asserts;
import com.greejoy.gtip.module.rbac.domain.User;
import com.greejoy.gtip.module.rbac.support.helper.UserHelper;
import com.greejoy.gtip.tag.components.AjaxResult;
import com.greejoy.gtip.web.Action;
import com.greejoy.gtip.web.support.UrlSupport;
import com.greejoy.station.domain.Station;
import com.greejoy.user.domain.UserPerssionHelper;
import com.greejoy.user.domain.UserXPerssion;
import com.greejoy.user.domain.UserXStation;
import org.apache.commons.codec.digest.DigestUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-10-28
 * Time: 下午3:49
 * To change this template use File | Settings | File Templates.
 */
@Action
public class UsersAction extends UrlSupport{
    private String chk_value;
    private String oldPassword;
    private String newPassword;
    public String index(){
        createPage();
        User currentUser = UserHelper.getCurrentLoginUser();
        List<User> userList=User.listByParentAndPage(currentUser, page);
        setContextValue("userList",userList);
        return "index";
    }

    public String delete(){
        User currentUser=UserHelper.getCurrentLoginUser();
        String[] values=chk_value.split("\\.");
        if(values.length>0){
            for(String value:values){
                User user = User.get(User.class,Long.valueOf(value.trim()));
                long user_id=Long.valueOf(value.trim());
                UserXStation.deleteByUserId(user_id);
                UserXPerssion.deleteByUserId(user_id);
                Asserts.assertTrue(user != null, getText("user.nonexist"));
                assert user != null;
                currentUser.isParentValidate(user);
                user.delete();
                String result = "[id->" + user.getId() + ",username->" + user.getUsername() + ",name->" + user.getName() + "]";
                String infor = getText("user.delete.success", new String[] {user.getUsername()});
                //日志
                saveOperationLog("user.delete", infor, result);
                setMessage(infor);
            }
        }
        AjaxSupport.sendSuccessText(null,"success");
        return AJAX_RESULT;
    }

    /**
     * 修改密码
     */
    public String beforeUpdatePasswd(){
        User user=UserHelper.getCurrentLoginUser();
        setContextValue("user",user);
        return "editpassword";
    }

    public String updatePasswd(){
        User user=UserHelper.getCurrentLoginUser();
        if(!user.getPassword().equals(DigestUtils.shaHex(user.getUsername() + oldPassword))){
            AjaxSupport.sendFailText("旧密码输入错误！请重新输入！",null);
            return AJAX_RESULT;
        }
        user.changePassword(oldPassword, newPassword);
		//成功信息
		String infor = getText("user.changeSelfPassword.success");
		//日志
		saveOperationLog("user.changeSelfPassword", infor, null);
		addActionMessage(infor);
        AjaxSupport.sendSuccessText(null,"success");
        return AJAX_RESULT;
    }

    /** 启用/禁用 */
    public String forbidAjax() {
        User currentUser=UserHelper.getCurrentLoginUser();
        String[] values=chk_value.split("\\.");
        if(values.length>0){
            for(String value:values){
                User user = User.get(User.class,Long.valueOf(value.trim()));
                Asserts.assertTrue(user != null, getText("user.nonexist"));
                currentUser.isParentValidate(user);
                assert user != null;
                String result = user.forbid();
                String infor = getText("user.forbid.success", new String[] {user.getUsername(), user.getForbidInfor()});
                saveOperationLog("user.forbid", infor, result);
            }
        }
        AjaxSupport.sendSuccessText(null,"success");
        return AJAX_RESULT;
    }

    /**
     * 用户权限
     * @return
     */
    public String perssionAjax(){
        List<Station> stationList= RbacInterceptor.floorIntercept();
        User user=User.get(User.class,idx);
        if(user.isForbidFlag()){
            AjaxSupport.sendFailText("此用户已被禁用，请先启用该用户再添加权限！",null);
            return AJAX_RESULT;
        }
        List<UserXPerssion> userXPerssionList=UserXPerssion.getByUserId(user.getId());
        UserPerssionHelper userPerssionHelper = new UserPerssionHelper();
        userPerssionHelper.setUser(user);
        userPerssionHelper.setStationList(stationList);
        userPerssionHelper.setUserXPerssionList(userXPerssionList);
        AjaxSupport.sendSuccessText(null,userPerssionHelper,"user.*","stationList.*","stationList.floorList.*","userXPerssionList.floor.id","userXPerssionList.station.id");
        return NONE;
    }

    /**
     * 添加权限
     * @return
     */
    public String add(){
        User user= User.get(User.class,idx);
        String[] values=chk_value.split("\\.");
        if(values.length>0){
            UserXPerssion.deleteByUserId(user.getId());
            UserXStation.deleteByUserId(user.getId());
        }
        for(String str:values){
            String[] value=str.split("-");
            if(value[0].equals("cz")){
                Station station=Station.get(Station.class,Long.valueOf(value[1]));
                UserXPerssion userXPerssion=new UserXPerssion();
                userXPerssion.setUser_id(user.getId());
                userXPerssion.setStation(station);
                userXPerssion.add();
            }else if(value[0].equals("lou")){
                Floor floor=Floor.get(Floor.class,Long.valueOf(value[1]));
                Station station=floor.getStation();
                UserXPerssion userXPerssion=new UserXPerssion();
                userXPerssion.setUser_id(user.getId());
                userXPerssion.setStation(station);
                userXPerssion.setFloor(floor);
                userXPerssion.add();
            }
        }
        AjaxSupport.sendSuccessText(null,"success");
        return AJAX_RESULT;
    }

    public String getChk_value() {
        return chk_value;
    }

    public void setChk_value(String chk_value) {
        this.chk_value = chk_value;
    }

    public String getOldPassword() {
        return oldPassword;
    }

    public void setOldPassword(String oldPassword) {
        this.oldPassword = oldPassword;
    }

    public String getNewPassword() {
        return newPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }
}
