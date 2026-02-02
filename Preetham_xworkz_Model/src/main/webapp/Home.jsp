<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home | X-Workz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>

        :root {
            --sidebar-bg: #1e293b; /* Modern Slate Dark */
            --sidebar-hover: #334155;
            --accent-color: #38bdf8; /* Soft Sky Blue */
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

         .navbar.fixed-top {
                z-index: 1040;
            }

        @media (min-width: 992px) {
            .sidebar-header img { height: 45px; }
        }
    </style>
</head>

<body class="bg-light">

<button class="menu-toggle" id="menuToggle">
    <span></span>
    <span></span>
    <span></span>
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

<div class="main-content">
    <div class="content-wrapper">
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm fixed-top">
            <div class="container">
                <div style="width: 50px;"></div>
                <a class="navbar-brand d-flex align-items-center" href="#">
                    <span class="fw-bold">X-Workz Institute</span>
                </a>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto align-items-center">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" data-bs-toggle="dropdown">
                                <div class="bg-white bg-opacity-25 rounded-circle p-2 me-2">
                                    <i class="bi bi-person-fill"></i>
                                </div>
                                <span class="fw-semibold">${name != null ? name : 'User'}</span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end shadow">
                                <li class="px-3 py-2 bg-light">
                                    <h6 class="mb-0 fw-bold">${name}</h6>
                                    <small class="text-muted">${email}</small>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="signIn">Logout</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="bg-primary text-white py-5 mb-4">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-8 text-center text-md-start">
                        <h1 class="display-4 fw-bold mb-3">Welcome Back, ${name}!</h1>
                        <p class="lead mb-4 opacity-75">Your learning progress is looking great this week.</p>
                        <div class="d-flex flex-wrap gap-3 justify-content-center justify-content-md-start">
                            <button class="btn btn-light btn-lg px-4 shadow-sm">Continue Learning</button>
                            <button class="btn btn-outline-light btn-lg px-4">Browse Courses</button>
                        </div>
                    </div>
                    <div class="col-lg-4 d-none d-lg-block text-center">
                        <i class="bi bi-mortarboard" style="font-size: 8rem; opacity: 0.2;"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="container mb-5">
            <div class="row g-4">
                <div class="col-md-3">
                    <div class="card border-0 shadow-sm rounded-4 h-100 p-2">
                        <div class="card-body d-flex align-items-center">
                            <div class="rounded-3 bg-primary bg-opacity-10 p-3 me-3">
                                <i class="bi bi-book-fill text-primary fs-3"></i>
                            </div>
                            <div>
                                <h4 class="fw-bold mb-0">5</h4>
                                <small class="text-muted">Enrolled</small>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card border-0 shadow-sm rounded-4 h-100 p-2">
                        <div class="card-body d-flex align-items-center">
                            <div class="rounded-3 bg-success bg-opacity-10 p-3 me-3">
                                <i class="bi bi-trophy-fill text-success fs-3"></i>
                            </div>
                            <div>
                                <h4 class="fw-bold mb-0">3</h4>
                                <small class="text-muted">Completed</small>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card border-0 shadow-sm rounded-4 h-100 p-2">
                        <div class="card-body d-flex align-items-center">
                            <div class="rounded-3 bg-warning bg-opacity-10 p-3 me-3">
                                <i class="bi bi-clock-fill text-warning fs-3"></i>
                            </div>
                            <div>
                                <h4 class="fw-bold mb-0">24h</h4>
                                <small class="text-muted">Learning</small>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card border-0 shadow-sm rounded-4 h-100 p-2">
                        <div class="card-body d-flex align-items-center">
                            <div class="rounded-3 bg-info bg-opacity-10 p-3 me-3">
                                <i class="bi bi-star-fill text-info fs-3"></i>
                            </div>
                            <div>
                                <h4 class="fw-bold mb-0">12</h4>
                                <small class="text-muted">Certificates</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="container mb-5">
            <div class="row">
                <div class="col-lg-8 mb-4">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4 class="fw-bold mb-0">Current Progress</h4>
                        <a href="#" class="btn btn-sm btn-outline-primary rounded-pill">View All</a>
                    </div>
                    <div class="row g-4">
                        <div class="col-md-6">
                            <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between mb-2">
                                        <span class="badge bg-primary-subtle text-primary rounded-pill">In Progress</span>
                                        <i class="bi bi-three-dots"></i>
                                    </div>
                                    <h6 class="fw-bold">Java Full Stack Development</h6>
                                    <div class="progress mt-3 mb-2" style="height: 6px;">
                                        <div class="progress-bar bg-primary" style="width: 65%"></div>
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <small class="text-muted">65% Done</small>
                                        <small class="fw-bold text-primary">Resume <i class="bi bi-arrow-right"></i></small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </div>
                </div>

                <div class="col-lg-4">
                    <div class="card border-0 shadow-sm rounded-4 mb-4">
                        <div class="card-body">
                            <h6 class="fw-bold mb-3"><i class="bi bi-calendar-event me-2"></i>Upcoming Live Classes</h6>
                            <div class="list-group list-group-flush">
                                <div class="list-group-item px-0 border-0 pb-3">
                                    <div class="d-flex align-items-center">
                                        <div class="bg-primary bg-opacity-10 text-primary p-2 rounded-3 me-3">
                                            <small class="fw-bold d-block">TODAY</small>
                                        </div>
                                        <div>
                                            <p class="mb-0 fw-bold small">Spring Boot Advanced</p>
                                            <small class="text-muted">02:00 PM - Live</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <button class="btn btn-primary w-100 rounded-pill mt-2">View Schedule</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <footer class="bg-white border-top py-4">
            <div class="container text-center">
                <p class="text-muted mb-0 small">© 2026 X-Workz Training Institute. All rights reserved.</p>
            </div>
        </footer>
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