<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign In with OTP | X-Workz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        main {
            flex: 1;
            padding-top: 90px;
        }
        .logo-img {
            height: 45px;
        }
    </style>
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow fixed-top px-4">
    <a class="navbar-brand d-flex align-items-center" href="<c:url value='/'/>">
        <img src="https://x-workz.com/Logo.png" class="logo-img me-2" alt="X-Workz">
        X-Workz Modules
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
            <li class="nav-item">
                <a class="nav-link fw-semibold" href="">Home</a>
            </li>
        </ul>
        <div class="d-flex gap-2">
            <a href="signIn" class="btn btn-light text-primary px-3 fw-semibold">Sign In</a>
            <a href="signUp" class="btn btn-outline-light px-3 fw-semibold">Sign Up</a>
        </div>
    </div>
</nav>

<main class="d-flex align-items-center justify-content-center">
    <div class="card shadow p-4" style="max-width: 450px; width: 100%;">
        <div class="card-body">
            <h5 class="card-title text-center fs-2 fw-bold text-uppercase">Password Reset</h5>
            <br>

            <form action="sendOTP" method="post">
                <c:if test="${not empty msg}">
                    <p class="text-center mt-3 fw-bold text-success">${msg}</p>
                </c:if>
                <c:if test="${not empty msgUnsuccess}">
                    <p class="text-center mt-3 fw-bold text-danger">${msgUnsuccess}</p>
                </c:if>

                <div class="mb-3">
                    <label for="email" class="form-label fw-semibold">
                        Email <span class="text-danger">*</span>
                    </label>
                    <div class="d-flex gap-2">
                        <input type="email" class="form-control" id="email" name="email"
                               value="${email}" placeholder="Enter your email" required>
                        <button type="submit" class="btn btn-primary fw-semibold text-uppercase">
                            Send OTP
                        </button>
                    </div>
                </div>
            </form>

            <form action="signInWithOTP" method="post">
                <input type="hidden" name="email" value="${email}"/>

                <div class="mb-3">
                    <label for="otp" class="form-label fw-semibold">
                        OTP <span class="text-danger">*</span>
                    </label>
                    <input type="text" class="form-control" id="otp" name="otp"
                           placeholder="Enter OTP" maxlength="6" required>
                </div>

                <div class="d-grid mt-4">
                    <button type="submit" class="btn btn-primary fs-5 fw-semibold text-uppercase">
                        Verify OTP
                    </button>
                </div>

                <c:if test="${not empty wrongOTP}">
                    <p class="text-center mt-3 fw-bold text-danger">${wrongOTP}</p>
                </c:if>
            </form>
        </div>
    </div>
</main>

<footer class="bg-primary text-white text-center py-3 mt-auto">
    <p class="mb-0 fw-semibold">© 2026 X-Workz Training Institute</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>