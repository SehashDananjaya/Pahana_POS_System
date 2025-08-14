package com.icbt.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public Login() {
        super();
       
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		   String error = "";
		    if ("POST".equalsIgnoreCase(request.getMethod())) {
		        String loginUsername = request.getParameter("username");
		        String loginPassword = request.getParameter("password");
		        
		        if (loginUsername != null && loginPassword != null) {
		            // Simple authentication (replace with database validation)
		            if (("admin".equals(loginUsername) && "admin123".equals(loginPassword)) ||
		                ("manager".equals(loginUsername) && "manager123".equals(loginPassword)) ||
		                ("user".equals(loginUsername) && "user123".equals(loginPassword))) {
		                
		                //session.setAttribute("username", loginUsername);
		                //session.setAttribute("loginTime", new java.util.Date());
		                response.sendRedirect("home.jsp");
		                return;
		            } else {
		            	
		            	String errorMessage = "Invalid username or password"; // your error
		            	request.setAttribute("error", errorMessage);

		            	// forward back to the JSP
		            	RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
		            	dispatcher.forward(request, response);
		            	
		            	//response.sendRedirect("login.jsp");
		            	
		            }
		        }
		    }
		    
		    
		    
		doGet(request, response);
	}

}
