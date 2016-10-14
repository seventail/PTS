package com.greejoy.car.util;

import java.sql.*;

/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-10-26
 * Time: 下午9:58
 * To change this template use File | Settings | File Templates.
 */
public class CarDBUtil {
    public static final String DriverClass = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    /**数据库用户名*/
    public static final  String UserName = "sa";
    /**数据库密码*/
    public static final String UserPassword = "jzkj-1248";
//    public static final String UserPassword = "11111";
    public static String Url = "";
    /**
     * 获得数据库连接
     * @return 数据库连接
     */
    public static Connection getConnection(){
        Connection conn = null;
        try{
            Class.forName(DriverClass);
            conn = DriverManager.getConnection(Url, UserName, UserPassword);
        }catch (ClassNotFoundException e){
            e.printStackTrace();
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }

    public static Connection getConnection(String dervier,String username,String password,String url){
        Connection conn = null;
        try{
            Class.forName(dervier);
            conn = DriverManager.getConnection(url, username, password);
        }catch (ClassNotFoundException e){
            e.printStackTrace();
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }

    /**
     * 关闭数据库连接
     * @param conn	数据库对象
     * @param stmt	语句对象
     * @param rs	结果集对象
     */
    public static void closeConnection(Connection conn, Statement stmt, ResultSet rs){
        try {
            if(rs != null){
                rs.close();
            }
            if(stmt != null){
                stmt.close();
            }
            if(conn != null){
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
