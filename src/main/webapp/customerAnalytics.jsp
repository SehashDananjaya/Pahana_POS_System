<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.ResultSet, java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Analytics</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<div class="container py-4">
    <h2 class="mb-4">Customer Analytics Report</h2>

    <%
        ResultSet rs = (ResultSet) request.getAttribute("reportResult");
        ArrayList<String> customerNames = new ArrayList<>();
        ArrayList<Integer> totalUnits = new ArrayList<>();

        if (rs != null) {
            while (rs.next()) {
                customerNames.add(rs.getString("customer_name"));
                totalUnits.add(rs.getInt("total_units"));
            }
        }
    %>

    <% if (!customerNames.isEmpty()) { %>

    <!-- Customer Table -->
    <table class="table table-striped table-bordered mb-5">
        <thead class="table-light">
        <tr>
            <th>Customer Name</th>
            <th>Total Units Purchased</th>
        </tr>
        </thead>
        <tbody>
        <% for (int i = 0; i < customerNames.size(); i++) { %>
            <tr>
                <td><%= customerNames.get(i) %></td>
                <td><%= totalUnits.get(i) %></td>
            </tr>
        <% } %>
        </tbody>
    </table>

    <!-- Chart Section -->
    <div class="row">
        <div class="col-md-12">
            <h5 class="mb-3">Units Purchased per Customer</h5>
            <canvas id="customerUnitsChart"></canvas>
        </div>
    </div>

    <%
        // 🔹 Build proper JSON strings for Chart.js
        StringBuilder labels = new StringBuilder("[");
        for (int i = 0; i < customerNames.size(); i++) {
            labels.append("\"").append(customerNames.get(i)).append("\"");
            if (i < customerNames.size() - 1) labels.append(",");
        }
        labels.append("]");

        StringBuilder unitsData = new StringBuilder("[");
        for (int i = 0; i < totalUnits.size(); i++) {
            unitsData.append(totalUnits.get(i));
            if (i < totalUnits.size() - 1) unitsData.append(",");
        }
        unitsData.append("]");
    %>

    <script>
        const customerNames = <%= labels.toString() %>;
        const totalUnits = <%= unitsData.toString() %>;

        new Chart(document.getElementById("customerUnitsChart"), {
            type: "bar",
            data: {
                labels: customerNames,
                datasets: [{
                    label: "Units Purchased",
                    data: totalUnits,
                    backgroundColor: "rgba(75, 192, 192, 0.6)",
                    borderColor: "rgba(75, 192, 192, 1)",
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { display: false } },
                scales: { y: { beginAtZero: true } }
            }
        });
    </script>

    <% } else { %>
        <div class="alert alert-warning">No customer data available.</div>
    <% } %>

    <a href="dashboard.jsp" class="btn btn-secondary mt-3">Back to Dashboard</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
