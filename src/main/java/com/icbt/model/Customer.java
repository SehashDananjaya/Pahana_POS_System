package com.icbt.model;

public class Customer {
	
	private int id;
	private String name;
	private String address;
	private String telphone;
	private String email;
	private int units;
	
	
	
	public Customer(String name, String address, String telphone,String email, int units) {
		super();
		this.name = name;
		this.address = address;
		this.telphone = telphone;
		this.email = email;
		this.units = units;
	}
	
	
	
	public Customer() {
		super();
	}



	public int getId() {
		return id;
	}



	public void setId(int id) {
		this.id = id;
	}



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	public String getAddress() {
		return address;
	}



	public void setAddress(String address) {
		this.address = address;
	}



	public String getTelphone() {
		return telphone;
	}



	public void setTelphone(String telphone) {
		this.telphone = telphone;
	}



	public String getEmail() {
		return email;
	}



	public void setEmail(String email) {
		this.email = email;
	}



	public int getUnits() {
		return units;
	}



	public void setUnits(int units) {
		this.units = units;
	}


	
	
	
}
	
	