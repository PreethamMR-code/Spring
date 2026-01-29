<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Batch | X-Workz</title>
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
        <a href="<c:url value='/dashboard'/>" class="btn btn-outline-light btn-sm">
            <i class="bi bi-arrow-left me-1"></i>Back to Dashboard
        </a>
    </div>
</nav>

<!-- Header -->
<div class="bg-white shadow-sm py-4 mb-4">
    <div class="container">
        <h2 class="fw-bold mb-0">
            <i class="bi bi-plus-circle text-primary me-2"></i>Add New Batch
        </h2>
        <p class="text-muted mb-0">Create a new training batch</p>
    </div>
</div>

<!-- Form -->
<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card border-0 shadow-sm">
                <div class="card-body p-4">

                    <c:if test="${not empty msg}">
                        <div class="alert alert-success alert-dismissible">
                            <i class="bi bi-check-circle me-2"></i>${msg}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible">
                            <i class="bi bi-exclamation-triangle me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="<c:url value='/dashboard/addBatch'/>" method="post">

                        <!-- Batch Name -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-tag me-2"></i>Batch Name <span class="text-danger">*</span>
                            </label>
                            <input type="text" class="form-control" name="batchName"
                                   placeholder="e.g., Java-Jan-2026" required>
                            <small class="text-muted">Unique identifier for the batch</small>
                        </div>

                        <!-- Instructor/Trainer -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-person-video3 me-2"></i>Instructor/Trainer <span class="text-danger">*</span>
                            </label>
                            <input type="text" class="form-control" name="instructor"
                                   placeholder="Enter instructor name" required>
                        </div>

                        <!-- Course Selection -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-book me-2"></i>Course <span class="text-danger">*</span>
                            </label>
                            <select class="form-select" name="course" required>
                                <option value="">Select Course</option>
                                <option value="Java Full Stack">Java Full Stack Development</option>
                                <option value="Python Programming">Python Programming</option>
                                <option value="Web Development">Web Development</option>
                                <option value="Data Science">Data Science</option>
                                <option value="DevOps">DevOps Engineering</option>
                                <option value="Cloud Computing">Cloud Computing</option>
                                <option value="Machine Learning">Machine Learning</option>
                                <option value="Mobile Development">Mobile App Development</option>
                            </select>
                        </div>

                        <!-- Start Date -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-calendar-event me-2"></i>Start Date <span class="text-danger">*</span>
                            </label>
                            <input type="date" class="form-control" name="startDate" required>
                        </div>

                        <!-- Batch Type/Mode -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-gear me-2"></i>Batch Type/Mode <span class="text-danger">*</span>
                            </label>
                            <div class="btn-group w-100" role="group">
                                <input type="radio" class="btn-check" name="batchType" id="online" value="Online" required>
                                <label class="btn btn-outline-primary" for="online">
                                    <i class="bi bi-laptop me-2"></i>Online
                                </label>

                                <input type="radio" class="btn-check" name="batchType" id="offline" value="Offline">
                                <label class="btn btn-outline-primary" for="offline">
                                    <i class="bi bi-building me-2"></i>Offline
                                </label>

                                <input type="radio" class="btn-check" name="batchType" id="hybrid" value="Hybrid">
                                <label class="btn btn-outline-primary" for="hybrid">
                                    <i class="bi bi-box-arrow-up-right me-2"></i>Hybrid
                                </label>
                            </div>
                        </div>

                        <!-- Description -->
                        <div class="mb-4">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-text-paragraph me-2"></i>Description
                            </label>
                            <textarea class="form-control" name="description" rows="4"
                                      placeholder="Enter batch description, schedule details, or additional information..."></textarea>
                        </div>

                        <!-- Buttons -->
                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="<c:url value='/dashboard'/>" class="btn btn-outline-secondary">
                                <i class="bi bi-x-circle me-1"></i>Cancel
                            </a>
                            <button type="submit" class="btn btn-primary px-4">
                                <i class="bi bi-check-circle me-1"></i>Create Batch
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