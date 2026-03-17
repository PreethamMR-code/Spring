<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delegate Dashboard - NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body class="bg-light">
<div class="container mt-4">
    <div class="card p-4 shadow-sm">
        <h2 class="text-primary">Delegate Dashboard</h2>
        <p>Welcome, <strong>${email}</strong></p>
        <p class="text-muted">Role: DELEGATE</p>

        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <!-- Stat Cards -->
        <div class="row g-3 mb-4">
            <div class="col-md-4">
                <div class="card text-center p-3 border-primary">
                    <h5>My Registrations</h5>
                    <h2 class="text-primary">${myRegistrations}</h2>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-center p-3 border-success">
                    <h5>Attended</h5>
                    <h2 class="text-success">0</h2>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-center p-3 border-warning">
                    <h5>Certificates</h5>
                    <h2 class="text-warning">0</h2>
                </div>
            </div>
        </div>

        <!-- Registrations Table -->
        <h5 class="text-primary mt-3">My Registered Conferences</h5>
        <c:choose>
            <c:when test="${empty registrations}">
                <p class="text-muted">You have not registered for any conferences yet.</p>
            </c:when>
            <c:otherwise>
                <table class="table table-hover table-bordered">
                    <thead class="table-primary">
                        <tr>
                            <th>Reg. Number</th>
                            <th>Conference</th>
                            <th>Mode</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="reg" items="${registrations}">
                            <tr>
                                <td><code>${reg.registrationNumber}</code></td>
                                <td>${reg.conference.title}</td>
                                <td>${reg.conference.mode}</td>
                                <td>${fn:substringBefore(reg.conference.startDate.toString(), 'T')}</td>
                                <td>
                                    <span class="badge ${reg.status == 'CONFIRMED' ? 'bg-success' : 'bg-secondary'}">
                                        ${reg.status}
                                    </span>
                                </td>
                                <td>
                                    <c:if test="${reg.status != 'CANCELLED'}">
                                        <form action="${pageContext.request.contextPath}/delegate/registration/${reg.id}/cancel"
                                              method="post" class="d-inline"
                                              onsubmit="return confirm('Are you sure you want to cancel this registration?')">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                            <button class="btn btn-danger btn-sm">Cancel</button>
                                        </form>
                                    </c:if>
                                    <c:if test="${reg.status == 'CANCELLED'}">
                                        <span class="text-muted">—</span>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>

        <div class="mt-3">
            <a href="${pageContext.request.contextPath}/conferences" class="btn btn-primary">Browse Conferences</a>

            <form action="${pageContext.request.contextPath}/logout" method="post" class="d-inline">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <button type="submit" class="btn btn-outline-danger">Logout</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>