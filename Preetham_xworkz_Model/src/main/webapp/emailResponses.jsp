<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Email Responses | X-Workz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .badge-yes    { background:#d1fae5; color:#065f46; border-radius:20px; padding:4px 12px; font-size:0.8rem; font-weight:700; }
        .badge-no     { background:#fee2e2; color:#991b1b; border-radius:20px; padding:4px 12px; font-size:0.8rem; font-weight:700; }
        .badge-wait   { background:#fef9c3; color:#854d0e; border-radius:20px; padding:4px 12px; font-size:0.8rem; font-weight:700; }
        .stat-card    { border-radius:12px; padding:1.25rem; text-align:center; }
    </style>
</head>
<body class="bg-light">

<nav class="navbar navbar-dark bg-primary shadow-sm">
    <div class="container-fluid px-4">
        <span class="navbar-brand fw-bold"><i class="bi bi-bar-chart me-2"></i>Email Responses — ${batch.batchName}</span>
        <a href="<c:url value='/dashboard/batchDetails/${batch.id}'/>" class="btn btn-outline-light btn-sm">
            <i class="bi bi-arrow-left me-1"></i>Back to Batch
        </a>
    </div>
</nav>

<div class="container py-4">

    <%-- Summary Stats --%>
    <div class="row g-3 mb-4">
        <div class="col-md-3">
            <div class="stat-card bg-white shadow-sm">
                <div class="fs-2 fw-bold text-primary">${notifications.size()}</div>
                <small class="text-muted">Emails Sent</small>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card bg-white shadow-sm">
                <div class="fs-2 fw-bold text-success" id="yesCount">0</div>
                <small class="text-muted">Responded YES</small>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card bg-white shadow-sm">
                <div class="fs-2 fw-bold text-danger" id="noCount">0</div>
                <small class="text-muted">Responded NO</small>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card bg-white shadow-sm">
                <div class="fs-2 fw-bold text-warning" id="waitCount">0</div>
                <small class="text-muted">No Response Yet</small>
            </div>
        </div>
    </div>

    <%-- Filter tabs --%>
    <ul class="nav nav-pills mb-3" id="filterTabs">
        <li class="nav-item"><button class="nav-link active" onclick="filterTable('all')">All</button></li>
        <li class="nav-item"><button class="nav-link" onclick="filterTable('YES')">YES Only</button></li>
        <li class="nav-item"><button class="nav-link" onclick="filterTable('NO')">NO Only</button></li>
        <li class="nav-item"><button class="nav-link" onclick="filterTable('WAIT')">Awaiting</button></li>
    </ul>

    <div class="card border-0 shadow-sm">
        <div class="card-body p-0">
            <c:choose>
                <c:when test="${empty notifications}">
                    <div class="text-center py-5">
                        <i class="bi bi-envelope-x text-muted" style="font-size:4rem;"></i>
                        <h5 class="mt-3 text-muted">No emails sent for this batch yet</h5>
                        <p class="text-muted">Go to the batch details page and click the envelope icon next to a student.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table table-hover mb-0 align-middle" id="responseTable">
                            <thead class="table-light">
                                <tr>
                                    <th>Student</th>
                                    <th>Email</th>
                                    <th>Subject</th>
                                    <th>Sent By</th>
                                    <th>Sent At</th>
                                    <th>Response</th>
                                    <th>Responded At</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="n" items="${notifications}">
                                    <c:set var="resp" value="${n.response != null ? n.response : 'WAIT'}"/>
                                    <tr data-response="${resp}">
                                        <td class="fw-semibold">${n.studentName}</td>
                                        <td><small>${n.studentEmail}</small></td>
                                        <td><small>${n.subject}</small></td>
                                        <td><small>${n.sentBy}</small></td>
                                        <td><small>${n.sentAt}</small></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${n.response == 'YES'}">
                                                    <span class="badge-yes">✓ YES</span>
                                                </c:when>
                                                <c:when test="${n.response == 'NO'}">
                                                    <span class="badge-no">✗ NO</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge-wait">⏳ Awaiting</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><small>${n.respondedAt != null ? n.respondedAt : '—'}</small></td>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Count and display stats
    const rows = document.querySelectorAll('#responseTable tbody tr');
    let yes = 0, no = 0, wait = 0;
    rows.forEach(r => {
        const resp = r.dataset.response;
        if (resp === 'YES')  yes++;
        else if (resp === 'NO') no++;
        else wait++;
    });
    document.getElementById('yesCount').textContent  = yes;
    document.getElementById('noCount').textContent   = no;
    document.getElementById('waitCount').textContent = wait;

    // Filter rows
    function filterTable(filter) {
        rows.forEach(r => {
            const resp = r.dataset.response;
            if (filter === 'all') { r.style.display = ''; return; }
            r.style.display = (resp === filter) ? '' : 'none';
        });
        // Update active tab
        document.querySelectorAll('#filterTabs .nav-link').forEach(btn => {
            btn.classList.toggle('active', btn.getAttribute('onclick').includes("'" + filter + "'"));
        });
    }
</script>
</body>
</html>
