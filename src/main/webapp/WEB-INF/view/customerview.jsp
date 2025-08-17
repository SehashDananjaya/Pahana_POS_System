<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@ page import="java.util.*" %>
<%
    

    // Sample customer data (replace with database query)
    List<Map<String, String>> customers = new ArrayList<>();
    
    Map<String, String> customer1 = new HashMap<>();
    customer1.put("accountNumber", "ACC001001");
    customer1.put("name", "Kasun Perera");
    customer1.put("address", "123 Galle Road, Colombo 03");
    customer1.put("telephone", "+94 77 123 4567");
    customer1.put("email", "kasun.perera@email.com");
    customer1.put("registeredDate", "2024-01-15");
    customer1.put("totalPurchases", "₹45,320");
    customer1.put("status", "Active");
    customers.add(customer1);
    
    Map<String, String> customer2 = new HashMap<>();
    customer2.put("accountNumber", "ACC001002");
    customer2.put("name", "Nimal Silva");
    customer2.put("address", "456 Kandy Road, Peradeniya");
    customer2.put("telephone", "+94 81 234 5678");
    customer2.put("email", "nimal.silva@email.com");
    customer2.put("registeredDate", "2024-02-10");
    customer2.put("totalPurchases", "₹23,150");
    customer2.put("status", "Active");
    customers.add(customer2);
    
    Map<String, String> customer3 = new HashMap<>();
    customer3.put("accountNumber", "ACC001003");
    customer3.put("name", "Amara Jayasinghe");
    customer3.put("address", "789 Negombo Road, Gampaha");
    customer3.put("telephone", "+94 33 345 6789");
    customer3.put("email", "amara.jay@email.com");
    customer3.put("registeredDate", "2024-03-05");
    customer3.put("totalPurchases", "₹67,890");
    customer3.put("status", "VIP");
    customers.add(customer3);
    
    Map<String, String> customer4 = new HashMap<>();
    customer4.put("accountNumber", "ACC001004");
    customer4.put("name", "Dilini Fernando");
    customer4.put("address", "321 Matara Road, Galle");
    customer4.put("telephone", "+94 91 456 7890");
    customer4.put("email", "dilini.fernando@email.com");
    customer4.put("registeredDate", "2024-01-28");
    customer4.put("totalPurchases", "₹12,500");
    customer4.put("status", "Active");
    customers.add(customer4);
    
    Map<String, String> customer5 = new HashMap<>();
    customer5.put("accountNumber", "ACC001005");
    customer5.put("name", "Roshan Mendis");
    customer5.put("address", "654 Jaffna Road, Anuradhapura");
    customer5.put("telephone", "+94 25 567 8901");
    customer5.put("email", "roshan.mendis@email.com");
    customer5.put("registeredDate", "2024-04-12");
    customer5.put("totalPurchases", "₹8,750");
    customer5.put("status", "Inactive");
    customers.add(customer5);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pahana Edu - Customer Management</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .header-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
        }
        
        .stats-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: transform 0.3s ease;
            border: none;
        }
        
        .stats-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }
        
        .customer-table {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }
        
        .table thead th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            font-weight: 600;
            padding: 15px;
        }
        
        .table tbody td {
            padding: 15px;
            vertical-align: middle;
            border-color: #f8f9fa;
        }
        
        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
        }
        
        .status-active {
            background-color: #d4edda;
            color: #155724;
        }
        
        .status-inactive {
            background-color: #f8d7da;
            color: #721c24;
        }
        
        .status-vip {
            background-color: #fff3cd;
            color: #856404;
        }
        
        .action-btn {
            border-radius: 8px;
            padding: 8px 12px;
            font-size: 0.875rem;
            border: none;
            transition: all 0.3s ease;
        }
        
        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        .search-section {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }
        
        .form-control {
            border-radius: 10px;
            padding: 12px 15px;
            border: 2px solid #e9ecef;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 10px;
            padding: 12px 24px;
            font-weight: 500;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }
        
        .pagination .page-link {
            border-radius: 8px;
            margin: 0 2px;
            border: none;
            color: #667eea;
        }
        
        .pagination .page-item.active .page-link {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
        }
        
        .customer-avatar {
            width: 45px;
            height: 45px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 1.2rem;
        }
        
        @media (max-width: 768px) {
            .table-responsive {
                font-size: 0.875rem;
            }
            
            .action-btn {
                padding: 6px 10px;
                font-size: 0.75rem;
            }
        }
        
        .modal-content {
            border-radius: 15px;
            border: none;
        }
        
        .modal-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px 15px 0 0;
        }
        
        .export-buttons {
            margin-bottom: 1rem;
        }
        
        .export-buttons .btn {
            margin-right: 0.5rem;
            margin-bottom: 0.5rem;
        }
    </style>
