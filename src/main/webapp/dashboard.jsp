<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pahana Edu - Dashboard</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .sidebar .nav-link {
            color: rgba(255,255,255,0.8);
            padding: 12px 20px;
            margin: 5px 0;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .sidebar .nav-link:hover, .sidebar .nav-link.active {
            background-color: rgba(255,255,255,0.1);
            color: white;
            transform: translateX(5px);
        }
        .main-content {
            background-color: #f8f9fa;
            min-height: 100vh;
        }
        .stats-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: transform 0.3s ease;
        }
        .stats-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }
        .navbar-brand {
            font-weight: 600;
            color: #2c3e50;
        }
        .welcome-card {
            background: linear-gradient(135deg, #74b9ff 0%, #0984e3 100%);
            color: white;
            border-radius: 15px;
        }
        .action-btn {
            border-radius: 10px;
            padding: 12px 24px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 sidebar p-0">
                <div class="p-4">
                    <h4 class="text-white mb-4">
                        <i class="bi bi-book"></i> Pahana Edu
                    </h4>
                    <nav class="nav flex-column">
                        <a class="nav-link active" href="#" onclick="showSection('dashboard')">
                            <i class="bi bi-house-door me-2"></i> Dashboard
                        </a>
                        <a class="nav-link" href="#" onclick="showSection('customers')">
                            <i class="bi bi-people me-2"></i> Customer Management
                        </a>
                        <a class="nav-link" href="#" onclick="showSection('items')">
                            <i class="bi bi-box me-2"></i> Item Management
                        </a>
                        <a class="nav-link" href="#" onclick="showSection('billing')">
                            <i class="bi bi-receipt me-2"></i> Billing System
                        </a>
                        <a class="nav-link" href="#" onclick="showSection('reports')">
                            <i class="bi bi-graph-up me-2"></i> Reports
                        </a>
                        <a class="nav-link" href="#" onclick="showSection('help')">
                            <i class="bi bi-question-circle me-2"></i> Help
                        </a>
                        <hr class="text-white-50">
                        <a class="nav-link" href="logout.jsp">
                            <i class="bi bi-box-arrow-right me-2"></i> Logout
                        </a>
                    </nav>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-md-9 col-lg-10 main-content">
                <!-- Top Navigation -->
                <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
                    <div class="container-fluid">
                        <span class="navbar-brand">Management Dashboard</span>
                        <div class="navbar-nav ms-auto">
                            <span class="nav-link">
                                <i class="bi bi-person-circle me-2"></i>
                                Welcome, <strong>User</strong>
                            </span>
                        </div>
                    </div>
                </nav>

                <!-- Dashboard Content -->
                <div id="dashboard-section" class="p-4">
                    <!-- Welcome Card -->
                    <div class="welcome-card p-4 mb-4">
                        <h2>Welcome to Pahana Edu Management System</h2>
                        <p class="mb-0">Manage your bookshop operations efficiently with our comprehensive system</p>
                    </div>

                    <!-- Statistics Cards -->
                    <div class="row mb-4">
                        <div class="col-md-3 mb-3">
                            <div class="stats-card p-4 text-center">
                                <i class="bi bi-people text-primary" style="font-size: 2.5rem;"></i>
                                <h3 class="mt-3 mb-1">1,245</h3>
                                <p class="text-muted mb-0">Total Customers</p>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="stats-card p-4 text-center">
                                <i class="bi bi-box text-success" style="font-size: 2.5rem;"></i>
                                <h3 class="mt-3 mb-1">3,567</h3>
                                <p class="text-muted mb-0">Items in Stock</p>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="stats-card p-4 text-center">
                                <i class="bi bi-receipt text-warning" style="font-size: 2.5rem;"></i>
                                <h3 class="mt-3 mb-1">89</h3>
                                <p class="text-muted mb-0">Today's Bills</p>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="stats-card p-4 text-center">
                                <i class="bi bi-currency-rupee text-info" style="font-size: 2.5rem;"></i>
                                <h3 class="mt-3 mb-1">₹45,320</h3>
                                <p class="text-muted mb-0">Today's Revenue</p>
                            </div>
                        </div>
                    </div>

                    <!-- Quick Actions -->
                    <div class="row">
                        <div class="col-md-6 mb-4">
                            <div class="stats-card p-4">
                                <h5 class="mb-3">
                                    <i class="bi bi-lightning-charge text-primary me-2"></i>
                                    Quick Actions
                                </h5>
                                <div class="d-grid gap-2">
                                    <button class="btn btn-primary action-btn" onclick="showSection('customers')">
                                        <i class="bi bi-person-plus me-2"></i>Add New Customer
                                    </button>
                                    <button class="btn btn-success action-btn" onclick="showSection('items')">
                                        <i class="bi bi-plus-circle me-2"></i>Add New Item
                                    </button>
                                    <button class="btn btn-info action-btn" onclick="showSection('billing')">
                                        <i class="bi bi-receipt me-2"></i>Generate Bill
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 mb-4">
                            <div class="stats-card p-4">
                                <h5 class="mb-3">
                                    <i class="bi bi-clock-history text-success me-2"></i>
                                    Recent Activities
                                </h5>
                                <div class="list-group list-group-flush">
                                    <div class="list-group-item border-0 px-0">
                                        <small class="text-muted">2 minutes ago</small><br>
                                        New customer registered - ACC001245
                                    </div>
                                    <div class="list-group-item border-0 px-0">
                                        <small class="text-muted">5 minutes ago</small><br>
                                        Bill generated for customer ACC001200
                                    </div>
                                    <div class="list-group-item border-0 px-0">
                                        <small class="text-muted">10 minutes ago</small><br>
                                        Item updated - Programming Books
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Customer Management Section -->
                <div id="customers-section" class="p-4" style="display: none;">
                    <h3 class="mb-4">Customer Management</h3>
                    <div class="row">
                        <div class="col-md-8 mb-4">
                            <div class="stats-card p-4">
                                <h5 class="mb-3">Add New Customer</h5>
                                <form action="customer?action=add" method="post">
                                    <div class="row">
                                        <!-- <div class="col-md-6 mb-3">
                                            <label for="accountNumber" class="form-label">Account Number</label>
                                            <input type="text" class="form-control" id="accountNumber" name="cusid" required>
                                        </div> -->
                                        <div class="col-md-6 mb-3">
                                            <label for="customerName" class="form-label">Customer Name</label>
                                            <input type="text" class="form-control" id="customerName" name="cusname" required>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="address" class="form-label">Address</label>
                                        <textarea class="form-control" id="address" rows="3" name="cusaddress"></textarea>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="telephone" class="form-label">Telephone</label>
                                            <input type="tel" class="form-control" id="telephone" name="custelephone" required>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="email" class="form-label">Email</label>
                                            <input type="email" class="form-control" id="email" name="cusemail">
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-primary action-btn">
                                        <i class="bi bi-check-circle me-2"></i>Add Customer
                                    </button>
                                    <button type="button" class="btn btn-secondary action-btn ms-2">
                                        <i class="bi bi-search me-2"></i>Search Customer
                                    </button>
                                </form>
                            </div>
                        </div>
                        <div class="col-md-4 mb-4">
                            <div class="stats-card p-4">
                                <h5 class="mb-3">Customer Actions</h5>
                                <div class="d-grid gap-2">
                                    
                                    <a href="customer?action=viewallcustomers" class="btn btn-outline-primary">View Customers</a>
                                    <button class="btn btn-outline-info">
                                        <i class="bi bi-pencil me-2"></i>Edit Customer
                                    </button>
                                    <button class="btn btn-outline-danger">
                                        <i class="bi bi-trash me-2"></i>Delete Customer
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Item Management Section -->
                <div id="items-section" class="p-4" style="display: none;">
                    <h3 class="mb-4">Item Management</h3>
                    <div class="row">
                        <div class="col-md-8 mb-4">
                            <div class="stats-card p-4">
                                <h5 class="mb-3">Add/Update Item</h5>
                                <form>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="itemCode" class="form-label">Item Code</label>
                                            <input type="text" class="form-control" id="itemCode" required>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="itemName" class="form-label">Item Name</label>
                                            <input type="text" class="form-control" id="itemName" required>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4 mb-3">
                                            <label for="category" class="form-label">Category</label>
                                            <select class="form-select" id="category">
                                                <option value="">Select Category</option>
                                                <option value="books">Books</option>
                                                <option value="stationery">Stationery</option>
                                                <option value="electronics">Electronics</option>
                                            </select>
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <label for="price" class="form-label">Price (₹)</label>
                                            <input type="number" class="form-control" id="price" step="0.01" required>
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <label for="quantity" class="form-label">Quantity</label>
                                            <input type="number" class="form-control" id="quantity" required>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="description" class="form-label">Description</label>
                                        <textarea class="form-control" id="description" rows="2"></textarea>
                                    </div>
                                    <button type="submit" class="btn btn-primary action-btn">
                                        <i class="bi bi-check-circle me-2"></i>Save Item
                                    </button>
                                    <button type="button" class="btn btn-secondary action-btn ms-2">
                                        <i class="bi bi-search me-2"></i>Search Item
                                    </button>
                                </form>
                            </div>
                        </div>
                        <div class="col-md-4 mb-4">
                            <div class="stats-card p-4">
                                <h5 class="mb-3">Item Actions</h5>
                                <div class="d-grid gap-2">
                                    <button class="btn btn-outline-primary">
                                        <i class="bi bi-list me-2"></i>View All Items
                                    </button>
                                    <button class="btn btn-outline-success">
                                        <i class="bi bi-plus-circle me-2"></i>Add New Item
                                    </button>
                                    <button class="btn btn-outline-warning">
                                        <i class="bi bi-arrow-clockwise me-2"></i>Update Stock
                                    </button>
                                    <button class="btn btn-outline-danger">
                                        <i class="bi bi-trash me-2"></i>Delete Item
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Billing Section -->
                <div id="billing-section" class="p-4" style="display: none;">
                    <h3 class="mb-4">Billing System</h3>
                    <div class="row">
                        <div class="col-md-8 mb-4">
                            <div class="stats-card p-4">
                                <h5 class="mb-3">Generate Bill</h5>
                                <form>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="billCustomer" class="form-label">Customer Account</label>
                                            <input type="text" class="form-control" id="billCustomer" placeholder="Enter account number" required>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="billDate" class="form-label">Bill Date</label>
                                            <input type="date" class="form-control" id="billDate" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" required>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Items</label>
                                        <div class="border rounded p-3">
                                            <div class="row mb-2">
                                                <div class="col-md-4">
                                                    <input type="text" class="form-control" placeholder="Item Code">
                                                </div>
                                                <div class="col-md-3">
                                                    <input type="number" class="form-control" placeholder="Quantity">
                                                </div>
                                                <div class="col-md-3">
                                                    <input type="number" class="form-control" placeholder="Price" step="0.01">
                                                </div>
                                                <div class="col-md-2">
                                                    <button type="button" class="btn btn-primary">Add</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <button type="submit" class="btn btn-success action-btn">
                                                <i class="bi bi-receipt me-2"></i>Generate Bill
                                            </button>
                                            <button type="button" class="btn btn-info action-btn ms-2">
                                                <i class="bi bi-printer me-2"></i>Print Bill
                                            </button>
                                        </div>
                                        <div class="col-md-6 text-end">
                                            <h5>Total: ₹<span id="totalAmount">0.00</span></h5>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="col-md-4 mb-4">
                            <div class="stats-card p-4">
                                <h5 class="mb-3">Billing Actions</h5>
                                <div class="d-grid gap-2">
                                    <button class="btn btn-outline-primary">
                                        <i class="bi bi-list me-2"></i>View All Bills
                                    </button>
                                    <button class="btn btn-outline-info">
                                        <i class="bi bi-search me-2"></i>Search Bills
                                    </button>
                                    <button class="btn btn-outline-warning">
                                        <i class="bi bi-arrow-clockwise me-2"></i>Reprint Bill
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Reports Section -->
                <div id="reports-section" class="p-4" style="display: none;">
                    <h3 class="mb-4">Reports & Analytics</h3>
                    <div class="row">
                        <div class="col-md-6 mb-4">
                            <div class="stats-card p-4">
                                <h5 class="mb-3">Sales Reports</h5>
                                <div class="d-grid gap-2">
                                    <button class="btn btn-outline-primary">
                                        <i class="bi bi-calendar-day me-2"></i>Daily Sales Report
                                    </button>
                                    <button class="btn btn-outline-success">
                                        <i class="bi bi-calendar-week me-2"></i>Weekly Sales Report
                                    </button>
                                    <button class="btn btn-outline-info">
                                        <i class="bi bi-calendar-month me-2"></i>Monthly Sales Report
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 mb-4">
                            <div class="stats-card p-4">
                                <h5 class="mb-3">Inventory Reports</h5>
                                <div class="d-grid gap-2">
                                    <button class="btn btn-outline-warning">
                                        <i class="bi bi-exclamation-triangle me-2"></i>Low Stock Alert
                                    </button>
                                    <button class="btn btn-outline-secondary">
                                        <i class="bi bi-box-seam me-2"></i>Inventory Summary
                                    </button>
                                    <button class="btn btn-outline-dark">
                                        <i class="bi bi-graph-up me-2"></i>Sales Analytics
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Help Section -->
                <div id="help-section" class="p-4" style="display: none;">
                    <h3 class="mb-4">Help & Support</h3>
                    <div class="row">
                        <div class="col-md-8 mb-4">
                            <div class="stats-card p-4">
                                <h5 class="mb-3">System Usage Guidelines</h5>
                                <div class="accordion" id="helpAccordion">
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="headingOne">
                                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne">
                                                Customer Management
                                            </button>
                                        </h2>
                                        <div id="collapseOne" class="accordion-collapse collapse show" data-bs-parent="#helpAccordion">
                                            <div class="accordion-body">
                                                <ul>
                                                    <li>To add a new customer, click on "Customer Management" and fill in all required fields</li>
                                                    <li>Account numbers are automatically generated if left blank</li>
                                                    <li>Use the search function to find existing customers</li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="headingTwo">
                                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo">
                                                Item Management
                                            </button>
                                        </h2>
                                        <div id="collapseTwo" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
                                            <div class="accordion-body">
                                                <ul>
                                                    <li>Add new items with unique item codes</li>
                                                    <li>Update stock quantities regularly</li>
                                                    <li>Use categories to organize your inventory</li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="headingThree">
                                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree">
                                                Billing System
                                            </button>
                                        </h2>
                                        <div id="collapseThree" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
                                            <div class="accordion-body">
                                                <ul>
                                                    <li>Enter customer account number first</li>
                                                    <li>Add items one by one to the bill</li>
                                                    <li>Review total before generating the bill</li>
                                                    <li>Bills can be printed or saved as PDF</li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 mb-4">
                            <div class="stats-card p-4">
                                <h5 class="mb-3">Contact Support</h5>
                                <p><i class="bi bi-telephone me-2"></i>+94 11 234 5678</p>
                                <p><i class="bi bi-envelope me-2"></i>support@pahanaedu.lk</p>
                                <p><i class="bi bi-clock me-2"></i>Mon-Sat: 9:00 AM - 6:00 PM</p>
                                <hr>
                                <h6>Quick Links</h6>
                                <div class="d-grid gap-1">
                                    <button class="btn btn-outline-primary btn-sm">User Manual</button>
                                    <button class="btn btn-outline-info btn-sm">Video Tutorials</button>
                                    <button class="btn btn-outline-success btn-sm">FAQ</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function showSection(sectionName) {
            // Hide all sections
            const sections = ['dashboard', 'customers', 'items', 'billing', 'reports', 'help'];
            sections.forEach(section => {
                document.getElementById(section + '-section').style.display = 'none';
            });
            
            // Show selected section
            document.getElementById(sectionName + '-section').style.display = 'block';
            
            // Update active nav link
            document.querySelectorAll('.sidebar .nav-link').forEach(link => {
                link.classList.remove('active');
            });
            event.target.classList.add('active');
        }

        // Auto-update current date in billing
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date().toISOString().split('T')[0];
            const billDateInput = document.getElementById('billDate');
            if (billDateInput) {
                billDateInput.value = today;
            }
        });

        // Simple total calculation for billing
        function updateTotal() {
            // This would be connected to actual calculation logic
            document.getElementById('totalAmount').textContent = '0.00';
        }
    </script>
</body>
</html>