package com.xp.controller;

import java.io.*;
import com.xp.bean.*;
import com.xp.dbConnection.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itextpdf.*;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.*;

   

import com.xp.bean.*;
import java.sql.*;
import java.util.*;

import javax.servlet.http.HttpSession;


@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


    public OrderServlet() {
        super();
        // TODO Auto-generated constructor stub
    }



    
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

			HttpSession session = request.getSession();
			List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
			String userName = (String) session.getAttribute("username");
			
			
			double totalprice = 0.0;
			
			if(cart != null) {
				for(CartItem item: cart) {
					totalprice += item.getPrice()*item.getQuantity();
					
				}
			}
			
			session.setAttribute("total_price", totalprice);
			
			if(userName == null) {
				response.sendRedirect("login.jsp?error=login_required");
				
			}
			
			if(cart == null || cart.isEmpty()) {
				response.sendRedirect("checkout.jsp?error=empty_cart");
				return;
			}
			
			Connection conn = null;
			dbConnection dbcon = new dbConnection();
			PreparedStatement ordersStmt = null;
			PreparedStatement orderItemsStmt = null;
			ResultSet rs = null;
			
			PreparedStatement getUserId =  null;
			
			
			try {
				
				conn = dbcon.createConnection();
				conn.setAutoCommit(false); 
				
				String forUserTableQuery = "select user_id from Login where username = ?";
				
				
				getUserId = conn.prepareStatement(forUserTableQuery);
				getUserId.setString(1, userName);
				ResultSet rs1 = getUserId.executeQuery();
				int userId = -1;
				if (rs1.next()) {
					 userId = rs1.getInt("user_id");
				}
				
				
				// now, begin of the transaction
				String orderQuery = "INSERT INTO orders (user_id,total_price) values (?, ?)";
				
				ordersStmt = conn.prepareStatement(orderQuery, Statement.RETURN_GENERATED_KEYS);
				double totalPrice = Double.parseDouble(request.getParameter("totalPrice"));
				ordersStmt.setInt(1, userId);
				ordersStmt.setDouble(2, totalPrice);
				ordersStmt.executeUpdate();
				// get the generated order id
				
				rs = ordersStmt.getGeneratedKeys();
				int orderId= 0;
				if(rs.next()) {
					orderId = rs.getInt(1);
				}
				//er_id, product_name, price, quantity) VALUES (?, ?, ?, ?)";
				// now, insert each item in that cart into oder_items
				String itemsTableQuery = "insert into order_items(order_id, product_name, price, quantity) values(?,?,?,?)";
				
				orderItemsStmt = conn.prepareStatement(itemsTableQuery);
				
				for(CartItem item: cart) {
					orderItemsStmt.setInt(1, orderId);
					orderItemsStmt.setString(2, item.getName());
					orderItemsStmt.setDouble(3, item.getPrice());
					orderItemsStmt.setInt(4, item.getQuantity());
					orderItemsStmt.executeUpdate();
					System.out.println("It's Working");
				}
				
				conn.commit();
				
				generateInvoice(orderId, userId, cart, totalprice);
				
				
				// now, clear the cart
				System.out.println(totalprice);
				
				session.removeAttribute("cart");
				
				response.sendRedirect("orderConfirmation.jsp?orderId="+orderId);
				
			} catch (Exception e) {
				e.printStackTrace();
				try {
					if(conn!=null) conn.rollback();
				} catch(Exception rollback) {
					rollback.printStackTrace();
				}
				response.sendRedirect("checkout.jsp?error=order_failed");
				
			} finally {
				try {
					if(rs!=null) rs.close();
					if(ordersStmt != null) ordersStmt.close();
					if(orderItemsStmt != null) orderItemsStmt.close();
					if(conn!= null) conn.close();
					
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
	
	}
	
	
	private void generateInvoice(int orderId, int userId, List<CartItem> cart, double totalAmount) {
	
			String invoiceDir = "C:/Java Programs/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/Sprint2/invoicces/";
			File directory = new File(invoiceDir);

			// Create directory if it does not exist
			if (!directory.exists()) {
			    directory.mkdirs();  // This creates the full directory structure if missing
			}
			
			String pdfPath = invoiceDir+"order_"+ orderId+".pdf";
//			PdfWriter.getInstance(document, new FileOutputStream(pdfPath));
			try (FileOutputStream fos = new FileOutputStream(new File(pdfPath))) {
				
				
				Document document = new Document();
				PdfWriter.getInstance(document, fos);
			
				
			document.open();
			
			
			Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18,BaseColor.BLACK);
			Paragraph title = new Paragraph("Order Invoice for Order : "+ orderId, titleFont);
			title.setAlignment(Element.ALIGN_CENTER);
			document.add(title);
			document.add(new Paragraph("\n"));
			
			document.add(new Paragraph("Order ID : "+orderId));
			document.add(new Paragraph("User ID : "+userId));
			document.add(new Paragraph(""));
			PdfPTable table = new PdfPTable(4);
			table.addCell("Product ID");
            table.addCell("Quantity");
            table.addCell("Price");
            table.addCell("Total");			

			
			for(CartItem item : cart) {
				table.addCell(String.valueOf(item.getId()));
				table.addCell(String.valueOf(item.getQuantity()));
				table.addCell(String.valueOf(item.getPrice()));
				table.addCell(String.valueOf(item.getQuantity() * item.getPrice()));
								
			}
			document.add(table);
			document.add(new Paragraph(""));
            document.add(new Paragraph("Total Amount: Rs. " + totalAmount));
            
            document.close();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

}
