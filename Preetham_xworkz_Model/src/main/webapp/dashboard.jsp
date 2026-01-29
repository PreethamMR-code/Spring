<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | X-Workz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">

<!-- Navbar -->
<nav class="navbar navbar-dark bg-primary shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand" href="<c:url value='/'/>">
            <img src="https://x-workz.com/Logo.png" height="40" class="me-2" alt="X-Workz">
            X-Workz Dashboard
        </a>
        <div class="d-flex gap-2">
            <a href="<c:url value='/'/>" class="btn btn-outline-light btn-sm">
                <i class="bi bi-house-door me-1"></i>Home
            </a>
            <a href="signIn" class="btn btn-outline-light btn-sm">
                <i class="bi bi-box-arrow-right me-1"></i>Logout
            </a>
        </div>
    </div>
</nav>

<!-- Header -->
<div class="bg-white shadow-sm py-4 mb-4">
    <div class="container">
        <h2 class="fw-bold mb-0">
            <i class="bi bi-speedometer2 text-primary me-2"></i>Admin Dashboard
        </h2>
        <p class="text-muted mb-0">Manage batches and students</p>
    </div>
</div>

<!-- Main Content -->
<div class="container my-5">
    <div class="row g-4">
        <!-- Add Batch Card -->
        <div class="col-md-6">
            <div class="card border-0 shadow-sm h-100 hover-card">
                <div class="card-body text-center p-5">
                    <div class="bg-primary bg-opacity-10 rounded-circle d-inline-flex p-4 mb-4">
                        <i class="bi bi-plus-circle-fill text-primary" style="font-size: 4rem;"></i>
                    </div>
                    <h3 class="fw-bold mb-3">Add New Batch</h3>
                    <p class="text-muted mb-4">Create a new training batch with course details, instructor information, and schedule</p>
                    <a href="<c:url value='/dashboard/addBatch'/>" class="btn btn-primary btn-lg px-5">
                        <i class="bi bi-plus-lg me-2"></i>Add Batch
                    </a>
                </div>
            </div>
        </div>

        <!-- View Batches Card -->
        <div class="col-md-6">
            <div class="card border-0 shadow-sm h-100 hover-card">
                <div class="card-body text-center p-5">
                    <div class="bg-success bg-opacity-10 rounded-circle d-inline-flex p-4 mb-4">
                        <i class="bi bi-list-ul text-success" style="font-size: 4rem;"></i>
                    </div>
                    <h3 class="fw-bold mb-3">View All Batches</h3>
                    <p class="text-muted mb-4">Browse all training batches, view details, and manage enrolled students</p>
                    <a href="<c:url value='/dashboard/viewBatches'/>" class="btn btn-success btn-lg px-5">
                        <i class="bi bi-eye me-2"></i>View Batches
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Stats -->
    <div class="row g-4 mt-4">
        <div class="col-md-3">
            <div class="card border-0 shadow-sm">
                <div class="card-body text-center">
                    <i class="bi bi-people-fill text-primary fs-1 mb-3"></i>
                    <h4 class="fw-bold mb-1">24</h4>
                    <p class="text-muted mb-0">Total Batches</p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card border-0 shadow-sm">
                <div class="card-body text-center">
                    <i class="bi bi-person-check-fill text-success fs-1 mb-3"></i>
                    <h4 class="fw-bold mb-1">342</h4>
                    <p class="text-muted mb-0">Active Students</p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card border-0 shadow-sm">
                <div class="card-body text-center">
                    <i class="bi bi-book-fill text-warning fs-1 mb-3"></i>
                    <h4 class="fw-bold mb-1">12</h4>
                    <p class="text-muted mb-0">Active Courses</p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card border-0 shadow-sm">
                <div class="card-body text-center">
                    <i class="bi bi-person-video3 text-info fs-1 mb-3"></i>
                    <h4 class="fw-bold mb-1">8</h4>
                    <p class="text-muted mb-0">Instructors</p>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
.hover-card {
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}
.hover-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 0.5rem 1rem rgba(0,0,0,0.15) !important;
}
</style>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>