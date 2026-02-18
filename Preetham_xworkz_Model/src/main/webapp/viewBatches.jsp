<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Batches | X-Workz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@400;600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root { --sidebar-w:260px; --navy:#0f172a; --accent:#3b82f6; --surface:#f8fafc; --border:#e2e8f0; --text:#1e293b; --muted:#64748b; }
        * { box-sizing:border-box; }
        body { font-family:'Inter',sans-serif; background:var(--surface); margin:0; }
        h1,h2,h3,h4,h5,h6 { font-family:'Sora',sans-serif; }
        .sidebar { position:fixed;top:0;left:0;width:var(--sidebar-w);height:100vh;background:var(--navy);z-index:1050;overflow-y:auto;display:flex;flex-direction:column;box-shadow:4px 0 24px rgba(0,0,0,0.2); }
        .sidebar-logo { padding:1.5rem 1.25rem 1rem;display:flex;align-items:center;gap:10px;border-bottom:1px solid rgba(255,255,255,0.07); }
        .sidebar-logo img { width:36px;height:36px;object-fit:contain; }
        .sidebar-logo-text { color:white;font-family:'Sora',sans-serif;font-weight:700;font-size:1rem;line-height:1.1; }
        .sidebar-logo-text small { display:block;color:#64748b;font-size:0.65rem;font-weight:400;letter-spacing:1px;text-transform:uppercase;font-family:'Inter',sans-serif; }
        .sidebar-section { padding:1.25rem 1.25rem 0.4rem;color:#475569;font-size:0.65rem;text-transform:uppercase;font-weight:700;letter-spacing:1.5px; }
        .nav-link-item { display:flex;align-items:center;gap:12px;padding:0.7rem 1.25rem;color:#94a3b8;text-decoration:none;font-size:0.9rem;font-weight:500;transition:all 0.18s; }
        .nav-link-item:hover { background:rgba(255,255,255,0.06);color:#f1f5f9; }
        .nav-link-item.active { background:linear-gradient(90deg,rgba(59,130,246,0.15),transparent);color:var(--accent);border-left:3px solid var(--accent); }
        .nav-link-item i { font-size:1.1rem;width:20px;flex-shrink:0; }
        .sidebar-footer { margin-top:auto;padding:1rem 1.25rem;border-top:1px solid rgba(255,255,255,0.07); }
        .main-layout { margin-left:var(--sidebar-w);min-height:100vh; }
        .topbar { background:white;border-bottom:1px solid var(--border);padding:0 2rem;height:64px;display:flex;align-items:center;justify-content:space-between;position:sticky;top:0;z-index:100;box-shadow:0 1px 3px rgba(0,0,0,0.06); }
        .topbar-title { font-family:'Sora',sans-serif;font-weight:700;font-size:1.05rem;color:var(--text); }
        .btn-add { background:var(--accent);color:white;border:none;padding:0.55rem 1.25rem;border-radius:10px;font-weight:600;font-size:0.88rem;text-decoration:none;display:inline-flex;align-items:center;gap:6px;transition:all 0.2s; }
        .btn-add:hover { background:#2563eb;color:white;transform:translateY(-1px); }
        .batch-card { background:white;border-radius:16px;border:1px solid var(--border);overflow:hidden;transition:all 0.22s;height:100%; }
        .batch-card:hover { transform:translateY(-4px);box-shadow:0 16px 40px rgba(0,0,0,0.1);border-color:var(--accent); }
        .batch-card-top { height:6px; }
        .batch-card-body { padding:1.25rem; }
        .batch-type-badge { display:inline-flex;align-items:center;gap:5px;border-radius:6px;padding:3px 10px;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;margin-bottom:0.75rem; }
        .batch-name { font-family:'Sora',sans-serif;font-weight:700;font-size:1rem;color:var(--text);margin-bottom:0.75rem;line-height:1.3; }
        .batch-meta-row { display:flex;align-items:center;gap:6px;color:var(--muted);font-size:0.8rem;margin-bottom:0.4rem; }
        .batch-meta-row i { width:16px;flex-shrink:0;color:var(--accent); }
        .batch-card-footer { padding:0.9rem 1.25rem;background:#fafafa;border-top:1px solid var(--border);display:flex;align-items:center;justify-content:space-between;gap:8px; }
        .btn-view { background:var(--accent);color:white;border:none;padding:0.45rem 1rem;border-radius:8px;font-size:0.8rem;font-weight:600;text-decoration:none;display:inline-flex;align-items:center;gap:5px;transition:all 0.18s; }
        .btn-view:hover { background:#2563eb;color:white; }
        .search-box { border-radius:10px;border:1px solid var(--border);padding:0.5rem 1rem 0.5rem 2.5rem;font-size:0.88rem;background:white;transition:all 0.2s;outline:none; }
        .search-box:focus { border-color:var(--accent);box-shadow:0 0 0 3px rgba(59,130,246,0.12); }
        @media(max-width:992px) { .sidebar { display:none; } .main-layout { margin-left:0; } }
    </style>
</head>
<body>

<c:set var="displayName"  value="${not empty sessionScope.name  ? sessionScope.name  : 'User'}"/>
<c:set var="displayEmail" value="${not empty sessionScope.email ? sessionScope.email : ''}"/>
<c:set var="displayFileId" value="${not empty sessionScope.fileId ? sessionScope.fileId : ''}"/>

<!-- SIDEBAR -->
<aside class="sidebar">
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
    <div class="sidebar-footer">
        <div style="display:flex;align-items:center;gap:10px;">
            <c:choose>
                <c:when test="${not empty displayFileId}">
                    <img src="<c:url value='/getImage?id=${displayFileId}'/>" style="width:36px;height:36px;border-radius:50%;object-fit:cover;border:2px solid var(--accent);" alt="">
                </c:when>
                <c:otherwise>
                    <div style="width:36px;height:36px;border-radius:50%;background:linear-gradient(135deg,var(--accent),#06b6d4);display:flex;align-items:center;justify-content:center;">
                        <i class="bi bi-person-fill text-white" style="font-size:1rem;"></i>
                    </div>
                </c:otherwise>
            </c:choose>
            <div>
                <div style="color:white;font-size:0.82rem;font-weight:600;">${displayName}</div>
                <div style="color:#64748b;font-size:0.7rem;">${displayEmail}</div>
            </div>
        </div>
    </div>
</aside>

<!-- MAIN -->
<div class="main-layout">
    <div class="topbar">
        <span class="topbar-title">Manage Batches</span>
        <a href="<c:url value='/dashboard/addBatch'/>" class="btn-add">
            <i class="bi bi-plus-circle"></i> Create New Batch
        </a>
    </div>

    <div class="container-fluid py-4 px-4">

        <%-- Flash messages --%>
        <c:if test="${not empty msg}">
            <div class="alert alert-success alert-dismissible fade show mb-3" style="border-radius:12px;">
                <i class="bi bi-check-circle me-2"></i>${msg}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <%-- Header stats + search --%>
        <div class="d-flex align-items-center justify-content-between flex-wrap gap-3 mb-4">
            <div>
                <h5 style="font-family:'Sora',sans-serif;font-weight:700;margin-bottom:2px;">All Batches</h5>
                <span style="color:var(--muted);font-size:0.85rem;">${not empty batches ? batches.size() : 0} batch${batches.size() != 1 ? 'es' : ''} found</span>
            </div>
            <div style="position:relative;">
                <i class="bi bi-search" style="position:absolute;left:10px;top:50%;transform:translateY(-50%);color:var(--muted);font-size:0.85rem;"></i>
                <input type="text" class="search-box" id="batchSearch" placeholder="Search batches..." oninput="filterBatches(this.value)" style="width:240px;">
            </div>
        </div>

        <%-- Batch Grid --%>
        <c:choose>
            <c:when test="${empty batches}">
                <div style="background:white;border-radius:16px;border:1px solid var(--border);padding:4rem;text-align:center;">
                    <i class="bi bi-inbox" style="font-size:4rem;color:#cbd5e1;"></i>
                    <div style="font-family:'Sora',sans-serif;font-weight:700;font-size:1.1rem;margin-top:1rem;color:var(--text);">No Batches Yet</div>
                    <div style="color:var(--muted);margin-top:0.4rem;">Create your first training batch to get started.</div>
                    <a href="<c:url value='/dashboard/addBatch'/>" class="btn-add d-inline-flex mt-3"><i class="bi bi-plus-circle"></i> Create Batch</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row g-3" id="batchGrid">
                    <c:forEach var="batch" items="${batches}">
                        <div class="col-md-6 col-xl-4 batch-item" data-name="${batch.batchName.toLowerCase()} ${batch.course.toLowerCase()} ${batch.instructor.toLowerCase()}">
                            <div class="batch-card">
                                <%-- Color strip by type --%>
                                <div class="batch-card-top" style="background:${batch.batchType == 'Online' ? 'linear-gradient(90deg,#3b82f6,#06b6d4)' : batch.batchType == 'Offline' ? 'linear-gradient(90deg,#10b981,#059669)' : 'linear-gradient(90deg,#8b5cf6,#ec4899)'};"></div>
                                <div class="batch-card-body">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <c:choose>
                                            <c:when test="${batch.batchType == 'Online'}">
                                                <span class="batch-type-badge" style="background:rgba(59,130,246,0.1);color:#3b82f6;"><i class="bi bi-laptop"></i>Online</span>
                                            </c:when>
                                            <c:when test="${batch.batchType == 'Offline'}">
                                                <span class="batch-type-badge" style="background:rgba(16,185,129,0.1);color:#10b981;"><i class="bi bi-building"></i>Offline</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="batch-type-badge" style="background:rgba(139,92,246,0.1);color:#8b5cf6;"><i class="bi bi-arrow-left-right"></i>Hybrid</span>
                                            </c:otherwise>
                                        </c:choose>

                                        <%-- Actions dropdown --%>
                                        <div class="dropdown">
                                            <button class="btn btn-sm" style="background:var(--surface);border:1px solid var(--border);border-radius:8px;padding:3px 8px;" data-bs-toggle="dropdown">
                                                <i class="bi bi-three-dots-vertical text-muted"></i>
                                            </button>
                                            <ul class="dropdown-menu dropdown-menu-end" style="border-radius:10px;font-size:0.85rem;">
                                                <li><a class="dropdown-item" href="<c:url value='/dashboard/batchDetails/${batch.id}'/>"><i class="bi bi-eye me-2"></i>View Details</a></li>
                                                <li><hr class="dropdown-divider"></li>
                                                <li>
                                                    <form action="<c:url value='/dashboard/deleteBatch/${batch.id}'/>" method="post" onsubmit="return confirm('Delete this batch?');">
                                                        <button type="submit" class="dropdown-item text-danger"><i class="bi bi-trash me-2"></i>Delete</button>
                                                    </form>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>

                                    <div class="batch-name">${batch.batchName}</div>
                                    <div class="batch-meta-row"><i class="bi bi-book"></i> ${batch.course}</div>
                                    <div class="batch-meta-row"><i class="bi bi-person-video3"></i> ${batch.instructor}</div>
                                    <div class="batch-meta-row"><i class="bi bi-calendar-event"></i> ${batch.startDate}</div>
                                    <c:if test="${not empty batch.description}">
                                        <div class="batch-meta-row mt-2" style="font-size:0.78rem;color:var(--muted);"><i class="bi bi-text-paragraph"></i>${batch.description}</div>
                                    </c:if>
                                </div>
                                <div class="batch-card-footer">
                                    <span style="font-size:0.75rem;color:var(--muted);">
                                        <i class="bi bi-circle-fill me-1" style="font-size:0.5rem;color:#10b981;"></i>Active
                                    </span>
                                    <a href="<c:url value='/dashboard/batchDetails/${batch.id}'/>" class="btn-view">
                                        <i class="bi bi-arrow-right-circle"></i> View Details
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
function filterBatches(query) {
    const q = query.toLowerCase().trim();
    document.querySelectorAll('.batch-item').forEach(item => {
        item.style.display = (!q || item.dataset.name.includes(q)) ? '' : 'none';
    });
}
</script>
</body>
</html>
