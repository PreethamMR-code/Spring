<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>X-Workz Training Institute</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        body{
            background:#f5f6fa;
        }
        .navbar-brand img{
            height:50px;
        }
        .hero{
            min-height:85vh;
            background: linear-gradient(to right,#000,#222);
            color:white;
            display:flex;
            align-items:center;
        }
        .hero h1{
            font-size:3rem;
            font-weight:700;
        }
        .hero p{
            font-size:1.2rem;
            color:#ddd;
        }
        .btn-main{
            background:#ff4d00;
            color:white;
        }
        .feature-card{
            border:none;
            border-radius:12px;
            box-shadow:0 0 15px rgba(0,0,0,0.1);
        }
    </style>
</head>

<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4 fixed-top">
    <a class="navbar-brand d-flex align-items-center" href="<c:url value='/'/>">
        <img src="<c:url value='/assets/xworkz-logo.png'/>" class="me-2" alt="X-Workz Logo">
    </a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
            data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav me-auto">
            <li class="nav-item"><a class="nav-link active" href="<c:url value='/'/>">Home</a></li>
            <li class="nav-item"><a class="nav-link" href="#">Courses</a></li>
            <li class="nav-item"><a class="nav-link" href="#">Placements</a></li>
            <li class="nav-item"><a class="nav-link" href="#">About</a></li>
            <li class="nav-item"><a class="nav-link" href="#">Contact</a></li>
        </ul>

        <div class="d-flex">
            <!-- submit to /login (POST) -->
            <form action="<c:url value='/login'/>" method="post" class="me-2">
                <button type="submit" class="btn btn-outline-light">Sign In</button>
            </form>

            <!-- submit to /signup (POST) -->
            <form action="<c:url value='/signup'/>" method="post">
                <button type="submit" class="btn btn-warning">Sign Up</button>
            </form>
        </div>
    </div>
</nav>

<!-- HERO -->
<div class="hero">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h1>X-Workz Training Institute</h1>
                <p class="mt-3">
                    Industry-oriented training in Java, Spring, Web Technologies
                    and Enterprise Application Development with placement support.
                </p>

                <div class="mt-4">
                    <form action="<c:url value='/signup'/>" method="post" class="d-inline">
                        <button type="submit" class="btn btn-main btn-lg me-3">Get Started</button>
                    </form>

                    <form action="<c:url value='/login'/>" method="post" class="d-inline">
                        <button type="submit" class="btn btn-outline-light btn-lg">Login</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- FEATURES -->
<div class="container py-5">
    <h2 class="text-center fw-bold mb-5">Why X-Workz?</h2>

    <div class="row g-4 text-center">
        <div class="col-md-4">
            <div class="card feature-card p-4">
                <h5>Industry Experts</h5>
                <p>Trainers with real corporate experience.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card feature-card p-4">
                <h5>Placement Support</h5>
                <p>Interview training and job referrals.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card feature-card p-4">
                <h5>Real-Time Projects</h5>
                <p>Work on enterprise-level applications.</p>
            </div>
        </div>
    </div>
</div>

<!-- FOOTER -->
<footer class="bg-dark text-white text-center py-3">
    © 2026 X-Workz Training Institute | Bengaluru
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
