package com.xp.controller;



import java.util.List;
import java.util.ArrayList;
import java.io.IOException;

import com.xp.bean.CartItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AddToCartServlet
 */
@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int id = Integer.parseInt(request.getParameter("id"));
		String name = request.getParameter("name");
		double price = Double.parseDouble(request.getParameter("price"));
		
		HttpSession session = request.getSession(false);
		
		if(session == null || session.getAttribute("username") == null) {
			response.sendRedirect("login.jsp");
		} else {

			// Type Casting
			List<CartItem> cart = (List<CartItem>)session.getAttribute("cart");
			
			if(cart == null) {
				cart = new ArrayList<>();
				session.setAttribute("cart", cart);
			}
			
			boolean thereOrNot = false;
			for(CartItem cItem : cart) {
				if(cItem.getId() == id) {
					cItem.setQuantity(cItem.getQuantity() + 1);
					thereOrNot = true ;
					break;
				}
			}
			
			if(!thereOrNot) {
				cart.add(new CartItem(id, 1, name, price));
			}
			
			
			response.sendRedirect("orderConfirmation.jsp");
			
			
		}
		

	}

}
