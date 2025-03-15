package com.xp.controller;


import com.xp.bean.*;
import java.util.List;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RemoveFromCartServlet
 */
@WebServlet("/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
	
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int id = Integer.parseInt(request.getParameter("id"));
		
		HttpSession session = request.getSession();
		List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
		
		
		if(cart != null) {
			cart.removeIf(item -> item.getId() == id);
		}
		
		response.sendRedirect("orderConfirmation.jsp");
		
		
	}

}
