<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Registration Portal</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        body {
            background-color: #f4f6f9;
        }
        .card {
            transition: transform 0.2s ease-in-out;
        }
        .card:hover {
            transform: translateY(-5px);
        }
    </style>
</head>

<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="#">Spring MVC Project</a>
    </div>
</nav>

<!-- Page Header -->
<div class="container mt-5">
    <div class="text-center mb-4">
        <h2 class="fw-bold">Registration Modules</h2>
        <p class="text-muted">Choose a form to register data</p>
    </div>

    <!-- Cards -->
    <div class="row g-4">

        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body text-center">
                    <h5 class="card-title">Student Registration</h5>
                    <p class="card-text">Register student details</p>
                    <a href="student.jsp" class="btn btn-primary w-100">Register</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body text-center">
                    <h5 class="card-title">Employee Registration</h5>
                    <p class="card-text">Register employee details</p>
                    <a href="employee.jsp" class="btn btn-success w-100">Register</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body text-center">
                    <h5 class="card-title">Customer Registration</h5>
                    <p class="card-text">Register customer information</p>
                    <a href="customer.jsp" class="btn btn-warning w-100">Register</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body text-center">
                    <h5 class="card-title">Vendor Registration</h5>
                    <p class="card-text">Register vendor details</p>
                    <a href="vendor.jsp" class="btn btn-info w-100">Register</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body text-center">
                    <h5 class="card-title">Doctor Registration</h5>
                    <p class="card-text">Register doctor profile</p>
                    <a href="doctor.jsp" class="btn btn-danger w-100">Register</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body text-center">
                    <h5 class="card-title">Trainer Registration</h5>
                    <p class="card-text">Register trainer details</p>
                    <a href="trainer.jsp" class="btn btn-secondary w-100">Register</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body text-center">
                    <h5 class="card-title">Course Registration</h5>
                    <p class="card-text">Register course details</p>
                    <a href="course.jsp" class="btn btn-dark w-100">Register</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body text-center">
                    <h5 class="card-title">Event Registration</h5>
                    <p class="card-text">Register event information</p>
                    <a href="event.jsp" class="btn btn-primary w-100">Register</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body text-center">
                    <h5 class="card-title">Product Registration</h5>
                    <p class="card-text">Register product details</p>
                    <a href="product.jsp" class="btn btn-success w-100">Register</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body text-center">
                    <h5 class="card-title">Service Registration</h5>
                    <p class="card-text">Register service details</p>
                    <a href="service.jsp" class="btn btn-warning w-100">Register</a>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- Footer -->
<footer class="bg-dark text-white text-center mt-5 p-3">
    © 2026 Spring MVC Registration System
</footer>

</body>
</html>
