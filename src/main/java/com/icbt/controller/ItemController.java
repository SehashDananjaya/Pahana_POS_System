package com.icbt.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.icbt.model.Item;
import com.icbt.service.ItemService;

@WebServlet("/item")
public class ItemController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ItemService itemService;

    public void init() throws ServletException {
        itemService = ItemService.getInstance();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.equals("viewallitems")) {
            getAllItems(request, response);
        } else if (action.equals("edit")) {
            editItem(request, response);
        } else if (action.equals("delete")) {
            deleteItem(request, response);
        } else {
            response.getWriter().println("Invalid action!");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addItem(request, response);
            
            
            getAllItems(request, response);
        } else if ("update".equals(action)) {
            updateItem(request, response);
        } else {
            response.getWriter().println("Invalid action!");
        }
    }

    // ---------------- Private Methods ----------------

    private void addItem(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	int product_id = Integer.parseInt(request.getParameter("itemId"));
        String name = request.getParameter("itemName");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Item item = new Item(product_id, name, description, price, quantity);
        itemService.addProduct(item);

        System.out.println("Item Added: " + product_id + ", " + price + ", " + quantity);
    }

    private void getAllItems(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Item> itemList;
		try {
			itemList = itemService.getAllProducts();
			request.setAttribute("items", itemList);
	        request.setAttribute("activeSection", "items");
	        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
    }

    private void editItem(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Item item = itemService.getProductById(id);
        request.setAttribute("item", item);
        request.setAttribute("activeSection", "items");
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }

    private void updateItem(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("itemName");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Item item = new Item(id, name, description, price, quantity);
        itemService.updateProduct(item);

        getAllItems(request, response);
    }

    private void deleteItem(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        itemService.deleteProduct(id);

        getAllItems(request, response);
    }
}
