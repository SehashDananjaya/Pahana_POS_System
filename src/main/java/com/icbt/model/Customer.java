package com.icbt.model;

public class Customer {
	
	private int id;
	private String name;
	private String address;
	private String telephone;
	private String email;
	private int units;
	
	
	
	public Customer(String name, String address, String telephone,String email) {
		super();
		this.name = name;
		this.address = address;
		this.telephone = telephone;
		this.email = email;
		
	}
	
	
	
	
	
	public Customer(int id, String name, String address, String telephone, String email, int units) {
		super();
		this.id = id;
		this.name = name;
		this.address = address;
		this.telephone = telephone;
		this.email = email;
		this.units = units;
	}





	public Customer(int id, String name, String address, String telephone, String email) {
		super();
		this.id = id;
		this.name = name;
		this.address = address;
		this.telephone = telephone;
		this.email = email;
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



	public String getTelephone() {
		return telephone;
	}



	public void setTelephone(String telephone) {
		this.telephone = telephone;
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
	
	