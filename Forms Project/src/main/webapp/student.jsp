<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>


<!DOCTYPE html>
<html>
<head>
    <title>Student Registration</title>

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
                    <h4>Student Registration</h4>
                </div>

                <div class="card-body">

                    <!-- MUST match @PostMapping("student") -->
                    <form action="student" method="post">

                        <!-- Name -->
                        <div class="mb-3">
                            <label class="form-label">Name</label>
                            <input type="text" name="name" class="form-control"
                                   value="${param.name}">
                            <small class="text-danger">
                                <c:out value="${nameError}" />
                            </small>
                        </div>

                        <!-- Age -->
                        <div class="mb-3">
                            <label class="form-label">Age</label>
                            <input type="number" name="age" class="form-control"
                                   value="${param.age}">
                            <small class="text-danger">
                                <c:out value="${ageError}" />
                            </small>
                        </div>

                        <!-- Gender -->
                        <div class="mb-3">
                            <label class="form-label">Gender (M/F)</label>
                            <input type="text" name="gender" maxlength="1"
                                   class="form-control"
                                   value="${param.gender}">
                            <small class="text-danger">
                                <c:out value="${genderError}" />
                            </small>
                        </div>

                        <!-- Phone -->
                        <div class="mb-3">
                            <label class="form-label">Mobile Number</label>
                            <input type="number" name="phone" class="form-control"
                                   value="${param.phone}">
                            <small class="text-danger">
                                <c:out value="${phoneError}" />
                            </small>
                        </div>

                        <!-- Rating -->
                        <div class="mb-3">
                            <label class="form-label">Rating</label>
                            <input type="number" step="0.1" name="rating"
                                   class="form-control"
                                   value="${param.rating}">
                            <small class="text-danger">
                                <c:out value="${ratingError}" />
                            </small>
                        </div>

                        <!-- Fee -->
                        <div class="mb-3">
                            <label class="form-label">Fees</label>
                            <input type="number" step="0.01" name="fees"
                                   class="form-control"
                                   value="${param.fees}">
                            <small class="text-danger">
                                <c:out value="${feesError}" />
                            </small>
                        </div>

                        <!-- Active -->
                        <div class="mb-3 form-check">
                            <input type="checkbox" name="active" value="true"
                                   class="form-check-input"
                                   <c:if test="${param.active eq 'true'}">checked</c:if>>
                            <label class="form-check-label">Active</label>
                        </div>

                        <!-- Semester -->
                        <div class="mb-3">
                            <label class="form-label">Semester</label>
                            <input type="number" name="semester"
                                   class="form-control"
                                   value="${param.semester}">
                            <small class="text-danger">
                                <c:out value="${semesterError}" />
                            </small>
                        </div>


                        <label class="form-label">Grade (1–10)</label>
                        <input type="number" name="grade" min="1" max="10"
                               class="form-control"
                               value="${param.grade}">
                        <small class="text-danger">
                            <c:out value="${gradeError}" />
                        </small>



                        <div class="d-grid">
                            <button type="submit" class="btn btn-success">
                                Submit
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
