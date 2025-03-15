package com.xp.controller;
import java.sql.*;
import java.io.IOException;
import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletResponse;

import com.xp.bean.*;
import com.xp.dao.*;
import com.xp.dbConnection.*;

/**
 * Servlet implementation class loginServlet
 */
@WebServlet("/loginServlet")
public class loginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;



	
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		int userId = 0;
		LoginBean lb = new LoginBean();
		
		dbConnection dbCon = new dbConnection();
		try {
			Connection conn2 = dbCon.createConnection();
			String sql = "select user_id from Login where username=?";
			PreparedStatement pst = conn2.prepareStatement(sql);
			pst.setString(1, username);
			
			ResultSet rs2 = pst.executeQuery();
			
			while(rs2.next()) {
				 userId = rs2.getInt(1);
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		System.out.println(userId);
		lb.setUsername(username);
		lb.setPassword(password);
		lb.setUserId(userId);

		
		PrintWriter out =response.getWriter();// to html page
		System.out.println();
		System.out.println("********************************* Begin of LoginServlet code ********************************* Below line is user ID");
		System.out.println(userId);

		System.out.println("This is getting printed to console from inside doPost of loginSerevlet");
		System.out.println();
		
		LoginDao loginDao = new LoginDao();
		
		if(loginDao.validate(lb)) {
			
			HttpSession session = request.getSession();
			session.setAttribute("userId", lb.getUserId());
			session.setAttribute("username", lb.getUsername());
			System.out.println("Currently logged in as " + session.getAttribute("username"));
			
			response.sendRedirect("index.jsp");
		} else {
			response.sendRedirect("login.jsp");
		}
		
		// loginDao validate() takes a loginBean object as parameter
		
		
		

	}

}
