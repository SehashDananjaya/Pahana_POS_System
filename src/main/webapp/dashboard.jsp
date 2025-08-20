<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Pahana Edu - Dashboard</title>
<!-- Bootstrap 5 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Bootstrap Icons -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
<style>
.sidebar {
	min-height: 100vh;
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.sidebar .nav-link {
	color: rgba(255, 255, 255, 0.8);
	padding: 12px 20px;
	margin: 5px 0;
	border-radius: 8px;
	transition: all 0.3s ease;
}

.sidebar .nav-link:hover, .sidebar .nav-link.active {
	background-color: rgba(255, 255, 255, 0.1);
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
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
	transition: transform 0.3s ease;
}

.stats-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
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
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
}

/* ----------------------BIlling Section-------------------------------- */
</style>
</head>
<body>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%
    String role = (String) session.getAttribute("role");
    boolean isAdmin = "admin".equalsIgnoreCase(role);
%>

	<div class="container-fluid">
		<div class="row">
			<!-- Sidebar -->
			<div class="col-md-3 col-lg-2 sidebar p-0">
				<div class="p-4">
					<h4 class="text-white mb-4">
						<i class="bi bi-book"></i> Pahana Edu
					</h4>
					<nav class="nav flex-column">
						<a class="nav-link active" href="#"
							onclick="showSection('dashboard')"> <i
							class="bi bi-house-door me-2"></i> Dashboard
						</a>
						<!-- <a class="nav-link" href="customer?action=viewallcustomers" onclick="showSection('customers')">
    					<i class="bi bi-people me-2"></i> Customer Management
						</a> -->
						<a class="nav-link" href="customer?action=viewallcustomers"
							onclick="showSection('customers', this)"> 
							<i class="bi bi-people me-2"></i> Customer Management
						</a> 
						<a class="nav-link" href="item?action=viewallitems" 
							onclick="showSection('items',this)">
							<i class="bi bi-box me-2"></i> Item Management
						</a>
						 <a class="nav-link" href="billing?action=viewbilling" 
						 	onclick="showSection('billing',this)">
							<i class="bi bi-receipt me-2"></i> Billing System
						</a>
						 <a class="nav-link" href="#" onclick="showSection('reports')">
							<i class="bi bi-graph-up me-2"></i> Reports
						</a> 
						<a class="nav-link" href="#" onclick="showSection('help')"> <i
							class="bi bi-question-circle me-2"></i> Help
						</a>
						<hr class="text-white-50">
						<a class="nav-link" href="login?action=logout"> <i
							class="bi bi-box-arrow-right me-2"></i> Logout
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
							<span class="nav-link"> <i
								class="bi bi-person-circle me-2"></i> Welcome, <strong><%= username.toUpperCase() %></strong></strong>
							</span>
							<a href="login?action=logout" class="btn btn-danger">Logout</a>
						</div>
					</div>
				</nav>

				<!-- Dashboard Content -->
				<div id="dashboard-section" class="p-4">
					<!-- Welcome Card -->
					<div class="welcome-card p-4 mb-4">
						<h2>Welcome to Pahana Edu Management System</h2>
						<p class="mb-0">Manage your bookshop operations efficiently
							with our comprehensive system</p>
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
								<i class="bi bi-currency-rupee text-info"
									style="font-size: 2.5rem;"></i>
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
									<i class="bi bi-lightning-charge text-primary me-2"></i> Quick
									Actions
								</h5>
								<div class="d-grid gap-2">
									<button class="btn btn-primary action-btn"
										onclick="showSection('customers')">
										<i class="bi bi-person-plus me-2"></i>Add New Customer
									</button>
									<button class="btn btn-success action-btn"
										onclick="showSection('items')">
										<i class="bi bi-plus-circle me-2"></i>Add New Item
									</button>
									<button class="btn btn-info action-btn"
										onclick="showSection('billing')">
										<i class="bi bi-receipt me-2"></i>Generate Bill
									</button>
								</div>
							</div>
						</div>
						<div class="col-md-6 mb-4">
							<div class="stats-card p-4">
								<h5 class="mb-3">
									<i class="bi bi-clock-history text-success me-2"></i> Recent
									Activities
								</h5>
								<div class="list-group list-group-flush">
									<div class="list-group-item border-0 px-0">
										<small class="text-muted">2 minutes ago</small><br> New
										customer registered - ACC001245
									</div>
									<div class="list-group-item border-0 px-0">
										<small class="text-muted">5 minutes ago</small><br> Bill
										generated for customer ACC001200
									</div>
									<div class="list-group-item border-0 px-0">
										<small class="text-muted">10 minutes ago</small><br> Item
										updated - Programming Books
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
        <h5 class="mb-3">
            ${customer != null ? "Edit Customer" : "Add New Customer"}
        </h5>
        <form action="customer?action=${customer != null ? 'update' : 'add'}" method="post">
            <c:if test="${customer != null}">
                <input type="hidden" name="id" value="${customer.id}">
            </c:if>
            
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="customerName" class="form-label">Customer Name</label>
                    <input type="text" class="form-control" id="customerName" name="cusname"
                        value="${customer != null ? customer.name : ''}" required>
                </div>
            </div>
            
            <div class="mb-3">
                <label for="address" class="form-label">Address</label>
                <textarea class="form-control" id="address" rows="3" name="cusaddress">${customer != null ? customer.address : ''}</textarea>
            </div>
            
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="telephone" class="form-label">Telephone</label>
                    <input type="tel" class="form-control" id="telephone" name="custelephone"
                        value="${customer != null ? customer.telephone : ''}" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="cusemail"
                        value="${customer != null ? customer.email : ''}">
                </div>
            </div>
            
            <button type="submit" class="btn btn-primary action-btn">
                <i class="bi ${customer != null ? 'bi-pencil' : 'bi-check-circle'} me-2"></i>
                ${customer != null ? "Update Customer" : "Add Customer"}
            </button>
            
            <c:if test="${customer != null}">
                <a href="customer?action=viewallcustomers" class="btn btn-secondary ms-2">
                    Cancel
                </a>
            </c:if>
        </form>
    </div>
