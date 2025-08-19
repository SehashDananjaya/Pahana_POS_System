<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.ResultSet, java.sql.ResultSetMetaData" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Inventory Reports</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container py-4">
    <h2 class="mb-4">Inventory Report</h2>

    <%
        ResultSet rs = (ResultSet) request.getAttribute("reportResult");
        if (rs != null) {
            ResultSetMetaData rsmd = rs.getMetaData();
            int columnCount = rsmd.getColumnCount();
    %>

    <table class="table table-bordered table-hover">
        <thead class="table-light">
        <tr>
            <% for (int i = 1; i <= columnCount; i++) { %>
                <th><%= rsmd.getColumnLabel(i) %></th>
            <% } %>
        </tr>
        </thead>
        <tbody>
        <%
            while (rs.next()) {
                out.print("<tr>");
                for (int i = 1; i <= columnCount; i++) {
                    String colValue = rs.getString(i);
                    
                    // Highlight "Low Stock" rows
                    if ("status".equalsIgnoreCase(rsmd.getColumnLabel(i)) && "Low Stock".equalsIgnoreCase(colValue)) {
                        out.print("<td class='text-danger fw-bold'>" + colValue + "</td>");
                    } else {
                        out.print("<td>" + colValue + "</td>");
                    }
                }
                out.print("</tr>");
            }
        %>
        </tbody>
    </table>

    <%
        } else {
    %>
        <div class="alert alert-warning">No inventory data available.</div>
    <%
        }
    %>

    <a href="dashboard.jsp" class="btn btn-secondary mt-3">Back to Dashboard</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
