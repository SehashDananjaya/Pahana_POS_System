package com.icbt.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.icbt.model.Customer;
import com.icbt.model.Product;
import com.icbt.service.CustomerService;



@WebServlet("/customer")
public class CustomerController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	private CustomerService customerService;
    
	public void init() throws ServletException {
        customerService = CustomerService.getInstance();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	//request.getRequestDispatcher("/WEB-INF/view/addCustomer.jsp").forward(request, response);
		
	String action = request.getParameter("action");
    if (action == null || action.equals("viewallcustomers")) {
    	getAllCustomers(request, response);
    } else if (action.equals("add")) {
    	response.getWriter().println("Invalid action!");
    }
}
		
	

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String action = request.getParameter("action");
		
		if (action.equals("add")) {
			
            addCustomer(request, response);
       
            
        } else {
            response.getWriter().println("Invalid action!");
        }
	}
	
	private void addCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//int id = Integer.parseInt(request.getParameter("cusid"));
        String name = request.getParameter("cusname");
        String address = request.getParameter("cusaddress");
        String telphone = request.getParameter("custelephone");
        String email = request.getParameter("cusemail");
        //int units = Integer.parseInt(request.getParameter("cusunits"));

        Customer customer = new Customer(name,address,telphone,email);
        
        CustomerService customerservice= CustomerService.getInstance();
        customerservice.addCustomer(customer);
        
        
        
        System.out.println("Customer Added: " + name + ", " + address + ", " + telphone + ", " + email);

        // Redirect after success
        response.sendRedirect(request.getContextPath() + "/customer?action=add&success=true");
    }
	
	private void getAllCustomers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Customer> customerList = new ArrayList<Customer>();
		customerList = customerService.getAllCustomers();
		request.setAttribute("customers", customerList);
    	
        request.getRequestDispatcher("WEB-INF/view/customerview.jsp").forward(request, response);
    }
		
	

}
