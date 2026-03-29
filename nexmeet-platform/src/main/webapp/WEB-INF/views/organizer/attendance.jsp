<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Attendance - ${conf.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
</head>
<body class="bg-light">

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>


<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div>
            <h2 class="text-success mb-0">Attendance Check-in</h2>
            <p class="text-muted">${conf.title}</p>
        </div>
        <a href="${pageContext.request.contextPath}/organizer/conferences"
           class="btn btn-outline-secondary">Back</a>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <!-- Check-in Form -->
    <div class="card mb-4">
        <div class="card-header fw-bold bg-success text-white">
            Scan / Enter Registration Number
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/organizer/conference/${conf.id}/attendance/mark"
                  method="post" class="d-flex gap-2">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="text"
                       name="registrationNumber"
                       class="form-control form-control-lg"
                       placeholder="e.g. NM-AF752AE3"
                       autofocus
                       required/>
                <button type="submit" class="btn btn-success btn-lg px-4">
                    Check In
                </button>
            </form>
            <p class="text-muted small mt-2">
                * Scan the QR from delegate's ticket PDF or enter the
                registration number manually.
            </p>
        </div>
    </div>

    <!-- Stats -->
    <div class="row g-3 mb-4">
        <div class="col-md-4">
            <div class="card text-center p-3 border-success">
                <h5>Checked In</h5>
                <h2 class="text-success">${attendedCount}</h2>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card text-center p-3 border-primary">
                <h5>Total Registered</h5>
                <h2 class="text-primary">${conf.registeredCount}</h2>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card text-center p-3 border-warning">
                <h5>Not Yet Arrived</h5>
                <h2 class="text-warning">${conf.registeredCount - attendedCount}</h2>
            </div>
        </div>
    </div>

    <!-- Attended List -->
    <div class="card">
        <div class="card-header fw-bold">Checked-in Delegates</div>
        <div class="card-body">
            <c:choose>
                <c:when test="${empty attended}">
                    <p class="text-muted">No delegates checked in yet.</p>
                </c:when>
                <c:otherwise>
                    <table class="table table-hover table-bordered">
                        <thead class="table-success">
                            <tr>
                                <th>#</th>
                                <th>Reg. Number</th>
                                <th>Delegate Name</th>
                                <th>Checked In At</th>
                                <th>Checked In By</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="a" items="${attended}" varStatus="s">
                                <tr>
                                    <td>${s.count}</td>
                                    <td><code>${a.registration.registrationNumber}</code></td>
                                    <td>${a.user.fullName}</td>
                                    <td>
                                        ${fn:replace(
                                            fn:substringBefore(a.checkedInAt.toString(), '.'),
                                            'T', ' '
                                        )}
                                    </td>
                                    <td>${a.checkedInBy.fullName}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>