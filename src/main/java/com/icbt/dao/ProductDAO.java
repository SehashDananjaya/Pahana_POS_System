package com.icbt.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.icbt.model.Product;

public class ProductDAO {
	public void addProduct(Product product) {
        String query = "INSERT INTO Product (name, price, description) VALUES (?, ?, ?)";

        try 
        {   Connection connection = DBConnectionFactory.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, product.getName());
            statement.setDouble(2, product.getPrice());
            statement.setString(3, product.getDescription());
            statement.executeUpdate();
        } 
        catch (SQLException e) 
        {
            e.printStackTrace();
        }
    }

    public List<Product> getAllProducts() throws SQLException {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM Product";

        Connection connection = DBConnectionFactory.getConnection();
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(query);
        while (resultSet.next()) 
        {
        	int id = resultSet.getInt("product_id");
        	String name = resultSet.getString("name");
        	double price = resultSet.getDouble("price");
        	String desc = resultSet.getString("description");
        	products.add(new Product(id, name, desc, price));
        }

        return products;
    }
    
    public Product getProductById(int id) {
        String query = "SELECT * FROM Product WHERE product_id = ?";
        Product product = null;

        try {
            Connection connection = DBConnectionFactory.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                String name = resultSet.getString("name");
                double price = resultSet.getDouble("price");
                String desc = resultSet.getString("description");
                product = new Product(id, name, desc, price);
            }
        } 
        catch (SQLException e) {
            e.printStackTrace();
        }

        return product;
    }

    public void updateProduct(Product product) {
        String query = "UPDATE Product SET name = ?, price = ?, description = ? WHERE product_id = ?";

        try {
            Connection connection = DBConnectionFactory.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, product.getName());
            statement.setDouble(2, product.getPrice());
            statement.setString(3, product.getDescription());
            statement.setInt(4, product.getProductId());
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