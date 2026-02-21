<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Employee Registration</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-7">

            <div class="card shadow-lg">
                <div class="card-header bg-success text-white text-center">
                    <h4>Employee Registration</h4>
                </div>

                <div class="card-body">

                    <!-- MUST match @PostMapping("employee") -->
                    <form action="employee" method="post">

                        <!-- Name -->
                        <div class="mb-3">
                            <label class="form-label">Employee Name</label>
                            <input type="text" name="name" class="form-control"
                                   value="${param.name}">
                            <small class="text-danger">${nameError}</small>
                        </div>

                        <!-- Age -->
                        <div class="mb-3">
                            <label class="form-label">Age</label>
                            <input type="number" name="age" class="form-control"
                                   value="${param.age}">
                            <small class="text-danger">${ageError}</small>
                        </div>

                        <!-- Gender -->
                        <div class="mb-3">
                            <label class="form-label">Gender (M/F)</label>
                            <input type="text" name="gender" maxlength="1"
                                   class="form-control"
                                   value="${param.gender}">
                            <small class="text-danger">${genderError}</small>
                        </div>

                        <!-- Phone -->
                        <div class="mb-3">
                            <label class="form-label">Mobile Number</label>
                            <input type="number" name="phone" class="form-control"
                                   value="${param.phone}">
                            <small class="text-danger">${phoneError}</small>
                        </div>

                        <!-- Performance -->
                        <div class="mb-3">
                            <label class="form-label">Performance Rating</label>
                            <input type="number" step="0.1" name="performance"
                                   class="form-control"
                                   value="${param.performance}">
                            <small class="text-danger">${performanceError}</small>
                        </div>

                        <!-- Salary -->
                        <div class="mb-3">
                            <label class="form-label">Salary</label>
                            <input type="number" step="0.01" name="salary"
                                   class="form-control"
                                   value="${param.salary}">
                            <small class="text-danger">${salaryError}</small>
                        </div>

                        <!-- Active (boolean) -->
                        <input type="hidden" name="active" value="false">
                        <div class="mb-3 form-check">
                            <input type="checkbox" name="active" value="true"
                                   class="form-check-input"
                                   <c:if test="${param.active eq 'true'}">checked</c:if>>
                            <label class="form-check-label">Currently Active</label>
                        </div>

                        <!-- Experience -->
                        <div class="mb-3">
                            <label class="form-label">Experience (Years)</label>
                            <input type="number" name="experience"
                                   class="form-control"
                                   value="${param.experience}">
                            <small class="text-danger">${experienceError}</small>
                        </div>

                        <!-- Level -->
                        <div class="mb-3">
                            <label class="form-label">Job Level (1–10)</label>
                            <input type="number" name="level" min="1" max="10"
                                   class="form-control"
                                   value="${param.level}">
                            <small class="text-danger">${levelError}</small>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-success">
                                Register Employee
                            </button>
                        </div>

                    </form>

                </div>
            </div>

        </div>
    </div>
</div>

</body>
</html>
