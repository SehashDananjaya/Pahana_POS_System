package com.icbt.model;

import java.sql.Date;

import java.util.List;

public class Bill {
    private int billId;
    private int customerId;
    private Date billDate;
    private double totalAmount;
    private List<BillItem> billItems;
    
    // Additional fields for display purposes
    private String customerName;
    private String customerAddress;
    private String customerPhone;
    private String customerEmail;

    // Constructors
    public Bill() {}
    
    

    public Bill(int customerId, Date billDate) {
		super();
		this.customerId = customerId;
		this.billDate = billDate;
	}



	public Bill(int billId, int customerId, Date billDate, double totalAmount) {
        this.billId = billId;
        this.customerId = customerId;
        this.billDate = billDate;
        this.totalAmount = totalAmount;
    }

    public Bill(int billId, int customerId, Date billDate, double totalAmount, List<BillItem> billItems) {
        this.billId = billId;
        this.customerId = customerId;
        this.billDate = billDate;
        this.totalAmount = totalAmount;
        this.billItems = billItems;
    }

    // Getters and Setters
    public int getBillId() {
        return billId;
    }

    public void setBillId(int billId) {
        this.billId = billId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public Date getBillDate() {
        return billDate;
    }

    public void setBillDate(Date billDate) {
        this.billDate = billDate;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public List<BillItem> getBillItems() {
        return billItems;
    }

    public void setBillItems(List<BillItem> billItems) {
        this.billItems = billItems;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerAddress() {
        return customerAddress;
    }

    public void setCustomerAddress(String customerAddress) {
        this.customerAddress = customerAddress;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    @Override
    public String toString() {
        return "Bill{" +
                "billId=" + billId +
                ", customerId=" + customerId +
                ", billDate='" + billDate + '\'' +
                ", totalAmount=" + totalAmount +
                ", customerName='" + customerName + '\'' +
                '}';
    }
}