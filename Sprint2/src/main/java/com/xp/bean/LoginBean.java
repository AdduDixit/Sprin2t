package com.xp.bean;

public class LoginBean {
	
	public LoginBean() {
		//
	}
	
	private String username;
	private String password;
	private int userId;
	
	public int getUserId() { return userId;}
	public void setUserId(int userId) {this.userId= userId;}
	
	public LoginBean(String username, String password) {
		super();
		this.username = username;
		this.password = password;
	}


	public String getUsername() {
		return username;
	}


	public void setUsername(String username) {
		this.username = username;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}
	
	
	

}
