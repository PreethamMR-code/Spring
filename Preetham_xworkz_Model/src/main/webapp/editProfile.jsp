
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Profile | X-Workz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">

<!-- Navbar -->
<nav class="navbar navbar-dark bg-primary shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="<c:url value='/'/>">
            <img src="https://x-workz.com/Logo.png" height="40" class="me-2" alt="X-Workz">
            X-Workz
        </a>
        <a href="javascript:history.back()" class="btn btn-outline-light btn-sm">
            <i class="bi bi-arrow-left me-1"></i>Back
        </a>
    </div>
</nav>

<!-- Edit Profile Form -->
<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-sm">
                <div class="card-body p-4">
                    <div class="text-center mb-4">
                        <div class="bg-primary bg-opacity-10 rounded-circle d-inline-flex p-4 mb-3">
                            <i class="bi bi-person-fill text-primary" style="font-size: 3rem;"></i>
                        </div>
                        <h3 class="fw-bold">Edit Profile</h3>
                        <p class="text-muted">Update your personal information</p>
                    </div>

                    <c:if test="${not empty msg}">
                        <div class="alert alert-success alert-dismissible">
                            ${msg}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible">
                            ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="updateProfile" method="post">
                        <!-- Email (Read-only) -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-envelope me-2"></i>Email
                            </label>
                            <input type="email" class="form-control bg-light" name="email"
                                   value="${student.email}" readonly>
                            <small class="text-muted">Email cannot be changed</small>
                        </div>

                        <!-- Name -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-person me-2"></i>Full Name <span class="text-danger">*</span>
                            </label>
                            <input type="text" class="form-control" name="name"
                                   value="${student.name}" required>
                        </div>

                        <!-- Phone -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-telephone me-2"></i>Phone <span class="text-danger">*</span>
                            </label>
                            <input type="tel" class="form-control" name="phone"
                                   value="${student.phone}" maxlength="10" required>
                        </div>

                        <!-- Age -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-calendar me-2"></i>Age <span class="text-danger">*</span>
                            </label>
                            <input type="number" class="form-control" name="age"
                                   value="${student.age}" min="18" max="60" required>
                        </div>

                        <!-- Gender (Read-only) -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-gender-ambiguous me-2"></i>Gender
                            </label>
                            <input type="text" class="form-control bg-light"
                                   value="${student.gender}" readonly>
                            <small class="text-muted">Gender cannot be changed</small>
                        </div>

                        <!-- Address -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-geo-alt me-2"></i>Address <span class="text-danger">*</span>
                            </label>
                            <textarea class="form-control" name="address" rows="3" required>${student.address}</textarea>
                        </div>

                        <!-- Buttons -->
                        <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                            <a href="javascript:history.back()" class="btn btn-outline-secondary">
                                <i class="bi bi-x-circle me-1"></i>Cancel
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-check-circle me-1"></i>Save Changes
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