</div>
						<div class="col-md-4 mb-4">
							<div class="stats-card p-4">
								<h5 class="mb-3">Customer Actions</h5>
								<div class="d-grid gap-2">

									<a href="customer?action=viewallcustomers"
										class="btn btn-outline-primary">View Customers</a>
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
<!---------- Add Customer Table newww   ------------------------------ -->
					<div class="d-flex justify-content-between align-items-center mb-3">
						<div class="export-buttons">
							<button class="btn btn-success btn-sm"
								onclick="exportData('excel')">
								<i class="bi bi-file-earmark-excel me-1"></i>Excel
							</button>
							<button class="btn btn-danger btn-sm" onclick="exportData('pdf')">
								<i class="bi bi-file-earmark-pdf me-1"></i>PDF
							</button>
							<button class="btn btn-info btn-sm" onclick="printTable()">
								<i class="bi bi-printer me-1"></i>Print
							</button>
						</div>
						<button class="btn btn-primary" data-bs-toggle="modal"
							data-bs-target="#addCustomerModal">
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
										<th>Email</th>
										<th>Units</th>
										<th>Actions</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="customer" items="${customers}">
										<tr>
											<td>
												<div class="d-flex align-items-center">
													<div>
														<div class="fw-bold">${customer.id}</div>
													</div>
												</div>
											</td>
											<td><span class="fw-bold">${customer.name}</span></td>
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
											<td><strong class="text-success">${customer.email}</strong>
											</td>
											<td>
												<i class=""></i>${customer.units}
											</td>
											<td>
												<div class="btn-group" role="group">
													 <a href="customer?action=edit&id=${customer.id}"
														class="btn btn-sm btn-outline-warning"
														title="Edit Customer"> <i class="bi bi-pencil"></i>
													</a>
												 <a href="customer?action=generateBill&id=${customer.id}"
														class="btn btn-sm btn-outline-info" title="Generate Bill">
														<i class="bi bi-receipt"></i>
													</a> <a href="customer?action=delete&id=${customer.id}"
														class="btn btn-sm btn-outline-danger"
														title="Delete Customer"
														onclick="return confirm('Are you sure you want to delete this customer?');">
														<i class="bi bi-trash"></i>
													</a>
												</div>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
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
									<button type="button" class="btn-close btn-close-white"
										data-bs-dismiss="modal"></button>
								</div>
								<div class="modal-body">
									<form action="customer?action=add" method="post">
										<div class="row">
											<!-- <div class="col-md-6 mb-3">
                                            <label for="accountNumber" class="form-label">Account Number</label>
                                            <input type="text" class="form-control" id="accountNumber" name="cusid" required>
                                        </div> -->
											<div class="col-md-6 mb-3">
												<label for="customerName" class="form-label">Customer
													Name</label> <input type="text" class="form-control"
													id="customerName" name="cusname" required>
											</div>
										</div>
										<div class="mb-3">
											<label for="address" class="form-label">Address</label>
											<textarea class="form-control" id="address" rows="3"
												name="cusaddress"></textarea>
										</div>
										<div class="row">
											<div class="col-md-6 mb-3">
												<label for="telephone" class="form-label">Telephone</label>
												<input type="tel" class="form-control" id="telephone"
													name="custelephone" required>
											</div>
											<div class="col-md-6 mb-3">
												<label for="email" class="form-label">Email</label> <input
													type="email" class="form-control" id="email"
													name="cusemail">
											</div>
										</div>

										<button type="submit" class="btn btn-primary action-btn">
											<i class="bi bi-check-circle me-2"></i>Add Customer
										</button>



										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-bs-dismiss="modal">Cancel</button>
											<button type="submit" class="btn btn-primary">
												<i class="bi bi-check-circle me-2"></i>Save Customer
											</button>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>

				</div>

				<!-- Item Management Section -->
