<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Course Registration</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-7">

            <div class="card shadow-lg">
                <div class="card-header bg-dark text-white text-center">
                    <h4>Course Registration</h4>
                </div>

                <div class="card-body">
                    <!-- action MUST match controller mapping -->
                    <form action="course" method="post">

                        <!-- String -->
                        <div class="mb-3">
                            <label class="form-label">Course Name</label>
                            <input type="text" name="name" class="form-control">
                            <small class="text-danger">
                                <c:out value="${nameError}" />
                            </small>
                        </div>

                        <!-- int -->
                        <div class="mb-3">
                            <label class="form-label">Duration (Months)</label>
                            <input type="number" name="duration" class="form-control">
                            <small class="text-danger">
                                <c:out value="${durationError}" />
                            </small>
                        </div>

                        <!-- char -->
                        <div class="mb-3">
                            <label class="form-label">Course Mode (O/F)</label>
                            <input type="text" name="mode" maxlength="1"
                                   class="form-control">
                            <small class="text-danger">
                                <c:out value="${modeError}" />
                            </small>
                        </div>

                        <!-- long -->
                        <div class="mb-3">
                            <label class="form-label">Course Code</label>
                            <input type="number" name="code" class="form-control">
                            <small class="text-danger">
                                <c:out value="${codeError}" />
                            </small>
                        </div>

                        <!-- float -->
                        <div class="mb-3">
                            <label class="form-label">Course Rating</label>
                            <input type="number" step="0.1" name="rating"
                                   class="form-control">
                            <small class="text-danger">
                                <c:out value="${ratingError}" />
                            </small>
                        </div>

                        <!-- double -->
                        <div class="mb-3">
                            <label class="form-label">Course Fee</label>
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
                            <label class="form-check-label">Course Active</label>
                        </div>

                        <!-- short -->
                        <div class="mb-3">
                            <label class="form-label">Credits</label>
                            <input type="number" name="credits"
                                   class="form-control">
                            <small class="text-danger">
                                <c:out value="${creditsError}" />
                            </small>
                        </div>

                        <!-- byte -->
                        <div class="mb-3">
                            <label class="form-label">Difficulty Level (1–10)</label>
                            <input type="number" name="level" min="1" max="10"
                                   class="form-control">
                            <small class="text-danger">
                                <c:out value="${levelError}" />
                            </small>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-dark">
                                Register Course
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
