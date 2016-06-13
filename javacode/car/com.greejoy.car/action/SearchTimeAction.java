package com.greejoy.car.action;

import com.greejoy.car.domain.SearchTime;
import com.greejoy.gtip.component.json.AjaxSupport;
import com.greejoy.gtip.web.Action;
import com.greejoy.gtip.web.support.UrlSupport;

import java.util.List;

/**
 * Created by CZJiang on 2015/12/28.
 */
@Action
public class SearchTimeAction extends UrlSupport {
    private int num;

    public String index(){
        List<SearchTime> searchTimeList=SearchTime.listAll(SearchTime.class);
        if(searchTimeList.size()==0){
            num=15;
        }else{
            num=searchTimeList.get(0).getDay();
        }
        return "index";
    }
    public String setSearchTime(){
        List<SearchTime> searchTimeList=SearchTime.listAll(SearchTime.class);
        if(searchTimeList.size()==0){
            SearchTime searchTime=new SearchTime();
            searchTime.setDay(num);
            searchTime.add();
        }else {
            SearchTime searchTime=searchTimeList.get(0);
            searchTime.setDay(num);
            searchTime.update();
        }
        AjaxSupport.sendSuccessText(null,"success");
        return AJAX_RESULT;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }
}
