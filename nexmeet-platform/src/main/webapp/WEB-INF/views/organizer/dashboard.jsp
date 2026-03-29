<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Organizer Dashboard - NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<c:if test="${not empty success}">
    <div class="alert alert-success">${success}</div>
</c:if>
<c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
</c:if>


<body class="bg-light">

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container mt-5">
    <div class="card p-4 shadow-sm">
        <h2 class="text-success">Organizer Dashboard</h2>
        <p>Welcome, <strong><sec:authentication property="name"/></strong></p>
        <p class="text-muted">Role: ORGANIZER</p>
        <hr>
        <div class="row g-3">
            <div class="col-md-4">
                <div class="card text-center p-3 border-success">
                    <h5>My Conferences</h5>
                    <h2 class="text-primary">${myConferences}</h2>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-center p-3 border-primary">
                    <h5>Total Registrations</h5>
                    <h2 class="text-warning">${totalRegistrations}</h2>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-center p-3 border-warning">
                    <h5>Pending Approval</h5>
                    <h2 class="text-warning">${pendingApproval}</h2>
                </div>
            </div>
        </div>
        <div class="mt-4">

            <form action="${pageContext.request.contextPath}/logout" method="post" class="d-inline">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <button type="submit" class="btn btn-outline-danger">Logout</button>
            </form>

        </div>
        <a href="${pageContext.request.contextPath}/organizer/conference/create"
           class="btn btn-success mt-3">+ Create Conference</a>

           <a href="${pageContext.request.contextPath}/organizer/conferences"
              class="btn btn-outline-success me-2">My Conferences</a>
    </div>
</div>
</body>
</html>