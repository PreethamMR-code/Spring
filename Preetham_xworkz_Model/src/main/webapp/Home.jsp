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
</head>
<body class="bg-light">

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm sticky-top">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="<c:url value='/'/>">
            <img src="https://x-workz.com/Logo.png" height="40" class="me-2" alt="X-Workz">
            <span class="fw-bold">X-Workz</span>
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item">
                    <a class="nav-link active" href="#">
                        <i class="bi bi-house-door me-1"></i>Home
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <i class="bi bi-book me-1"></i>Courses
                    </a>
                </li>

                <!-- ✅ UPDATED: Profile Dropdown with Name -->
                <li class="nav-item dropdown ms-3">
                    <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        <div class="bg-white bg-opacity-25 rounded-circle p-2 me-2">
                            <i class="bi bi-person-fill"></i>
                        </div>
                        <span class="fw-semibold">${name != null ? name : 'User'}</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end shadow" style="min-width: 280px;">
                        <!-- Profile Info Section -->
                        <li class="px-3 py-2 bg-light">
                            <div class="d-flex align-items-center">
                                <div class="bg-primary bg-opacity-10 rounded-circle p-3 me-3">
                                    <i class="bi bi-person-fill text-primary fs-4"></i>
                                </div>
                                <div class="flex-grow-1">
                                    <h6 class="mb-0 fw-bold">${name != null ? name : 'User Name'}</h6>
                                    <small class="text-muted">${email != null ? email : 'email@example.com'}</small>
                                </div>
                            </div>
                        </li>

                        <li><hr class="dropdown-divider"></li>

                        <!-- Profile Actions -->
                        <li>
                            <a class="dropdown-item py-2" href="editProfile">
                                <i class="bi bi-pencil-square me-2 text-primary"></i>
                                <span class="fw-semibold">Edit Profile</span>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item py-2" href="#">
                                <i class="bi bi-gear me-2 text-secondary"></i>
                                <span class="fw-semibold">Settings</span>
                            </a>
                        </li>

                        <li><hr class="dropdown-divider"></li>

                        <!-- Logout -->
                        <li>
                            <a class="dropdown-item py-2 text-danger" href="signIn">
                                <i class="bi bi-box-arrow-right me-2"></i>
                                <span class="fw-semibold">Logout</span>
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Welcome Banner -->
<div class="bg-primary text-white py-5">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-8">
                <h1 class="display-4 fw-bold mb-3">Welcome Back, ${name != null ? name : 'User'}!</h1>
                <p class="lead mb-4">Continue your learning journey with X-Workz Training Institute</p>
                <div class="d-flex gap-3">
                    <button class="btn btn-light btn-lg px-4">
                        <i class="bi bi-play-circle me-2"></i>Continue Learning
                    </button>
                    <button class="btn btn-outline-light btn-lg px-4">
                        <i class="bi bi-search me-2"></i>Browse Courses
                    </button>
                </div>
            </div>
            <div class="col-lg-4 d-none d-lg-block text-center">
                <i class="bi bi-mortarboard display-1"></i>
            </div>
        </div>
    </div>
</div>

<!-- Quick Stats -->
<div class="container my-5">
    <div class="row g-4">
        <div class="col-md-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body text-center">
                    <div class="bg-primary bg-opacity-10 rounded-circle d-inline-flex p-3 mb-3">
                        <i class="bi bi-book-fill text-primary fs-1"></i>
                    </div>
                    <h3 class="fw-bold mb-2">5</h3>
                    <p class="text-muted mb-0">Enrolled Courses</p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body text-center">
                    <div class="bg-success bg-opacity-10 rounded-circle d-inline-flex p-3 mb-3">
                        <i class="bi bi-trophy-fill text-success fs-1"></i>
                    </div>
                    <h3 class="fw-bold mb-2">3</h3>
                    <p class="text-muted mb-0">Completed</p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body text-center">
                    <div class="bg-warning bg-opacity-10 rounded-circle d-inline-flex p-3 mb-3">
                        <i class="bi bi-clock-fill text-warning fs-1"></i>
                    </div>
                    <h3 class="fw-bold mb-2">24h</h3>
                    <p class="text-muted mb-0">Learning Time</p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body text-center">
                    <div class="bg-info bg-opacity-10 rounded-circle d-inline-flex p-3 mb-3">
                        <i class="bi bi-star-fill text-info fs-1"></i>
                    </div>
                    <h3 class="fw-bold mb-2">12</h3>
                    <p class="text-muted mb-0">Certificates</p>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Main Content -->
