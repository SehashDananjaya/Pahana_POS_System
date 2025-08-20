package com.icbt.controller;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.*;

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
        boolean saveToFile = "true".equals(request.getParameter("saveFile"));
        String fileName = reportType + "_report.txt";
        String forwardPage = "reports.jsp"; // default

        try {Connection conn = DBConnectionFactory.getConnection();

            String sql = getSQLForReport(reportType);
            forwardPage = getForwardPage(reportType);

            if (sql == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid report type");
                return;
            }

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            if (saveToFile) {
                // Save report in project folder or Documents
                String savePath = "C:/Users/Public/" + fileName;
                File file = new File(savePath);
                file.getParentFile().mkdirs(); // Create directories if missing
                saveResultSetToFile(rs, savePath);
                response.getWriter().println("Report saved successfully at " + savePath);
            } else {
                request.setAttribute("reportResult", rs);
                request.getRequestDispatcher(forwardPage).forward(request, response);
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

    private String getSQLForReport(String reportType) {
        switch (reportType) {
            case "daily":
                return "SELECT b.bill_id, c.name AS customer_name, b.bill_date, b.total_amount " +
                        "FROM bills b JOIN customer c ON b.customer_id = c.customer_id " +
                        "WHERE b.bill_date = CURDATE()";
            case "weekly":
                return "SELECT b.bill_id, c.name AS customer_name, b.bill_date, b.total_amount " +
                        "FROM bills b JOIN customer c ON b.customer_id = c.customer_id " +
                        "WHERE b.bill_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)";
            case "monthly":
                return "SELECT b.bill_id, c.name AS customer_name, b.bill_date, b.total_amount " +
                        "FROM bills b JOIN customer c ON b.customer_id = c.customer_id " +
                        "WHERE MONTH(b.bill_date) = MONTH(CURDATE()) AND YEAR(b.bill_date) = YEAR(CURDATE())";
            case "lowStock":
                return "SELECT product_id, name, quantity, price, " +
                        "CASE WHEN quantity < 10 THEN 'Low Stock' ELSE 'OK' END AS status " +
                        "FROM product ORDER BY quantity ASC";
            case "inventorySummary":
                return "SELECT product_id, name, quantity, price, " +
                        "CASE WHEN quantity < 10 THEN 'Low Stock' ELSE 'OK' END AS status " +
                        "FROM product ORDER BY name ASC";
            case "salesAnalytics":
                return "SELECT p.name AS product_name, SUM(bi.quantity) AS total_sold, SUM(bi.subtotal) AS total_amount " +
                        "FROM billitems bi JOIN product p ON bi.item_id = p.product_id " +
                        "GROUP BY bi.item_id ORDER BY total_sold DESC";
            case "customerAnalytics":
                return "SELECT c.name AS customer_name, SUM(bi.quantity) AS total_units " +
                        "FROM customer c " +
                        "JOIN bills b ON c.customer_id = b.customer_id " +
                        "JOIN billitems bi ON b.bill_id = bi.bill_id " +
                        "GROUP BY c.customer_id, c.name ORDER BY total_units DESC";
            case "customerDetails":
                return "SELECT name, email, telephone, address, units FROM customer ORDER BY name ASC";
            default:
                return null;
        }
    }

    private String getForwardPage(String reportType) {
        switch (reportType) {
            case "daily":
            case "weekly":
            case "monthly":
                return "reports.jsp";
            case "lowStock":
            case "inventorySummary":
                return "inventoryReports.jsp";
            case "salesAnalytics":
                return "analyticsReports.jsp";
            case "customerAnalytics":
                return "customerAnalytics.jsp";
            case "customerDetails":
                return "customerDetailsReport.jsp";
            default:
                return "reports.jsp";
        }
    }

    private void saveResultSetToFile(ResultSet rs, String filePath) throws SQLException, IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            ResultSetMetaData metaData = rs.getMetaData();
            int columnCount = metaData.getColumnCount();

            // Write header
            for (int i = 1; i <= columnCount; i++) {
                writer.write(metaData.getColumnLabel(i));
                if (i < columnCount) writer.write("\t");
            }
            writer.newLine();

            // Write rows
            while (rs.next()) {
                for (int i = 1; i <= columnCount; i++) {
                    writer.write(String.valueOf(rs.getObject(i)));
                    if (i < columnCount) writer.write("\t");
                }
                writer.newLine();
            }
        }
    }
}
