package com.icbt.service;

import java.util.List;

import com.icbt.dao.CustomerDAO;
import com.icbt.model.Customer;

public class CustomerService {

	private static CustomerService instance;

	private CustomerDAO customerDAO;

	private CustomerService() {
		this.customerDAO = new CustomerDAO();
	}

	public static CustomerService getInstance() {
		if (instance == null) {
			synchronized (CustomerService.class) {
				if (instance == null) {
					instance = new CustomerService();
				}
			}
		}
		return instance;
	}

	public void addCustomer(Customer customer) {
		customerDAO.addCustomer(customer);
	}

	public List<Customer> getAllCustomers() {
		return customerDAO.getAllCustomers();
	}

	public Customer getCustomerById(int id) {
		return customerDAO.getCustomerById(id);
	}

	public void updateCustomer(Customer customer) {
		customerDAO.updateCustomer(customer);
	}

	public void deleteCustomer(int id) {
		customerDAO.deleteCustomer(id);
	}
}
