package com.icbt.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.icbt.model.Customer;
import com.icbt.service.CustomerService;

@WebServlet("/customer")
public class CustomerController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private CustomerService customerService;

    public void init() throws ServletException {
        customerService = CustomerService.getInstance();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.equals("viewallcustomers")) {
            getAllCustomers(request, response);
        } else if (action.equals("edit")) {
            editCustomer(request, response);
        } else if (action.equals("delete")) {
            deleteCustomer(request, response);
        } else {
            response.getWriter().println("Invalid action!");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addCustomer(request, response);
            getAllCustomers(request, response);
        } else if ("update".equals(action)) {
            updateCustomer(request, response);
        } else {
            response.getWriter().println("Invalid action!");
        }
    }

    // ---------------- Private Methods ----------------

    private void addCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("cusname");
        String address = request.getParameter("cusaddress");
        String telephone = request.getParameter("custelephone");
        String email = request.getParameter("cusemail");

        Customer customer = new Customer(name, address, telephone, email);
        customerService.addCustomer(customer);

        System.out.println("Customer Added: " + name + ", " + address + ", " + telephone + ", " + email);
    }

    private void getAllCustomers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Customer> customerList = customerService.getAllCustomers();
        request.setAttribute("customers", customerList);
        request.setAttribute("activeSection", "customers");
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }

    private void editCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Customer customer = customerService.getCustomerById(id);
        request.setAttribute("customer", customer);
        request.setAttribute("activeSection", "customers");
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }

    private void updateCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("cusname");
        String address = request.getParameter("cusaddress");
        String telephone = request.getParameter("custelephone");
        String email = request.getParameter("cusemail");

        Customer customer = new Customer(id, name, address, telephone, email);
        customerService.updateCustomer(customer);

        getAllCustomers(request, response);
    }

    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        customerService.deleteCustomer(id);

        getAllCustomers(request, response);
    }
}
