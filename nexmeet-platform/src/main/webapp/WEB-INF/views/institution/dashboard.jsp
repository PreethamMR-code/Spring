<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Institution Dashboard - NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
</head>
<body class="bg-light">
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container py-4">
    <div class="card p-4 shadow-sm">
        <h2 class="fw-bold text-primary mb-1">
            Institution Dashboard
        </h2>
        <p class="text-muted small mb-4">
            ${currentUser.email}
        </p>

        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>

        <c:choose>
            <c:when test="${not instAdmin.verified}">
                <div class="alert alert-warning">
                    ⏳ <strong>Pending Verification.</strong>
                    Your account is awaiting admin approval.
                    You will be notified once verified.
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-success">
                    ✅ Account verified. You can now
                    perform bulk registrations for your
                    institution's delegates.
                </div>
            </c:otherwise>
        </c:choose>

        <!-- Institution Info -->
        <div class="card mb-3">
            <div class="card-header fw-bold bg-white
                        border-bottom">
                🏫 Your Institution
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <strong>Name:</strong>
                        ${instAdmin.institution.name}
                    </div>
                    <div class="col-md-3">
                        <strong>Type:</strong>
                        ${instAdmin.institution.type}
                    </div>
                    <div class="col-md-3">
                        <strong>City:</strong>
                        ${instAdmin.institution.city}
                    </div>
                    <div class="col-md-6 mt-2">
                        <strong>Your Role:</strong>
                        ${instAdmin.jobTitle}
                        <c:if test="${not empty instAdmin.department}">
                            — ${instAdmin.department}
                        </c:if>
                    </div>
                    <div class="col-md-6 mt-2">
                        <strong>Domains:</strong>
                        ${instAdmin.institution.domains}
                    </div>
                </div>
            </div>
        </div>

        <!-- Actions -->
        <c:if test="${instAdmin.verified}">
            <div class="row g-3">
                <div class="col-md-6">
                    <div class="card text-center p-3
                                border-primary h-100">
                        <h5>Browse Conferences</h5>
                        <p class="text-muted small">
                            Find conferences to bulk-register
                            your students/employees.
                        </p>
                        <a href="${pageContext.request.contextPath}/conferences"
                           class="btn btn-primary">
                            Browse →
                        </a>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card text-center p-3
                                border-success h-100">
                        <h5>My Profile</h5>
                        <p class="text-muted small">
                            View and update your
                            institutional admin profile.
                        </p>
                        <a href="${pageContext.request.contextPath}/profile"
                           class="btn btn-success">
                            My Profile →
                        </a>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>