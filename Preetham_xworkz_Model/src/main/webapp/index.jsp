<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>X-Workz | Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        main {
            flex: 1;
        }
        .logo-img {
            height: 45px;
            width: auto;
        }
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 100px 0;
            text-align: center;
        }
    </style>
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow px-4">
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
                <a class="nav-link active fw-semibold" href="">Home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link fw-semibold" href="#">Courses</a>
            </li>
        </ul>
        <div class="d-flex gap-2">
            <a href="signIn" class="btn btn-outline-light rounded-pill px-3">Sign In</a>
            <a href="signUp" class="btn btn-light text-primary rounded-pill px-3 fw-semibold">Sign Up</a>
        </div>
    </div>
</nav>

<main>
    <div class="hero-section">
        <div class="container">
            <h1 class="display-4 fw-bold mb-4">Welcome to X-Workz Training Institute</h1>
            <p class="lead mb-4">Learn, Grow, and Excel with Industry-Leading Courses</p>
            <div class="d-flex gap-3 justify-content-center">
                <a href="signUp" class="btn btn-light btn-lg px-5">Get Started</a>
                <a href="signIn" class="btn btn-outline-light btn-lg px-5">Sign In</a>
            </div>
        </div>
    </div>
</main>

<footer class="bg-primary text-white text-center py-3 mt-auto">
    <p class="mb-0 fw-semibold">© 2026 X-Workz Training Institute</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

