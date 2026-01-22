<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<html lang="en">
<head>
    <title>Student Signup</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        body {
            padding-top: 70px;
        }
    </style>
</head>

<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container-fluid px-4">
        <a class="navbar-brand" href="/">X-Workz</a>
    </div>
</nav>

<div class="container mt-5">
<div class="row justify-content-center">
<div class="col-md-5">

<c:if test="${not empty error}">
    <div class="alert alert-danger text-center">
        ${error}
    </div>
</c:if>

<div class="card shadow p-4">

    <div class="text-center mb-3">
        <img src="https://x-workz.com/Logo.png" height="50">
    </div>

    <h4 class="text-center fw-bold mb-4">Create Account</h4>

<form action="signup" method="post">

    <!-- Name -->
    <div class="mb-3">
        <label class="form-label">Full Name</label>
        <input type="text" name="name" class="form-control"
               value="${param.name}">
        <small class="text-danger">${nameError}</small>
    </div>

    <!-- Email -->
    <div class="mb-3">
        <label class="form-label">Email</label>
        <input type="email" name="email" class="form-control"
               value="${param.email}">
        <small class="text-danger">${emailError}</small>
    </div>

    <!-- Phone -->
    <div class="mb-3">
        <label class="form-label">Mobile</label>
        <input type="text" name="phone" maxlength="10"
               class="form-control" value="${param.phone}">
        <small class="text-danger">${phoneError}</small>
    </div>

    <!-- Age -->
    <div class="mb-3">
        <label class="form-label">Age</label>
        <input type="number" name="age" class="form-control"
               value="${param.age}">
        <small class="text-danger">${ageError}</small>
    </div>

    <!-- Gender -->
    <div class="mb-3">
        <label class="form-label d-block">Gender</label>

        <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio"
                   name="gender" value="Male"
                   ${param.gender == 'Male' ? 'checked' : ''}>
            <label class="form-check-label">Male</label>
        </div>

        <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio"
                   name="gender" value="Female"
                   ${param.gender == 'Female' ? 'checked' : ''}>
            <label class="form-check-label">Female</label>
        </div>

        <small class="text-danger d-block">${genderError}</small>
    </div>

    <!-- Address -->
    <div class="mb-3">
        <label class="form-label">Address</label>
        <textarea name="address" class="form-control"
                  rows="3">${param.address}</textarea>
        <small class="text-danger">${addressError}</small>
    </div>

    <!-- Password -->
    <div class="mb-3">
        <label class="form-label">Password</label>
        <input type="password" name="password" class="form-control">
        <small class="text-danger">${passwordError}</small>
    </div>

    <!-- Confirm Password -->
    <div class="mb-3">
        <label class="form-label">Confirm Password</label>
        <input type="password" name="confirmPassword"
               class="form-control">
        <small class="text-danger">${confirmPasswordError}</small>
    </div>

    <button type="submit" class="btn btn-warning w-100">
        Create Account
    </button>

</form>

<div class="text-center mt-3">
    Already registered?
    <a href="login">Login</a>
</div>

</div>
</div>
</div>
</div>

<footer class="bg-dark text-white text-center py-3 mt-5">
    <small>&copy; 2026 X-Workz Training Institute</small>
</footer>

</body>
</html>
