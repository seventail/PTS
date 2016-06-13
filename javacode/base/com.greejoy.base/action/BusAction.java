package com.greejoy.base.action;

import com.greejoy.gtip.web.Action;
import com.greejoy.gtip.web.support.BaseAction;

/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-10-13
 * Time: 下午2:20
 * To change this template use File | Settings | File Templates.
 */
@Action
public class BusAction extends BaseAction{
    public String about(){
        return "about";
    }
}
