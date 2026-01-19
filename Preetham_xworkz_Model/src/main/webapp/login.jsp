<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Student Login</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        body { padding-top: 70px; }
        .navbar-brand img { height: 40px; }
    </style>
</head>

<body class="bg-light">

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container-fluid px-4">
        <a class="navbar-brand d-flex align-items-center" href="<c:url value='/'/>">
            <img src="<c:url value='/assets/xworkz-logo.png'/>" class="me-2">
            <span class="fw-bold">X-Workz</span>
        </a>

        <div class="ms-auto">
            <a href="<c:url value='/login'/>" class="btn btn-outline-light me-2">Login</a>
            <a href="<c:url value='/signup'/>" class="btn btn-warning">Sign Up</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
<div class="row justify-content-center">
<div class="col-md-4">

<div class="card shadow p-4">
<h4 class="text-center mb-3">Student Login</h4>

<c:if test="${not empty msg}">
    <div class="alert alert-success text-center">${msg}</div>
</c:if>

<c:if test="${not empty error}">
    <div class="alert alert-danger text-center">${error}</div>
</c:if>

<form action="<c:url value='/login'/>" method="post">

<!-- Email -->
<div class="mb-3">
    <label class="form-label">Email</label>
    <input type="email" name="email" class="form-control"
           value="${param.email}">
    <small class="text-danger">
        <c:out value="${emailError}" />
    </small>
</div>

<!-- Password -->
<div class="mb-3">
    <label class="form-label">Password</label>
    <input type="password" name="password" class="form-control">
    <small class="text-danger">
        <c:out value="${passwordError}" />
    </small>
</div>

<button type="submit" class="btn btn-primary w-100">
    Login
</button>

</form>

<div class="text-center mt-3">
    New user?
    <a href="<c:url value='/signup'/>">Create Account</a>
</div>

<c:if test="${showOtp}">
    <hr>

    <div class="alert alert-warning text-center">
        Login with OTP
    </div>

    <form action="<c:url value='/login-otp'/>" method="post">

        <div class="mb-3">
            <label class="form-label">Registered Email</label>
            <input type="email" name="email" class="form-control"
                   value="${param.email}" readonly>
        </div>

        <div class="mb-3">
            <label class="form-label">OTP</label>
            <input type="text" name="otp" class="form-control"
                   placeholder="Enter 6-digit OTP">
        </div>

        <button type="submit" class="btn btn-success w-100">
            Login with OTP
        </button>
    </form>
</c:if>

</div>
</div>
</div>
</div>



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