</head>
<body>
    <!-- Header Section -->
    <div class="header-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="mb-2">
                        <i class="bi bi-people me-3"></i>Customer Management
                    </h1>
                    <p class="mb-0">Manage all your customer accounts and information</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="dashboard.jsp" class="btn btn-light">
                        <i class="bi bi-arrow-left me-2"></i>Back to Dashboard
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <!-- Statistics Row -->
        <div class="row mb-4">
            <div class="col-md-3 mb-3">
                <div class="stats-card p-4 text-center">
                    <i class="bi bi-people text-primary" style="font-size: 2.5rem;"></i>
                    <h3 class="mt-3 mb-1"><%= customers.size() %></h3>
                    <p class="text-muted mb-0">Total Customers</p>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stats-card p-4 text-center">
                    <i class="bi bi-person-check text-success" style="font-size: 2.5rem;"></i>
                    <h3 class="mt-3 mb-1">
                        <%= customers.stream().mapToInt(c -> "Active".equals(c.get("status")) || "VIP".equals(c.get("status")) ? 1 : 0).sum() %>
                    </h3>
                    <p class="text-muted mb-0">Active Customers</p>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stats-card p-4 text-center">
                    <i class="bi bi-star text-warning" style="font-size: 2.5rem;"></i>
                    <h3 class="mt-3 mb-1">
                        <%= customers.stream().mapToInt(c -> "VIP".equals(c.get("status")) ? 1 : 0).sum() %>
                    </h3>
                    <p class="text-muted mb-0">VIP Customers</p>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stats-card p-4 text-center">
                    <i class="bi bi-calendar-plus text-info" style="font-size: 2.5rem;"></i>
                    <h3 class="mt-3 mb-1">12</h3>
                    <p class="text-muted mb-0">New This Month</p>
                </div>
            </div>
        </div>

        <!-- Search and Filter Section -->
        <div class="search-section">
            <div class="row">
                <div class="col-md-4 mb-3">
                    <label class="form-label">Search Customers</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-search"></i></span>
                        <input type="text" class="form-control" id="searchInput" placeholder="Search by name, account, or phone">
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <label class="form-label">Filter by Status</label>
                    <select class="form-select" id="statusFilter">
                        <option value="">All Status</option>
                        <option value="Active">Active</option>
                        <option value="Inactive">Inactive</option>
                        <option value="VIP">VIP</option>
                    </select>
                </div>
                <div class="col-md-3 mb-3">
                    <label class="form-label">Date Range</label>
                    <select class="form-select" id="dateFilter">
                        <option value="">All Time</option>
                        <option value="thisMonth">This Month</option>
                        <option value="lastMonth">Last Month</option>
                        <option value="last3Months">Last 3 Months</option>
                    </select>
                </div>
                <div class="col-md-2 mb-3">
                    <label class="form-label">&nbsp;</label>
                    <div class="d-grid">
                        <button class="btn btn-primary" onclick="clearFilters()">
                            <i class="bi bi-arrow-clockwise"></i> Reset
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div class="export-buttons">
                <button class="btn btn-success btn-sm" onclick="exportData('excel')">
                    <i class="bi bi-file-earmark-excel me-1"></i>Excel
                </button>
                <button class="btn btn-danger btn-sm" onclick="exportData('pdf')">
                    <i class="bi bi-file-earmark-pdf me-1"></i>PDF
                </button>
                <button class="btn btn-info btn-sm" onclick="printTable()">
                    <i class="bi bi-printer me-1"></i>Print
                </button>
            </div>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCustomerModal">
                <i class="bi bi-person-plus me-2"></i>Add New Customer
            </button>
        </div>

        <!-- Customer Table -->
        <div class="customer-table">
            <div class="table-responsive">
                <table class="table table-hover mb-0" id="customerTable">
                    <thead>
                        <tr>
                            <th>Customer</th>
                            <th>Account Number</th>
                            <th>Contact Info</th>
                            <th>Address</th>
                            <th>Total Purchases</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                       
                        <c:forEach var="customer" items="${customers}">
                        <tr>
                            <td>
                                <div class="d-flex align-items-center">
                                    
                                    <div>
                                        <div class="fw-bold">${customer.id} </div>
                                        
                                    </div>
                                </div>
                            </td>
                            <td>
                                <span class="fw-bold"> ${customer.name} </span>
                            </td>
                            <td>
                                <div>
                                    <i class="bi bi-telephone me-1"></i>${customer.telephone}
                                </div>
                                
                            </td>
                            <td>
                                <div>
                                    <i class="bi bi-envelope me-1"></i>${customer.address}
                                </div>
                            </td>
                            <td>
                                <strong class="text-success">${customer.email}</strong>
                            </td>
                            <td>
                                
                            </td>
                            <td>
                                <div class="btn-group" role="group">
                                    <button class="btn btn-sm btn-outline-primary action-btn" 
                                          
                                            title="View Details">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                    <button class="btn btn-sm btn-outline-warning action-btn" 
                                            
                                            title="Edit Customer">
                                        <i class="bi bi-pencil"></i>
                                    </button>
                                    <button class="btn btn-sm btn-outline-info action-btn" 
                                           
                                            title="Generate Bill">
                                        <i class="bi bi-receipt"></i>
                                    </button>
                                    <button class="btn btn-sm btn-outline-danger action-btn" 
                                            
                                            title="Delete Customer">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        </c:forEach>
                      
                       
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Add Customer Modal -->
    <div class="modal fade" id="addCustomerModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="bi bi-person-plus me-2"></i>Add New Customer
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="addCustomerForm">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Account Number</label>
                                <input type="text" class="form-control" name="accountNumber" placeholder="Auto-generated if empty">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Customer Name *</label>
                                <input type="text" class="form-control" name="customerName" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Address *</label>
                            <textarea class="form-control" name="address" rows="3" required></textarea>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Telephone *</label>
                                <input type="tel" class="form-control" name="telephone" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" name="email">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Status</label>
                                <select class="form-select" name="status">
                                    <option value="Active">Active</option>
                                    <option value="Inactive">Inactive</option>
                                    <option value="VIP">VIP</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Registration Date</label>
                                <input type="date" class="form-control" name="registrationDate" 
                                       value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" onclick="saveCustomer()">
                        <i class="bi bi-check-circle me-2"></i>Save Customer
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- DataTables JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>

    <script>
        $(document).ready(function() {
            // Initialize DataTable
            const table = $('#customerTable').DataTable({
                responsive: true,
                pageLength: 10,
                order: [[0, 'asc']],
                columnDefs: [
                    { orderable: false, targets: 6 }
                ],
                language: {
                    search: "",
                    searchPlaceholder: "Search customers...",
                    lengthMenu: "Show _MENU_ customers per page",
                    info: "Showing _START_ to _END_ of _TOTAL_ customers",
                    paginate: {
                        first: '<i class="bi bi-chevron-double-left"></i>',
                        previous: '<i class="bi bi-chevron-left"></i>',
                        next: '<i class="bi bi-chevron-right"></i>',
                        last: '<i class="bi bi-chevron-double-right"></i>'
                    }
                }
            });

            // Custom search functionality
            $('#searchInput').on('keyup', function() {
                table.search(this.value).draw();
            });

            // Status filter
            $('#statusFilter').on('change', function() {
                const status = this.value;
                if (status) {
                    table.column(5).search(status).draw();
                } else {
                    table.column(5).search('').draw();
                }
            });
        });

        function viewCustomer(accountNumber) {
            alert(`Viewing customer details for: ${accountNumber}`);
            // Implement view customer functionality
        }

        function editCustomer(accountNumber) {
            alert(`Editing customer: ${accountNumber}`);
            // Implement edit customer functionality
        }

        function deleteCustomer(accountNumber) {
            if (confirm(`Are you sure you want to delete customer ${accountNumber}?`)) {
                alert(`Customer ${accountNumber} deleted successfully!`);
                // Implement delete customer functionality
                location.reload();
            }
        }

        function generateBill(accountNumber) {
            alert(`Generating bill for customer: ${accountNumber}`);
            // Redirect to billing page or open billing modal
        }

        function saveCustomer() {
            const form = document.getElementById('addCustomerForm');
            const formData = new FormData(form);
            
            // Validate required fields
            const name = formData.get('customerName');
            const address = formData.get('address');
            const telephone = formData.get('telephone');
            
            if (!name || !address || !telephone) {
                alert('Please fill in all required fields!');
                return;
            }
            
            alert('Customer added successfully!');
            $('#addCustomerModal').modal('hide');
            form.reset();
            location.reload();
        }

        function clearFilters() {
            $('#searchInput').val('');
            $('#statusFilter').val('');
            $('#dateFilter').val('');
            $('#customerTable').DataTable().search('').columns().search('').draw();
        }

        function exportData(format) {
            alert(`Exporting customer data to ${format.toUpperCase()}`);
            // Implement export functionality
        }

        function printTable() {
            window.print();
        }

        // Auto-generate account number
        document.querySelector('input[name="customerName"]').addEventListener('input', function() {
            const accountField = document.querySelector('input[name="accountNumber"]');
            if (!accountField.value) {
                const timestamp = new Date().getTime().toString().slice(-6);
                accountField.value = `ACC${timestamp}`;
            }
        });
    </script>
</body>
</html>