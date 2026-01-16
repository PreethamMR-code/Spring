<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Signup</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">


          <style>
              body {
                  padding-top: 70px; /* prevents overlap with fixed navbar */
              }
              .navbar-brand img {
                  height: 40px;
              }
          </style>

</head>

<body class="bg-light">

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container-fluid px-4">

        <!-- Logo -->
        <a class="navbar-brand d-flex align-items-center" href="<c:url value='/'/>">
            <img src="<c:url value='/assets/xworkz-logo.png'/>" class="me-2" alt="X-Workz Logo">
            <span class="fw-bold">X-Workz</span>
        </a>

        <!-- Toggler -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav" aria-controls="navbarNav"
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Menu -->
        <div class="collapse navbar-collapse" id="navbarNav">

            <!-- Left Links -->
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" href="<c:url value='/'/>">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Courses</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Placements</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">About</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Contact</a>
                </li>
            </ul>

            <!-- Right Actions -->
            <div class="d-flex">
                <a href="<c:url value='/login'/>" class="btn btn-outline-light me-2">
                    Login
                </a>
                <a href="<c:url value='/signup'/>" class="btn btn-warning">
                    Sign Up
                </a>
            </div>

        </div>
    </div>
</nav>


<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-5">

<c:if test="${not empty error}">
    <div class="alert alert-danger text-center">
        ${error}
    </div>
</c:if>

      <div class="card shadow p-4">
        <h4 class="text-center mb-3">Student Registration</h4>

        <form action="<c:url value='/signup'/>" method="post"
              onsubmit="return validateSignupForm(event)">

          <!-- Name -->
          <div class="mb-3">
            <label class="form-label">Full Name</label>
            <input type="text" name="name" class="form-control"
                   oninput="validateName()">
            <small class="text-danger" id="nameError"></small>
          </div>

          <!-- Email -->
          <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email" class="form-control"
                   oninput="validateEmail()">
            <small class="text-danger" id="emailError"></small>
          </div>

          <!-- Phone -->
          <div class="mb-3">
            <label class="form-label">Mobile</label>
            <input type="text" name="phone" class="form-control"
                   oninput="validatePhone()">
            <small class="text-danger" id="phoneError"></small>
          </div>

          <!-- Age -->
          <div class="mb-3">
            <label class="form-label">Age</label>
            <input type="number" name="age" class="form-control"
                   min="10" max="100"
                   onchange="validateAge()">
            <small class="text-danger" id="ageError"></small>
          </div>

          <!-- Gender -->
          <div class="mb-3">
            <label class="form-label d-block">Gender</label>

            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="gender"
                       value="Male" onchange="validateGender()">
                <label class="form-check-label">Male</label>
            </div>

            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="gender"
                       value="Female" onchange="validateGender()">
                <label class="form-check-label">Female</label>
            </div>

            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="gender"
                       value="Other" onchange="validateGender()">
                <label class="form-check-label">Other</label>
            </div>

            <small class="text-danger" id="genderError"></small>
          </div>

          <!-- Address -->
          <div class="mb-3">
            <label class="form-label">Address</label>
            <textarea name="address" class="form-control" rows="3"
                      oninput="validateAddress()"></textarea>
            <small class="text-danger" id="addressError"></small>
          </div>

          <!-- Password -->
          <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password" id="password"
                   class="form-control"
                   oninput="validatePassword()">
            <small class="text-danger" id="passwordError"></small>
          </div>

          <!-- Confirm Password -->
          <div class="mb-3">
            <label class="form-label">Confirm Password</label>
            <input type="password" name="confirmPassword" id="confirmPassword"
                   class="form-control"
                   oninput="validateConfirmPassword()">
            <small class="text-danger" id="confirmPasswordError"></small>
          </div>

          <button type="submit" class="btn btn-warning w-100">
              Create Account
          </button>

        </form>

        <div class="text-center mt-3">
          Already registered?
          <form action="<c:url value='/login'/>" method="post" class="d-inline">
              <button type="submit" class="btn btn-link p-0 align-baseline">
                  Login
              </button>
          </form>
        </div>

      </div>
    </div>
  </div>
</div>

<script src="<c:url value='/js/validation.js'/>"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>


</body>
</html>
