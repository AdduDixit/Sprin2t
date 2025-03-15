package com.xp.dao;
import java.lang.ProcessBuilder.Redirect;
import java.sql.*;

import com.xp.bean.LoginBean;
import com.xp.dbConnection.*;
public class LoginDao {
	
	public boolean validate(LoginBean loginbean) {
		
		String query = "Select * from Login where username = ? and password = ?";

		try 
		{
			dbConnection dbCon = new dbConnection();
			Connection conn = dbCon.createConnection();

			if(conn != null) {
				System.out.println();
				System.out.println("Connection still aint null!");
				PreparedStatement pst = conn.prepareStatement(query);
				pst.setString(1, loginbean.getUsername());
				pst.setString(2, loginbean.getPassword());
				ResultSet rs = pst.executeQuery();
				// now this stores a  resultSet with 1 row

				if(rs.next()) 
				{
											
					System.out.println("Login successful!");
						return true;
				
				}
				else {
					System.out.println("Login unsuccessful! ! AANd you suck  ");
					return false;
				}
			}
			
					
		} catch(SQLException e) {
			System.out.println();
			System.out.println("Inside catch block of LoginDao bitch!");
			
			System.out.println("SQLEXception . Probablty failed to establish a database connection");
		} catch(Exception e) {
			System.out.println();
e.printStackTrace();
		}
		
		
		
		return true;
	}

}
