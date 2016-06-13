package com.greejoy.car.dao.lmp;

import com.greejoy.car.dao.CarDao;
import com.greejoy.car.domain.*;
import com.greejoy.car.util.CarDBUtil;
import com.greejoy.chart.domain.StopCarInfo;
import com.greejoy.floor.domain.AkeparkFloorNum;
import com.greejoy.floor.domain.Floor;
import com.greejoy.gtip.component.Page;
import com.greejoy.gtip.module.rbac.domain.User;
import com.greejoy.gtip.module.rbac.support.helper.UserHelper;
import com.greejoy.station.domain.Station;
import com.greejoy.user.domain.UserXPerssion;
import org.apache.struts2.ServletActionContext;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-10-26
 * Time: 下午10:03
 * To change this template use File | Settings | File Templates.
 */
public class CarDaoImp implements CarDao{
    public void setAKEPARKUrl(Station station){
        CarDBUtil.Url="jdbc:sqlserver://"+station.getStation_ip()+":"+station.getStation_port()+";DatabaseName=AKEPARK";
    }
    public void setImgofCarUrl(Station station){
        CarDBUtil.Url="jdbc:sqlserver://"+station.getStation_ip()+":"+station.getStation_port()+";DatabaseName=akepark_reserse";
    }
    public void setMonitorUrl(Station station){
        CarDBUtil.Url="jdbc:sqlserver://"+station.getStation_ip()+":"+station.getStation_port()+";DatabaseName=monitor";
    }
    public CarFloor getScreen(int floor_num,int akepark_num){
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        CarFloor carFloor=new CarFloor();
        String sql ="select count(*) as num from detector where Occupied=0 and Floor="+akepark_num;
        try{
            conn = CarDBUtil.getConnection();
            Station station=Station.getStationByUser();
            Floor floor=Floor.getByNum(station.getId(),floor_num);
            int  leftseats=0;
            int parking_lot=floor.getParking_lot();
            statement = conn.prepareStatement(sql);
            rs = statement.executeQuery();
            if(rs.next()){
                leftseats=leftseats+rs.getInt("num");
            }
            carFloor.setLeftseats(leftseats);
            carFloor.setFloor_num(floor.getFloor_num());
            carFloor.setOccupySeats(parking_lot-leftseats);
            carFloor.setParking_lot(parking_lot);
            carFloor.setPercent((parking_lot-leftseats)*100/parking_lot);
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            CarDBUtil.closeConnection(conn, statement, rs);
        }
        return carFloor;
    }
    public List<CarFloor> getScreen(Station station){
        User user= UserHelper.getCurrentLoginUser();
        List<CarFloor> show_screen=new ArrayList();
        List<Floor> floorList=new ArrayList<Floor>();
        if(user.isSysUser()||user.getUsername().equals("admin")){
            floorList=Floor.getFloorByStation(station.getId());
        }else{
            List<UserXPerssion> userXPerssionList=UserXPerssion.getByUserIdStationId(user.getId(),station.getId());
            for(UserXPerssion userXPerssion:userXPerssionList){
                floorList.add(userXPerssion.getFloor());
            }
        }
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        String sql ="select count(*) as num from detector where Floor=? and Occupied=0";
        try{
            conn = CarDBUtil.getConnection();
            for(Floor floor:floorList){
                int  leftseats=0;
                int parking_lot=floor.getParking_lot();
                statement = conn.prepareStatement(sql);
                statement.setInt(1,AkeparkFloorNum.getByFloorNum(floor.getFloor_num(),station.getId()));
                rs = statement.executeQuery();
                if(rs.next()){
                    leftseats=rs.getInt("num");
                }
                CarFloor carFloor=new CarFloor();
                carFloor.setLeftseats(leftseats);
                carFloor.setFloor_num(floor.getFloor_num());
                carFloor.setOccupySeats(parking_lot-leftseats);
                carFloor.setParking_lot(parking_lot);
                carFloor.setPercent((parking_lot-leftseats)*100/parking_lot);
                show_screen.add(carFloor);
            }

        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            CarDBUtil.closeConnection(conn, statement, rs);
        }
        return show_screen;
    }

