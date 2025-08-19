package com.icbt.model;

public class Item {
	
	private int itemId;
	private String name;
	private String description;
	private double price;
	private int quantity;
	
	
	
	public Item(int productId, String name, String description, double price, int quantity) {
		super();
		this.itemId = productId;
		this.name = name;
		this.description = description;
		this.price = price;
		this.quantity = quantity;
	}
	
	
	public Item() {
		super();
	}


	public int getProductId() {
		return itemId;
	}
	public void setProductId(int productId) {
		this.itemId = productId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	
	
	
	
	

}