package com.icbt.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.icbt.model.Customer;

public class CustomerDAO {
	
	public void addCustomer(Customer customer) {
        String query = "INSERT INTO Customer (name, address, telephone, email) VALUES (?, ?, ?, ?)";

        try {
            Connection connection = DBConnectionFactory.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, customer.getName());
            statement.setString(2, customer.getAddress());
            statement.setString(3, customer.getTelephone());
            statement.setString(4, customer.getEmail());
           // statement.setInt(5, customer.getUnits());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        String query = "SELECT * FROM Customer";

        try {
            Connection connection = DBConnectionFactory.getConnection();
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);

            while (resultSet.next()) {
                int id = resultSet.getInt("customer_id");
                String name = resultSet.getString("name");
                String address = resultSet.getString("address");
                String telphone = resultSet.getString("telephone");
                String email = resultSet.getString("email");
                //int units = resultSet.getInt("units");

                Customer customer = new Customer(name, address, telphone, email);
                customer.setId(id);
                customers.add(customer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return customers;
    }

    public Customer getCustomerById(int id) {
        String query = "SELECT * FROM Customer WHERE id = ?";
        Customer customer = null;

        try {
            Connection connection = DBConnectionFactory.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                String name = resultSet.getString("name");
                String address = resultSet.getString("address");
                String telphone = resultSet.getString("telephone");
                String email = resultSet.getString("email");
                int units = resultSet.getInt("units");

                customer = new Customer(name, address, telphone, email);
                customer.setId(id);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return customer;
    }

    public void updateCustomer(Customer customer) {
        String query = "UPDATE Customer SET name = ?, address = ?, telphone = ?, email = ?, units = ? WHERE id = ?";

        try {
            Connection connection = DBConnectionFactory.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, customer.getName());
            statement.setString(2, customer.getAddress());
            statement.setString(3, customer.getTelephone());
            statement.setString(4, customer.getEmail());
            statement.setInt(5, customer.getUnits());
            statement.setInt(6, customer.getId());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteCustomer(int id) {
        String query = "DELETE FROM Customer WHERE id = ?";

        try {
            Connection connection = DBConnectionFactory.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public int getLastId() {
        String query = "SELECT MAX(id) AS last_id FROM Customer";
        int lastId = 0;

        try {
            Connection connection = DBConnectionFactory.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                lastId = resultSet.getInt("last_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lastId;
    }

}
