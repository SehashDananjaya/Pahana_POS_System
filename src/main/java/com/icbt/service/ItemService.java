package com.icbt.service;

import java.sql.SQLException;
import java.util.List;

import com.icbt.dao.ItemDAO;
import com.icbt.model.Item;



public class ItemService {

	private static ItemService instance;
    private ItemDAO productDAO;

    private ItemService() {
        this.productDAO = new ItemDAO();
    }

    public static ItemService getInstance() {
        if (instance == null) {
            synchronized (ItemService.class) {
                if (instance == null) {
                    instance = new ItemService();
                }
            }
        }
        return instance;
    }

    public void addProduct(Item item) {
        productDAO.addProduct(item);
    }

    public List<Item> getAllProducts() throws SQLException {
        return productDAO.getAllProducts();
    }

    public Item getProductById(int id) {
        return productDAO.getProductById(id);
    }

    public void updateProduct(Item product) {
        productDAO.updateProduct(product);
    }

    public void deleteProduct(int id) {
        productDAO.deleteProduct(id);
    }
	}
