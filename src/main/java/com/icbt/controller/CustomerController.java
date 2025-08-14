package com.icbt.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.icbt.model.Product;


@WebServlet("/customer")
public class CustomerController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public CustomerController() {
        super();
     
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	request.getRequestDispatcher("/WEB-INF/view/addCustomer.jsp").forward(request, response);
		
		//String action = request.getParameter("action");

       // if ("add".equalsIgnoreCase(action)) {
		
		
//        if (action == null || action.equals("list")) {
//            // Forward to JSP in WEB-INF/view
//            request.getRequestDispatcher("/WEB-INF/view/addCustomer.jsp")
//                   .forward(request, response);
//        } else {
//            response.getWriter().println("Invalid action!");
//        }
		
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
		int id = Integer.parseInt(request.getParameter("cusid"));
        String name = request.getParameter("cusname");
        String address = request.getParameter("cusaddress");
        String telphone = request.getParameter("custelephone");
        String email = request.getParameter("cusemail");
        //int units = Integer.parseInt(request.getParameter("cusunits"));

        // Here you would save the data to DB (DAO logic)
        System.out.println("Customer Added: " + id + ", " + name + ", " + address + ", " + telphone + ", " + email);

        // Redirect after success
        response.sendRedirect(request.getContextPath() + "/customer?action=add&success=true");
    }
	
	

}