<div class="container my-5">
    <div class="row">
        <!-- My Courses -->
        <div class="col-lg-8 mb-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold mb-0">My Courses</h2>
                <a href="#" class="btn btn-outline-primary">View All</a>
            </div>

            <div class="row g-4">
                <div class="col-md-6">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-start mb-3">
                                <span class="badge bg-primary">In Progress</span>
                                <i class="bi bi-bookmark-fill text-warning"></i>
                            </div>
                            <h5 class="card-title fw-bold">Java Full Stack Development</h5>
                            <p class="text-muted small mb-3">Master Java, Spring Boot, and React</p>
                            <div class="progress mb-2" style="height: 8px;">
                                <div class="progress-bar bg-primary" role="progressbar" style="width: 65%"></div>
                            </div>
                            <div class="d-flex justify-content-between align-items-center">
                                <small class="text-muted">65% Complete</small>
                                <a href="#" class="btn btn-sm btn-primary">Continue</a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-start mb-3">
                                <span class="badge bg-success">Completed</span>
                                <i class="bi bi-bookmark text-muted"></i>
                            </div>
                            <h5 class="card-title fw-bold">Python Programming</h5>
                            <p class="text-muted small mb-3">Learn Python from basics to advanced</p>
                            <div class="progress mb-2" style="height: 8px;">
                                <div class="progress-bar bg-success" role="progressbar" style="width: 100%"></div>
                            </div>
                            <div class="d-flex justify-content-between align-items-center">
                                <small class="text-muted">100% Complete</small>
                                <a href="#" class="btn btn-sm btn-outline-success">
                                    <i class="bi bi-award me-1"></i>Certificate
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-start mb-3">
                                <span class="badge bg-warning text-dark">Starting Soon</span>
                                <i class="bi bi-bookmark text-muted"></i>
                            </div>
                            <h5 class="card-title fw-bold">Database Management</h5>
                            <p class="text-muted small mb-3">MySQL, MongoDB, and PostgreSQL</p>
                            <div class="progress mb-2" style="height: 8px;">
                                <div class="progress-bar bg-warning" role="progressbar" style="width: 0%"></div>
                            </div>
                            <div class="d-flex justify-content-between align-items-center">
                                <small class="text-muted">Starts: Jan 30, 2026</small>
                                <a href="#" class="btn btn-sm btn-outline-primary">View Details</a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-start mb-3">
                                <span class="badge bg-primary">In Progress</span>
                                <i class="bi bi-bookmark text-muted"></i>
                            </div>
                            <h5 class="card-title fw-bold">Web Development Basics</h5>
                            <p class="text-muted small mb-3">HTML, CSS, JavaScript fundamentals</p>
                            <div class="progress mb-2" style="height: 8px;">
                                <div class="progress-bar bg-primary" role="progressbar" style="width: 40%"></div>
                            </div>
                            <div class="d-flex justify-content-between align-items-center">
                                <small class="text-muted">40% Complete</small>
                                <a href="#" class="btn btn-sm btn-primary">Continue</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Sidebar -->
        <div class="col-lg-4">
            <!-- Upcoming Classes -->
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-body">
                    <h5 class="card-title fw-bold mb-3">
                        <i class="bi bi-calendar-check text-primary me-2"></i>Upcoming Classes
                    </h5>
                    <div class="list-group list-group-flush">
                        <div class="list-group-item px-0 border-0">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <h6 class="mb-1 fw-bold">Spring Boot Advanced</h6>
                                    <small class="text-muted">
                                        <i class="bi bi-clock me-1"></i>Today, 2:00 PM
                                    </small>
                                </div>
                                <span class="badge bg-primary">Live</span>
                            </div>
                        </div>
                        <div class="list-group-item px-0 border-0">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <h6 class="mb-1 fw-bold">React Hooks Deep Dive</h6>
                                    <small class="text-muted">
                                        <i class="bi bi-clock me-1"></i>Tomorrow, 10:00 AM
                                    </small>
                                </div>
                            </div>
                        </div>
                        <div class="list-group-item px-0 border-0">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <h6 class="mb-1 fw-bold">Database Optimization</h6>
                                    <small class="text-muted">
                                        <i class="bi bi-clock me-1"></i>Jan 25, 3:00 PM
                                    </small>
                                </div>
                            </div>
                        </div>
                    </div>
                    <a href="#" class="btn btn-outline-primary btn-sm w-100 mt-3">View All Classes</a>
                </div>
            </div>

            <!-- Announcements -->
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-body">
                    <h5 class="card-title fw-bold mb-3">
                        <i class="bi bi-megaphone text-warning me-2"></i>Announcements
                    </h5>
                    <div class="alert alert-info border-0 mb-3">
                        <h6 class="alert-heading fw-bold mb-2">New Course Launch</h6>
                        <p class="small mb-0">Cloud Computing with AWS starts Feb 1st. Early bird discount available!</p>
                    </div>
                    <div class="alert alert-warning border-0 mb-0">
                        <h6 class="alert-heading fw-bold mb-2">Maintenance Notice</h6>
                        <p class="small mb-0">Platform will be under maintenance on Jan 28, 2:00-4:00 AM.</p>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="card border-0 shadow-sm">
                <div class="card-body">
                    <h5 class="card-title fw-bold mb-3">Quick Actions</h5>
                    <div class="d-grid gap-2">
                        <button class="btn btn-outline-primary">
                            <i class="bi bi-search me-2"></i>Browse Courses
                        </button>
                        <button class="btn btn-outline-primary">
                            <i class="bi bi-download me-2"></i>Download Resources
                        </button>
                        <button class="btn btn-outline-primary">
                            <i class="bi bi-question-circle me-2"></i>Help & Support
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Recommended Courses -->
<div class="bg-white py-5">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold mb-0">Recommended for You</h2>
            <a href="#" class="btn btn-outline-primary">Explore All</a>
        </div>

        <div class="row g-4">
            <div class="col-md-4">
                <div class="card border-0 shadow-sm h-100">
                    <img src="https://via.placeholder.com/400x200/667eea/ffffff?text=Microservices" class="card-img-top" alt="Course">
                    <div class="card-body">
                        <span class="badge bg-primary mb-2">Advanced</span>
                        <h5 class="card-title fw-bold">Microservices Architecture</h5>
                        <p class="text-muted small">Build scalable applications with microservices</p>
                        <div class="d-flex justify-content-between align-items-center mt-3">
                            <div>
                                <i class="bi bi-star-fill text-warning"></i>
                                <span class="fw-bold">4.8</span>
                                <small class="text-muted">(1.2k)</small>
                            </div>
                            <button class="btn btn-primary btn-sm">Enroll Now</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card border-0 shadow-sm h-100">
                    <img src="https://via.placeholder.com/400x200/764ba2/ffffff?text=DevOps" class="card-img-top" alt="Course">
                    <div class="card-body">
                        <span class="badge bg-success mb-2">Intermediate</span>
                        <h5 class="card-title fw-bold">DevOps Essentials</h5>
                        <p class="text-muted small">CI/CD, Docker, Kubernetes fundamentals</p>
                        <div class="d-flex justify-content-between align-items-center mt-3">
                            <div>
                                <i class="bi bi-star-fill text-warning"></i>
                                <span class="fw-bold">4.9</span>
                                <small class="text-muted">(890)</small>
                            </div>
                            <button class="btn btn-primary btn-sm">Enroll Now</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card border-0 shadow-sm h-100">
                    <img src="https://via.placeholder.com/400x200/f093fb/ffffff?text=AI+ML" class="card-img-top" alt="Course">
                    <div class="card-body">
                        <span class="badge bg-warning text-dark mb-2">Beginner</span>
                        <h5 class="card-title fw-bold">AI & Machine Learning</h5>
                        <p class="text-muted small">Introduction to artificial intelligence</p>
                        <div class="d-flex justify-content-between align-items-center mt-3">
                            <div>
                                <i class="bi bi-star-fill text-warning"></i>
                                <span class="fw-bold">4.7</span>
                                <small class="text-muted">(750)</small>
                            </div>
                            <button class="btn btn-primary btn-sm">Enroll Now</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="bg-dark text-white py-4 mt-5">
    <div class="container">
        <div class="row">
            <div class="col-md-4 mb-3">
                <h5 class="fw-bold mb-3">X-Workz Training Institute</h5>
                <p class="small text-muted">Empowering learners with industry-relevant skills and knowledge.</p>
            </div>
            <div class="col-md-4 mb-3">
                <h6 class="fw-bold mb-3">Quick Links</h6>
                <ul class="list-unstyled">
                    <li><a href="#" class="text-decoration-none text-muted small">About Us</a></li>
                    <li><a href="#" class="text-decoration-none text-muted small">Contact</a></li>
                    <li><a href="#" class="text-decoration-none text-muted small">Privacy Policy</a></li>
                    <li><a href="#" class="text-decoration-none text-muted small">Terms of Service</a></li>
                </ul>
            </div>
            <div class="col-md-4 mb-3">
                <h6 class="fw-bold mb-3">Connect With Us</h6>
                <div class="d-flex gap-3">
                    <a href="#" class="text-white"><i class="bi bi-facebook fs-4"></i></a>
                    <a href="#" class="text-white"><i class="bi bi-twitter fs-4"></i></a>
                    <a href="#" class="text-white"><i class="bi bi-linkedin fs-4"></i></a>
                    <a href="#" class="text-white"><i class="bi bi-instagram fs-4"></i></a>
                </div>
            </div>
        </div>
        <hr class="border-secondary">
        <div class="text-center">
            <p class="mb-0 small text-muted">© 2026 X-Workz Training Institute. All rights reserved.</p>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>