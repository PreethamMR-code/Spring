<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reset Password | X-Workz</title>
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
</nav>

<main class="d-flex justify-content-center align-items-center">
    <div class="card shadow p-3" style="max-width: 450px; width: 100%;">
        <div class="card-body">
            <h5 class="card-title text-center fs-2 fw-bold text-uppercase">Reset Password</h5>
            <br>

            <form action="resetPassword" method="post">
                <c:if test="${not empty msg}">
                    <p class="text-center fw-bold text-success">${msg}</p>
                </c:if>
                <c:if test="${not empty errorMsg}">
                    <p class="text-center fw-bold text-danger">${errorMsg}</p>
                </c:if>

                <div class="mb-3">
                    <label class="form-label fw-semibold">
                        Email <span class="text-danger">*</span>
                    </label>
                    <input type="email" class="form-control" name="email" value="${email}" readonly>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">
                        New Password <span class="text-danger">*</span>
                    </label>
                    <input type="password" class="form-control" name="newPassword"
                           placeholder="Enter new password" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">
                        Confirm Password <span class="text-danger">*</span>
                    </label>
                    <input type="password" class="form-control" name="confirmPassword"
                           placeholder="Re-enter new password" required>
                </div>

                <div class="d-grid mt-4">
                    <button type="submit" class="btn btn-primary fs-5 fw-semibold text-uppercase">
                        Update Password
                    </button>
                </div>
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