    public List getAddressByZone(int floor_num,String zone){
        List addressList=new ArrayList();
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        String sql ="select Address from detector where Floor="+floor_num+" and ControllerId='"+zone+"' order by CAST(Address AS INT)";
        try{
            conn = CarDBUtil.getConnection();
            statement = conn.prepareStatement(sql);
            rs = statement.executeQuery();
            while(rs.next()){
                String address=rs.getString("Address");
                addressList.add(address);
            }

        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            CarDBUtil.closeConnection(conn, statement, rs);
        }
        return addressList;
    }

    public List<Detector> getDetector(List<Detector> detectorList,int floor_num){
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        String sql ="select ItemNo,Occupied from detector where Floor="+floor_num;
        try{
            conn = CarDBUtil.getConnection();
            statement = conn.prepareStatement(sql);
            rs = statement.executeQuery();
            while(rs.next()){
                String ItemNo=rs.getString("ItemNo");
                boolean Occupied=rs.getBoolean("Occupied");
                for(Detector detector:detectorList){
                    if(ItemNo.equals(detector.getItemNo())){
                        detector.setOccupied(Occupied);
                    }
                }
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            CarDBUtil.closeConnection(conn, statement, rs);
        }
        return detectorList;
    }
    public List getControllerAll(int floor_num){
        List controllerList=new ArrayList();
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        String sql ="select ControllerId from detector where Floor="+floor_num+" group by ControllerId";
        try{
            conn = CarDBUtil.getConnection();
            statement = conn.prepareStatement(sql);
            rs = statement.executeQuery();
            while(rs.next()){
                String controllerId=rs.getString("ControllerId");
                controllerList.add(controllerId);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            CarDBUtil.closeConnection(conn, statement, rs);
        }
        return controllerList;
    }

    public String splitStr(List<CameraIp> cameraIpList){
        String str="";
        for(CameraIp cameraIp:cameraIpList){
            str=str+"','"+cameraIp.getCameraIp();
        }
        str=str.substring(2,str.length())+"'";
        return str;
    }

    public List getCarInfoByIP(List<CameraIp> cameraIpList,int num){
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date=new Date();
        String startTime=sdf.format(new Date(date.getTime()-num*24*60*60*1000));
        String endTime=sdf.format(date);
        List list=new ArrayList();
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        String str=splitStr(cameraIpList);
        String sql ="select PlateNo from imageofCar where s_ip in("+str+") and timeID BETWEEN '"+startTime+"' and '"+endTime+"'";
        try{
            conn = CarDBUtil.getConnection();
            statement = conn.prepareStatement(sql);
            rs = statement.executeQuery();
            while(rs.next()){
                String busPlate=rs.getString("PlateNo");
                busPlate=busPlate.substring(1,busPlate.length());
                String busNo=CarInfo.getCarByPlate(busPlate);
                if(busNo!=null){
                    list.add(busNo);
                }
            }
            Collections.sort(list);
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            CarDBUtil.closeConnection(conn, statement, rs);
        }
        return list;
    }

    public List<CarInfo> getCarInfo(List<CameraIp> cameraIpList, int floor_num, Page page,int num){
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date=new Date();
        String startTime=sdf.format(new Date(date.getTime()-(long)num*24*60*60*1000));
        String endTime=sdf.format(date);
        List<CarInfo> carInfoList=new ArrayList<CarInfo>();
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        String str=splitStr(cameraIpList);
        String sql="select count(*) as totalCount from imageofCar where s_ip in("+str+") and timeID BETWEEN '"+startTime+"' and '"+endTime+"'";
        try{
            conn = CarDBUtil.getConnection();
            statement = conn.prepareStatement(sql);
            rs = statement.executeQuery();
            if(rs.next()){
                page.setTotalCount(rs.getInt("totalCount"));
            }
            int currentPage=page.getCurrentPage();
            int pageSize=page.getPageSize();
            int endNum=currentPage*pageSize;
            int size=24;
            if(currentPage==page.getTotalPage()){
                size=page.getTotalCount()-pageSize*(currentPage-1);
            }
            sql="SELECT TOP "+size+" timeID,PlateNo FROM (select top "+endNum+" timeID,PlateNo from imageofCar" +
                    "  where s_ip in("+str+") and timeID BETWEEN '"+startTime+"' and '"+endTime+"' order by id  ) as img";
            statement = conn.prepareStatement(sql);
            rs = statement.executeQuery();
            while(rs.next()){
                String busPlate=rs.getString("PlateNo");
                busPlate=busPlate.substring(1,busPlate.length());
                Pattern pattern = Pattern.compile("川A.*");
                Matcher match = pattern.matcher(busPlate);
                if(match.find()){
                    Date stopDate=rs.getTimestamp("timeID");
                    CarInfo carInfo=new CarInfo();
                    carInfo.setBusPlate(busPlate);
                    carInfo.setStopDate(stopDate);
                    carInfo.setFloor_num(floor_num);
                    String busNo=CarInfo.getCarByPlate(busPlate);
                    if(busNo!=null){
                        carInfo.setBusNo(busNo);
                    }
                    carInfoList.add(carInfo);
                }
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            CarDBUtil.closeConnection(conn, statement, rs);
        }
        return carInfoList;
    }
    public List<CarStopInfo> getStopInfo(String busPlate)throws Exception{
        List<CarStopInfo> carStopInfoList=new ArrayList<CarStopInfo>();
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String sql ="select timeID,s_ip from copyimageofCar where PlateNo like '_"+busPlate+"' order by timeID DESC";
        try{
            conn = CarDBUtil.getConnection();
            statement = conn.prepareStatement(sql);
            rs = statement.executeQuery();
            while(rs.next()){
                String s_ip=rs.getString("s_ip");
                CarStopInfo carStopInfo=new CarStopInfo();
                carStopInfo.setTimeID(rs.getTimestamp("timeID"));
                CameraIp cameraIp=CameraIp.getCameraIpByIp(s_ip);
                carStopInfo.setFloor_num(AkeparkFloorNum.getByAkeparkFloor(cameraIp.getFloor_num()).getFloorNum());
                carStopInfo.setPassageway(cameraIp.isPassageway());
                carStopInfo.setPlateNo(busPlate);
                carStopInfoList.add(carStopInfo);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            CarDBUtil.closeConnection(conn, statement, rs);
        }
        return carStopInfoList;
    }

    public List<CarInfo> getByBusnoBusplateDate(String busPlate,Date stopDate, List<CameraIp> cameraIpList){
        List<CarInfo> carInfoList=new ArrayList<CarInfo>();
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
        String sql ="select timeID,PlateNo,s_ip from copyimageofCar where";
        Calendar calendar=Calendar.getInstance();
        calendar.setTime(stopDate);
        calendar.add(Calendar.DATE,1);
        String startTime=sdf.format(stopDate);
        String endTime=sdf.format(calendar.getTime());
        sql=sql+" timeID between '"+startTime+"' and '"+endTime+"'";
        if(!busPlate.equals("")){
            sql=sql+" and PlateNo like '_"+busPlate+"' ";
        }
        String str="";
        for(CameraIp cameraIp:cameraIpList){
            str=str+"','"+cameraIp.getCameraIp();
        }
        str=str.substring(2,str.length())+"'";
        sql=sql+" and s_ip in("+str+")"+" order by timeID DESC";
        try{
            conn = CarDBUtil.getConnection();
            statement = conn.prepareStatement(sql);
            rs = statement.executeQuery();
            while (rs.next()){
                busPlate=rs.getString("PlateNo");
                busPlate=busPlate.substring(1,busPlate.length());
                stopDate=rs.getTimestamp("timeID");
                CarInfo carInfo=new CarInfo();
                carInfo.setBusPlate(busPlate);
                carInfo.setStopDate(stopDate);
                carInfo.setFloor_num(AkeparkFloorNum.getByAkeparkFloor(CameraIp.getCameraIpByIp(rs.getString("s_ip")).getFloor_num()).getFloorNum());
                String busNo=CarInfo.getCarByPlate(busPlate);
                if(busNo!=null){
                    carInfo.setBusNo(busNo);
                }
                carInfoList.add(carInfo);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            CarDBUtil.closeConnection(conn, statement, rs);
        }
        return carInfoList;
    }

    public Map getCarInfoByDetector(int year,int month,int floor_num){
        Map<String,Integer> map=new TreeMap<String,Integer>();
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        String sql="";
        int flag=0;
        if(month!=0){
            flag=1;
            Calendar calendar = Calendar.getInstance();
            calendar.set(Calendar.MONTH,month-1);
            int lastDay=calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
            String startTime=year+"-"+month+"-1 00:00:00";
            String endTime=year+"-"+(month+"-"+lastDay+" 23:59:59");
            if(floor_num!=0){
                sql="SELECT count(*) as num,convert(varchar(10),UPDateTime,120) as date" +
                        " FROM detector_update where Occupied=1 and UPDateTime between '"+startTime+"' and '"+endTime +
                        "' and Floor="+floor_num+" group by convert(varchar(10),UPDateTime,120)";
            }else{
                sql="SELECT count(*) as num,convert(varchar(10),UPDateTime,120) as date" +
                        " FROM detector_update where Occupied=1 and UPDateTime between '"+startTime+"' and '"+endTime +
                        "' group by convert(varchar(10),UPDateTime,120)";
            }
        }else{
            if(floor_num==0){
                sql="SELECT convert(varchar(7),UPDateTime,120) as date, count(*) as num" +
                        "  FROM detector_update where Occupied=1 and UPDateTime " +
                        "between '"+year+"-1-1 00:00:00' and '"+(year+1)+"-1-1 00:00:00' group by " +
                        "convert(varchar(7),UPDateTime,120)";
            }else{
                sql="SELECT convert(varchar(7),UPDateTime,120) as date, count(*) as num" +
                        "  FROM detector_update where Occupied=1 and UPDateTime " +
                        "between '"+year+"-1-1 00:00:00' and '"+(year+1)+"-1-1 00:00:00' " +
                        "AND Floor="+floor_num+" group by convert(varchar(7),UPDateTime,120)";
            }
        }
        try{
            conn = CarDBUtil.getConnection();
            statement = conn.prepareStatement(sql);
            rs = statement.executeQuery();
            while(rs.next()){
                String date=rs.getString("date");
                if(flag==0){
                    date=date.substring(5,7);
                }else{
                    date=date.substring(8,10);
                }
                int num=rs.getInt("num");
                map.put(date,num);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            CarDBUtil.closeConnection(conn, statement, rs);
        }
        return map;
    }


    public String getZoneByItem(String itemNo){
        String zone="";
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        String sql ="select Zone from detector where ItemNo='"+itemNo+"'";
        try{
            conn = CarDBUtil.getConnection();
            statement = conn.prepareStatement(sql);
            rs = statement.executeQuery();
            while(rs.next()){
                zone=rs.getString("Zone");
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            CarDBUtil.closeConnection(conn, statement, rs);
        }
        return zone;
    }

    public boolean textConnection(){
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try{
            Class.forName(CarDBUtil.DriverClass);
            conn = DriverManager.getConnection(CarDBUtil.Url, CarDBUtil.UserName, CarDBUtil.UserPassword);
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }finally {
            CarDBUtil.closeConnection(conn, statement, rs);
        }
        return true;
    }

    public boolean getOccupiedByItemNo(String itemNo){
        boolean occupied=false;
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        String sql ="select Occupied from detector where ItemNo='"+itemNo+"'";
        try{
            conn = CarDBUtil.getConnection();
            statement = conn.prepareStatement(sql);
            rs = statement.executeQuery();
            if(rs.next()){
                occupied=rs.getBoolean("Occupied");
                if(occupied){
                    return true;
                }
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            CarDBUtil.closeConnection(conn, statement, rs);
        }
        return occupied;
    }

    /**
     *  更新车辆信息
     */
    public boolean updateCarInfo(String dervier,String username,String password,String url,String tableName,long lastBusId){
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        String sql ="select id,BUSNO,BUSPLATE,BUSCREWNO,LX,JSBUSTYPE,CONO from "+tableName+" where id>"+lastBusId;
        try{
            conn = CarDBUtil.getConnection(dervier,username,password,url);
            statement = conn.prepareStatement(sql);
            rs = statement.executeQuery();
            while(rs.next()){
                CarInfo carInfo=new CarInfo();
                carInfo.setBus_id(rs.getLong("id"));
                carInfo.setBusNo(rs.getString("BUSNO"));
                carInfo.setBusPlate(rs.getString("BUSPLATE"));
                carInfo.setBusCrewno(rs.getString("BUSCREWNO"));
                carInfo.setLx(rs.getString("LX"));
                carInfo.setJsBusType(rs.getString("JSBUSTYPE"));
                carInfo.setCoNo(rs.getString("CONO"));
                carInfo.add();
            }
        }catch (SQLException e){
            return false;
        }finally {
            CarDBUtil.closeConnection(conn, statement, rs);
        }
        return true;
    }
}
