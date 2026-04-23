<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delegates - ${conf.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
</head>
<body class="bg-light">

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>


<div class="container py-4">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <div>
            <h2 class="text-success mb-0">Registered Delegates</h2>
            <p class="text-muted mb-0">${conf.title}</p>
            <small class="text-muted">
                ${fn:substringBefore(conf.startDate.toString(),'T')} |
                ${conf.city}, ${conf.state}
            </small>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}/attendance"
               class="btn btn-success me-2">Attendance Check-in</a>
            <a href="${pageContext.request.contextPath}/organizer/conferences"
               class="btn btn-outline-secondary">Back</a>
        </div>
    </div>

    <div class="d-flex gap-2 mb-3">
        <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}/delegates/export?format=excel"
           class="btn btn-success btn-sm">
            📥 Export Excel
        </a>
        <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}/delegates/export?format=csv"
           class="btn btn-outline-secondary btn-sm">
            📄 Export CSV
        </a>
    </div>

    <!-- Stats -->
    <div class="row g-3 mb-4">
        <div class="col-md-3">
            <div class="card text-center p-3 border-primary">
                <h5>Total Registered</h5>
                <h2 class="text-primary">${registrations.size()}</h2>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center p-3 border-success">
                <h5>Confirmed</h5>
                <h2 class="text-success">${confirmedCount}</h2>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center p-3 border-danger">
                <h5>Cancelled</h5>
                <h2 class="text-danger">${cancelledCount}</h2>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center p-3 border-warning">
                <h5>Seats Left</h5>
                <h2 class="text-warning">
                    ${conf.maxDelegates - conf.registeredCount}
                </h2>
            </div>
        </div>
    </div>

    <!-- Delegates Table -->
    <div class="card">
        <div class="card-header fw-bold d-flex justify-content-between">
            <span>Delegate List</span>
            <span class="text-muted small">
                ${conf.registeredCount} / ${conf.maxDelegates} seats filled
            </span>
        </div>
        <div class="card-body p-0">
            <c:choose>
                <c:when test="${empty registrations}">
                    <p class="text-muted p-4">No delegates registered yet.</p>
                </c:when>
                <c:otherwise>
                    <table class="table table-hover table-bordered mb-0">
                        <thead class="table-success">
                            <tr>
                                <th>#</th>
                                <th>Reg. Number</th>
                                <th>Full Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Organization</th>
                                <th>Designation</th>
                                <th>Registered On</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="reg" items="${registrations}"
                                       varStatus="s">
                                <tr class="${reg.status == 'CANCELLED' ?
                                            'table-secondary' : ''}">
                                    <td>${s.count}</td>
                                    <td>
                                        <code>${reg.registrationNumber}</code>
                                    </td>
                                    <td>${reg.user.fullName}</td>
                                    <td>
                                        <a href="mailto:${reg.user.email}">
                                            ${reg.user.email}
                                        </a>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty reg.user.phone}">
                                                ${reg.user.phone}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">—</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty reg.user.delegate.organization}">
                                                ${reg.user.delegate.organization}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">—</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty reg.user.delegate.designation}">
                                                ${reg.user.delegate.designation}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">—</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        ${fn:substringBefore(
                                            reg.registeredAt.toString(),'T')}
                                    </td>
                                    <td>
                                        <span class="badge
                                            ${reg.status == 'CONFIRMED' ?
                                              'bg-success' : 'bg-secondary'}">
                                            ${reg.status}
                                        </span>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>