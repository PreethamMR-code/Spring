<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Student Signup</title>

    <!-- Bootstrap -->
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
            <img src="<c:url value='/assets/xworkz-logo.png'/>" class="me-2" alt="X-Workz">
            <span class="fw-bold">X-Workz</span>
        </a>
    </div>
</nav>

<div class="container mt-5">
<div class="row justify-content-center">
<div class="col-md-5">

<c:if test="${not empty error}">
    <div class="alert alert-danger text-center">${error}</div>
</c:if>

<div class="card shadow p-4">
<h4 class="text-center mb-3">Student Registration</h4>

<form action="<c:url value='/signup'/>"
      method="post"
      novalidate
      oninput="validateSignupForm(event)"
      onchange="validateSignupForm(event)"
      onsubmit="return validateSignupForm(event)">

    <!-- Full Name -->
    <div class="mb-3">
        <label class="form-label">Full Name</label>
        <input type="text" name="name" class="form-control">
        <c:if test="${not empty nameError}">
            <small class="text-danger d-block">${nameError}</small>
        </c:if>
        <small class="text-danger" id="nameError"></small>
    </div>

    <!-- Email -->
    <div class="mb-3">
        <label class="form-label">Email</label>
        <input type="email" name="email" class="form-control">
        <c:if test="${not empty emailError}">
            <small class="text-danger d-block">${emailError}</small>
        </c:if>
        <small class="text-danger" id="emailError"></small>
    </div>

    <!-- Mobile -->
    <div class="mb-3">
        <label class="form-label">Mobile</label>
        <input type="text" name="phone" class="form-control" maxlength="10">
        <c:if test="${not empty phoneError}">
            <small class="text-danger d-block">${phoneError}</small>
        </c:if>
        <small class="text-danger" id="phoneError"></small>
    </div>

    <!-- Age -->
    <div class="mb-3">
        <label class="form-label">Age</label>
        <input type="number" name="age" class="form-control" min="18" max="100">
        <c:if test="${not empty ageError}">
            <small class="text-danger d-block">${ageError}</small>
        </c:if>
        <small class="text-danger" id="ageError"></small>
    </div>

    <!-- Gender -->
    <div class="mb-3">
        <label class="form-label d-block">Gender</label>

        <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="gender" value="M">
            <label class="form-check-label">Male</label>
        </div>

        <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="gender" value="F">
            <label class="form-check-label">Female</label>
        </div>

        <c:if test="${not empty genderError}">
            <small class="text-danger d-block">${genderError}</small>
        </c:if>
        <small class="text-danger d-block" id="genderError"></small>
    </div>

    <!-- Address -->
    <div class="mb-3">
        <label class="form-label">Address</label>
        <textarea name="address" class="form-control" rows="3"></textarea>
        <c:if test="${not empty addressError}">
            <small class="text-danger d-block">${addressError}</small>
        </c:if>
        <small class="text-danger" id="addressError"></small>
    </div>

    <!-- Password -->
    <div class="mb-3">
        <label class="form-label">Password</label>
        <input type="password" name="password" id="password" class="form-control">
        <c:if test="${not empty passwordError}">
            <small class="text-danger d-block">${passwordError}</small>
        </c:if>
        <small class="text-danger" id="passwordError"></small>
    </div>

    <!-- Confirm Password -->
    <div class="mb-3">
        <label class="form-label">Confirm Password</label>
        <input type="password" name="confirmPassword" id="confirmPassword" class="form-control">
        <c:if test="${not empty confirmPasswordError}">
            <small class="text-danger d-block">${confirmPasswordError}</small>
        </c:if>
        <small class="text-danger" id="confirmPasswordError"></small>
    </div>

    <button type="submit" class="btn btn-warning w-100">Create Account</button>

</form>

<div class="text-center mt-3">
    Already registered?
    <a href="<c:url value='/login'/>">Login</a>
</div>

</div>
</div>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="<c:url value='/assets/js/validation.js'/>"></script>

</body>
</html>
