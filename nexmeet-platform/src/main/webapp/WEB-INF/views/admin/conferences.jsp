<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Conferences - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
</head>
<body class="bg-light">

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="text-danger">All Conferences</h2>
        <a href="${pageContext.request.contextPath}/admin/dashboard"
           class="btn btn-outline-secondary">Back to Dashboard</a>
    </div>

    <!-- Status Filter -->
    <div class="mb-3 d-flex gap-2 flex-wrap">
        <a href="${pageContext.request.contextPath}/admin/conferences"
           class="btn btn-sm ${empty selectedStatus ? 'btn-danger' : 'btn-outline-danger'}">
            All
        </a>
        <a href="${pageContext.request.contextPath}/admin/conferences?status=SUBMITTED"
           class="btn btn-sm ${selectedStatus == 'SUBMITTED' ? 'btn-warning' : 'btn-outline-warning'}">
            Pending
        </a>
        <a href="${pageContext.request.contextPath}/admin/conferences?status=APPROVED"
           class="btn btn-sm ${selectedStatus == 'APPROVED' ? 'btn-success' : 'btn-outline-success'}">
            Approved
        </a>
        <a href="${pageContext.request.contextPath}/admin/conferences?status=REJECTED"
           class="btn btn-sm ${selectedStatus == 'REJECTED' ? 'btn-danger' : 'btn-outline-danger'}">
            Rejected
        </a>
        <a href="${pageContext.request.contextPath}/admin/conferences?status=DRAFT"
           class="btn btn-sm ${selectedStatus == 'DRAFT' ? 'btn-secondary' : 'btn-outline-secondary'}">
            Draft
        </a>
    </div>

    <div class="card">
        <div class="card-body p-0">
            <c:choose>
                <c:when test="${empty conferences}">
                    <p class="text-muted p-4">No conferences found.</p>
                </c:when>
                <c:otherwise>
                    <table class="table table-hover table-bordered mb-0">
                        <thead class="table-danger">
                            <tr>
                                <th>#</th>
                                <th>Title</th>
                                <th>Organizer</th>
                                <th>Type</th>
                                <th>Mode</th>
                                <th>Start Date</th>
                                <th>Registered</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="conf" items="${conferences}"
                                       varStatus="s">
                                <tr>
                                    <td>${s.count}</td>
                                    <td><strong>${conf.title}</strong></td>
                                    <td>${conf.organizer.user.fullName}</td>
                                    <td>${conf.conferenceType}</td>
                                    <td>${conf.mode}</td>
                                    <td>${fn:substringBefore(
                                        conf.startDate.toString(),'T')}</td>
                                    <td>${conf.registeredCount}/${conf.maxDelegates}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${conf.status == 'DRAFT'}">
                                                <span class="badge bg-secondary">DRAFT</span>
                                            </c:when>
                                            <c:when test="${conf.status == 'SUBMITTED'}">
                                                <span class="badge bg-warning text-dark">PENDING</span>
                                            </c:when>
                                            <c:when test="${conf.status == 'APPROVED'}">
                                                <span class="badge bg-success">APPROVED</span>
                                            </c:when>
                                            <c:when test="${conf.status == 'REJECTED'}">
                                                <span class="badge bg-danger">REJECTED</span>
                                            </c:when>
                                            <c:when test="${conf.status == 'COMPLETED'}">
                                                <span class="badge bg-dark">COMPLETED</span>
                                            </c:when>
                                            <c:when test="${conf.status == 'CANCELLED'}">
                                                <span class="badge bg-danger">CANCELLED</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">${conf.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/conference/${conf.id}"
                                           class="btn btn-outline-danger btn-sm">Review</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
</body>
</html>