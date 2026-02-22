<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Batch Details | X-Workz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@400;600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root { --sidebar-w:260px; --navy:#0f172a; --accent:#3b82f6; --surface:#f8fafc; --border:#e2e8f0; --text:#1e293b; --muted:#64748b; }
        * { box-sizing:border-box; }
        body { font-family:'Inter',sans-serif; background:var(--surface); margin:0; }
        h1,h2,h3,h4,h5,h6 { font-family:'Sora',sans-serif; }

        .sidebar { position:fixed; top:0; left:0; width:var(--sidebar-w); height:100vh; background:var(--navy); z-index:1050; overflow-y:auto; display:flex; flex-direction:column; box-shadow:4px 0 24px rgba(0,0,0,0.2); }
        .sidebar-logo { padding:1.5rem 1.25rem 1rem; display:flex; align-items:center; gap:10px; border-bottom:1px solid rgba(255,255,255,0.07); }
        .sidebar-logo img { width:36px; height:36px; object-fit:contain; }
        .sidebar-logo-text { color:white; font-family:'Sora',sans-serif; font-weight:700; font-size:1rem; }
        .sidebar-logo-text small { display:block; color:#64748b; font-size:0.65rem; text-transform:uppercase; letter-spacing:1px; }
        .sidebar-section { padding:1.25rem 1.25rem 0.4rem; color:#475569; font-size:0.65rem; text-transform:uppercase; font-weight:700; letter-spacing:1.5px; }
        .nav-link-item { display:flex; align-items:center; gap:12px; padding:0.7rem 1.25rem; color:#94a3b8; text-decoration:none; font-size:0.9rem; font-weight:500; transition:all 0.18s; }
        .nav-link-item:hover { background:rgba(255,255,255,0.06); color:#f1f5f9; }
        .nav-link-item.active { background:linear-gradient(90deg,rgba(59,130,246,0.15),transparent); color:var(--accent); border-left:3px solid var(--accent); }
        .nav-link-item i { font-size:1.1rem; width:20px; }

        .main-layout { margin-left:var(--sidebar-w); min-height:100vh; }
        .topbar { background:white; border-bottom:1px solid var(--border); padding:0 2rem; height:64px; display:flex; align-items:center; justify-content:space-between; box-shadow:0 1px 3px rgba(0,0,0,0.06); }
        .topbar-title { font-family:'Sora',sans-serif; font-weight:700; font-size:1.05rem; color:var(--text); }
        .topbar-actions { display:flex; gap:8px; flex-wrap:wrap; }
        .btn-action { padding:0.5rem 1rem; border-radius:10px; font-size:0.85rem; font-weight:600; transition:all 0.2s; border:none; cursor:pointer; text-decoration:none; display:inline-flex; align-items:center; gap:5px; }
        .btn-warning-custom { background:#f59e0b; color:white; } .btn-warning-custom:hover { background:#d97706; color:white; }
        .btn-info-custom { background:white; border:1px solid var(--border); color:var(--text); } .btn-info-custom:hover { background:var(--surface); color:var(--accent); }
        .btn-back { background:white; border:1px solid var(--border); color:var(--text); } .btn-back:hover { background:var(--surface); color:var(--accent); }

        .hero-mini { background:linear-gradient(135deg,#1e3a5f,#0f172a); padding:2rem; color:white; }
        .hero-mini h2 { font-family:'Sora',sans-serif; font-weight:800; margin-bottom:0.5rem; }
        .batch-meta { display:flex; gap:1.5rem; flex-wrap:wrap; margin-top:0.75rem; }
        .batch-meta-item { display:flex; align-items:center; gap:6px; opacity:0.9; font-size:0.9rem; }
        .students-card { background:white; border-radius:16px; border:1px solid var(--border); overflow:hidden; box-shadow:0 4px 20px rgba(0,0,0,0.06); }
        .students-card-header { background:white; padding:1.25rem 1.5rem; border-bottom:1px solid var(--border); display:flex; justify-content:space-between; align-items:center; }
        .btn-add { background:var(--accent); color:white; border:none; padding:0.5rem 1rem; border-radius:10px; font-size:0.85rem; font-weight:600; }
        .btn-add:hover { background:#2563eb; }
        .empty-state { text-align:center; padding:3rem; }
        .empty-state i { font-size:4rem; color:#cbd5e1; }
        .response-yes { background:#d1fae5; color:#065f46; border-radius:16px; padding:3px 10px; font-size:0.75rem; font-weight:700; white-space:nowrap; }
        .response-no { background:#fee2e2; color:#991b1b; border-radius:16px; padding:3px 10px; font-size:0.75rem; font-weight:700; white-space:nowrap; }
        .response-none { background:#f1f5f9; color:#64748b; border-radius:16px; padding:3px 10px; font-size:0.75rem; font-weight:700; white-space:nowrap; }

        @media(max-width:992px) { .sidebar { transform:translateX(-100%); } .sidebar.open { transform:translateX(0); } .main-layout { margin-left:0; } .topbar-actions { flex-direction:column; align-items:stretch; } }
        .mobile-menu-btn { display:none; }
        @media(max-width:992px) { .mobile-menu-btn { display:flex; width:38px; height:38px; border-radius:10px; border:1px solid var(--border); background:white; align-items:center; justify-content:center; cursor:pointer; } }
        .sidebar-overlay { display:none; position:fixed; inset:0; background:rgba(0,0,0,0.5); z-index:1049; }
        @media(max-width:992px) { .sidebar-overlay.active { display:block; } }
    </style>
</head>
<body>

<c:set var="displayEmail" value="${not empty sessionScope.email ? sessionScope.email : ''}"/>
<div class="sidebar-overlay" id="sidebarOverlay" onclick="document.getElementById('sidebar').classList.remove('open');this.classList.remove('active');"></div>

<c:if test="${not empty msg}">
    <div class="alert alert-success alert-dismissible fade show position-fixed" style="top:15px;right:15px;z-index:9999;min-width:320px;border-radius:12px;" role="alert">
        <i class="bi bi-check-circle me-2"></i>${msg}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>
<c:if test="${not empty error}">
    <div class="alert alert-danger alert-dismissible fade show position-fixed" style="top:15px;right:15px;z-index:9999;min-width:320px;border-radius:12px;" role="alert">
        <i class="bi bi-exclamation-circle me-2"></i>${error}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<aside class="sidebar" id="sidebar">
    <div class="sidebar-logo">
        <img src="https://x-workz.com/Logo.png" alt="X-Workz">
        <div class="sidebar-logo-text">X-Workz <small>Learning Platform</small></div>
    </div>
    <div class="sidebar-section">Main</div>
    <a href="<c:url value='/dashboard/Home'/>" class="nav-link-item"><i class="bi bi-grid-1x2-fill"></i> Dashboard</a>
    <a href="<c:url value='/dashboard/viewBatches'/>" class="nav-link-item active"><i class="bi bi-journal-bookmark-fill"></i> My Courses</a>
    <a href="<c:url value='/editProfile'/>?email=${displayEmail}" class="nav-link-item"><i class="bi bi-person-badge-fill"></i> My Profile</a>
    <div class="sidebar-section">Administration</div>
    <a href="<c:url value='/dashboard/addBatch'/>" class="nav-link-item"><i class="bi bi-plus-square-dotted"></i> Create Batch</a>
    <a href="<c:url value='/dashboard/viewBatches'/>" class="nav-link-item"><i class="bi bi-layers-fill"></i> Manage Batches</a>
    <div class="sidebar-section">System</div>
    <a href="#" class="nav-link-item"><i class="bi bi-sliders"></i> Settings</a>
    <a href="<c:url value='/logout'/>" class="nav-link-item" style="color:#f87171;"><i class="bi bi-box-arrow-right"></i> Logout</a>
</aside>

<div class="main-layout">
    <div class="topbar">
        <div class="d-flex align-items-center gap-3">
            <button class="mobile-menu-btn" onclick="document.getElementById('sidebar').classList.add('open');document.getElementById('sidebarOverlay').classList.add('active');">
                <i class="bi bi-list fs-5"></i>
            </button>
            <span class="topbar-title">${batch.batchName}</span>
        </div>
        <div class="topbar-actions">
            <a href="<c:url value='/dashboard/addStudent/${batch.id}'/>" class="btn-action btn-info-custom">
                <i class="bi bi-person-plus"></i>Add Student
            </a>
            <%-- ⭐ EMAIL ALL STUDENTS BUTTON - KEPT AS REQUESTED ⭐ --%>
            <a href="<c:url value='/dashboard/sendBatchEmail'/>?batchId=${batch.id}" class="btn-action btn-warning-custom">
                <i class="bi bi-envelope-paper"></i>Email All Students
            </a>
            <a href="<c:url value='/dashboard/emailResponses?batchId=${batch.id}'/>" class="btn-action btn-info-custom">
                <i class="bi bi-bar-chart"></i>Responses
            </a>
            <a href="<c:url value='/dashboard/viewBatches'/>" class="btn-action btn-back">
                <i class="bi bi-arrow-left"></i>Back
            </a>
        </div>
    </div>

    <div class="hero-mini">
        <h2>${batch.batchName}</h2>
        <div class="batch-meta">
            <div class="batch-meta-item">
                <i class="bi bi-laptop"></i>
                <span>${batch.batchType}</span>
            </div>
            <div class="batch-meta-item">
                <i class="bi bi-book"></i>
                <span>${batch.course}</span>
            </div>
            <div class="batch-meta-item">
                <i class="bi bi-person-video3"></i>
                <span>${batch.instructor}</span>
            </div>
            <div class="batch-meta-item">
                <i class="bi bi-calendar-event"></i>
                <span>${batch.startDate}</span>
            </div>
            <div class="batch-meta-item">
                <i class="bi bi-people-fill"></i>
                <span>${students != null ? students.size() : 0} Students</span>
            </div>
        </div>
        <c:if test="${not empty batch.description}">
            <p style="opacity:0.85;margin-top:0.75rem;margin-bottom:0;">${batch.description}</p>
        </c:if>
    </div>

    <div class="container-fluid px-4 py-4">
        <div class="students-card">
            <div class="students-card-header">
                <h5 class="mb-0 fw-bold"><i class="bi bi-people-fill text-primary me-2"></i>Enrolled Students</h5>
                <a href="<c:url value='/dashboard/addStudent/${batch.id}'/>" class="btn-add">
                    <i class="bi bi-person-plus me-1"></i>Add Student
                </a>
            </div>
            <div>
                <c:choose>
                    <c:when test="${empty students}">
                        <div class="empty-state">
                            <i class="bi bi-person-x"></i>
                            <h5 class="mt-3 text-muted">No Students Enrolled</h5>
                            <a href="<c:url value='/dashboard/addStudent/${batch.id}'/>" class="btn-add mt-2">
                                <i class="bi bi-person-plus me-2"></i>Add First Student
                            </a>
                        </div>
                    </c:when>

                    <%-- EDIT OPTION NOT ADDED yet --%>


                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-hover mb-0 align-middle">
                                <thead style="background:#f8fafc;">
                                    <tr>
                                        <th style="padding:0.9rem 1.5rem;">ID</th>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Phone</th>
                                        <th>Gender</th>
                                        <th>Age</th>
                                        <th>Joined</th>
                                        <th>Last Response</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="student" items="${students}">
                                        <tr>
                                            <td style="padding:0.9rem 1.5rem;"><span class="badge bg-secondary">${student.studentId}</span></td>
                                            <td class="fw-semibold">${student.name}</td>
                                            <td><small>${student.email}</small></td>
                                            <td><small>${student.phone}</small></td>
                                            <td>${student.gender}</td>
                                            <td>${student.age}</td>
                                            <td><small>${student.joinedDate}</small></td>
                                            <td>
                                                <c:set var="notif" value="${latestResponses[student.id]}"/>
                                                <c:choose>
                                                    <c:when test="${notif == null}">
                                                        <span class="response-none">No email sent</span>
                                                    </c:when>
                                                    <c:when test="${notif.response == 'YES'}">
                                                        <span class="response-yes">✓ YES</span>
                                                        <br><small class="text-muted" style="font-size:0.7rem;">${notif.subject}</small>
                                                    </c:when>
                                                    <c:when test="${notif.response == 'NO'}">
                                                        <span class="response-no">✗ NO</span>
                                                        <br><small class="text-muted" style="font-size:0.7rem;">${notif.subject}</small>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="response-none">⏳ Awaiting</span>
                                                        <br><small class="text-muted" style="font-size:0.7rem;">${notif.subject}</small>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="d-flex gap-1">
                                                    <a href="<c:url value='/dashboard/sendEmail?studentId=${student.id}&batchId=${batch.id}'/>"
                                                       class="btn btn-sm btn-outline-primary" title="Send Email" style="border-radius:8px;">
                                                        <i class="bi bi-envelope"></i>
                                                    </a>
                                                    <form action="<c:url value='/dashboard/deleteStudent/${student.id}/${batch.id}'/>"
                                                          method="post" style="display:inline;" onsubmit="return confirm('Remove this student from batch?');">
                                                        <button type="submit" class="btn btn-sm btn-outline-danger" title="Remove" style="border-radius:8px;">
                                                            <i class="bi bi-trash"></i>
                                                        </button>
                                                    </form>
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
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
