<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%
// Check if user is already logged in
/*    String username = (String) session.getAttribute("username");
   if (username != null) {
       response.sendRedirect("dashboard.jsp");
       return;
   }  */

// Handle login form submission
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Pahana Edu - Login</title>
<!-- Bootstrap 5 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Bootstrap Icons -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
<style>
body {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	min-height: 100vh;
	display: flex;
	align-items: center;
	justify-content: center;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.login-container {
	background: rgba(255, 255, 255, 0.95);
	backdrop-filter: blur(10px);
	border-radius: 20px;
	box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
	overflow: hidden;
	max-width: 900px;
	width: 100%;
	margin: 20px;
}

.login-left {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	color: white;
	padding: 60px 40px;
	text-align: center;
	position: relative;
}

.login-left::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background:
		url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="white" opacity="0.1"/><circle cx="75" cy="75" r="1" fill="white" opacity="0.1"/><circle cx="50" cy="10" r="0.5" fill="white" opacity="0.1"/><circle cx="10" cy="60" r="0.5" fill="white" opacity="0.1"/><circle cx="90" cy="40" r="0.5" fill="white" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
	opacity: 0.3;
}

.login-left .content {
	position: relative;
	z-index: 1;
}

.login-right {
	padding: 60px 40px;
}

.brand-logo {
	font-size: 3rem;
	margin-bottom: 1rem;
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	background-clip: text;
}

.form-control {
	border: 2px solid #e9ecef;
	border-radius: 12px;
	padding: 15px 20px;
	font-size: 16px;
	transition: all 0.3s ease;
}

.form-control:focus {
	border-color: #667eea;
	box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
}

.input-group {
	position: relative;
	margin-bottom: 1.5rem;
}

.input-group .form-control {
	padding-left: 55px;
}

.input-icon {
	position: absolute;
	left: 20px;
	top: 50%;
	transform: translateY(-50%);
	color: #667eea;
	font-size: 1.2rem;
	z-index: 5;
}

.btn-login {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	border: none;
	border-radius: 12px;
	padding: 15px 30px;
	font-size: 16px;
	font-weight: 600;
	color: white;
	width: 100%;
	transition: all 0.3s ease;
}

.btn-login:hover {
	transform: translateY(-2px);
	box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
	color: white;
}

.alert {
	border-radius: 12px;
	border: none;
}

.demo-credentials {
	background: rgba(102, 126, 234, 0.1);
	border-radius: 12px;
	padding: 20px;
	margin-top: 20px;
}

.demo-credentials h6 {
	color: #667eea;
	margin-bottom: 10px;
}

.demo-credentials .credential-item {
	display: flex;
	justify-content: space-between;
	margin-bottom: 8px;
	font-size: 0.9rem;
}

.floating-shapes {
	position: absolute;
	width: 100%;
	height: 100%;
	overflow: hidden;
}

.shape {
	position: absolute;
	opacity: 0.1;
	animation: float 6s ease-in-out infinite;
}

.shape:nth-child(1) {
	top: 20%;
	left: 20%;
	animation-delay: 0s;
}

.shape:nth-child(2) {
	top: 60%;
	right: 20%;
	animation-delay: 2s;
}

.shape:nth-child(3) {
	bottom: 20%;
	left: 30%;
	animation-delay: 4s;
}

@
keyframes float { 0%, 100% {
	transform: translateY(0px);
}

50
%
{
transform
:
translateY(
-20px
);
}
}
@media ( max-width : 768px) {
	.login-left {
		display: none;
	}
	.login-right {
		padding: 40px 30px;
	}
}

.remember-forgot {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 1.5rem;
}

.form-check-input:checked {
	background-color: #667eea;
	border-color: #667eea;
}

.forgot-password {
	color: #667eea;
	text-decoration: none;
	font-size: 0.9rem;
}

