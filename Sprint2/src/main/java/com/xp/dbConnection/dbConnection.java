package com.xp.dbConnection;
import java.sql.*;
public class dbConnection {
	
	public Connection createConnection() throws SQLException, ClassNotFoundException {
		
		String url = "jdbc:derby:C:\\Users\\Lenovo\\MyDB;create=true";
		Connection conn = null;
		try {
			Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
			conn = DriverManager.getConnection(url);
			System.out.println("Connection sucksessful from dbConnect file");
			return conn;
		} catch(Exception e) {
			
			System.out.println("You're inside catch block bitch!");
			e.printStackTrace();
			
			return null;
		}		
	}
	
	

}
