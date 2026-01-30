<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Student | X-Workz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            overflow-x: hidden;
        }

        /* Sidebar Styles */
        .sidebar {
            position: fixed;
            top: 0;
            left: -280px;
            width: 280px;
            height: 100vh;
            background: linear-gradient(180deg, #0d6efd 0%, #0a58ca 100%);
            transition: left 0.3s ease;
            z-index: 1050;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
        }

        .sidebar.active {
            left: 0;
        }

        .sidebar-header {
            padding: 20px;
            background: rgba(0,0,0,0.1);
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .sidebar-menu {
            padding: 20px 0;
        }

        .sidebar-menu .menu-item {
            padding: 15px 25px;
            color: rgba(255,255,255,0.8);
            text-decoration: none;
            display: flex;
            align-items: center;
            transition: all 0.3s ease;
            border-left: 3px solid transparent;
        }

        .sidebar-menu .menu-item:hover {
            background: rgba(255,255,255,0.1);
            color: white;
            border-left-color: white;
        }

        .sidebar-menu .menu-item i {
            font-size: 1.2rem;
            margin-right: 15px;
            width: 25px;
        }

        .sidebar-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 1040;
            display: none;
        }

        .sidebar-overlay.active {
            display: block;
        }

        .menu-toggle {
            position: fixed;
            top: 20px;
            left: 20px;
            width: 50px;
            height: 50px;
            background: #0d6efd;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            gap: 5px;
            z-index: 1000;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
            transition: all 0.3s ease;
        }

        .menu-toggle:hover {
            background: #0a58ca;
            transform: scale(1.05);
        }

        .menu-toggle span {
            width: 25px;
            height: 3px;
            background: white;
            border-radius: 2px;
            transition: all 0.3s ease;
        }

        .menu-toggle.active span:nth-child(1) {
            transform: rotate(45deg) translate(7px, 7px);
        }

        .menu-toggle.active span:nth-child(2) {
            opacity: 0;
        }

        .menu-toggle.active span:nth-child(3) {
            transform: rotate(-45deg) translate(7px, -7px);
        }

        .content-wrapper {
            padding-left: 80px;
        }
    </style>
</head>
<body class="bg-light">

<!-- Hamburger Menu Button -->
<button class="menu-toggle" id="menuToggle">
    <span></span>
    <span></span>
    <span></span>
</button>

<!-- Sidebar Overlay -->
<div class="sidebar-overlay" id="sidebarOverlay"></div>

<!-- Sidebar -->
<div class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <div class="d-flex align-items-center text-white">
            <img src="https://x-workz.com/Logo.png" height="35" class="me-2" alt="X-Workz">
            <div>
                <h5 class="mb-0 fw-bold">X-Workz</h5>
                <small class="opacity-75">Admin Panel</small>
            </div>
        </div>
    </div>

    <div class="sidebar-menu">
        <a href="<c:url value='/dashboard'/>" class="menu-item">
            <i class="bi bi-speedometer2"></i>
            <span>Dashboard</span>
        </a>

        <a href="<c:url value='/dashboard/addBatch'/>" class="menu-item">
            <i class="bi bi-plus-circle"></i>
            <span>Add Batch</span>
        </a>

        <a href="<c:url value='/dashboard/viewBatches'/>" class="menu-item">
            <i class="bi bi-list-ul"></i>
            <span>View Batches</span>
        </a>

        <div style="border-top: 1px solid rgba(255,255,255,0.1); margin: 20px 0;"></div>

        <a href="<c:url value='/Home'/>"  class="menu-item">
            <i class="bi bi-house-door"></i>
            <span>Home</span>
        </a>

        <a href="signIn" class="menu-item">
            <i class="bi bi-box-arrow-right"></i>
            <span>Logout</span>
        </a>
    </div>
</div>

<!-- Main Content -->
<div class="main-content">
    <div class="content-wrapper">
        <!-- Top Navbar -->
        <nav class="navbar navbar-light bg-white shadow-sm mb-4">
            <div class="container-fluid">
                <h4 class="mb-0 fw-bold">
                    <i class="bi bi-person-plus text-primary me-2"></i>Add Student to ${batch.batchName}
                </h4>
                <a href="<c:url value='/dashboard/batchDetails/${batch.id}'/>" class="btn btn-outline-primary btn-sm">
                    <i class="bi bi-arrow-left me-1"></i>Back to Batch
                </a>
            </div>
        </nav>

        <!-- Form Content -->
        <div class="container-fluid px-4 py-4">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body p-4">

                            <!-- Auto-generated Student ID Display -->
                            <div class="alert alert-info border-0 mb-4">
                                <div class="d-flex align-items-center">
                                    <i class="bi bi-info-circle fs-3 me-3"></i>
                                    <div>
                                        <strong>Next Student ID:</strong>
                                        <span class="badge bg-primary fs-6 ms-2">${nextStudentId}</span>
                                        <br>
                                        <small>This ID will be automatically assigned to the student</small>
                                    </div>
                                </div>
                            </div>

                            <c:if test="${not empty error}">
                                <div class="alert alert-danger alert-dismissible">
                                    <i class="bi bi-exclamation-triangle me-2"></i>${error}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <form action="<c:url value='/dashboard/addStudent'/>" method="post">


                                <!-- Hidden Batch ID -->
                                <input type="hidden" name="batchId" value="${batch.id}">

                                <!-- Name -->
                                <div class="mb-3">
                                    <label class="form-label fw-semibold">
                                        <i class="bi bi-person me-2"></i>Full Name <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" class="form-control" name="name"
                                           placeholder="Enter student name" required>
                                </div>

                                <!-- Email -->
                                <div class="mb-3">
                                    <label class="form-label fw-semibold">
                                        <i class="bi bi-envelope me-2"></i>Email <span class="text-danger">*</span>
                                    </label>
                                    <input type="email" class="form-control" name="email"
                                           placeholder="student@example.com" required>
                                </div>

                                <!-- Phone -->
                                <div class="mb-3">
                                    <label class="form-label fw-semibold">
                                        <i class="bi bi-telephone me-2"></i>Phone Number <span class="text-danger">*</span>
                                    </label>
                                    <input type="tel" class="form-control" name="phone"
                                           placeholder="9876543210" maxlength="10"
                                           pattern="[6-9][0-9]{9}" required>
                                    <small class="text-muted">Must start with 6-9 and contain 10 digits</small>
                                </div>

                                <div class="row">
                                    <!-- Gender -->
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label fw-semibold">
                                            <i class="bi bi-gender-ambiguous me-2"></i>Gender <span class="text-danger">*</span>
                                        </label>
                                        <select class="form-select" name="gender" required>
                                            <option value="">Select Gender</option>
                                            <option value="Male">Male</option>
                                            <option value="Female">Female</option>
                                            <option value="Other">Other</option>
                                        </select>
                                    </div>

                                    <!-- Age -->
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label fw-semibold">
                                            <i class="bi bi-calendar me-2"></i>Age <span class="text-danger">*</span>
                                        </label>
                                        <input type="number" class="form-control" name="age"
                                               placeholder="18" min="18" max="60" required>
                                        <small class="text-muted">Must be between 18-60</small>
                                    </div>
                                </div>

                                <!-- Address -->
                                <div class="mb-4">
                                    <label class="form-label fw-semibold">
                                        <i class="bi bi-geo-alt me-2"></i>Address <span class="text-danger">*</span>
                                    </label>
                                    <textarea class="form-control" name="address" rows="3"
                                              placeholder="Enter complete address (minimum 10 characters)"
                                              minlength="10" required></textarea>
                                </div>

                                <!-- Buttons -->
                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                    <a href="<c:url value='/dashboard/batchDetails/${batch.id}'/>"
                                       class="btn btn-outline-secondary">
                                        <i class="bi bi-x-circle me-1"></i>Cancel
                                    </a>
                                    <button type="submit" class="btn btn-primary px-4">
                                        <i class="bi bi-check-circle me-1"></i>Add Student
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Batch Info Card -->
                    <div class="card border-0 shadow-sm mt-4">
                        <div class="card-header bg-primary bg-opacity-10">
                            <h6 class="mb-0 fw-bold">
                                <i class="bi bi-info-circle me-2"></i>Batch Information
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <small class="text-muted d-block mb-1">Batch Name</small>
                                    <p class="mb-0 fw-semibold">${batch.batchName}</p>
                                </div>
                                <div class="col-md-6">
                                    <small class="text-muted d-block mb-1">Course</small>
                                    <p class="mb-0 fw-semibold">${batch.course}</p>
                                </div>
                                <div class="col-md-6">
                                    <small class="text-muted d-block mb-1">Instructor</small>
                                    <p class="mb-0 fw-semibold">${batch.instructor}</p>
                                </div>
                                <div class="col-md-6">
                                    <small class="text-muted d-block mb-1">Batch Type</small>
                                    <span class="badge bg-primary">${batch.batchType}</span>
                                </div>
                                <div class="col-md-6">
                                    <small class="text-muted d-block mb-1">Start Date</small>
                                    <p class="mb-0 fw-semibold">${batch.startDate}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Sidebar Toggle
    const menuToggle = document.getElementById('menuToggle');
    const sidebar = document.getElementById('sidebar');
    const sidebarOverlay = document.getElementById('sidebarOverlay');

    menuToggle.addEventListener('click', function() {
        menuToggle.classList.toggle('active');
        sidebar.classList.toggle('active');
        sidebarOverlay.classList.toggle('active');
    });

    sidebarOverlay.addEventListener('click', function() {
        menuToggle.classList.remove('active');
        sidebar.classList.remove('active');
        sidebarOverlay.classList.remove('active');
    });

    // Form validation
    document.querySelector('form').addEventListener('submit', function(e) {
        const phone = document.querySelector('input[name="phone"]').value;
        const phonePattern = /^[6-9][0-9]{9}$/;

        if (!phonePattern.test(phone)) {
            e.preventDefault();
            alert('Phone number must start with 6-9 and contain exactly 10 digits');
            return false;
        }

        const age = parseInt(document.querySelector('input[name="age"]').value);
        if (age < 18 || age > 60) {
            e.preventDefault();
            alert('Age must be between 18 and 60');
            return false;
        }
    });
</script>
</body>
</html>