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

        <div class="ms-auto">
            <a href="<c:url value='/login'/>" class="btn btn-outline-light me-2">Login</a>
            <a href="<c:url value='/signup'/>" class="btn btn-warning">Sign Up</a>
        </div>

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

<form action="<c:url value='/signup'/>" method="post" onsubmit="return validateSignupForm(event)">

<!-- Name -->
<div class="mb-3">
    <label class="form-label">Full Name</label>
    <input type="text" name="name" class="form-control" value="${param.name}">
    <small class="text-danger" id="nameError"><c:out value="${nameError}" /></small>
</div>

<!-- Email -->
<div class="mb-3">
    <label class="form-label">Email</label>
    <input type="email" name="email" class="form-control" value="${param.email}">
    <small class="text-danger" id="emailError"><c:out value="${emailError}" /></small>
</div>

<!-- Phone -->
<div class="mb-3">
    <label class="form-label">Mobile</label>
    <input type="text" name="phone" class="form-control"
           maxlength="10" value="${param.phone}">
    <small class="text-danger" id="phoneError"><c:out value="${phoneError}" /></small>
</div>

<!-- Age -->
<div class="mb-3">
    <label class="form-label">Age</label>
    <input type="number" name="age" class="form-control"
           min="18" max="100" value="${param.age}">
    <small class="text-danger" id="ageError"><c:out value="${ageError}" /></small>
</div>

<!-- Gender -->
<div class="mb-3">
    <label class="form-label d-block">Gender</label>

    <div class="form-check form-check-inline">
        <input class="form-check-input" type="radio" name="gender" value="M"
               <c:if test="${param.gender == 'M'}">checked</c:if>>
        <label class="form-check-label">Male</label>
    </div>

    <div class="form-check form-check-inline">
        <input class="form-check-input" type="radio" name="gender" value="F"
               <c:if test="${param.gender == 'F'}">checked</c:if>>
        <label class="form-check-label">Female</label>
    </div>

    <br>
    <small class="text-danger" id="genderError"><c:out value="${genderError}" /></small>
</div>

<!-- Address -->
<div class="mb-3">
    <label class="form-label">Address</label>
    <textarea name="address" class="form-control" rows="3">${param.address}</textarea>
    <small class="text-danger" id="addressError"><c:out value="${addressError}" /></small>
</div>

<!-- Password -->
<div class="mb-3">
    <label class="form-label">Password</label>
    <input type="password" name="password" id="password" class="form-control">
    <small class="text-danger" id="passwordError"><c:out value="${passwordError}" /></small>
</div>

<!-- Confirm Password -->
<div class="mb-3">
    <label class="form-label">Confirm Password</label>
    <input type="password" name="confirmPassword" id="confirmPassword" class="form-control">
    <small class="text-danger" id="confirmPasswordError">
        <c:out value="${confirmPasswordError}" />
    </small>
</div>

<button type="submit" class="btn btn-warning w-100">
    Create Account
</button>

</form>

<div class="text-center mt-3">
    Already registered?
    <a href="<c:url value='/login'/>">Login</a>
</div>

</div>
</div>
</div>
</div>

<script src="<c:url value='/js/validation.js'/>"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
