package com.icbt.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.icbt.model.Item;

public class ItemDAO {
	public void addProduct(Item product) {
        String query = "INSERT INTO Product (product_id, name, price, description, quantity) VALUES (?,?, ?, ?,?)";

        try 
        {   Connection connection = DBConnectionFactory.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, product.getQuantity());
            statement.setString(2, product.getName());
            statement.setDouble(3, product.getPrice());
            statement.setString(4, product.getDescription());
            statement.setInt(5, product.getQuantity());
            statement.executeUpdate();
        } 
        catch (SQLException e) 
        {
            e.printStackTrace();
        }
    }

    public List<Item> getAllProducts() {
        List<Item> products = new ArrayList<>();
        String query = "SELECT * FROM Product";

        
		try {
			Connection connection = DBConnectionFactory.getConnection();
	        Statement statement;
			statement = connection.createStatement();
			
			 ResultSet resultSet = statement.executeQuery(query);
		        while (resultSet.next()) 
		        {
		        	int id = resultSet.getInt("product_id");
		        	String name = resultSet.getString("name");
		        	double price = resultSet.getDouble("price");
		        	String desc = resultSet.getString("description");
		        	int quantity= resultSet.getInt("quantity");
		        	products.add(new Item(id, name, desc, price, quantity));
		        }

		       
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return products;
        
    }
    
    public Item getProductById(int id) {
        String query = "SELECT * FROM Product WHERE product_id = ?";
        Item product = null;

        try {
            Connection connection = DBConnectionFactory.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                String name = resultSet.getString("name");
                double price = resultSet.getDouble("price");
                String desc = resultSet.getString("description");
                int quantity= resultSet.getInt("quantity");
                product = new Item(id, name, desc, price, quantity);
            }
        } 
        catch (SQLException e) {
            e.printStackTrace();
        }

        return product;
    }

    public void updateProduct(Item product) {
        String query = "UPDATE Product SET name = ?, price = ?, description = ?, quantity = ? WHERE product_id = ?";

        try {
            Connection connection = DBConnectionFactory.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, product.getName());
            statement.setDouble(2, product.getPrice());
            statement.setString(3, product.getDescription());
            statement.setInt(4, product.getQuantity());
            statement.setInt(5, product.getProductId());
            statement.executeUpdate();
        } 
        catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteProduct(int id) {
        String query = "DELETE FROM Product WHERE product_id = ?";

        try {
            Connection connection = DBConnectionFactory.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            statement.executeUpdate();
        } 
        catch (SQLException e) {
            e.printStackTrace();
        }
    }
}