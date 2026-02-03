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
    <style>

    :root {
                --sidebar-bg: #1e293b;
                --sidebar-hover: #334155;
                --accent-color: #38bdf8;
            }

            body {
                overflow-x: hidden;
                background-color: #f8fafc;
            }

     /* Professional Sidebar Styles */
            .sidebar {
                position: fixed;
                top: 0;
                left: -280px;
                width: 280px;
                height: 100vh;
                background: var(--sidebar-bg);
                transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                z-index: 1060;
                box-shadow: 4px 0 25px rgba(0,0,0,0.15);
                overflow-y: auto;
                border-right: 1px solid rgba(255,255,255,0.05);
            }

            .sidebar.active {
                left: 0;
            }

            .sidebar-header {
                padding: 1.5rem;
                background: rgba(0,0,0,0.2);
                border-bottom: 1px solid rgba(255,255,255,0.05);
                margin-bottom: 10px;
            }

            .sidebar-menu {
                padding: 10px 12px;
            }

            .sidebar-menu .menu-item {
                padding: 12px 18px;
                color: #94a3b8; /* Muted slate */
                text-decoration: none;
                display: flex;
                align-items: center;
                border-radius: 8px;
                margin-bottom: 4px;
                font-weight: 500;
                font-size: 0.95rem;
                transition: all 0.2s ease;
            }

            .sidebar-menu .menu-item:hover {
                background: var(--sidebar-hover);
                color: #f1f5f9;
                transform: translateX(4px);
            }

            .sidebar-menu .menu-item.active {
                background: rgba(56, 189, 248, 0.1);
                color: var(--accent-color);
            }

            .sidebar-menu .menu-item i {
                font-size: 1.25rem;
                margin-right: 14px;
                transition: transform 0.2s ease;
            }

            .sidebar-menu .menu-item:hover i {
                transform: scale(1.1);
                color: var(--accent-color);
            }

            .sidebar-section {
                padding: 20px 18px 8px;
                color: #475569;
                font-size: 0.7rem;
                text-transform: uppercase;
                font-weight: 700;
                letter-spacing: 1.5px;
            }

            /* Modern Hamburger Toggle */
            .menu-toggle {
                position: fixed;
                top: 15px;
                left: 15px;
                width: 45px;
                height: 45px;
                background: white;
                border: 1px solid #e2e8f0;
                border-radius: 12px;
                cursor: pointer;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                gap: 4px;
                z-index: 1055;
                box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1);
                transition: all 0.3s ease;
            }

            .menu-toggle:hover {
                background: #f8fafc;
                border-color: #cbd5e1;
            }

            .menu-toggle span {
                width: 20px;
                height: 2px;
                background: #475569;
                border-radius: 2px;
                transition: 0.3s;
            }

            .menu-toggle.active {
                left: 295px; /* Moves with sidebar */
                background: var(--sidebar-bg);
                border: none;
            }

            .menu-toggle.active span { background: white; }

            .sidebar-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(15, 23, 42, 0.6);
                backdrop-filter: blur(4px);
                z-index: 1050;
                display: none;
                opacity: 0;
                transition: opacity 0.3s ease;
            }

            .sidebar-overlay.active {
                display: block;
                opacity: 1;
            }

            .content-wrapper {
                transition: padding 0.4s ease;
                padding-top: 72px;
            }

            @media (min-width: 992px) {
                .sidebar-header img { height: 45px; }
            }

            .navbar.fixed-top {
                z-index: 1040;
            }

            </style>
</head>


<body class="bg-light">

<button class="menu-toggle" id="menuToggle">
    <span></span><span></span><span></span>
</button>

<div class="sidebar-overlay" id="sidebarOverlay"></div>

<div class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <div class="d-flex align-items-center">
            <img src="https://x-workz.com/Logo.png" height="35" class="me-3 filter-white" alt="X-Workz">
            <div class="text-white">
                <h6 class="mb-0 fw-bold">X-Workz</h6>
                <small class="text-muted" style="font-size: 0.7rem;">LMS DASHBOARD</small>
            </div>
        </div>
    </div>

    <div class="sidebar-menu">
        <div class="sidebar-section">Main Navigation</div>


         <a href="<c:url value='/dashboard/Home'/>" class="menu-item active">
                    <i class="bi bi-grid-1x2-fill"></i>
                    <span>Dashboard</span>
                </a>

                <a href="#" class="menu-item">
                    <i class="bi bi-journal-bookmark"></i>
                    <span>My Courses</span>
                </a>

                <a href="editProfile?email=${email}" class="menu-item">
                    <i class="bi bi-person-badge"></i>
                    <span>My Profile</span>
                </a>

                <div class="sidebar-section">Administration</div>

                <a href="<c:url value='/dashboard/addBatch'/>" class="menu-item">
                    <i class="bi bi-plus-square-dotted"></i>
                    <span>Create Batch</span>
                </a>

                <a href="<c:url value='/dashboard/viewBatches'/>" class="menu-item">
                    <i class="bi bi-layers"></i>
                    <span>Manage Batches</span>
                </a>

                <div class="sidebar-section">System</div>

                <a href="#" class="menu-item">
                    <i class="bi bi-sliders"></i>
                    <span>Settings</span>
                </a>

                <a href="signIn" class="menu-item text-danger-hover">
                    <i class="bi bi-box-arrow-right"></i>
                    <span>Logout</span>
                </a>
    </div>
</div>

<div class="content-wrapper">
    <nav class="navbar navbar-dark bg-primary shadow-sm fixed-top">
        <div class="container-fluid">
            <div style="width: 50px;"></div>
            <a class="navbar-brand d-flex align-items-center" href="#">
                <span class="fw-bold">X-Workz Institute</span>
            </a>
            <a href="<c:url value='/dashboard/Home'/>" class="btn btn-outline-light btn-sm">
                <i class="bi bi-arrow-left me-1"></i>Back
            </a>
        </div>
    </nav>

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
                        </div>

                        <!-- Instructor -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-person-video3 me-2"></i>Instructor <span class="text-danger">*</span>
                            </label>
                            <input type="text" class="form-control" name="instructor"
                                   placeholder="Enter instructor name" required>
                        </div>

                        <!-- Course -->
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

                        <!-- Batch Type -->
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
                                      placeholder="Enter batch description..."></textarea>
                        </div>

                        <!-- Buttons -->
                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">

                            <a href="<c:url value='/dashboard/Home'/>" class="btn btn-outline-secondary">
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
<script>
    const menuToggle = document.getElementById('menuToggle');
    const sidebar = document.getElementById('sidebar');
    const sidebarOverlay = document.getElementById('sidebarOverlay');

    function toggleSidebar() {
        menuToggle.classList.toggle('active');
        sidebar.classList.toggle('active');
        sidebarOverlay.classList.toggle('active');
    }

    menuToggle.addEventListener('click', toggleSidebar);
    sidebarOverlay.addEventListener('click', toggleSidebar);
</script>
</body>
</html>