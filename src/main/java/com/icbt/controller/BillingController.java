package com.icbt.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.icbt.model.Bill;
import com.icbt.model.BillItem;
import com.icbt.model.Customer;
import com.icbt.model.Item;
import com.icbt.service.BillingService;
import com.icbt.service.CustomerService;
import com.icbt.service.ItemService;

@WebServlet("/billing")
public class BillingController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private BillingService billingService;
    private CustomerService customerService;
    private ItemService itemService;

    public void init() throws ServletException {
        billingService = BillingService.getInstance();
        customerService = CustomerService.getInstance();
        itemService = ItemService.getInstance();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.equals("viewbilling")) {
            showBillingPage(request, response);
        } else if ("deleteItem".equals(action)) {
            deleteBillItem(request, response); // handle delete here
        } 
        else if ("cancelBill".equals(action)) {
            cancelBill(request, response);
        } else if ("saveBill".equals(action)) {   // <-- Add this
            saveBill(request, response);
        }else {
            response.getWriter().println("Invalid action!");
        }
    }
    
    

   
		
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("createBill".equals(action)) {
			createBIll(request,response);
		}

        if ("table".equals(action)) {
            generateTable(request, response);
            
        }else {
            response.getWriter().println("Invalid action!");
        }
    }
	
	private void saveBill(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
		
		System.out.println("save bill");
		
	    String billIdStr = request.getParameter("billId");
	    String customerName = request.getParameter("customerName");
	    String billDateStr = request.getParameter("billDate");

	    if (billIdStr == null || billIdStr.isEmpty()) {
	        response.getWriter().println("No bill to save.");
	        return;
	    }

	    try {
	        int billId = Integer.parseInt(billIdStr);

	        // Get all items from this bill
	        List<BillItem> billItems = billingService.getBillItemsByBillId3(billId);

	        if (billItems.isEmpty()) {
	            response.getWriter().println("Cannot save an empty bill.");
	            return;
	        }

	        // Calculate total
	        double totalAmount = 0;
	        for (BillItem item : billItems) {
	            totalAmount += item.getSubtotal();
	        }

	        // Save the bill with total amount
	        billingService.saveFinalBill(billId, totalAmount);

	     // Clear session/cart info
			HttpSession session = request.getSession();
			session.removeAttribute("cart");
			session.removeAttribute("billId");
			session.removeAttribute("customerName");
			session.removeAttribute("billDate");

			request.setAttribute("activeSection", "billing");
			showBillingPage(request, response);
	     
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
	
	private void cancelBill(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    String billIdStr = request.getParameter("billId");
	    if (billIdStr == null || billIdStr.isEmpty()) {
	        response.getWriter().println("No bill selected to cancel.");
	        return;
	    }

	    int billId = Integer.parseInt(billIdStr);
		billingService.deleteBillItemsByBillId(billId);

		// Clear session/cart info
		HttpSession session = request.getSession();
		session.removeAttribute("cart");
		session.removeAttribute("billId");
		session.removeAttribute("customerName");
		session.removeAttribute("billDate");

		request.setAttribute("activeSection", "billing");
		showBillingPage(request, response);
	}
	
	public void deleteBillItem(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException {
	    try {
	        int billItemId = Integer.parseInt(request.getParameter("billItemId"));
	        int billId = Integer.parseInt(request.getParameter("billId"));

	        // Delete the item
	        billingService.deleteBillItem(billItemId);

	        // Reload bill items
	        List<BillItem> billItems = billingService.getBillItemsByBillId3(billId);
	        request.setAttribute("billItems", billItems);

	        // Recalculate total
	        double totalAmount = billingService.getTotalAmountByBillId(billId);
	        request.setAttribute("totalAmount", totalAmount);

	        // ✅ Reload products for dropdown
	        List<Item> items = itemService.getAllProducts();
	        request.setAttribute("items", items);

	        // Keep bill info
	        request.setAttribute("billId", billId);
	        request.setAttribute("customerName", request.getParameter("customerName"));
	        request.setAttribute("billDate", request.getParameter("billDate"));

	        // Show billing section
	        request.setAttribute("activeSection", "billing");

	        RequestDispatcher dispatcher = request.getRequestDispatcher("dashboard.jsp");
	        dispatcher.forward(request, response);
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.sendRedirect("dashboard.jsp?error=DeleteFailed");
	    }
	}
    private void createBIll(HttpServletRequest request, HttpServletResponse response) {
    	
    	
    	
    	
		try {
			
			String customerValue = request.getParameter("customerId"); 
			// e.g. "123,John Perera"

			String[] parts = customerValue.split(",");
			int cusid = Integer.parseInt(parts[0]);
			String customerName = parts[1];
			
			
			
	    	
	    	
	    	String billDateStr = request.getParameter("billDate");
	    	
	    	Date date = java.sql.Date.valueOf(billDateStr);
	    	
	    	Bill bill = new Bill(cusid,date);
	    	
			int billid = billingService.saveBillAndGetId(bill);
			
			List<Item> items = itemService.getAllProducts();
			request.setAttribute("items", items);
			
			request.setAttribute("billId", billid);
			request.setAttribute("customerName", customerName);
			request.setAttribute("billDate", billDateStr);
			request.setAttribute("activeSection", "billing");
			request.getRequestDispatcher("dashboard.jsp").forward(request, response);
			
			System.out.println(billid);
			
			
		} catch (SQLException | ServletException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    	
		
	}

    private void generateTable(HttpServletRequest request, HttpServletResponse response) {
        try {
            int billid = Integer.parseInt(request.getParameter("billId"));
            int itemId = Integer.parseInt(request.getParameter("itemId"));
            int quantity = Integer.parseInt(request.getParameter("itemQty"));
            double unitPrice = Double.parseDouble(request.getParameter("itemPrice"));
            
            request.setAttribute("customerName", request.getParameter("customerName"));
            request.setAttribute("billDate", request.getParameter("billDate"));

            double subtotal = quantity * unitPrice;

            BillItem billItem = new BillItem();
            billItem.setBillId(billid);
            billItem.setItemId(itemId);
            billItem.setQuantity(quantity);
            billItem.setUnitPrice(unitPrice);
            billItem.setSubtotal(subtotal);

            billingService.saveBillItem(billItem);
            
            double totalAmount = billingService.getTotalAmountByBillId(billid);
            request.setAttribute("totalAmount", totalAmount);

            // Load items again for dropdown
            List<Item> items = itemService.getAllProducts();
            request.setAttribute("items", items);
            
            
            //load table----------------------------------
            
           // int billId = Integer.parseInt(request.getParameter("billId"));

            List<BillItem> billItems = billingService.getBillItemsByBillId3(billid);
            request.setAttribute("billItems", billItems);

            // Keep bill info in request (or from hidden inputs)
            request.setAttribute("billId", billid);
            request.setAttribute("customerName", request.getParameter("customerName"));
            request.setAttribute("billDate", request.getParameter("billDate"));
            request.setAttribute("activeSection", "billing");

            request.getRequestDispatcher("dashboard.jsp").forward(request, response);

        } catch (SQLException | ServletException | IOException e) {
            e.printStackTrace();
        }
    }

	// ---------------- Private Methods ----------------

    private void showBillingPage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Load customers and items for dropdowns
		List<Customer> customers = customerService.getAllCustomers();
         // List<Item> items = itemService.getAllProducts();
		
		
		request.setAttribute("customers", customers);
		//request.setAttribute("items", items);
		request.setAttribute("activeSection", "billing");
		request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }

//    private void generateBill(HttpServletRequest request, HttpServletResponse response) 
//            throws ServletException, IOException {
//        try {
//            int customerId = Integer.parseInt(request.getParameter("customerId"));
//            String billDate = request.getParameter("billDate");
//
//            // ✅ Get arrays of parameters
//            String[] itemIds = request.getParameterValues("itemId");
//            String[] quantities = request.getParameterValues("quantity");
//            String[] prices = request.getParameterValues("price");
//
//            if (itemIds == null || itemIds.length == 0) {
//                response.getWriter().println("No items selected for billing!");
//                return;
//            }
//
//            List<BillItem> billItems = new ArrayList<>();
//            double totalAmount = 0.0;
//
//            // ✅ Loop through items
//            for (int i = 0; i < itemIds.length; i++) {
//                int itemId = Integer.parseInt(itemIds[i]);
//                int quantity = Integer.parseInt(quantities[i]);
//                double price = Double.parseDouble(prices[i]);
//
//                double subtotal = quantity * price;
//                totalAmount += subtotal;
//
//                BillItem billItem = new BillItem(0, itemId, quantity, price, subtotal);
//                billItems.add(billItem);
//            }
//
//            // ✅ Create Bill and save
//            Bill bill = new Bill(0, customerId, billDate, totalAmount, billItems);
//            //int billId = billingService.generateBill(bill);
//
//            if (billId > 0) {
//                request.setAttribute("billId", billId);
//                request.setAttribute("message", "Bill generated successfully! Bill ID: " + billId);
//                showBillingPage(request, response);
//            } else {
//                response.getWriter().println("Error generating bill!");
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.getWriter().println("Error generating bill: " + e.getMessage());
//        }
//    }

//    private void getAllBills(HttpServletRequest request, HttpServletResponse response) 
//            throws ServletException, IOException {
//        try {
//            List<Bill> bills = billingService.getAllBills();
//            request.setAttribute("bills", bills);
//            request.setAttribute("activeSection", "billing");
//            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
//        } catch (SQLException e) {
//            e.printStackTrace();
//            response.getWriter().println("Error retrieving bills: " + e.getMessage());
//        }
//    }
//
//    private void searchBills(HttpServletRequest request, HttpServletResponse response) 
//            throws ServletException, IOException {
//        String searchTerm = request.getParameter("searchTerm");
//        String searchType = request.getParameter("searchType");
//        
//        try {
//            List<Bill> bills;
//            if ("customerId".equals(searchType)) {
//                int customerId = Integer.parseInt(searchTerm);
//                bills = billingService.getBillsByCustomerId(customerId);
//            } else if ("date".equals(searchType)) {
//                bills = billingService.getBillsByDate(searchTerm);
//            } else {
//                bills = billingService.getAllBills();
//            }
//            
//            request.setAttribute("bills", bills);
//            request.setAttribute("searchPerformed", true);
//            request.setAttribute("activeSection", "billing");
//            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
//        } catch (SQLException e) {
//            e.printStackTrace();
//            response.getWriter().println("Error searching bills: " + e.getMessage());
//        }
//    }
//
//    private void viewBill(HttpServletRequest request, HttpServletResponse response) 
//            throws ServletException, IOException {
//        try {
//            int billId = Integer.parseInt(request.getParameter("id"));
//            Bill bill = billingService.getBillById(billId);
//            
//            if (bill != null) {
//                request.setAttribute("selectedBill", bill);
//            }
//            
//            request.setAttribute("activeSection", "billing");
//            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
//        } catch (SQLException e) {
//            e.printStackTrace();
//            response.getWriter().println("Error retrieving bill: " + e.getMessage());
//        }
//    }
//
//    private void getCustomerByAccount(HttpServletRequest request, HttpServletResponse response) 
//            throws ServletException, IOException {
//        try {
//            int customerId = Integer.parseInt(request.getParameter("customerId"));
//            Customer customer = customerService.getCustomerById(customerId);
//            
//            if (customer != null) {
//                response.setContentType("application/json");
//                response.getWriter().write("{\"success\": true, \"customer\": {" +
//                    "\"id\": " + customer.getId() + "," +
//                    "\"name\": \"" + customer.getName() + "\"," +
//                    "\"address\": \"" + customer.getAddress() + "\"," +
//                    "\"telephone\": \"" + customer.getTelephone() + "\"," +
//                    "\"email\": \"" + customer.getEmail() + "\"" +
//                    "}}");
//            } else {
//                response.setContentType("application/json");
//                response.getWriter().write("{\"success\": false, \"message\": \"Customer not found\"}");
//            }
//        } catch (Exception e) {
//            response.setContentType("application/json");
//            response.getWriter().write("{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}");
//        }
//    }
//
//    private void getItemByCode(HttpServletRequest request, HttpServletResponse response) 
//            throws ServletException, IOException {
//        try {
//            int itemId = Integer.parseInt(request.getParameter("itemId"));
//            Item item = itemService.getProductById(itemId);
//            
//            if (item != null) {
//                response.setContentType("application/json");
//                response.getWriter().write("{\"success\": true, \"item\": {" +
//                    "\"id\": " + item.getProductId() + "," +
//                    "\"name\": \"" + item.getName() + "\"," +
//                    "\"description\": \"" + item.getDescription() + "\"," +
//                    "\"price\": " + item.getPrice() + "," +
//                    "\"quantity\": " + item.getQuantity() +
//                    "}}");
//            } else {
//                response.setContentType("application/json");
//                response.getWriter().write("{\"success\": false, \"message\": \"Item not found\"}");
//            }
//        } catch (Exception e) {
//            response.setContentType("application/json");
//            response.getWriter().write("{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}");
//        }
//    }
}