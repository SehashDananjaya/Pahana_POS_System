package com.icbt.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class Login extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // ✅ Replace with DB authentication in real app
        if ((username.equals("admin") && password.equals("admin123")) ||
            (username.equals("manager") && password.equals("manager123")) ||
            (username.equals("user") && password.equals("user123"))) {

            HttpSession session = request.getSession();
            session.setAttribute("username", username);

            if (username.equals("admin")) session.setAttribute("role", "admin");
            else if (username.equals("manager")) session.setAttribute("role", "manager");
            else session.setAttribute("role", "user");

            response.sendRedirect("dashboard.jsp");

        } else {
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("logout".equalsIgnoreCase(action)) {
            // ✅ Handle logout
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect("login.jsp");
            return;
        }

        // Check if already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("username") != null) {
            response.sendRedirect("dashboard.jsp");
        } else {
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
