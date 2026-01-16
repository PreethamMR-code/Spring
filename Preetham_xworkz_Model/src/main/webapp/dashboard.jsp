<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        body {
            background: #f5f6fa;
        }
        .navbar-brand img {
            height: 40px;
        }
        .welcome-card {
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0,0,0,0.08);
        }
    </style>
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4">
    <a class="navbar-brand d-flex align-items-center" href="<c:url value='/'/>">
        <img src="<c:url value='/assets/xworkz-logo.png'/>" class="me-2" alt="X-Workz Logo">
        <span> Training</span>
    </a>

    <div class="collapse navbar-collapse">
        <ul class="navbar-nav ms-auto align-items-center">
            <li class="nav-item">
                <a class="nav-link" href="<c:url value='/'/>">Home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Courses</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Profile</a>
            </li>
            <li class="nav-item ms-3">
                <a class="btn btn-outline-light btn-sm" href="<c:url value='/logout'/>">
                    Logout
                </a>
            </li>
        </ul>

    </div>
</nav>

<!-- MAIN CONTENT -->
<div class="container mt-4">
    <div class="row">
        <div class="col-md-8">

            <div class="card welcome-card p-4 mb-4">
                <h3 class="mb-2">Welcome,
                    <c:out value="${studentName != null ? studentName : 'Student'}"/>
                </h3>
                <p class="text-muted mb-0">
                    You are successfully logged in. Explore your courses and track your learning progress here.
                </p>
            </div>

            <div class="card p-3 mb-4">
                <h5 class="mb-3">Your Details</h5>
                <p class="mb-1"><strong>Name:</strong> <c:out value="${studentName}"/></p>
                <p class="mb-1"><strong>Email:</strong> <c:out value="${studentEmail}"/></p>
                <p class="mb-1"><strong>Phone:</strong> <c:out value="${studentPhone}"/></p>
            </div>

        </div>

        <div class="col-md-4">
            <div class="card p-3 mb-3">
                <h6 class="mb-2">Quick Actions</h6>
                <ul class="list-unstyled mb-0">
                    <li><a href="#">View Courses</a></li>
                    <li><a href="#">Update Profile</a></li>
                    <li><a href="#">Support</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>

</body>
</html>
