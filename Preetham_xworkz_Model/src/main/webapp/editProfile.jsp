<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile | X-Workz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@400;600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root { --sidebar-w:260px; --navy:#0f172a; --navy-2:#1e293b; --accent:#3b82f6; --surface:#f8fafc; --border:#e2e8f0; --text:#1e293b; --muted:#64748b; }
        * { box-sizing:border-box; }
        body { font-family:'Inter',sans-serif; background:var(--surface); margin:0; }
        h1,h2,h3,h4,h5,h6 { font-family:'Sora',sans-serif; }

        /* Sidebar — same as Home.jsp */
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

        .profile-card { background:white;border-radius:20px;border:1px solid var(--border);overflow:hidden;box-shadow:0 2px 12px rgba(0,0,0,0.05); }
        .profile-banner { height:120px;background:linear-gradient(135deg,#1e3a5f 0%,#0f172a 60%,#1e293b 100%);position:relative; }
        .profile-avatar-wrap { position:absolute;bottom:-40px;left:50%;transform:translateX(-50%); }
        .profile-avatar { width:80px;height:80px;border-radius:50%;object-fit:cover;border:4px solid white;box-shadow:0 4px 12px rgba(0,0,0,0.15); }
        .profile-avatar-default { width:80px;height:80px;border-radius:50%;background:linear-gradient(135deg,var(--accent),#06b6d4);display:flex;align-items:center;justify-content:center;border:4px solid white;box-shadow:0 4px 12px rgba(0,0,0,0.15); }
        .form-control-custom { border-radius:10px;border:1px solid var(--border);padding:0.6rem 1rem;font-size:0.9rem;transition:all 0.2s;background:white; }
        .form-control-custom:focus { border-color:var(--accent);box-shadow:0 0 0 3px rgba(59,130,246,0.12);outline:none; }
        .form-control-custom[readonly] { background:#f8fafc;color:var(--muted);cursor:not-allowed; }
        .form-label-custom { font-weight:600;font-size:0.8rem;color:var(--muted);text-transform:uppercase;letter-spacing:0.5px;margin-bottom:0.4rem; }
        .btn-save { background:var(--accent);color:white;border:none;padding:0.65rem 2rem;border-radius:10px;font-weight:700;font-size:0.9rem;transition:all 0.2s; }
        .btn-save:hover { background:#2563eb;transform:translateY(-1px); }
        .btn-cancel { background:white;color:var(--muted);border:1px solid var(--border);padding:0.65rem 1.5rem;border-radius:10px;font-weight:600;font-size:0.9rem;transition:all 0.2s;text-decoration:none; }
        .btn-cancel:hover { background:var(--surface);color:var(--text); }

        @media(max-width:992px) { .sidebar { display:none; } .main-layout { margin-left:0; } }
    </style>
</head>
<body>

<%-- The controller puts user data in model as 'registrationEntity' --%>
<%-- Session fallbacks for sidebar display --%>
<c:set var="displayName"   value="${not empty sessionScope.name  ? sessionScope.name  : 'User'}"/>
<c:set var="displayEmail"  value="${not empty sessionScope.email ? sessionScope.email : ''}"/>
<c:set var="displayFileId" value="${not empty sessionScope.fileId ? sessionScope.fileId : ''}"/>

<%-- The user data for the form comes from registrationEntity set by XworkzController.showEditProfile() --%>
<c:set var="u" value="${registrationEntity}"/>

<!-- SIDEBAR -->
<aside class="sidebar">
    <div class="sidebar-logo">
        <img src="https://x-workz.com/Logo.png" alt="X-Workz">
        <div class="sidebar-logo-text">X-Workz <small>Learning Platform</small></div>
    </div>
    <div class="sidebar-section">Main</div>
    <a href="<c:url value='/dashboard/Home'/>" class="nav-link-item"><i class="bi bi-grid-1x2-fill"></i> Dashboard</a>
    <a href="<c:url value='/dashboard/viewBatches'/>" class="nav-link-item"><i class="bi bi-journal-bookmark-fill"></i> My Courses</a>
    <a href="<c:url value='/editProfile'/>?email=${displayEmail}" class="nav-link-item active"><i class="bi bi-person-badge-fill"></i> My Profile</a>
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

<!-- MAIN LAYOUT -->
<div class="main-layout">

    <!-- TOPBAR -->
    <div class="topbar">
        <span class="topbar-title">My Profile</span>
        <a href="<c:url value='/dashboard/Home'/>" style="color:var(--muted);text-decoration:none;font-size:0.85rem;display:flex;align-items:center;gap:5px;">
            <i class="bi bi-arrow-left"></i> Back to Dashboard
        </a>
    </div>

    <div class="container py-4" style="max-width:680px;">

        <%-- Alerts --%>
        <c:if test="${not empty msg}">
            <div class="alert alert-success alert-dismissible fade show" style="border-radius:12px;">
                <i class="bi bi-check-circle me-2"></i>${msg}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" style="border-radius:12px;">
                <i class="bi bi-exclamation-circle me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Profile Card -->
        <div class="profile-card">
            <%-- Banner + Avatar --%>
            <div class="profile-banner">
                <div class="profile-avatar-wrap">
                    <c:choose>
                        <c:when test="${not empty displayFileId}">
                            <img src="<c:url value='/getImage?id=${displayFileId}'/>" class="profile-avatar" alt="Profile">
                        </c:when>
                        <c:otherwise>
                            <div class="profile-avatar-default">
                                <i class="bi bi-person-fill text-white fs-2"></i>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <%-- Name and email shown below avatar --%>
            <div style="padding:3rem 2rem 0.5rem;text-align:center;">
                <div style="font-family:'Sora',sans-serif;font-weight:700;font-size:1.25rem;color:var(--text);">${u.name}</div>
                <div style="color:var(--muted);font-size:0.85rem;margin-top:2px;">${u.email}</div>
                <button class="btn btn-outline-primary btn-sm mt-2" style="border-radius:8px;font-size:0.8rem;"
                        data-bs-toggle="modal" data-bs-target="#uploadPhotoModal">
                    <i class="bi bi-camera me-1"></i>Change Photo
                </button>
            </div>

            <%-- FORM --%>
            <form action="<c:url value='/updateProfile'/>" method="post" style="padding:1.5rem 2rem 2rem;">
                <div class="row g-3">

                    <%-- Email — read only, pre-filled --%>
                    <div class="col-12">
                        <div class="form-label-custom">Email Address</div>
                        <div style="position:relative;">
                            <input type="email" class="form-control-custom w-100" name="email"
                                   value="${u.email}" readonly>
                            <span style="position:absolute;right:12px;top:50%;transform:translateY(-50%);background:rgba(100,116,139,0.1);color:var(--muted);border-radius:5px;padding:1px 8px;font-size:0.7rem;">locked</span>
                        </div>
                        <small style="color:var(--muted);font-size:0.75rem;">Email cannot be changed</small>
                    </div>

                    <%-- Full Name --%>
                    <div class="col-12">
                        <label class="form-label-custom">Full Name *</label>
                        <input type="text" class="form-control-custom w-100" name="name"
                               value="${u.name}" required placeholder="Your full name">
                    </div>

                    <%-- Phone + Age in a row --%>
                    <div class="col-sm-7">
                        <label class="form-label-custom">Phone Number *</label>
                        <input type="tel" class="form-control-custom w-100" name="phone"
                               value="${u.phone}" maxlength="10" required placeholder="10-digit number">
                    </div>
                    <div class="col-sm-5">
                        <label class="form-label-custom">Age *</label>
                        <input type="number" class="form-control-custom w-100" name="age"
                               value="${u.age}" min="18" max="60" required>
                    </div>

                    <%-- Gender — read only --%>
                    <div class="col-12">
                        <label class="form-label-custom">Gender</label>
                        <div style="position:relative;">
                            <input type="text" class="form-control-custom w-100"
                                   value="${u.gender}" readonly>
                            <span style="position:absolute;right:12px;top:50%;transform:translateY(-50%);background:rgba(100,116,139,0.1);color:var(--muted);border-radius:5px;padding:1px 8px;font-size:0.7rem;">locked</span>
                        </div>
                    </div>

                    <%-- Address --%>
                    <div class="col-12">
                        <label class="form-label-custom">Address *</label>
                        <textarea class="form-control-custom w-100" name="address" rows="3"
                                  required placeholder="Your full address">${u.address}</textarea>
                    </div>
                </div>

                <%-- Buttons --%>
                <div class="d-flex gap-2 justify-content-end mt-4">
                    <a href="<c:url value='/dashboard/Home'/>" class="btn-cancel">Cancel</a>
                    <button type="submit" class="btn-save">
                        <i class="bi bi-check-circle me-1"></i>Save Changes
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Upload Photo Modal -->
<div class="modal fade" id="uploadPhotoModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="border-radius:16px;border:none;">
            <div class="modal-header border-0">
                <h5 class="modal-title fw-bold"><i class="bi bi-camera me-2 text-primary"></i>Update Photo</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="<c:url value='/uploadProfilePhoto'/>" method="post" enctype="multipart/form-data">
                <div class="modal-body">
                    <input type="hidden" name="email" value="${displayEmail}">
                    <div class="text-center mb-3">
                        <img id="photoPreview"
                             src="<c:choose><c:when test='${not empty displayFileId}'><c:url value='/getImage?id=${displayFileId}'/></c:when><c:otherwise>https://ui-avatars.com/api/?name=${displayName}&size=120&background=3b82f6&color=fff&bold=true</c:otherwise></c:choose>"
                             style="width:100px;height:100px;border-radius:50%;object-fit:cover;border:3px solid #e2e8f0;" alt="Preview">
                    </div>
                    <input type="file" class="form-control" name="profilePhoto" accept="image/*" required
                           style="border-radius:10px;" onchange="previewImage(this)">
                    <small class="text-muted">Max 5MB · JPG, PNG, GIF</small>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary" style="border-radius:10px;">Upload</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
function previewImage(input) {
    if (input.files && input.files[0]) {
        const r = new FileReader();
        r.onload = e => document.getElementById('photoPreview').src = e.target.result;
        r.readAsDataURL(input.files[0]);
    }
}
</script>
</body>
</html>