<div id="items-section" class="p-4" style="display: ${activeSection == 'items' ? 'block' : 'none'};">
    <h3 class="mb-4">Item Management</h3>
    <div class="row">
        <div class="col-md-8 mb-4">
            <div class="stats-card p-4">
                <h5 class="mb-3">
                    ${item != null ? "Edit Item" : "Add New Item"}
                </h5>
                <form action="item?action=${item != null ? 'update' : 'add'}" method="post">
                    <c:if test="${item != null}">
                        <input type="hidden" name="id" value="${item.productId}">
                    </c:if>

                    <div class="row">
                    	<div class="col-md-6 mb-3">
                            <label for="itemId" class="form-label">Item ID</label>
                            <input type="text" class="form-control" id="itemId" name="itemId"
                                value="${item != null ? item.productId : ''}" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="itemName" class="form-label">Item Name</label>
                            <input type="text" class="form-control" id="itemName" name="itemName"
                                value="${item != null ? item.name : ''}" required>
                        </div>
                        
                    </div>

                    <div class="row">
                    <div class="col-md-6 mb-3">
                            <label for="price" class="form-label">Price</label>
                            <input type="number" class="form-control" id="price" name="price"
                                value="${item != null ? item.price : ''}" step="0.01" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="quantity" class="form-label">Quantity</label>
                            <input type="number" class="form-control" id="quantity" name="quantity"
                                value="${item != null ? item.quantity : ''}" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="description" class="form-label">Description</label>
                        <textarea class="form-control" id="description" rows="2"
                            name="description">${item != null ? item.description : ''}</textarea>
                    </div>

                    <button type="submit" class="btn btn-primary action-btn">
                        <i class="bi ${item != null ? 'bi-pencil' : 'bi-check-circle'} me-2"></i>
                        ${item != null ? "Update Item" : "Add Item"}
                    </button>

                    <c:if test="${item != null}">
                        <a href="item?action=viewallitems" class="btn btn-secondary ms-2">Cancel</a>
                    </c:if>
                </form>
            </div>
        </div>

        <!-- Item Actions -->
        <div class="col-md-4 mb-4">
            <div class="stats-card p-4">
                <h5 class="mb-3">Item Actions</h5>
                <div class="d-grid gap-2">
                    <a href="item?action=viewallitems" class="btn btn-outline-primary">View All Items</a>
                    <a href="" class="btn btn-outline-success">Add New Item</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Item Table -->
    <div class="customer-table mt-4">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Item Name</th>
                        <th>Description</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${items}">
                        <tr>
                            <td>${item.productId}</td>
                            <td>${item.name}</td>
                            <td>${item.description}</td>
                            <td>${item.price}</td>
                            <td>${item.quantity}</td>
                            <td>
                                <div class="btn-group" role="group">
                                    <a href="item?action=edit&id=${item.productId}" class="btn btn-sm btn-outline-warning">
                                        <i class="bi bi-pencil"></i>
                                    </a>
                                    <a href="item?action=delete&id=${item.productId}" 
                                       class="btn btn-sm btn-outline-danger"
                                       onclick="return confirm('Are you sure you want to delete this item?');">
                                        <i class="bi bi-trash"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<!-- Billing Section -->
