package com.greejoy.station.action;

import com.greejoy.base.util.DBUtil;
import com.greejoy.gtip.component.ConfigLoader;
import com.greejoy.gtip.component.json.AjaxSupport;
import com.greejoy.gtip.module.rbac.support.annotation.Permission;
import com.greejoy.gtip.web.Action;
import com.greejoy.gtip.web.support.BaseAction;
import com.greejoy.gtip.web.support.UrlSupport;
import com.greejoy.station.domain.Station;
import org.apache.struts2.ServletActionContext;

import java.sql.Connection;
import java.util.List;


/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-10-9
 * Time: 上午11:04
 * To change this template use File | Settings | File Templates.
 */

@Action
public class StationAction extends UrlSupport {
    private String chk_value;
    private Station station;
    private String station_name;
    private String station_address;
    private String station_ip;
    private int station_port;

    public String index(){
        createPage();
        List<Station> stationList=Station.listByPage(page,station_name,idx);
        setContextValue("stationList",stationList);
        return "index";
    }

    public String beforeAdd(){
        return "beforeAdd";
    }

    public String add(){
        station=new Station();
        station.setName(station_name);
        station.setAddress(station_address);
        station.setStation_ip(station_ip);
        station.setStation_port(station_port);
        station.add();
        return "addTr";
    }

    public String beforeUpdate(){
        station=Station.get(Station.class,idx);
        return "beforeUpdate";
    }

    public String update(){
        station=new Station();
        station.setName(station_name);
        station.setAddress(station_address);
        station.setStation_ip(station_ip);
        station.setStation_port(station_port);
        Station stationE=Station.get(Station.class,idx);
        String infor = stationE.update(station);
        String result = getText("station.update.success");
        saveOperationLog("station.update", result, infor);
        station=Station.get(Station.class,idx);
        return "updateTr";
    }

    public String delete(){
        String[] values=chk_value.split("\\.");
        if(values.length>0){
            for(String value:values){
                station=Station.get(Station.class,Long.valueOf(value));
                station.delete();
            }
        }
        AjaxSupport.sendSuccessText(null,"success");
        return AJAX_RESULT;
    }

    public String communication(){
        Connection connection=null;
        if(station_ip==null&&station_port==0&&idx!=0){
            station=Station.get(Station.class, idx);
            station_ip=station.getStation_ip();
            station_port=station.getStation_port();
        }
        String url="jdbc:sqlserver://"+station_ip+":"+station_port+";DatabaseName="+configLoader.getValue("config.sql.testConnection");
        System.out.println(station_ip+":"+station_port);
        try{
            connection= DBUtil.getConnection(
                    configLoader.getValue("config.sql.driverClass"),url,
                    configLoader.getValue("config.sql.stationName"),
                    configLoader.getValue("config.sql.stationPassword"));
            if(connection!=null){
                AjaxSupport.sendSuccessText(null,"success");
            }
        }catch (Exception e){
            AjaxSupport.sendSuccessText(null,"error");
        } finally {
            DBUtil.closeConnection(connection,null,null);
        }
        return AJAX_RESULT;
    }


    public Station getStation() {
        return station;
    }

    public void setStation(Station station) {
        this.station = station;
    }

    public String getChk_value() {
        return chk_value;
    }

    public void setChk_value(String chk_value) {
        this.chk_value = chk_value;
    }

    public String getStation_name() {
        return station_name;
    }

    public void setStation_name(String station_name) {
        this.station_name = station_name;
    }

    public String getStation_address() {
        return station_address;
    }

    public void setStation_address(String station_address) {
        this.station_address = station_address;
    }

    public String getStation_ip() {
        return station_ip;
    }

    public void setStation_ip(String station_ip) {
        this.station_ip = station_ip;
    }

    public int getStation_port() {
        return station_port;
    }

    public void setStation_port(int station_port) {
        this.station_port = station_port;
    }
}
