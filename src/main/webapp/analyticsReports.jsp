<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.ResultSet, java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sales Analytics</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<div class="container py-4">
    <h2 class="mb-4">Sales Analytics</h2>

    <%
        ResultSet rs = (ResultSet) request.getAttribute("reportResult");

        ArrayList<String> productNames = new ArrayList<>();
        ArrayList<Integer> quantities = new ArrayList<>();
        ArrayList<Double> totals = new ArrayList<>();

        if (rs != null) {
            while (rs.next()) {
                productNames.add(rs.getString("product_name"));
                quantities.add(rs.getInt("total_sold"));
                totals.add(rs.getDouble("total_amount"));
            }
        }
    %>

    <% if (!productNames.isEmpty()) { %>

    <!-- Analytics Table -->
    <table class="table table-striped table-bordered mb-5">
        <thead class="table-light">
        <tr>
            <th>Product</th>
            <th>Total Units Sold</th>
            <th>Total Sales (Rs.)</th>
        </tr>
        </thead>
        <tbody>
        <% for (int i = 0; i < productNames.size(); i++) { %>
            <tr>
                <td><%= productNames.get(i) %></td>
                <td><%= quantities.get(i) %></td>
                <td><%= totals.get(i) %></td>
            </tr>
        <% } %>
        </tbody>
    </table>

    <!-- Chart Section -->
    <div class="row">
        <div class="col-md-6">
            <h5 class="mb-3">Units Sold per Product</h5>
            <canvas id="salesQuantityChart"></canvas>
        </div>
        <div class="col-md-6">
            <h5 class="mb-3">Revenue per Product</h5>
            <canvas id="salesRevenueChart"></canvas>
        </div>
    </div>
    
    
    
    
    
    
    
    
    <%
    // Build proper JSON strings
    StringBuilder productLabels = new StringBuilder("[");
    for (int i = 0; i < productNames.size(); i++) {
        productLabels.append("\"").append(productNames.get(i)).append("\"");
        if (i < productNames.size() - 1) productLabels.append(",");
    }
    productLabels.append("]");

    StringBuilder quantityData = new StringBuilder("[");
    for (int i = 0; i < quantities.size(); i++) {
        quantityData.append(quantities.get(i));
        if (i < quantities.size() - 1) quantityData.append(",");
    }
    quantityData.append("]");

    StringBuilder totalData = new StringBuilder("[");
    for (int i = 0; i < totals.size(); i++) {
        totalData.append(totals.get(i));
        if (i < totals.size() - 1) totalData.append(",");
    }
    totalData.append("]");
%>

<script>
    const productNames = <%= productLabels.toString() %>;
    const quantities = <%= quantityData.toString() %>;
    const totals = <%= totalData.toString() %>;

    // Quantity Chart
    new Chart(document.getElementById("salesQuantityChart"), {
        type: "bar",
        data: {
            labels: productNames,
            datasets: [{
                label: "Units Sold",
                data: quantities,
                backgroundColor: "rgba(54, 162, 235, 0.6)"
            }]
        },
        options: {
            responsive: true,
            plugins: { legend: { display: false } },
            scales: { y: { beginAtZero: true } }
        }
    });

    // Revenue Chart
    new Chart(document.getElementById("salesRevenueChart"), {
        type: "pie",
        data: {
            labels: productNames,
            datasets: [{
                label: "Revenue (Rs.)",
                data: totals,
                backgroundColor: [
                    "rgba(255, 99, 132, 0.6)",
                    "rgba(54, 162, 235, 0.6)",
                    "rgba(255, 206, 86, 0.6)",
                    "rgba(75, 192, 192, 0.6)",
                    "rgba(153, 102, 255, 0.6)",
                    "rgba(255, 159, 64, 0.6)"
                ]
            }]
        },
        options: { responsive: true }
    });
</script>






    <% } else { %>
        <div class="alert alert-warning">No sales analytics data available.</div>
    <% } %>

    <a href="dashboard.jsp" class="btn btn-secondary mt-3">Back to Dashboard</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
