package com.xp.bean;
import java.util.Date;
import java.util.List;

public class Order {
	private int orderId;
	private int userId;
	private Date order_date;
	private double total_price;
	private List<CartItem> cartItems;
	
	public Order() {
		
	}
	
	public Order(int orderId, int userId, Date order_date, double total_price, List<CartItem> cartItems )
	{
		super();
		this.orderId=orderId;
		this.userId=userId;
		this.order_date=order_date;
		this.total_price=total_price;
		this.cartItems=cartItems;
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public Date getOrder_date() {
		return order_date;
	}

	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}

	public double getTotal_price() {
		return total_price;
	}

	public void setTotal_price(double total_price) {
		this.total_price = total_price;
	}

	public List<CartItem> getCartItems() {
		return cartItems;
	}

	public void setCartItems(List<CartItem> cartItems) {
		this.cartItems = cartItems;
	}
	
	
	
	
	

}
