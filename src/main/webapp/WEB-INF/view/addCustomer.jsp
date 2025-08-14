<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Customer</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .container {
            margin-top: 50px;
            max-width: 600px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .btn-primary {
            width: 100%;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-center">Add Customer</h1>
        <form action="customer?action=add" method="post"> 
            <!-- ID (usually auto-generated, so optional to enter) -->
            <div class="form-group">
                <label for="id">ID:</label>
                <input type="number" class="form-control" id="id" name="cusid" placeholder="Enter ID" required>
            </div>
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" class="form-control" id="name" name="cusname" placeholder="Enter Name" required>
            </div>
            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" class="form-control" id="address" name="cus" placeholder="Enter Address" required>
            </div>
            <div class="form-group">
                <label for="telphone">Telephone:</label>
                <input type="tel" class="form-control" id="telphone" name="telphone" placeholder="Enter Telephone Number" required>
            </div>
            <div class="form-group">
                <label for="units">Units:</label>
                <input type="number" class="form-control" id="units" name="cusemail" placeholder="Enter Units" required>
            </div>
            <button type="submit" class="btn btn-primary">Add Customer</button>
        </form>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
