<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Trainer Registration</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-7">

            <div class="card shadow-lg">
                <div class="card-header bg-secondary text-white text-center">
                    <h4>Trainer Registration</h4>
                </div>

                <div class="card-body">
                    <!-- action MUST match controller mapping -->
                    <form action="trainer" method="post">

                        <!-- String -->
                        <div class="mb-3">
                            <label class="form-label">Trainer Name</label>
                            <input type="text" name="name" class="form-control">
                            <small class="text-danger">
                                <c:out value="${nameError}" />
                            </small>
                        </div>

                        <!-- int -->
                        <div class="mb-3">
                            <label class="form-label">Age</label>
                            <input type="number" name="age" class="form-control">
                            <small class="text-danger">
                                <c:out value="${ageError}" />
                            </small>
                        </div>

                        <!-- char -->
                        <div class="mb-3">
                            <label class="form-label">Gender (M/F)</label>
                            <input type="text" name="gender" maxlength="1"
                                   class="form-control">
                            <small class="text-danger">
                                <c:out value="${genderError}" />
                            </small>
                        </div>

                        <!-- long -->
                        <div class="mb-3">
                            <label class="form-label">Contact Number</label>
                            <input type="number" name="phone" class="form-control">
                            <small class="text-danger">
                                <c:out value="${phoneError}" />
                            </small>
                        </div>

                        <!-- float -->
                        <div class="mb-3">
                            <label class="form-label">Trainer Rating</label>
                            <input type="number" step="0.1" name="rating"
                                   class="form-control">
                            <small class="text-danger">
                                <c:out value="${ratingError}" />
                            </small>
                        </div>

                        <!-- double -->
                        <div class="mb-3">
                            <label class="form-label">Session Fee</label>
                            <input type="number" step="0.01" name="fee"
                                   class="form-control">
                            <small class="text-danger">
                                <c:out value="${feeError}" />
                            </small>
                        </div>

                        <!-- boolean -->
                        <div class="mb-3 form-check">
                            <input type="checkbox" name="active" value="true"
                                   class="form-check-input">
                            <label class="form-check-label">Currently Active</label>
                        </div>

                        <!-- short -->
                        <div class="mb-3">
                            <label class="form-label">Experience (Years)</label>
                            <input type="number" name="experience"
                                   class="form-control">
                            <small class="text-danger">
                                <c:out value="${experienceError}" />
                            </small>
                        </div>

                        <!-- byte -->
                        <div class="mb-3">
                            <label class="form-label">Trainer Level (1–10)</label>
                            <input type="number" name="level" min="1" max="10"
                                   class="form-control">
                            <small class="text-danger">
                                <c:out value="${levelError}" />
                            </small>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-secondary">
                                Register Trainer
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
