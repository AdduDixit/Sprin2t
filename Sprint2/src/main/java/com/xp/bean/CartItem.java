package com.xp.bean;

public class CartItem {
	private int id;
	private int quantity;
	private String name;
	private double price;
	
	
	public CartItem(int id, int quantity, String name, double price) {
		super();
		this.id = id;
		this.quantity = quantity;
		this.name = name;
		this.price = price;
	}
	
	
	public int getQuantity() {
		return quantity;
	}
	
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	public int getId() {
		return id;
	}
	
	public String getName() {
		return name;
	}
	
	public double getPrice() {
		return price;
	}
}
