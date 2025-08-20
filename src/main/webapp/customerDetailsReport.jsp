<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.ResultSet, java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Details Report</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<div class="container py-4">
    <h2 class="mb-4">Customer Details Report</h2>

    <%
        ResultSet rs = (ResultSet) request.getAttribute("reportResult");

        ArrayList<String> names = new ArrayList<>();
        ArrayList<String> emails = new ArrayList<>();
        ArrayList<String> phones = new ArrayList<>();
        ArrayList<String> addresses = new ArrayList<>();
        ArrayList<Integer> units = new ArrayList<>();

        if (rs != null) {
            while (rs.next()) {
                names.add(rs.getString("name"));
                emails.add(rs.getString("email"));
                phones.add(rs.getString("telephone"));
                addresses.add(rs.getString("address"));
                units.add(rs.getInt("units"));
            }
        }
    %>

    <% if (!names.isEmpty()) { %>

    <!-- Customer Table -->
    <table class="table table-striped table-bordered mb-5">
        <thead class="table-light">
        <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Telephone</th>
            <th>Address</th>
            <th>Total Units</th>
        </tr>
        </thead>
        <tbody>
        <% for (int i = 0; i < names.size(); i++) { %>
            <tr>
                <td><%= names.get(i) %></td>
                <td><%= emails.get(i) %></td>
                <td><%= phones.get(i) %></td>
                <td><%= addresses.get(i) %></td>
                <td><%= units.get(i) %></td>
            </tr>
        <% } %>
        </tbody>
    </table>

    <!-- Optional Chart: Units per Customer -->
    <div class="mb-4">
        <h5 class="mb-3">Total Units Purchased per Customer</h5>
        <canvas id="customerUnitsChart"></canvas>
    </div>

    <%
        // Convert to JSON for chart
        StringBuilder customerLabels = new StringBuilder("[");
        for (int i = 0; i < names.size(); i++) {
            customerLabels.append("\"").append(names.get(i)).append("\"");
            if (i < names.size() - 1) customerLabels.append(",");
        }
        customerLabels.append("]");

        StringBuilder unitsData = new StringBuilder("[");
        for (int i = 0; i < units.size(); i++) {
            unitsData.append(units.get(i));
            if (i < units.size() - 1) unitsData.append(",");
        }
        unitsData.append("]");
    %>

    <script>
        const customerNames = <%= customerLabels.toString() %>;
        const customerUnits = <%= unitsData.toString() %>;

        new Chart(document.getElementById("customerUnitsChart"), {
            type: "bar",
            data: {
                labels: customerNames,
                datasets: [{
                    label: "Total Units",
                    data: customerUnits,
                    backgroundColor: "rgba(54, 162, 235, 0.6)"
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

    <a href="reports.jsp" class="btn btn-secondary mt-3">Back to Reports</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
