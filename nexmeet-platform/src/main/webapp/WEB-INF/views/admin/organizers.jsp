<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1"/>
    <title>Organizer Verification – Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet"/>
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: #f0f2f5;
        }
        .section-header {
            font-size: 0.78rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.06em;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container py-4">

    <div class="d-flex justify-content-between
                align-items-center mb-4">
        <div>
            <h2 style="font-weight:800;
                 color:#dc2626;margin:0">
                Organizer Verification
            </h2>
            <p class="text-muted small mb-0">
                Review and approve organizer accounts
            </p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/dashboard"
           class="btn btn-outline-secondary btn-sm">
            ← Dashboard
        </a>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success
                    alert-dismissible fade show">
            ✅ ${success}
            <button type="button" class="btn-close"
                    data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger
                    alert-dismissible fade show">
            ❌ ${error}
            <button type="button" class="btn-close"
                    data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <%-- PENDING ORGANIZERS --%>
    <div class="card border-0 shadow-sm mb-4"
         style="border-radius:14px">
        <div class="card-header fw-bold bg-white
                    d-flex align-items-center gap-2
                    py-3"
             style="border-radius:14px 14px 0 0;
                    border-bottom:1px solid #fde68a">
            <span style="width:10px;height:10px;
                  background:#f59e0b;
                  border-radius:50%;
                  display:inline-block"></span>
            <span class="section-header"
                  style="color:#92400e">
                Pending Verification
            </span>
            <span class="badge bg-warning text-dark ms-1">
                ${pendingOrganizers.size()}
            </span>
        </div>
        <div class="card-body p-0">
            <c:choose>
                <c:when test="${empty pendingOrganizers}">
                    <div class="text-center py-4
                                text-muted small">
                        ✅ No organizers pending
                        verification.
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                    <table class="table table-hover
                                  mb-0 small">
                        <thead style="background:#fffbeb">
                            <tr>
                                <th class="ps-3">
                                    Name
                                </th>
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
                                <td class="ps-3
                                           fw-semibold">
                                    ${org.user.fullName}
                                </td>
                                <td>
                                    <a href="mailto:${org.user.email}"
                                       class="text-decoration-none
                                              text-muted small">
                                        ${org.user.email}
                                    </a>
                                </td>
                                <td class="fw-semibold">
                                    ${org.organizationName}
                                </td>
                                <td class="text-muted">
                                    ${org.organizationType}
                                </td>
                                <td class="text-muted">
                                    ${org.city}
                                </td>
                                <td>
                                    <c:if test="${not empty org.websiteUrl}">
                                        <a href="${org.websiteUrl}"
                                           target="_blank"
                                           class="small text-decoration-none"
                                           style="color:#667eea">
                                            Visit ↗
                                        </a>
                                    </c:if>
                                    <c:if test="${empty org.websiteUrl}">
                                        <span class="text-muted">—</span>
                                    </c:if>
                                </td>
                                <td class="text-muted small">
                                    ${fn:substringBefore(
                                        org.createdAt.toString(),'T')}
                                </td>
                                <td>
                                    <%-- Approve --%>
                                    <form action="${pageContext.request.contextPath}/admin/organizer/${org.id}/approve"
                                          method="post"
                                          class="d-inline">
                                        <input type="hidden"
                                            name="${_csrf.parameterName}"
                                            value="${_csrf.token}"/>
                                        <button class="btn btn-success
                                                       btn-sm fw-semibold">
                                            ✓ Approve
                                        </button>
                                    </form>
                                    <%-- Reject --%>
                                    <button class="btn btn-outline-danger
                                                   btn-sm ms-1"
                                        data-bs-toggle="modal"
                                        data-bs-target="#rejectModal${org.id}">
                                        Reject
                                    </button>

                                    <%-- Reject Modal --%>
                                    <div class="modal fade"
                                         id="rejectModal${org.id}"
                                         tabindex="-1">
                                        <div class="modal-dialog
                                            modal-dialog-centered">
                                            <div class="modal-content">
                                                <div class="modal-header
                                                            bg-danger
                                                            text-white">
                                                    <h5 class="modal-title
                                                                fw-bold">
                                                        Reject:
                                                        ${org.user.fullName}
                                                    </h5>
                                                    <button type="button"
                                                            class="btn-close
                                                                   btn-close-white"
                                                            data-bs-dismiss="modal">
                                                    </button>
                                                </div>
                                                <form action="${pageContext.request.contextPath}/admin/organizer/${org.id}/reject"
                                                      method="post">
                                                    <input type="hidden"
                                                        name="${_csrf.parameterName}"
                                                        value="${_csrf.token}"/>
                                                    <div class="modal-body">
                                                        <div class="alert
                                                                    alert-light
                                                                    border small
                                                                    mb-3">
                                                            <strong>
                                                                ${org.organizationName}
                                                            </strong>
                                                            <br/>
                                                            <span class="text-muted">
                                                                ${org.user.email}
                                                            </span>
                                                        </div>
                                                        <label class="form-label
                                                                      fw-semibold">
                                                            Reason for rejection *
                                                        </label>
                                                        <textarea name="reason"
                                                            class="form-control"
                                                            rows="3"
                                                            placeholder="e.g. Incomplete information, suspicious account..."
                                                            required></textarea>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button"
                                                            class="btn btn-secondary"
                                                            data-bs-dismiss="modal">
                                                            Cancel
                                                        </button>
                                                        <button type="submit"
                                                            class="btn btn-danger
                                                                   fw-bold">
                                                            Reject
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
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <%-- APPROVED ORGANIZERS --%>
    <div class="card border-0 shadow-sm"
         style="border-radius:14px">
        <div class="card-header fw-bold bg-white
                    d-flex align-items-center gap-2
                    py-3"
             style="border-radius:14px 14px 0 0;
                    border-bottom:1px solid #bbf7d0">
            <span style="width:10px;height:10px;
                  background:#22c55e;
                  border-radius:50%;
                  display:inline-block"></span>
            <span class="section-header"
                  style="color:#166534">
                Approved Organizers
            </span>
            <span class="badge bg-success ms-1">
                ${approvedOrganizers.size()}
            </span>
        </div>
        <div class="card-body p-0">
            <c:choose>
                <c:when test="${empty approvedOrganizers}">
                    <div class="text-center py-4
                                text-muted small">
                        No approved organizers yet.
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                    <table class="table table-hover
                                  mb-0 small">
                        <thead style="background:#f0fdf4">
                            <tr>
                                <th class="ps-3">
                                    Name
                                </th>
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
                                <td class="ps-3
                                           fw-semibold">
                                    ${org.user.fullName}
                                </td>
                                <td class="text-muted">
                                    ${org.user.email}
                                </td>
                                <td>
                                    ${org.organizationName}
                                </td>
                                <td class="text-muted">
                                    ${org.organizationType}
                                </td>
                                <td class="text-muted">
                                    ${org.city}
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${org.averageRating > 0}">
                                            <span style="color:#fbbf24">★</span>
                                            <span class="fw-semibold">
                                                ${org.averageRating}
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">—</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-muted">
                                    <c:choose>
                                        <c:when test="${not empty org.verifiedAt}">
                                            ${fn:substringBefore(
                                                org.verifiedAt.toString(),'T')}
                                        </c:when>
                                        <c:otherwise>—</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>