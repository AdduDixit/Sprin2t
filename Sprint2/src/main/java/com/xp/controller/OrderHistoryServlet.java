package com.xp.controller;
import com.xp.bean.Order;
import com.xp.dbConnection.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;




@WebServlet("/OrderHistoryServlet")
public class OrderHistoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(false);
		if(session == null || session.getAttribute("user") == null) {
			response.sendRedirect("login.jsp");
			return;
		}
		
		int userId= (Integer) session.getAttribute("userId"); // userId of current;y logged-in user
		try {
			dbConnection dbCon = new dbConnection();
			Connection conn = dbCon.createConnection();
            String query = "SELECT id, order_date, total_price FROM orders WHERE user_id = ? ORDER BY order_date DESC";
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setInt(1, userId);
            ResultSet rs = pst.executeQuery();
            ArrayList<Order> orderList = new ArrayList<>();
            
            while(rs.next()) {
            	Order order = new Order();
            	order.setOrderId(rs.getInt("id"));
            	order.setOrder_date(rs.getTimestamp("order_date"));
            	order.setTotal_price(rs.getDouble("total_price"));

            	orderList.add(order);
            }
            
            request.setAttribute("orderList", orderList);
            
            request.getRequestDispatcher("userprofile.jsp").forward(request,response);

		} catch(Exception e) {
			e.printStackTrace();
		}

	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
