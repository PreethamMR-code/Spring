<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-4">
    <div class="card p-4 shadow-sm">
        <h2 class="text-danger">Admin Dashboard</h2>
        <p>Welcome, <strong><sec:authentication property="name"/></strong></p>
        <p class="text-muted">Role: SUPER_ADMIN</p>

        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <hr>

        <!-- Stat Cards -->
        <div class="row g-3 mb-4">
            <div class="col-md-3">
                <div class="card text-center p-3 border-danger">
                    <h5>Pending Conferences</h5>
                    <h2 class="text-danger">${pendingCount}</h2>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-center p-3 border-primary">
                    <h5>Total Users</h5>
                    <h2 class="text-primary">${totalUsers}</h2>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-center p-3 border-success">
                    <h5>Active Conferences</h5>
                    <h2 class="text-success">${activeConferences}</h2>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-center p-3 border-warning">
                    <h5>Revenue</h5>
                    <h2 class="text-warning">${revenue}</h2>
                </div>
            </div>
        </div>

        <div class="d-flex gap-2 mb-4">
            <a href="${pageContext.request.contextPath}/admin/conferences"
               class="btn btn-outline-danger">All Conferences</a>
            <a href="${pageContext.request.contextPath}/admin/users"
               class="btn btn-outline-primary">All Users</a>
        </div>

        <!-- Pending Conferences Table -->
        <h5 class="text-danger">Conferences Awaiting Approval</h5>
        <c:choose>
            <c:when test="${empty pendingConferences}">
                <p class="text-muted">No conferences pending approval.</p>
            </c:when>
            <c:otherwise>
                <table class="table table-hover table-bordered">
                    <thead class="table-danger">
                        <tr>
                            <th>Title</th>
                            <th>Organizer</th>
                            <th>Type</th>
                            <th>Mode</th>
                            <th>Start Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="conf" items="${pendingConferences}">
                            <tr>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/conference/${conf.id}">
                                        ${conf.title}
                                    </a>
                                </td>
                                <td>${conf.organizer.user.fullName}</td>
                                <td>${conf.conferenceType}</td>
                                <td>${conf.mode}</td>
                                <td>${fn:substringBefore(conf.startDate.toString(), 'T')}</td>
                                <td>
                                    <!-- Approve -->
                                    <form action="${pageContext.request.contextPath}/admin/conference/${conf.id}/approve"
                                          method="post" class="d-inline">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                        <button class="btn btn-success btn-sm">Approve</button>
                                    </form>

                                    <!-- Reject -->
                                    <button class="btn btn-danger btn-sm" data-bs-toggle="modal"
                                            data-bs-target="#rejectModal${conf.id}">Reject</button>

                                    <!-- Reject Modal -->
                                    <div class="modal fade" id="rejectModal${conf.id}" tabindex="-1">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Reject: ${conf.title}</h5>
                                                </div>
                                                <form action="${pageContext.request.contextPath}/admin/conference/${conf.id}/reject"
                                                      method="post">
                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                    <div class="modal-body">
                                                        <label class="form-label">Reason for rejection</label>
                                                        <textarea name="reason" class="form-control" rows="3" required></textarea>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                        <button type="submit" class="btn btn-danger">Confirm Reject</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>

        <form action="${pageContext.request.contextPath}/logout" method="post" class="d-inline">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button type="submit" class="btn btn-outline-danger">Logout</button>
        </form>

    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>