.forgot-password:hover {
	color: #764ba2;
	text-decoration: underline;
}
</style>
</head>
<body>
	<div class="login-container">
		<div class="row g-0 h-100">
			<!-- Left Side - Branding -->
			<div class="col-md-6 login-left">
				<div class="floating-shapes">
					<i class="bi bi-book shape" style="font-size: 3rem;"></i> <i
						class="bi bi-journal-text shape" style="font-size: 2rem;"></i> <i
						class="bi bi-bookmark shape" style="font-size: 2.5rem;"></i>
				</div>
				<div class="content">
					<i class="bi bi-book" style="font-size: 4rem; margin-bottom: 2rem;"></i>
					<h1 class="fw-bold mb-4">
						Welcome to<br>Pahana Edu
					</h1>
					<p class="lead mb-4">Your trusted bookshop management solution</p>
					<div class="row text-center">
						<div class="col-4">
							<i class="bi bi-people" style="font-size: 2rem;"></i>
							<p class="mt-2 mb-0">
								Customer<br>Management
							</p>
						</div>
						<div class="col-4">
							<i class="bi bi-box" style="font-size: 2rem;"></i>
							<p class="mt-2 mb-0">
								Inventory<br>Control
							</p>
						</div>
						<div class="col-4">
							<i class="bi bi-receipt" style="font-size: 2rem;"></i>
							<p class="mt-2 mb-0">
								Billing<br>System
							</p>
						</div>
					</div>
				</div>
			</div>

			<!-- Right Side - Login Form -->
			<div class="col-md-6 login-right">
				<div class="text-center mb-4">
					<i class="bi bi-book brand-logo"></i>
					<h2 class="fw-bold mb-2">Sign In</h2>
					<p class="text-muted">Enter your credentials to access the
						system</p>
				</div>

				

				<%
				String error = (String) request.getAttribute("error");
				if (error != null && !error.isEmpty()) {
				%>
				<div class="alert alert-danger" role="alert">
					<i class="bi bi-exclamation-triangle me-2"></i><%=error%>
				</div>
				<%
				}
				%>


				<form method="POST" action="login">
					<div class="input-group">
						<i class="bi bi-person input-icon"></i> <input type="text"
							name="username" class="form-control" placeholder="Enter username"
							required>
					</div>

					<div class="input-group">
						<i class="bi bi-lock input-icon"></i> <input type="password"
							name="password" class="form-control" placeholder="Enter password"
							required>
					</div>

					<div class="remember-forgot">
						<div class="form-check">
							<input class="form-check-input" type="checkbox" id="rememberMe">
							<label class="form-check-label" for="rememberMe">
								Remember me </label>
						</div>
						<a href="#" class="forgot-password">Forgot Password?</a>
					</div>

					<button type="submit" class="btn btn-login">
						<i class="bi bi-box-arrow-in-right me-2"></i>Sign In
					</button>
				</form>

				<!-- Demo Credentials -->
				<div class="demo-credentials">
					<h6>
						<i class="bi bi-info-circle me-2"></i>Demo Credentials
					</h6>
					<div class="credential-item">
						<span><strong>Admin:</strong></span> <span>admin / admin123</span>
					</div>
					<div class="credential-item">
						<span><strong>Manager:</strong></span> <span>manager /
							manager123</span>
					</div>
					<div class="credential-item">
						<span><strong>User:</strong></span> <span>user / user123</span>
					</div>
				</div>

				<div class="text-center mt-4">
					<small class="text-muted"> © <%=new java.util.Date().getYear() + 1900%>
						Pahana Edu. All rights reserved.
					</small>
				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap 5 JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

	<script>
        // Auto-focus on username field
        document.addEventListener('DOMContentLoaded', function() {
            const usernameField = document.querySelector('input[name="username"]');
            if (usernameField) {
                usernameField.focus();
            }
        });
        
        /* // Handle form submission with loading state
        document.querySelector('form').addEventListener('submit', function(e) {
            const submitBtn = document.querySelector('.btn-login');
            submitBtn.innerHTML = '<i class="bi bi-arrow-clockwise me-2"></i>Signing In...';
            submitBtn.disabled = true;
        }); */
        
        // Password visibility toggle (optional enhancement)
        function togglePasswordVisibility() {
            const passwordField = document.querySelector('input[name="password"]');
            const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordField.setAttribute('type', type);
        }
        
        // Quick login function for demo credentials
        function quickLogin(username, password) {
            document.querySelector('input[name="username"]').value = username;
            document.querySelector('input[name="password"]').value = password;
        }
        
        // Add click handlers to demo credentials
        document.addEventListener('DOMContentLoaded', function() {
            const credentialItems = document.querySelectorAll('.credential-item');
            credentialItems.forEach(item => {
                item.style.cursor = 'pointer';
                item.addEventListener('click', function() {
                    const text = this.textContent;
                    if (text.includes('admin / admin123')) {
                        quickLogin('admin', 'admin123');
                    } else if (text.includes('manager / manager123')) {
                        quickLogin('manager', 'manager123');
                    } else if (text.includes('user / user123')) {
                        quickLogin('user', 'user123');
                    }
                });
            });
        });
    </script>
</body>
</html>