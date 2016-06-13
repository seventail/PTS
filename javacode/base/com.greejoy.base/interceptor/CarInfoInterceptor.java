package com.greejoy.base.interceptor;

import com.greejoy.gtip.module.rbac.domain.User;
import com.greejoy.user.domain.UserXStation;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpSession;

/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-11-18
 * Time: 上午10:35
 * To change this template use File | Settings | File Templates.
 */
public class CarInfoInterceptor extends AbstractInterceptor {
    public String intercept(ActionInvocation actionInvocation) throws Exception {
        HttpSession session = ServletActionContext.getRequest().getSession();
        User user = (User) session.getAttribute(User.CURRENT_LOGIN_USER);
        if(!user.isSysUser()&&!user.isAdmin()){
            return "permissionFail";
        }else {
            return actionInvocation.invoke();
        }
    }
}
