<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Conferences - NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f8f9fa; }
        .navbar-brand { color: #4f46e5 !important; font-weight: 700; font-size: 1.4rem; }
        .conf-card { border: none; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,0.08); transition: transform 0.2s; }
        .conf-card:hover { transform: translateY(-4px); box-shadow: 0 6px 20px rgba(0,0,0,0.12); }
        .badge-mode { font-size: 0.75rem; }
        .hero { background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%); color: white; padding: 60px 0 40px; }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<!-- Navbar -->
<nav class="navbar navbar-light bg-white shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">NexMeet</a>
        <div>
            <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-primary me-2">Login</a>
            <a href="${pageContext.request.contextPath}/register" class="btn btn-primary">Register</a>
        </div>
    </div>
</nav>

<!-- Hero -->
<div class="hero">
    <div class="container">
        <h1 class="fw-bold">Upcoming Conferences</h1>
        <p class="lead mb-0">Discover and register for conferences in your field</p>
    </div>
</div>

<!-- Conference Cards -->
<div class="container py-5">
    <c:choose>
        <c:when test="${empty conferences}">
            <div class="text-center py-5">
                <h4 class="text-muted">No conferences available right now.</h4>
                <p class="text-muted">Check back soon!</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row g-4">
                <c:forEach var="conf" items="${conferences}">
                    <div class="col-md-6 col-lg-4">
                        <div class="card conf-card h-100">
                            <div class="card-body p-4">

                                <!-- Type + Mode badges -->
                                <div class="mb-2">
                                    <span class="badge bg-primary badge-mode">${conf.conferenceType}</span>
                                    <span class="badge bg-secondary badge-mode ms-1">${conf.mode}</span>
                                    <c:if test="${conf.free}">
                                        <span class="badge bg-success badge-mode ms-1">FREE</span>
                                    </c:if>
                                </div>

                                <h5 class="card-title fw-bold">${conf.title}</h5>

                                <p class="text-muted small mb-3">
                                    <c:if test="${not empty conf.city}">
                                        📍 ${conf.city}, ${conf.state}
                                    </c:if>
                                </p>

                                <!-- Dates -->
                                <div class="small text-muted mb-3">
                                    <div>📅 ${fn:substringBefore(conf.startDate, 'T')}</div>
                                    <div>⏰ Register by: ${fn:substringBefore(conf.registrationDeadline, 'T')}</div>
                                </div>

                                <!-- Seats -->
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <small class="text-muted">
                                        ${conf.registeredCount} / ${conf.maxDelegates} registered
                                    </small>
                                    <c:choose>
                                        <c:when test="${conf.free}">
                                            <span class="fw-bold text-success">FREE</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="fw-bold text-primary">₹${conf.delegateFee}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <a href="${pageContext.request.contextPath}/conference/${conf.id}"
                                   class="btn btn-primary w-100">View Details</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>