<div id="billing-section" class="p-4" style="display: ${activeSection == 'billing' ? 'block' : 'none'};">
    <h3 class="mb-4">Billing System</h3>
    <div class="row">
        <div class="col-md-8 mb-4">
            <div class="stats-card p-4">
                <h5 class="mb-3">Create Bill</h5>

                <!-- Form to create bill and add items -->
                
                
                
                
				                <form action="billing?action=createBill" method="post" id="billForm">
									    <div class="row">
									        <!-- Customer Dropdown -->
									        <div class="col-md-6 mb-3">
									            <label for="customerId" class="form-label">Customer</label>
									            <select id="customerId" name="customerId" class="form-select" required>
									                <option value="">-- Select Customer --</option>
									                <c:forEach var="cust" items="${customers}">
									                    <option value="${cust.id},${cust.name}">${cust.name}</option>
									                </c:forEach>
									            </select>
									        </div>
									
									        <!-- Bill Date -->
									        <div class="col-md-6 mb-3">
									            <label for="billDate" class="form-label">Bill Date</label>
									            <input type="date" class="form-control" id="billDate" name="billDate"
									                   value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" required>
									        </div>
									    </div>
									    
									    <div>
									        <button type="submit" class="btn btn-success">Confirm Bill</button>
									    </div>
									</form>
				
				
<div class="row">
    <div class="col-md-6 mb-3">
        <label for="billId" class="form-label">Bill ID</label>
				<input type="text" id="billId" name="billId" class="form-control" value="${billId}" readonly>
    </div>
    <div class="col-md-6 mb-3">
        
    </div>
</div>

<!-- Show confirmed customer & bill date (readonly) -->
<div class="row">
    <div class="col-md-6 mb-3">
        <label class="form-label">Customer</label>
        <input type="text" class="form-control" value="${customerName}" readonly>
    </div>
    <div class="col-md-6 mb-3">
        <label class="form-label">Bill Date</label>
        <input type="text" class="form-control" value="${billDate}" readonly>
    </div>
</div>



