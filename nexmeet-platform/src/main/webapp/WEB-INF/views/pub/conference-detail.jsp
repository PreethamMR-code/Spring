<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${conference.title} - NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .navbar-brand { color: #4f46e5 !important; font-weight: 700; }
        .detail-card { border: none; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,0.08); }
        .info-box { background: #f8f9fa; border-radius: 8px; padding: 16px; }
    </style>
</head>
<body class="bg-light">

<nav class="navbar navbar-light bg-white shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">NexMeet</a>
        <a href="${pageContext.request.contextPath}/conferences" class="btn btn-outline-secondary btn-sm">
            Back to Conferences
        </a>
    </div>
</nav>

<div class="container py-5">
    <c:choose>
        <c:when test="${empty conference}">
            <div class="alert alert-danger">Conference not found.</div>
        </c:when>
        <c:otherwise>
            <div class="row g-4">

                <!-- Left: Main Info -->
                <div class="col-lg-8">
                    <div class="card detail-card p-4">
                        <div class="mb-3">
                            <span class="badge bg-primary">${conference.conferenceType}</span>
                            <span class="badge bg-secondary ms-1">${conference.mode}</span>
                            <c:if test="${conference.free}">
                                <span class="badge bg-success ms-1">FREE</span>
                            </c:if>
                        </div>

                        <h2 class="fw-bold">${conference.title}</h2>
                        <p class="text-muted">
                            Organized by: <strong>${conference.organizer.user.fullName}</strong>
                        </p>
                        <hr>
                        <p>${conference.description}</p>
                    </div>
                </div>

                <%-- Feedback Section --%>
                <c:if test="${feedbackCount > 0}">
                    <div class="card detail-card p-4 mt-3">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="fw-bold mb-0">Delegate Feedback</h5>
                            <div>
                                <span style="font-size:1.3rem;color:#ffc107;">
                                    <%-- Star display --%>
                                    <c:forEach begin="1" end="5" var="star">
                                        <c:choose>
                                            <c:when test="${avgRating >= star}">★</c:when>
                                            <c:otherwise>☆</c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </span>
                                <span class="fw-bold ms-1">
                                    <fmt:formatNumber value="${avgRating}"
                                                      maxFractionDigits="1"/>
                                </span>
                                <span class="text-muted small">
                                    (${feedbackCount} review<c:if
                                        test="${feedbackCount != 1}">s</c:if>)
                                </span>
                            </div>
                        </div>

                        <c:forEach var="fb" items="${feedbackList}">
                            <div class="border-bottom pb-3 mb-3">
                                <div class="d-flex justify-content-between">
                                    <strong>${fb.user.fullName}</strong>
                                    <span style="color:#ffc107;">
                                        <c:forEach begin="1" end="5" var="s">
                                            <c:choose>
                                                <c:when test="${fb.overallRating >= s}">★</c:when>
                                                <c:otherwise>☆</c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </span>
                                </div>
                                <small class="text-muted">
                                    ${fn:substringBefore(
                                        fb.submittedAt.toString(),'T')}
                                </small>
                                <c:if test="${not empty fb.comments}">
                                    <p class="mb-0 mt-1 text-muted small">
                                        ${fb.comments}
                                    </p>
                                </c:if>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>

                <!-- Right: Registration Box -->
                <div class="col-lg-4">
                    <div class="card detail-card p-4">
                        <h5 class="fw-bold mb-3">Event Details</h5>

                       <div class="info-box mb-3">
                           <div class="mb-2"><strong>📅 Start Date</strong><br>
                               ${fn:substringBefore(conference.startDate, 'T')}
                           </div>
                           <div class="mb-2"><strong>📅 End Date</strong><br>
                               ${fn:substringBefore(conference.endDate, 'T')}
                           </div>
                           <div><strong>⏰ Register By</strong><br>
                               ${fn:substringBefore(conference.registrationDeadline, 'T')}
                           </div>
                       </div>


                        <c:if test="${not empty conference.city}">
                            <div class="info-box mb-3">
                                <strong>📍 Location</strong><br>
                                ${conference.venueName}<br>
                                <small class="text-muted">${conference.venueAddress}</small><br>
                                ${conference.city}, ${conference.state}
                            </div>
                        </c:if>

                        <%-- Streaming link for online/hybrid --%>
                        <c:if test="${conference.mode == 'ONLINE' ||
                                     conference.mode == 'HYBRID'}">
                            <c:if test="${not empty conference.streamingLink}">
                                <div class="info-box mb-3">
                                    <strong>🔗 Streaming Link</strong><br/>
                                    <sec:authorize access="isAuthenticated()">
                                        <a href="${conference.streamingLink}"
                                           target="_blank"
                                           class="text-break small">
                                            ${conference.streamingLink}
                                        </a>
                                    </sec:authorize>
                                    <sec:authorize access="isAnonymous()">
                                        <span class="text-muted small">
                                            Login to view streaming link
                                        </span>
                                    </sec:authorize>
                                </div>
                            </c:if>
                        </c:if>

                        <div class="info-box mb-3">
                            <strong>👥 Seats</strong><br>
                            ${conference.registeredCount} / ${conference.maxDelegates} registered
                        </div>

                        <div class="d-grid">
                            <sec:authorize access="hasRole('ROLE_DELEGATE')">
                                <c:if test="${not empty success}">
                                    <div class="alert alert-success">${success}</div>
                                </c:if>
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger">${error}</div>
                                </c:if>
                                <form action="${pageContext.request.contextPath}/conference/${conference.id}/register" method="post">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <button type="submit" class="btn btn-primary btn-lg w-100">
                                        Register — ₹${conference.delegateFee}
                                    </button>
                                </form>
                            </sec:authorize>
                            <sec:authorize access="!isAuthenticated()">
                                <a href="${pageContext.request.contextPath}/login" class="btn btn-primary btn-lg w-100">
                                    Login to Register
                                </a>
                            </sec:authorize>
                            <sec:authorize access="!isAuthenticated()">
                                <a href="${pageContext.request.contextPath}/login"
                                   class="btn btn-primary btn-lg">Login to Register</a>
                                <small class="text-center text-muted mt-2">Login required to register</small>
                            </sec:authorize>
                        </div>
                    </div>
                </div>

            </div>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
