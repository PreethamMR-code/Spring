<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Batches | X-Workz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">

<!-- Navbar -->
<nav class="navbar navbar-dark bg-primary shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand" href="<c:url value='/dashboard'/>">
            <img src="https://x-workz.com/Logo.png" height="40" class="me-2" alt="X-Workz">
            X-Workz Dashboard
        </a>
        <div class="d-flex gap-2">
            <a href="<c:url value='/dashboard/addBatch'/>" class="btn btn-light btn-sm">
                <i class="bi bi-plus-lg me-1"></i>Add Batch
            </a>
            <a href="<c:url value='/dashboard'/>" class="btn btn-outline-light btn-sm">
                <i class="bi bi-arrow-left me-1"></i>Back
            </a>
        </div>
    </div>
</nav>

<!-- Header -->
<div class="bg-white shadow-sm py-4 mb-4">
    <div class="container">
        <h2 class="fw-bold mb-0">
            <i class="bi bi-list-ul text-primary me-2"></i>All Batches
        </h2>
        <p class="text-muted mb-0">Browse and manage training batches</p>
    </div>
</div>

<!-- Batches List -->
<div class="container my-5">

    <c:if test="${empty batches}">
        <div class="text-center py-5">
            <i class="bi bi-inbox text-muted" style="font-size: 5rem;"></i>
            <h4 class="mt-3 text-muted">No Batches Found</h4>
            <p class="text-muted">Create your first batch to get started</p>
            <a href="<c:url value='/dashboard/addBatch'/>" class="btn btn-primary mt-3">
                <i class="bi bi-plus-lg me-2"></i>Add Batch
            </a>
        </div>
    </c:if>

    <div class="row g-4">
        <c:forEach var="batch" items="${batches}">
            <div class="col-md-6 col-lg-4">
                <div class="card border-0 shadow-sm h-100 batch-card">
                    <div class="card-body">
                        <!-- Batch Type Badge -->
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <c:choose>
                                <c:when test="${batch.batchType == 'Online'}">
                                    <span class="badge bg-primary">
                                        <i class="bi bi-laptop me-1"></i>Online
                                    </span>
                                </c:when>
                                <c:when test="${batch.batchType == 'Offline'}">
                                    <span class="badge bg-success">
                                        <i class="bi bi-building me-1"></i>Offline
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-info">
                                        <i class="bi bi-box-arrow-up-right me-1"></i>Hybrid
                                    </span>
                                </c:otherwise>
                            </c:choose>

                            <div class="dropdown">
                                <button class="btn btn-sm btn-light" type="button" data-bs-toggle="dropdown">
                                    <i class="bi bi-three-dots-vertical"></i>
                                </button>
                                <ul class="dropdown-menu">
                                    <li>
                                        <a class="dropdown-item" href="<c:url value='/dashboard/batchDetails/${batch.id}'/>">
                                            <i class="bi bi-eye me-2"></i>View Details
                                        </a>
                                    </li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li>
                                        <form action="<c:url value='/dashboard/deleteBatch/${batch.id}'/>" method="post"
                                              onsubmit="return confirm('Are you sure you want to delete this batch?');">
                                            <button type="submit" class="dropdown-item text-danger">
                                                <i class="bi bi-trash me-2"></i>Delete
                                            </button>
                                        </form>
                                    </li>
                                </ul>
                            </div>
                        </div>

                        <!-- Batch Name -->
                        <h5 class="card-title fw-bold mb-3">${batch.batchName}</h5>

                        <!-- Course -->
                        <div class="mb-2">
                            <i class="bi bi-book text-primary me-2"></i>
                            <small class="text-muted">Course:</small>
                            <span class="fw-semibold">${batch.course}</span>
                        </div>

                        <!-- Instructor -->
                        <div class="mb-2">
                            <i class="bi bi-person-video3 text-success me-2"></i>
                            <small class="text-muted">Instructor:</small>
                            <span class="fw-semibold">${batch.instructor}</span>
                        </div>

                        <!-- Start Date -->
                        <div class="mb-3">
                            <i class="bi bi-calendar-event text-warning me-2"></i>
                            <small class="text-muted">Start Date:</small>
                            <span class="fw-semibold">${batch.startDate}</span>
                        </div>

                        <!-- View Details Button -->
                        <a href="<c:url value='/dashboard/batchDetails/${batch.id}'/>"
                           class="btn btn-primary w-100">
                            <i class="bi bi-eye me-2"></i>View Details
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<style>
.batch-card {
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}
.batch-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 0.5rem 1rem rgba(0,0,0,0.15) !important;
}
</style>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>