<!-- Add Item Form -->
						<form action="billing?action=table" method="post">
						
									
						    <div class="row mb-2">
						        <div class="col-md-5">
						        <!-- Hidden Bill ID -->
										<input type="hidden" name="billId" value="${billId}">
										<input type="hidden" name="customerName" value="${customerName}">
										<input type="hidden" name="billDate" value="${billDate}">
										
						            <select id="itemSelect" name="itemId" class="form-select" required>
						                <option value="">-- Select Item --</option>
						                <c:forEach var="itm" items="${items}">
						                    <option value="${itm.productId}" data-name="${itm.name}" data-price="${itm.price}">
						                        ${itm.name} (Rs.${itm.price})
						                    </option>
						                </c:forEach>
						            </select>
						        </div>
						        <div class="col-md-3">
						            <input type="number" name="itemQty" class="form-control" placeholder="Quantity" min="1" required>
						        </div>
						        <div class="col-md-3">
						            <input type="number" name="itemPrice" class="form-control" placeholder="Unit Price" step="0.01" required>
						        </div>
						        <div class="col-md-1">
						            <button type="submit" class="btn btn-primary">Add</button>
						        </div>
						    </div>
						</form>

                <!-- Items Table -->
                <div class="table-responsive mb-3">
                    <table class="table table-bordered" id="itemsTable">
    <thead>
        <tr>
            <th>Item Name</th>
            <th>Quantity</th>
            <th>Unit Price</th>
            <th>Subtotal</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <!-- Dynamically filled with BillItem records -->
        <c:forEach var="item" items="${billItems}">
            <tr>
                <td>${item.itemName}</td>
                <td>${item.quantity}</td>
                <td>Rs.${item.unitPrice}</td>
                <td>Rs.${item.subtotal}</td>
                <td>
                    <!-- Pass both billItemId and billId -->
                    <a href="billing?action=deleteItem&billItemId=${item.billItemId}&billId=${billId}" 
                       class="btn btn-sm btn-danger">
                       Delete
                    </a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
                </div>

                <!-- Total and Save -->
                <div class="row">
                    <div class="col-md-6">
                        <a href="billing?action=saveBill&billId=${billId}&customerName=${customerName}&billDate=${billDate}" 
  							 class="btn btn-success">
  										 Save Bill
							</a>
                        <a href="billing?action=cancelBill&billId=${billId}" class="btn btn-danger">
   							 Cancel Bill
						</a>
                        
                    </div>
                    <div class="col-md-6 text-end">
                        <h5>Total: Rs.<span id="totalAmount">
            <c:out value="${totalAmount}" default="0.00"/>
        </span></h5>
                    </div>
                </div>
            </div>
        </div>

        <!-- Billing Actions -->
        <div class="col-md-4 mb-4">
            <div class="stats-card p-4">
                <h5 class="mb-3">Billing Actions</h5>
                <div class="d-grid gap-2">
                    <a href="billing?action=viewall" class="btn btn-outline-primary">
                        <i class="bi bi-list me-2"></i>View All Bills
                    </a>
                    <a href="billing?action=search" class="btn btn-outline-info">
                        <i class="bi bi-search me-2"></i>Search Bills
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>






				<!-- Reports Section -->
				
				
				
			<div id="reports-section" class="p-4">
    <h3 class="mb-4">Reports & Analytics</h3>

    <div class="row g-4">

        <!-- Sales & Customer Analytics Reports -->
        <div class="col-md-6">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h5 class="card-title mb-3">Sales & Customer Analytics</h5>
                    
                    <!-- Customer Analytics -->
                    <div class="mb-3">
    <h6>Customer Reports</h6>

    <!-- Customer Details Report -->
    <div class="d-grid gap-2 mb-2">
        <form action="ReportController" method="get">
            <input type="hidden" name="reportType" value="customerDetails">
            <button type="submit" class="btn btn-outline-primary w-100">
                <i class="bi bi-card-list me-2"></i>Customer Details Report
            </button>
        </form>
    </div>

    <!-- Customer Analytics Report -->
    <div class="d-grid gap-2 mb-2">
        <form action="ReportController" method="get">
            <input type="hidden" name="reportType" value="customerAnalytics">
            <button type="submit" class="btn btn-outline-success w-100">
                <i class="bi bi-people-fill me-2"></i>Customer Analytics Report
            </button>
        </form>
    </div>

    <!-- Save Buttons -->
    <div class="d-grid gap-2">
    <!-- Save Customer Details -->
    <form action="ReportController" method="get">
        <input type="hidden" name="reportType" value="customerDetails">
        <input type="hidden" name="saveFile" value="true">
        <button type="submit" class="btn btn-primary w-100" <%= isAdmin ? "" : "disabled" %>>
            <i class="bi bi-download me-2 " ></i>Save Customer Details
        </button>
    </form>

    <!-- Save Customer Analytics -->
    <form action="ReportController" method="get">
        <input type="hidden" name="reportType" value="customerAnalytics">
        <input type="hidden" name="saveFile" value="true">
        <button type="submit" class="btn btn-success w-100" <%= isAdmin ? "" : "disabled" %>>
            <i class="bi bi-download me-2"></i>Save Customer Analytics
        </button>
    </form>
</div>
</div>
                    <!-- Sales Reports -->
                    <div class="mt-4">
                        <h6>Sales Reports</h6>
                        <div class="d-grid gap-2 mb-2">
                            <form action="ReportController" method="get">
                                <input type="hidden" name="reportType" value="daily">
                                <button type="submit" class="btn btn-outline-primary w-100">
                                    <i class="bi bi-calendar-day me-2"></i>Daily Sales Report
                                </button>
                            </form>
                            <form action="ReportController" method="get">
                                <input type="hidden" name="reportType" value="weekly">
                                <button type="submit" class="btn btn-outline-success w-100">
                                    <i class="bi bi-calendar-week me-2"></i>Weekly Sales Report
                                </button>
                            </form>
                            <form action="ReportController" method="get">
                                <input type="hidden" name="reportType" value="monthly">
                                <button type="submit" class="btn btn-outline-info w-100">
                                    <i class="bi bi-calendar-month me-2"></i>Monthly Sales Report
                                </button>
                            </form>
                        </div>

                        <!-- Save Sales Reports -->
                        <div class="d-grid gap-2">
    <form action="ReportController" method="get">
        <input type="hidden" name="reportType" value="daily">
        <input type="hidden" name="saveFile" value="true">
        <button class="btn btn-primary w-100">
            <i class="bi bi-download me-2"></i>Save Daily Report
        </button>
    </form>

    <form action="ReportController" method="get">
        <input type="hidden" name="reportType" value="weekly">
        <input type="hidden" name="saveFile" value="true">
        <button class="btn btn-success w-100">
            <i class="bi bi-download me-2"></i>Save Weekly Report
        </button>
    </form>

    <form action="ReportController" method="get">
        <input type="hidden" name="reportType" value="monthly">
        <input type="hidden" name="saveFile" value="true">
        <button class="btn btn-info w-100">
            <i class="bi bi-download me-2"></i>Save Monthly Report
        </button>
    </form>
