package com.greejoy.base.util;

import java.sql.*;

/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-10-14
 * Time: 下午5:04
 * To change this template use File | Settings | File Templates.
 */
public class DBUtil {
    /**
     * 测试数据库连接
     * @return 数据库连接
     */
    public static Connection getConnection(String driver,String url,String userName,String password)throws Exception{
        Connection conn = null;
        Class.forName(driver);
        conn = DriverManager.getConnection(url, userName, password);
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
