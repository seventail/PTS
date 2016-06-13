package com.greejoy.car.action;

import com.greejoy.car.dao.lmp.CarDaoImp;
import com.greejoy.car.domain.CarInfo;
import com.greejoy.gtip.component.json.AjaxSupport;
import com.greejoy.gtip.web.Action;
import com.greejoy.gtip.web.support.UrlSupport;
import org.apache.struts2.ServletActionContext;

import javax.servlet.ServletContext;
import java.io.FileInputStream;
import java.util.List;
import java.util.Properties;

/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-11-12
 * Time: 下午1:18
 * To change this template use File | Settings | File Templates.
 */
@Action
public class CarInfoAction extends UrlSupport{
    private String busNo;
    private String busPlate;
    private CarInfo carInfo;
    private String lx;
    private String jsBusType;
    private String busCrewno;
    public String index(){
        createPage();
        List<CarInfo> carInfoList=CarInfo.listByPage(page,busNo,idx);
        setContextValue("carInfoList",carInfoList);
        return "index";
    }

    public String beforeUpdate(){
        carInfo=CarInfo.get(CarInfo.class,idx);
        return "beforeUpdate";
    }

    public String update(){
        carInfo=CarInfo.get(CarInfo.class,idx);
        carInfo.setLx(lx);
        carInfo.setBusCrewno(busCrewno);
        carInfo.setJsBusType(jsBusType);
        carInfo.update();
        return "updateTr";
    }

    public String synchronization(){
        //String propertiesPath=ServletActionContext.getServletContext().getRealPath("/")+"WEB-INF/classes/config.properties";
        //Properties properties = new Properties();
        //try {
        //    properties.load( new FileInputStream( propertiesPath ) );
        //} catch ( Exception e ) {
            //加载失败的处理
        //    e.printStackTrace();
        //}
        //String dervier= properties.getProperty("config.sql.cardriverClass");
        //String username=properties.getProperty("config.sql.carusername");
        //String password=properties.getProperty("config.sql.carpassword");
        //String url=properties.getProperty("config.sql.carurl");
        //String tableName=properties.getProperty("config.sql.cartableName");
        String dervier=configLoader.getValue("config.sql.cardriverClass");
        String username=configLoader.getValue("config.sql.carusername");
        String password=configLoader.getValue("config.sql.carpassword");
        String url=configLoader.getValue("config.sql.carurl");
        String tableName=configLoader.getValue("config.sql.cartableName");
        long lastBusId=0;
        if(CarInfo.getCarInfoNum()!=0){
            lastBusId=CarInfo.getLastCarInfo();
        }
        CarDaoImp carDaoImp=new CarDaoImp();
        if(carDaoImp.updateCarInfo(dervier,username,password,url,tableName,lastBusId)){
            AjaxSupport.sendSuccessText(null,"success");
        }else {
            AjaxSupport.sendFailText("数据库连接错误！请检查数据库信息是否正确！",null);
        }
        return AJAX_RESULT;
    }


    public String getBusNo() {
        return busNo;
    }

    public void setBusNo(String busNo) {
        this.busNo = busNo;
    }

    public String getBusPlate() {
        return busPlate;
    }

    public void setBusPlate(String busPlate) {
        this.busPlate = busPlate;
    }

    public CarInfo getCarInfo() {
        return carInfo;
    }

    public void setCarInfo(CarInfo carInfo) {
        this.carInfo = carInfo;
    }

    public String getLx() {
        return lx;
    }

    public void setLx(String lx) {
        this.lx = lx;
    }

    public String getJsBusType() {
        return jsBusType;
    }

    public void setJsBusType(String jsBusType) {
        this.jsBusType = jsBusType;
    }

    public String getBusCrewno() {
        return busCrewno;
    }

    public void setBusCrewno(String busCrewno) {
        this.busCrewno = busCrewno;
    }
}
