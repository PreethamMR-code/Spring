<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Student | X-Workz</title>
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
        .info-card { background:white; border-radius:16px; border:1px solid var(--border); padding:1.5rem; margin-top:1.5rem; }
        .info-card-header { background:rgba(59,130,246,0.08); margin:-1.5rem -1.5rem 1rem; padding:0.75rem 1.5rem; border-radius:16px 16px 0 0; border-bottom:1px solid rgba(59,130,246,0.15); }
        .id-badge { background:linear-gradient(135deg,var(--accent),#2563eb); color:white; border-radius:10px; padding:1rem 1.5rem; text-align:center; margin-bottom:1.5rem; }
        .id-badge-num { font-family:'Sora',sans-serif; font-size:1.8rem; font-weight:800; }
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
            <span class="topbar-title">Add Student to ${batch.batchName}</span>
        </div>
        <a href="<c:url value='/dashboard/batchDetails/${batch.id}'/>" class="btn-back">
            <i class="bi bi-arrow-left me-1"></i>Back to Batch
        </a>
    </div>

    <div class="hero-mini">
        <h2><i class="bi bi-person-plus me-2"></i>Add Student</h2>
        <p style="opacity:0.8;margin-bottom:0;font-size:0.9rem;">Enroll a new student in ${batch.batchName}</p>
    </div>

    <div class="container-fluid px-4 py-4">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="form-card">
                    <div class="id-badge">
                        <div style="font-size:0.75rem;opacity:0.9;margin-bottom:4px;">Next Student ID</div>
                        <div class="id-badge-num">${nextStudentId}</div>
                        <small style="opacity:0.85;">This ID will be auto-assigned</small>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show mb-3" style="border-radius:10px;border:none;background:rgba(239,68,68,0.1);color:#991b1b;">
                            <i class="bi bi-exclamation-triangle me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="<c:url value='/dashboard/addStudent'/>" method="post">
                        <input type="hidden" name="batchId" value="${batch.id}">

                        <div class="mb-3">
                            <label class="form-label"><i class="bi bi-person me-2"></i>Full Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="name" placeholder="Enter student name" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label"><i class="bi bi-envelope me-2"></i>Email <span class="text-danger">*</span></label>
                            <input type="email" class="form-control" name="email" placeholder="student@example.com" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label"><i class="bi bi-telephone me-2"></i>Phone Number <span class="text-danger">*</span></label>
                            <input type="tel" class="form-control" name="phone" placeholder="9876543210" maxlength="10" pattern="[6-9][0-9]{9}" required>
                            <small class="text-muted">Must start with 6-9 and contain 10 digits</small>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label"><i class="bi bi-gender-ambiguous me-2"></i>Gender <span class="text-danger">*</span></label>
                                <select class="form-select" name="gender" required>
                                    <option value="">Select Gender</option>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label"><i class="bi bi-calendar me-2"></i>Age <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" name="age" placeholder="18" min="18" max="60" required>
                                <small class="text-muted">Must be between 18-60</small>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label"><i class="bi bi-geo-alt me-2"></i>Address <span class="text-danger">*</span></label>
                            <textarea class="form-control" name="address" rows="3" placeholder="Enter complete address (minimum 10 characters)" minlength="10" required></textarea>
                        </div>

                        <div class="d-flex gap-2 justify-content-end">
                            <a href="<c:url value='/dashboard/batchDetails/${batch.id}'/>" class="btn btn-outline-custom">
                                <i class="bi bi-x-circle me-1"></i>Cancel
                            </a>
                            <button type="submit" class="btn btn-primary-custom">
                                <i class="bi bi-check-circle me-1"></i>Add Student
                            </button>
                        </div>
                    </form>
                </div>

                <div class="info-card">
                    <div class="info-card-header">
                        <h6 class="mb-0 fw-bold"><i class="bi bi-info-circle me-2"></i>Batch Information</h6>
                    </div>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <small class="text-muted d-block mb-1">Batch Name</small>
                            <p class="mb-0 fw-semibold">${batch.batchName}</p>
                        </div>
                        <div class="col-md-6">
                            <small class="text-muted d-block mb-1">Course</small>
                            <p class="mb-0 fw-semibold">${batch.course}</p>
                        </div>
                        <div class="col-md-6">
                            <small class="text-muted d-block mb-1">Instructor</small>
                            <p class="mb-0 fw-semibold">${batch.instructor}</p>
                        </div>
                        <div class="col-md-6">
                            <small class="text-muted d-block mb-1">Batch Type</small>
                            <span class="badge" style="background:var(--accent);font-size:0.8rem;">${batch.batchType}</span>
                        </div>
                        <div class="col-md-6">
                            <small class="text-muted d-block mb-1">Start Date</small>
                            <p class="mb-0 fw-semibold">${batch.startDate}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
document.querySelector('form').addEventListener('submit', function(e) {
    const phone = document.querySelector('input[name="phone"]').value;
    const phonePattern = /^[6-9][0-9]{9}$/;
    if (!phonePattern.test(phone)) {
        e.preventDefault();
        alert('Phone number must start with 6-9 and contain exactly 10 digits');
        return false;
    }
    const age = parseInt(document.querySelector('input[name="age"]').value);
    if (age < 18 || age > 60) {
        e.preventDefault();
        alert('Age must be between 18 and 60');
        return false;
    }
});
</script>
</body>
</html>
