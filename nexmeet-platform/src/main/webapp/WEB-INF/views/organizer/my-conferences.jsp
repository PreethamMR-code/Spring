<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Conferences - NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body class="bg-light">

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="text-success">My Conferences</h2>
        <div>
            <a href="${pageContext.request.contextPath}/organizer/conference/create"
               class="btn btn-success me-2">+ Create New</a>
            <a href="${pageContext.request.contextPath}/organizer/dashboard"
               class="btn btn-outline-secondary">Dashboard</a>
        </div>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <c:choose>
        <c:when test="${empty conferences}">
            <div class="card p-5 text-center">
                <h5 class="text-muted">No conferences yet.</h5>
                <a href="${pageContext.request.contextPath}/organizer/conference/create"
                   class="btn btn-success mt-3">Create Your First Conference</a>
            </div>
        </c:when>
        <c:otherwise>
            <table class="table table-hover table-bordered bg-white">
                <thead class="table-success">
                    <tr>
                        <th>Title</th>
                        <th>Type</th>
                        <th>Mode</th>
                        <th>Start Date</th>
                        <th>Registered</th>
                        <th>Fee</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="conf" items="${conferences}">
                        <tr>
                            <td><strong>${conf.title}</strong></td>
                            <td>${conf.conferenceType}</td>
                            <td>${conf.mode}</td>
                            <td>${fn:substringBefore(conf.startDate.toString(),'T')}</td>
                            <td>${conf.registeredCount} / ${conf.maxDelegates}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${conf.free}">
                                        <span class="badge bg-success">Free</span>
                                    </c:when>
                                    <c:otherwise>₹${conf.delegateFee}</c:otherwise>
                                </c:choose>
                            </td>
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
                                </c:choose>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}"
                                   class="btn btn-outline-success btn-sm">View</a>

                                   <c:if test="${conf.status == 'APPROVED'}">
                                       <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}/delegates"
                                          class="btn btn-outline-primary btn-sm ms-1">Delegates</a>
                                       <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}/attendance"
                                          class="btn btn-outline-success btn-sm ms-1">Attendance</a>
                                   </c:if>

                                <c:if test="${conf.status == 'DRAFT' || conf.status == 'REJECTED'}">
                                    <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}/edit"
                                       class="btn btn-outline-warning btn-sm">Edit</a>
                                </c:if>
                                <c:if test="${conf.status == 'REJECTED'}">
                                    <span class="text-danger d-block small mt-1">
                                        Reason: ${conf.rejectionReason}
                                    </span>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>