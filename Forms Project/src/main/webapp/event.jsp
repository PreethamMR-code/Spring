<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Event Registration</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-7">

            <div class="card shadow-lg">
                <div class="card-header bg-primary text-white text-center">
                    <h4>Event Registration</h4>
                </div>

                <div class="card-body">

                    <!-- MUST match @PostMapping("event") -->
                    <form action="event" method="post">

                        <!-- Event Name -->
                        <div class="mb-3">
                            <label class="form-label">Event Name</label>
                            <input type="text" name="name" class="form-control"
                                   value="${param.name}">
                            <small class="text-danger">${nameError}</small>
                        </div>

                        <!-- Duration -->
                        <div class="mb-3">
                            <label class="form-label">Event Duration (Days)</label>
                            <input type="number" name="duration" class="form-control"
                                   value="${param.duration}">
                            <small class="text-danger">${durationError}</small>
                        </div>

                        <!-- Type -->
                        <div class="mb-3">
                            <label class="form-label">Event Type (P/O)</label>
                            <input type="text" name="type" maxlength="1"
                                   class="form-control"
                                   value="${param.type}">
                            <small class="text-danger">${typeError}</small>
                        </div>

                        <!-- Code -->
                        <div class="mb-3">
                            <label class="form-label">Event Code</label>
                            <input type="number" name="code" class="form-control"
                                   value="${param.code}">
                            <small class="text-danger">${codeError}</small>
                        </div>

                        <!-- Rating -->
                        <div class="mb-3">
                            <label class="form-label">Event Rating</label>
                            <input type="number" step="0.1" name="rating"
                                   class="form-control"
                                   value="${param.rating}">
                            <small class="text-danger">${ratingError}</small>
                        </div>

                        <!-- Budget -->
                        <div class="mb-3">
                            <label class="form-label">Event Budget</label>
                            <input type="number" step="0.01" name="budget"
                                   class="form-control"
                                   value="${param.budget}">
                            <small class="text-danger">${budgetError}</small>
                        </div>

                        <!-- Active -->
                        <input type="hidden" name="active" value="false">
                        <div class="mb-3 form-check">
                            <input type="checkbox" name="active" value="true"
                                   class="form-check-input"
                                   <c:if test="${param.active eq 'true'}">checked</c:if>>
                            <label class="form-check-label">Event Active</label>
                        </div>

                        <!-- Team Size -->
                        <div class="mb-3">
                            <label class="form-label">Team Size</label>
                            <input type="number" name="teamSize"
                                   class="form-control"
                                   value="${param.teamSize}">
                            <small class="text-danger">${teamSizeError}</small>
                        </div>

                        <!-- Priority -->
                        <div class="mb-3">
                            <label class="form-label">Priority Level (1–10)</label>
                            <input type="number" name="priority" min="1" max="10"
                                   class="form-control"
                                   value="${param.priority}">
                            <small class="text-danger">${priorityError}</small>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">
                                Register Event
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
