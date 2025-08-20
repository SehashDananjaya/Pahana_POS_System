package com.icbt.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.icbt.dao.DBConnectionFactory;

@WebServlet("/ReportController")
public class ReportController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ReportController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String reportType = request.getParameter("reportType");

        try {Connection conn = DBConnectionFactory.getConnection(); 

            if ("daily".equals(reportType)) {
                String sql = "SELECT b.bill_id, c.name AS customer_name, b.bill_date, b.total_amount " +
                             "FROM bills b " +
                             "JOIN customer c ON b.customer_id = c.customer_id " +
                             "WHERE b.bill_date = CURDATE()";

                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
                request.setAttribute("reportResult", rs);
                request.getRequestDispatcher("reports.jsp").forward(request, response);

            } else if ("weekly".equals(reportType)) {
                String sql = "SELECT b.bill_id, c.name AS customer_name, b.bill_date, b.total_amount " +
                             "FROM bills b " +
                             "JOIN customer c ON b.customer_id = c.customer_id " +
                             "WHERE b.bill_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)";

                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
                request.setAttribute("reportResult", rs);
                request.getRequestDispatcher("reports.jsp").forward(request, response);

            } else if ("monthly".equals(reportType)) {
                String sql = "SELECT b.bill_id, c.name AS customer_name, b.bill_date, b.total_amount " +
                             "FROM bills b " +
                             "JOIN customer c ON b.customer_id = c.customer_id " +
                             "WHERE MONTH(b.bill_date) = MONTH(CURDATE()) " +
                             "AND YEAR(b.bill_date) = YEAR(CURDATE())";

                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
                request.setAttribute("reportResult", rs);
                request.getRequestDispatcher("reports.jsp").forward(request, response);

            } else if ("lowStock".equals(reportType)) {
                String sql = "SELECT product_id, name, quantity, price, " +
                             "CASE WHEN quantity < 10 THEN 'Low Stock' ELSE 'OK' END AS status " +
                             "FROM product " +
                             "ORDER BY quantity ASC";

                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
                request.setAttribute("reportResult", rs);
                request.getRequestDispatcher("inventoryReports.jsp").forward(request, response);

            } else if ("inventorySummary".equals(reportType)) {
                String sql = "SELECT product_id, name, quantity, price, " +
                             "CASE WHEN quantity < 10 THEN 'Low Stock' ELSE 'OK' END AS status " +
                             "FROM product " +
                             "ORDER BY name ASC";

                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
                request.setAttribute("reportResult", rs);
                request.getRequestDispatcher("inventoryReports.jsp").forward(request, response);

            } else if ("salesAnalytics".equals(reportType)) {
                String sql = "SELECT p.name AS product_name, SUM(bi.quantity) AS total_sold, SUM(bi.subtotal) AS total_amount " +
                             "FROM billitems bi " +
                             "JOIN product p ON bi.item_id = p.product_id " +
                             "GROUP BY bi.item_id " +
                             "ORDER BY total_sold DESC";

                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
                request.setAttribute("reportResult", rs);
                request.getRequestDispatcher("analyticsReports.jsp").forward(request, response);

            } else if ("customerAnalytics".equals(reportType)) {
                // 🔥 New Customer Analytics Report
                String sql = "SELECT c.name AS customer_name, SUM(bi.quantity) AS total_units " +
                             "FROM customer c " +
                             "JOIN bills b ON c.customer_id = b.customer_id " +
                             "JOIN billitems bi ON b.bill_id = bi.bill_id " +
                             "GROUP BY c.customer_id, c.name " +
                             "ORDER BY total_units DESC";

                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
                request.setAttribute("reportResult", rs);
                request.getRequestDispatcher("customerAnalytics.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
