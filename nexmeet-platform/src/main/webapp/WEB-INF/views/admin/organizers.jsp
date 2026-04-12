<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Organizer Verification - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
</head>
<body class="bg-light">

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container py-4">
    <div class="d-flex justify-content-between
                align-items-center mb-4">
        <h2 class="text-danger">Organizer Verification</h2>
        <a href="${pageContext.request.contextPath}/admin/dashboard"
           class="btn btn-outline-secondary">Back</a>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <%-- PENDING ORGANIZERS --%>
    <div class="card mb-4">
        <div class="card-header fw-bold bg-warning text-dark">
            Pending Verification
            (${pendingOrganizers.size()})
        </div>
        <div class="card-body p-0">
            <c:choose>
                <c:when test="${empty pendingOrganizers}">
                    <p class="text-muted p-4">
                        No organizers pending verification.
                    </p>
                </c:when>
                <c:otherwise>
                    <table class="table table-hover
                                  table-bordered mb-0">
                        <thead class="table-warning">
                            <tr>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Organization</th>
                                <th>Type</th>
                                <th>City</th>
                                <th>Website</th>
                                <th>Registered</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="org"
                                items="${pendingOrganizers}">
                                <tr>
                                    <td>${org.user.fullName}</td>
                                    <td>
                                        <a href="mailto:${org.user.email}">
                                            ${org.user.email}
                                        </a>
                                    </td>
                                    <td><strong>
                                        ${org.organizationName}
                                    </strong></td>
                                    <td>${org.organizationType}</td>
                                    <td>${org.city}</td>
                                    <td>
                                        <c:if test="${not empty org.websiteUrl}">
                                            <a href="${org.websiteUrl}"
                                               target="_blank"
                                               class="small">
                                                Visit ↗
                                            </a>
                                        </c:if>
                                        <c:if test="${empty org.websiteUrl}">
                                            <span class="text-muted">—</span>
                                        </c:if>
                                    </td>
                                    <td class="small">
                                        ${fn:substringBefore(
                                            org.createdAt.toString(),
                                            'T')}
                                    </td>
                                    <td>
                                        <%-- Approve --%>
                                        <form action="${pageContext.request.contextPath}/admin/organizer/${org.id}/approve"
                                              method="post"
                                              class="d-inline">
                                            <input type="hidden"
                                                name="${_csrf.parameterName}"
                                                value="${_csrf.token}"/>
                                            <button class="btn btn-success btn-sm">
                                                ✓ Approve
                                            </button>
                                        </form>
                                        <%-- Reject --%>
                                        <button class="btn btn-danger btn-sm ms-1"
                                            data-bs-toggle="modal"
                                            data-bs-target="#rejectModal${org.id}">
                                            ✗ Reject
                                        </button>

                                        <%-- Reject Modal --%>
                                        <div class="modal fade"
                                             id="rejectModal${org.id}"
                                             tabindex="-1">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title">
                                                            Reject:
                                                            ${org.user.fullName}
                                                        </h5>
                                                    </div>
                                                    <form action="${pageContext.request.contextPath}/admin/organizer/${org.id}/reject"
                                                          method="post">
                                                        <input type="hidden"
                                                            name="${_csrf.parameterName}"
                                                            value="${_csrf.token}"/>
                                                        <div class="modal-body">
                                                            <label class="form-label">
                                                                Reason
                                                            </label>
                                                            <textarea name="reason"
                                                                class="form-control"
                                                                rows="3"
                                                                required></textarea>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button"
                                                                class="btn btn-secondary"
                                                                data-bs-dismiss="modal">
                                                                Cancel
                                                            </button>
                                                            <button type="submit"
                                                                class="btn btn-danger">
                                                                Confirm Reject
                                                            </button>
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
        </div>
    </div>

    <%-- APPROVED ORGANIZERS --%>
    <div class="card">
        <div class="card-header fw-bold bg-success text-white">
            Approved Organizers
            (${approvedOrganizers.size()})
        </div>
        <div class="card-body p-0">
            <c:choose>
                <c:when test="${empty approvedOrganizers}">
                    <p class="text-muted p-4">
                        No approved organizers yet.
                    </p>
                </c:when>
                <c:otherwise>
                    <table class="table table-hover
                                  table-bordered mb-0">
                        <thead class="table-success">
                            <tr>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Organization</th>
                                <th>Type</th>
                                <th>City</th>
                                <th>Avg Rating</th>
                                <th>Verified On</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="org"
                                items="${approvedOrganizers}">
                                <tr>
                                    <td>${org.user.fullName}</td>
                                    <td>${org.user.email}</td>
                                    <td>${org.organizationName}</td>
                                    <td>${org.organizationType}</td>
                                    <td>${org.city}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${org.averageRating > 0}">
                                                <span style="color:#ffc107;">★</span>
                                                ${org.averageRating}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">
                                                    No ratings yet
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="small">
                                        <c:choose>
                                            <c:when test="${not empty org.verifiedAt}">
                                                ${fn:substringBefore(
                                                    org.verifiedAt.toString(),
                                                    'T')}
                                            </c:when>
                                            <c:otherwise>—</c:otherwise>
                                        </c:choose>
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