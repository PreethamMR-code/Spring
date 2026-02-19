<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Batch | X-Workz</title>
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
        .btn-back { background:white; border:1px solid var(--border); color:var(--text); padding:0.5rem 1rem; border-radius:10px; font-size:0.85rem; font-weight:600; text-decoration:none; transition:all 0.2s; }
        .btn-back:hover { background:var(--surface); color:var(--accent); }

        .hero-mini { background:linear-gradient(135deg,#1e3a5f,#0f172a); padding:2rem; color:white; }
        .hero-mini h2 { font-family:'Sora',sans-serif; font-weight:800; margin-bottom:0.25rem; }
        .form-card { background:white; border-radius:16px; border:1px solid var(--border); padding:2rem; box-shadow:0 4px 20px rgba(0,0,0,0.06); }
        .form-label { font-weight:600; font-size:0.85rem; color:var(--text); margin-bottom:0.4rem; }
        .form-control, .form-select { border-radius:10px; border:2px solid #e2e8f0; padding:0.7rem 1rem; font-size:0.9rem; }
        .form-control:focus, .form-select:focus { border-color:var(--accent); box-shadow:0 0 0 4px rgba(59,130,246,0.12); }
        textarea { resize:vertical; }
        .btn-primary-custom { background:var(--accent); border:none; padding:0.7rem 2rem; border-radius:10px; font-weight:700; font-size:0.9rem; color:white; transition:all 0.2s; }
        .btn-primary-custom:hover { background:#2563eb; transform:translateY(-1px); }
        .btn-outline-custom { background:white; border:2px solid var(--border); color:var(--text); padding:0.65rem 1.5rem; border-radius:10px; font-weight:600; font-size:0.9rem; transition:all 0.2s; }
        .btn-outline-custom:hover { border-color:var(--accent); color:var(--accent); }

        @media(max-width:992px) { .sidebar { transform:translateX(-100%); } .sidebar.open { transform:translateX(0); } .main-layout { margin-left:0; } }
        .mobile-menu-btn { display:none; }
        @media(max-width:992px) { .mobile-menu-btn { display:flex; width:38px; height:38px; border-radius:10px; border:1px solid var(--border); background:white; align-items:center; justify-content:center; cursor:pointer; } }
        .sidebar-overlay { display:none; position:fixed; inset:0; background:rgba(0,0,0,0.5); z-index:1049; }
        @media(max-width:992px) { .sidebar-overlay.active { display:block; } }
    </style>
</head>
<body>

<c:set var="displayEmail" value="${not empty sessionScope.email ? sessionScope.email : ''}"/>
<div class="sidebar-overlay" id="sidebarOverlay" onclick="document.getElementById('sidebar').classList.remove('open');this.classList.remove('active');"></div>

<aside class="sidebar" id="sidebar">
    <div class="sidebar-logo">
        <img src="https://x-workz.com/Logo.png" alt="X-Workz">
        <div class="sidebar-logo-text">X-Workz <small>Learning Platform</small></div>
    </div>
    <div class="sidebar-section">Main</div>
    <a href="<c:url value='/dashboard/Home'/>" class="nav-link-item"><i class="bi bi-grid-1x2-fill"></i> Dashboard</a>
    <a href="<c:url value='/dashboard/viewBatches'/>" class="nav-link-item"><i class="bi bi-journal-bookmark-fill"></i> My Courses</a>
    <a href="<c:url value='/editProfile'/>?email=${displayEmail}" class="nav-link-item"><i class="bi bi-person-badge-fill"></i> My Profile</a>
    <div class="sidebar-section">Administration</div>
    <a href="<c:url value='/dashboard/addBatch'/>" class="nav-link-item active"><i class="bi bi-plus-square-dotted"></i> Create Batch</a>
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
            <span class="topbar-title">Create New Batch</span>
        </div>
        <a href="<c:url value='/dashboard/Home'/>" class="btn-back">
            <i class="bi bi-arrow-left me-1"></i>Back
        </a>
    </div>

    <div class="hero-mini">
        <h2><i class="bi bi-plus-circle me-2"></i>Add New Batch</h2>
        <p style="opacity:0.8;margin-bottom:0;font-size:0.9rem;">Create a new training batch for your students</p>
    </div>

    <div class="container-fluid px-4 py-4">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="form-card">
                    <c:if test="${not empty msg}">
                        <div class="alert alert-success alert-dismissible fade show mb-3" style="border-radius:10px;border:none;background:rgba(16,185,129,0.1);color:#065f46;">
                            <i class="bi bi-check-circle me-2"></i>${msg}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show mb-3" style="border-radius:10px;border:none;background:rgba(239,68,68,0.1);color:#991b1b;">
                            <i class="bi bi-exclamation-triangle me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="<c:url value='/dashboard/addBatch'/>" method="post">
                        <div class="mb-3">
                            <label class="form-label"><i class="bi bi-tag me-2"></i>Batch Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="batchName" placeholder="e.g., Java-Jan-2026" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label"><i class="bi bi-person-video3 me-2"></i>Instructor <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="instructor" placeholder="Enter instructor name" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label"><i class="bi bi-book me-2"></i>Course <span class="text-danger">*</span></label>
                            <select class="form-select" name="course" required>
                                <option value="">Select Course</option>
                                <option value="Java Full Stack">Java Full Stack Development</option>
                                <option value="Python Programming">Python Programming</option>
                                <option value="Web Development">Web Development</option>
                                <option value="Data Science">Data Science</option>
                                <option value="DevOps">DevOps Engineering</option>
                                <option value="Cloud Computing">Cloud Computing</option>
                                <option value="Machine Learning">Machine Learning</option>
                                <option value="Mobile Development">Mobile App Development</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label"><i class="bi bi-calendar-event me-2"></i>Start Date <span class="text-danger">*</span></label>
                            <input type="date" class="form-control" name="startDate" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label"><i class="bi bi-gear me-2"></i>Batch Type <span class="text-danger">*</span></label>
                            <div class="btn-group w-100" role="group">
                                <input type="radio" class="btn-check" name="batchType" id="online" value="Online" required>
                                <label class="btn btn-outline-primary" for="online" style="border-radius:10px 0 0 10px;"><i class="bi bi-laptop me-2"></i>Online</label>
                                <input type="radio" class="btn-check" name="batchType" id="offline" value="Offline">
                                <label class="btn btn-outline-primary" for="offline"><i class="bi bi-building me-2"></i>Offline</label>
                                <input type="radio" class="btn-check" name="batchType" id="hybrid" value="Hybrid">
                                <label class="btn btn-outline-primary" for="hybrid" style="border-radius:0 10px 10px 0;"><i class="bi bi-arrow-left-right me-2"></i>Hybrid</label>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label"><i class="bi bi-text-paragraph me-2"></i>Description</label>
                            <textarea class="form-control" name="description" rows="4" placeholder="Enter batch description..."></textarea>
                        </div>

                        <div class="d-flex gap-2 justify-content-end">
                            <a href="<c:url value='/dashboard/Home'/>" class="btn btn-outline-custom">
                                <i class="bi bi-x-circle me-1"></i>Cancel
                            </a>
                            <button type="submit" class="btn btn-primary-custom">
                                <i class="bi bi-check-circle me-1"></i>Create Batch
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