</div>
                    </div>

                    <!-- Customer Analytics -->
                    

                </div>
            </div>
        </div>

        <!-- Inventory Reports -->
        <div class="col-md-6">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h5 class="card-title mb-3">Inventory Reports</h5>

                    <div class="d-grid gap-2 mb-3">
                        <form action="ReportController" method="get">
                            <input type="hidden" name="reportType" value="lowStock">
                            <button type="submit" class="btn btn-outline-warning w-100">
                                <i class="bi bi-exclamation-triangle me-2"></i>Low Stock Alert
                            </button>
                        </form>
                        <form action="ReportController" method="get">
                            <input type="hidden" name="reportType" value="inventorySummary">
                            <button type="submit" class="btn btn-outline-secondary w-100">
                                <i class="bi bi-box-seam me-2"></i>Inventory Summary
                            </button>
                        </form>
                        <form action="ReportController" method="get">
                            <input type="hidden" name="reportType" value="salesAnalytics">
                            <button type="submit" class="btn btn-outline-dark w-100">
                                <i class="bi bi-graph-up me-2"></i>Sales Analytics
                            </button>
                        </form>
                    </div>

                    <!-- Save Inventory Reports -->
                    <div class="d-grid gap-2 mt-3">
    <form action="ReportController" method="get">
        <input type="hidden" name="reportType" value="lowStock">
        <input type="hidden" name="saveFile" value="true">
        <button class="btn btn-warning w-100">
            <i class="bi bi-download me-2"></i>Save Low Stock Report
        </button>
    </form>

    <form action="ReportController" method="get">
        <input type="hidden" name="reportType" value="inventorySummary">
        <input type="hidden" name="saveFile" value="true">
        <button class="btn btn-secondary w-100">
            <i class="bi bi-download me-2"></i>Save Inventory Summary
        </button>
    </form>

    <form action="ReportController" method="get">
        <input type="hidden" name="reportType" value="salesAnalytics">
        <input type="hidden" name="saveFile" value="true">
        <button class="btn btn-dark w-100">
            <i class="bi bi-download me-2"></i>Save Sales Analytics
        </button>
    </form>
</div>
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
											<button class="accordion-button" type="button"
												data-bs-toggle="collapse" data-bs-target="#collapseOne">
												Customer Management</button>
										</h2>
										<div id="collapseOne" class="accordion-collapse collapse show"
											data-bs-parent="#helpAccordion">
											<div class="accordion-body">
												<ul>
													<li>To add a new customer, click on "Customer
														Management" and fill in all required fields</li>
													<li>Account numbers are automatically generated if
														left blank</li>
													<li>Use the search function to find existing customers</li>
												</ul>
											</div>
										</div>
									</div>
									<div class="accordion-item">
										<h2 class="accordion-header" id="headingTwo">
											<button class="accordion-button collapsed" type="button"
												data-bs-toggle="collapse" data-bs-target="#collapseTwo">
												Item Management</button>
										</h2>
										<div id="collapseTwo" class="accordion-collapse collapse"
											data-bs-parent="#helpAccordion">
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
											<button class="accordion-button collapsed" type="button"
												data-bs-toggle="collapse" data-bs-target="#collapseThree">
												Billing System</button>
										</h2>
										<div id="collapseThree" class="accordion-collapse collapse"
											data-bs-parent="#helpAccordion">
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
								<p>
									<i class="bi bi-telephone me-2"></i>+94 11 234 5678
								</p>
								<p>
									<i class="bi bi-envelope me-2"></i>support@pahanaedu.lk
								</p>
								<p>
									<i class="bi bi-clock me-2"></i>Mon-Sat: 9:00 AM - 6:00 PM
								</p>
								<hr>
								<h6>Quick Links</h6>
								<div class="d-grid gap-1">
									<button class="btn btn-outline-primary btn-sm">User
										Manual</button>
									<button class="btn btn-outline-info btn-sm">Video
										Tutorials</button>
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
function showSection(sectionName, element) {
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

    if (element) {
        element.classList.add('active');
    }
}

window.onload = function() {
    <%String activeSection = (String) request.getAttribute("activeSection");%>
    <%if (activeSection != null) {%>
        showSection('<%=activeSection%>');
    <%} else {%>
        showSection('dashboard'); // default section
    <%}%>
}
</script>
</body>
</html>