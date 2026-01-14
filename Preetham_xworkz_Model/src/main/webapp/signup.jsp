<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Signup</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-5">

      <div class="card shadow p-4">
        <h4 class="text-center mb-3">Student Registration</h4>

        <!-- POST to /signup controller -->

        <form action="<c:url value='/signup'/>" method="post" onsubmit="validateSignupForm(event)">


          <!-- Name -->
          <div class="mb-3">
            <label class="form-label">Full Name</label>
            <input type="text" name="name" class="form-control" required>
          </div>

          <!-- Email -->
          <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email" class="form-control" required>
          </div>

          <!-- Phone -->
          <div class="mb-3">
            <label class="form-label">Mobile</label>
            <input type="text" name="phone" class="form-control" required>
          </div>

          <!-- Age -->
          <div class="mb-3">
            <label class="form-label">Age</label>
            <input type="number" name="age" class="form-control" min="10" max="100" required>
          </div>

          <!-- Gender -->
          <div class="mb-3">
            <label class="form-label d-block">Gender</label>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="gender" id="genderMale" value="Male" required>
              <label class="form-check-label" for="genderMale">Male</label>
            </div>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="gender" id="genderFemale" value="Female">
              <label class="form-check-label" for="genderFemale">Female</label>
            </div>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="gender" id="genderOther" value="Other">
              <label class="form-check-label" for="genderOther">Other</label>
            </div>
          </div>

          <!-- Address -->
          <div class="mb-3">
            <label class="form-label">Address</label>
            <textarea name="address" class="form-control" rows="3" required></textarea>
          </div>

          <!-- Password -->
          <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password" id="password" class="form-control" required>
          </div>

          <!-- Confirm Password -->
          <div class="mb-3">
            <label class="form-label">Confirm Password</label>
            <input type="password" name="confirmPassword" id="confirmPassword" class="form-control" required>
          </div>

          <button type="submit" class="btn btn-warning w-100">Create Account</button>

        </form>

        <div class="text-center mt-3">
          Already registered?
          <!-- go to login via controller -->
          <form action="<c:url value='/login'/>" method="post" class="d-inline">
              <button type="submit" class="btn btn-link p-0 align-baseline">Login</button>
          </form>
        </div>

      </div>
    </div>
  </div>
</div>

<script src="<c:url value='/js/validation.js'/>"></script>


</body>
</html>
