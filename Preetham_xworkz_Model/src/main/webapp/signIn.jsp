<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign In | X-Workz</title>
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
    <div class="card shadow p-4" style="width:100%; max-width:420px;">
        <div class="text-center mb-4">
            <h4 class="fw-bold text-primary">Sign In</h4>
        </div>

        <form action="login" method="post">
            <div class="mb-3">
                <input type="email" name="email" class="form-control" placeholder="Enter your email"
                       value="${email}" required>
            </div>

            <div class="mb-3">
                <input type="password" name="password" class="form-control"
                       placeholder="Enter your password" required>
            </div>

            <div class="d-grid mb-3">
                <button type="submit" class="btn btn-primary fs-5 fw-semibold text-uppercase"
                        id="signInBtn" <c:if test="${disableLogin}">disabled</c:if>>
                    Sign In
                </button>
            </div>

            <c:if test="${showForgot}">
                <div class="d-grid mb-3">
                    <a href="SignInWithOTP" class="btn btn-outline-primary fs-6 fw-semibold text-uppercase">
                        Forgot Password?
                    </a>
                </div>
            </c:if>

            <p class="text-center mb-0">
                Don't have an account? <a href="<c:url value='/signUp'/>">Sign Up</a>
            </p>

            <c:if test="${not empty msg}">
                <div class="alert alert-success mt-3">${msg}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger mt-3">${error}</div>
            </c:if>
        </form>
    </div>
</main>

<footer class="bg-primary text-white text-center py-3 mt-auto">
    <p class="mb-0 fw-semibold">© 2026 X-Workz Training Institute</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
