<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Batch Details | X-Workz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">

<!-- Navbar -->
<nav class="navbar navbar-dark bg-primary shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand" href="<c:url value='/dashboard'/>">
            <img src="https://x-workz.com/Logo.png" height="40" class="me-2" alt="X-Workz">
            X-Workz Dashboard
        </a>
        <div class="d-flex gap-2">
            <a href="<c:url value='/dashboard/addStudent/${batch.id}'/>" class="btn btn-light btn-sm">
                <i class="bi bi-person-plus me-1"></i>Add Student
            </a>
            <a href="<c:url value='/dashboard/viewBatches'/>" class="btn btn-outline-light btn-sm">
                <i class="bi bi-arrow-left me-1"></i>Back
            </a>
        </div>
    </div>
</nav>

<!-- Batch Info Header -->
<div class="bg-white shadow-sm py-4 mb-4">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h2 class="fw-bold mb-2">${batch.batchName}</h2>
                <div class="d-flex flex-wrap gap-3">
                    <span class="badge bg-primary fs-6">
                        <i class="bi bi-laptop me-1"></i>${batch.batchType}
                    </span>
                    <span class="text-muted">
                        <i class="bi bi-book me-1"></i>${batch.course}
                    </span>
                    <span class="text-muted">
                        <i class="bi bi-person-video3 me-1"></i>${batch.instructor}
                    </span>
                    <span class="text-muted">
                        <i class="bi bi-calendar-event me-1"></i>${batch.startDate}
                    </span>
                </div>
            </div>
            <div class="col-md-4 text-md-end mt-3 mt-md-0">
                <h4 class="fw-bold mb-0">
                    <span class="badge bg-success">${students != null ? students.size() : 0} Students</span>
                </h4>
            </div>
        </div>

        <c:if test="${not empty batch.description}">
            <div class="mt-3">
                <p class="text-muted mb-0"><strong>Description:</strong> ${batch.description}</p>
            </div>
        </c:if>
    </div>
</div>

<!-- Students List -->
<div class="container my-5">
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3">
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="mb-0 fw-bold">
                    <i class="bi bi-people-fill text-primary me-2"></i>Enrolled Students
                </h5>
                <a href="<c:url value='/dashboard/addStudent/${batch.id}'/>" class="btn btn-primary btn-sm">
                    <i class="bi bi-person-plus me-1"></i>Add Student
                </a>
            </div>
        </div>
        <div class="card-body p-0">
            <c:choose>
                <c:when test="${empty students}">
                    <div class="text-center py-5">
                        <i class="bi bi-person-x text-muted" style="font-size: 4rem;"></i>
                        <h5 class="mt-3 text-muted">No Students Enrolled</h5>
                        <p class="text-muted">Add students to this batch to get started</p>
                        <a href="<c:url value='/dashboard/addStudent/${batch.id}'/>" class="btn btn-primary mt-2">
                            <i class="bi bi-person-plus me-2"></i>Add First Student
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>Student ID</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Gender</th>
                                    <th>Age</th>
                                    <th>Joined Date</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="student" items="${students}">
                                    <tr>
                                        <td><span class="badge bg-secondary">${student.studentId}</span></td>
                                        <td class="fw-semibold">${student.name}</td>
                                        <td>${student.email}</td>
                                        <td>${student.phone}</td>
                                        <td>${student.gender}</td>
                                        <td>${student.age}</td>
                                        <td>${student.joinedDate}</td>
                                        <td>
                                            <div class="btn-group btn-group-sm">
                                                <button class="btn btn-outline-primary" title="View Details">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                                <form action="<c:url value='/dashboard/deleteStudent/${student.id}/${batch.id}'/>"
                                                      method="post" style="display:inline;"
                                                      onsubmit="return confirm('Remove this student from batch?');">
                                                    <button type="submit" class="btn btn-outline-danger" title="Remove">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>