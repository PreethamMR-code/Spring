<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1"/>
    <title>All Conferences – Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet"/>
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: #f0f2f5;
        }
        .filter-bar {
            background: white;
            border-radius: 12px;
            padding: 16px 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
        }
        .status-pill {
            border-radius: 20px;
            padding: 5px 14px;
            font-size: 0.82rem;
            font-weight: 600;
            border: 2px solid transparent;
            text-decoration: none;
            transition: all 0.15s;
        }
        .status-pill:hover { opacity: 0.85; }
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
                All Conferences
            </h2>
            <p class="text-muted small mb-0">
                ${fn:length(conferences)}
                conference(s) shown
                <c:if test="${not empty selectedStatus}">
                    · filtered: ${selectedStatus}
                </c:if>
            </p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/dashboard"
           class="btn btn-outline-secondary btn-sm">
            ← Dashboard
        </a>
    </div>

    <%-- Status filter tabs --%>
    <div class="filter-bar">
        <div class="d-flex gap-2 flex-wrap mb-3">
            <a href="${pageContext.request.contextPath}/admin/conferences"
               class="status-pill
                ${empty selectedStatus
                    ? 'bg-danger text-white'
                    : 'bg-light text-secondary'}">
                All
            </a>
            <a href="${pageContext.request.contextPath}/admin/conferences?status=SUBMITTED"
               class="status-pill
                ${selectedStatus == 'SUBMITTED'
                    ? 'bg-warning text-dark'
                    : 'bg-light text-secondary'}">
                ⏳ Pending
            </a>
            <a href="${pageContext.request.contextPath}/admin/conferences?status=APPROVED"
               class="status-pill
                ${selectedStatus == 'APPROVED'
                    ? 'bg-success text-white'
                    : 'bg-light text-secondary'}">
                ✅ Approved
            </a>
            <a href="${pageContext.request.contextPath}/admin/conferences?status=COMPLETED"
               class="status-pill
                ${selectedStatus == 'COMPLETED'
                    ? 'bg-dark text-white'
                    : 'bg-light text-secondary'}">
                🏁 Completed
            </a>
            <a href="${pageContext.request.contextPath}/admin/conferences?status=REJECTED"
               class="status-pill
                ${selectedStatus == 'REJECTED'
                    ? 'bg-danger text-white'
                    : 'bg-light text-secondary'}">
                ❌ Rejected
            </a>
            <a href="${pageContext.request.contextPath}/admin/conferences?status=CANCELLED"
               class="status-pill
                ${selectedStatus == 'CANCELLED'
                    ? 'bg-danger text-white'
                    : 'bg-light text-secondary'}">
                🚫 Cancelled
            </a>
            <a href="${pageContext.request.contextPath}/admin/conferences?status=DRAFT"
               class="status-pill
                ${selectedStatus == 'DRAFT'
                    ? 'bg-secondary text-white'
                    : 'bg-light text-secondary'}">
                📝 Draft
            </a>
        </div>

        <%-- Client-side search --%>
        <div class="d-flex gap-2 align-items-center">
            <input type="text"
                   id="confSearch"
                   class="form-control form-control-sm"
                   style="max-width:320px;
                          border-radius:8px"
                   placeholder="Search title or organizer..."
                   oninput="filterConfs()"/>
            <span id="countDisplay"
                  class="text-muted small">
                ${fn:length(conferences)} shown
            </span>
        </div>
    </div>

    <div class="card border-0 shadow-sm"
         style="border-radius:14px">
        <div class="card-body p-0">
            <c:choose>
                <c:when test="${empty conferences}">
                    <div class="text-center py-5
                                text-muted">
                        <div style="font-size:3rem">📋</div>
                        <div class="mt-2">
                            No conferences found.
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                    <table class="table table-hover
                                  mb-0 small"
                           id="confTable">
                        <thead style="background:#fef2f2">
                            <tr>
                                <th class="ps-3">#</th>
                                <th>Title</th>
                                <th>Organizer</th>
                                <th>Type</th>
                                <th>Mode</th>
                                <th>Start Date</th>
                                <th class="text-center">
                                    Registered
                                </th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody id="confBody">
                        <c:forEach var="conf"
                                   items="${conferences}"
                                   varStatus="s">
                            <tr data-title="${fn:toLowerCase(conf.title)}"
                                data-organizer="${fn:toLowerCase(conf.organizer.user.fullName)}">
                                <td class="ps-3
                                           text-muted">
                                    ${s.count}
                                </td>
                                <td>
                                    <div class="fw-semibold">
                                        ${fn:length(conf.title) > 38
                                            ? fn:substring(conf.title,0,38).concat('…')
                                            : conf.title}
                                    </div>
                                    <div class="text-muted"
                                         style="font-size:0.7rem">
                                        ${conf.conferenceType}
                                    </div>
                                </td>
                                <td>
                                    <div class="fw-semibold">
                                        ${conf.organizer.user.fullName}
                                    </div>
                                    <div class="text-muted"
                                         style="font-size:0.7rem">
                                        ${conf.organizer.organizationName}
                                    </div>
                                </td>
                                <td class="text-muted">
                                    ${conf.conferenceType}
                                </td>
                                <td>
                                    <span class="badge
                                        ${conf.mode == 'OFFLINE'
                                            ? 'bg-secondary'
                                        : conf.mode == 'ONLINE'
                                            ? 'bg-info text-dark'
                                            : 'bg-primary'}
                                        " style="font-size:0.68rem">
                                        ${conf.mode}
                                    </span>
                                </td>
                                <td class="text-muted">
                                    ${fn:substringBefore(
                                        conf.startDate.toString(),'T')}
                                </td>
                                <td class="text-center
                                           fw-semibold">
                                    ${conf.registeredCount}
                                    <span class="text-muted
                                                 fw-normal">
                                        /${conf.maxDelegates}
                                    </span>
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
                                        <c:when test="${conf.status == 'CANCELLED'}">
                                            <span class="badge bg-danger">CANCELLED</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">
                                                ${conf.status}
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/conference/${conf.id}"
                                       class="btn btn-outline-danger
                                              btn-sm"
                                       style="font-size:0.75rem">
                                        Review →
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    </div>
                    <div id="noConfs"
                         class="text-center py-4
                                text-muted d-none">
                        <div style="font-size:2rem">🔍</div>
                        <div class="mt-1 small">
                            No conferences match your search.
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
<script>
function filterConfs() {
    var q = document.getElementById('confSearch')
                .value.toLowerCase().trim();
    var rows = document.querySelectorAll('#confBody tr');
    var visible = 0;

    rows.forEach(function(row) {
        var title    = row.dataset.title    || '';
        var organizer = row.dataset.organizer || '';
        var match = !q
            || title.includes(q)
            || organizer.includes(q);
        row.style.display = match ? '' : 'none';
        if (match) visible++;
    });

    document.getElementById('countDisplay')
        .textContent = visible + ' shown';
    document.getElementById('noConfs')
        .classList.toggle('d-none', visible > 0);
}
</script>
</body>
</html>