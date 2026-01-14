<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-4">

      <div class="card shadow p-4">
        <h4 class="text-center mb-3">Student Login</h4>

        <!-- POST to /login controller -->

        <form action="<c:url value='/login'/>" method="post"
              onsubmit="validateLoginForm(event)">


          <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email" class="form-control" required>
          </div>

          <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control" required>
          </div>

          <button type="submit" class="btn btn-primary w-100">Login</button>

        </form>

        <div class="text-center mt-3">
          New user?
          <!-- go to signup via controller -->
          <form action="<c:url value='/signup'/>" method="post" class="d-inline">
              <button type="submit" class="btn btn-link p-0 align-baseline">Create Account</button>
          </form>
        </div>

      </div>
    </div>
  </div>
</div>


<script src="<c:url value='/js/validation.js'/>"></script>



</body>
</html>
