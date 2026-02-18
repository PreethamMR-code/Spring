<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home | X-Workz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@400;600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --sidebar-w: 260px;
            --navy: #0f172a;
            --navy-2: #1e293b;
            --navy-3: #334155;
            --accent: #3b82f6;
            --accent-2: #06b6d4;
            --gold: #f59e0b;
            --green: #10b981;
            --red: #ef4444;
            --surface: #f8fafc;
            --card: #ffffff;
            --text: #1e293b;
            --muted: #64748b;
            --border: #e2e8f0;
        }
        * { box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; background: var(--surface); margin: 0; overflow-x: hidden; }
        h1,h2,h3,h4,h5,h6 { font-family: 'Sora', sans-serif; }

        /* ── SIDEBAR ── */
        .sidebar {
            position: fixed; top: 0; left: 0; width: var(--sidebar-w); height: 100vh;
            background: var(--navy); z-index: 1050; overflow-y: auto;
            display: flex; flex-direction: column;
            transition: transform 0.3s cubic-bezier(0.4,0,0.2,1);
            box-shadow: 4px 0 24px rgba(0,0,0,0.2);
        }
        .sidebar-logo { padding: 1.5rem 1.25rem 1rem; display: flex; align-items: center; gap: 10px; border-bottom: 1px solid rgba(255,255,255,0.07); }
        .sidebar-logo img { width: 36px; height: 36px; object-fit: contain; }
        .sidebar-logo-text { color: white; font-family: 'Sora', sans-serif; font-weight: 700; font-size: 1rem; line-height: 1.1; }
        .sidebar-logo-text small { display: block; color: #64748b; font-size: 0.65rem; font-weight: 400; letter-spacing: 1px; text-transform: uppercase; font-family: 'Inter', sans-serif; }
        .sidebar-section { padding: 1.25rem 1.25rem 0.4rem; color: #475569; font-size: 0.65rem; text-transform: uppercase; font-weight: 700; letter-spacing: 1.5px; }
        .nav-link-item { display: flex; align-items: center; gap: 12px; padding: 0.7rem 1.25rem; color: #94a3b8; text-decoration: none; border-radius: 0; font-size: 0.9rem; font-weight: 500; transition: all 0.18s; margin: 1px 0; position: relative; }
        .nav-link-item:hover { background: rgba(255,255,255,0.06); color: #f1f5f9; }
        .nav-link-item.active { background: linear-gradient(90deg, rgba(59,130,246,0.15), transparent); color: var(--accent); border-left: 3px solid var(--accent); }
        .nav-link-item i { font-size: 1.1rem; width: 20px; flex-shrink: 0; }
        .nav-link-item .badge-count { margin-left: auto; background: var(--accent); color: white; border-radius: 10px; padding: 1px 8px; font-size: 0.7rem; font-weight: 700; }
        .sidebar-footer { margin-top: auto; padding: 1rem 1.25rem; border-top: 1px solid rgba(255,255,255,0.07); }
        .sidebar-user { display: flex; align-items: center; gap: 10px; }
        .sidebar-user-avatar { width: 36px; height: 36px; border-radius: 50%; object-fit: cover; border: 2px solid var(--accent); flex-shrink: 0; }
        .sidebar-user-avatar-default { width: 36px; height: 36px; border-radius: 50%; background: linear-gradient(135deg, var(--accent), var(--accent-2)); display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
        .sidebar-user-name { color: white; font-size: 0.82rem; font-weight: 600; }
        .sidebar-user-email { color: #64748b; font-size: 0.7rem; }

        /* ── MAIN CONTENT ── */
        .main-layout { margin-left: var(--sidebar-w); min-height: 100vh; }

        /* ── TOPBAR ── */
        .topbar { background: white; border-bottom: 1px solid var(--border); padding: 0 2rem; height: 64px; display: flex; align-items: center; justify-content: space-between; position: sticky; top: 0; z-index: 100; box-shadow: 0 1px 3px rgba(0,0,0,0.06); }
        .topbar-title { font-family: 'Sora', sans-serif; font-weight: 700; font-size: 1.05rem; color: var(--text); }
        .topbar-right { display: flex; align-items: center; gap: 12px; }
        .topbar-btn { width: 38px; height: 38px; border-radius: 10px; border: 1px solid var(--border); background: white; display: flex; align-items: center; justify-content: center; cursor: pointer; color: var(--muted); transition: all 0.15s; text-decoration: none; }
        .topbar-btn:hover { background: var(--surface); border-color: #cbd5e1; color: var(--accent); }
        .avatar-btn { border-radius: 50%; overflow: hidden; border: 2px solid var(--accent); width: 38px; height: 38px; cursor: pointer; }
        .avatar-btn img { width: 100%; height: 100%; object-fit: cover; }
        .avatar-btn-default { width: 38px; height: 38px; border-radius: 50%; background: linear-gradient(135deg, var(--accent), var(--accent-2)); display: flex; align-items: center; justify-content: center; cursor: pointer; border: 2px solid var(--accent); }

        /* ── HERO ── */
        .hero { background: linear-gradient(135deg, #1e3a5f 0%, #0f172a 60%, #1e293b 100%); padding: 2.5rem 2rem; position: relative; overflow: hidden; }
        .hero::before { content: ''; position: absolute; top: -50%; right: -10%; width: 500px; height: 500px; background: radial-gradient(circle, rgba(59,130,246,0.15) 0%, transparent 70%); pointer-events: none; }
        .hero::after { content: ''; position: absolute; bottom: -30%; left: 30%; width: 300px; height: 300px; background: radial-gradient(circle, rgba(6,182,212,0.1) 0%, transparent 70%); pointer-events: none; }
        .hero-greeting { color: rgba(255,255,255,0.6); font-size: 0.9rem; margin-bottom: 0.25rem; }
        .hero-name { font-family: 'Sora', sans-serif; font-size: 2rem; font-weight: 800; color: white; margin-bottom: 0.5rem; line-height: 1.2; }
        .hero-sub { color: rgba(255,255,255,0.55); font-size: 0.95rem; }
        .hero-actions { display: flex; gap: 12px; margin-top: 1.5rem; flex-wrap: wrap; }
        .btn-hero-primary { background: var(--accent); color: white; border: none; padding: 0.6rem 1.5rem; border-radius: 10px; font-weight: 600; font-size: 0.9rem; cursor: pointer; transition: all 0.2s; text-decoration: none; display: inline-flex; align-items: center; gap: 6px; }
        .btn-hero-primary:hover { background: #2563eb; color: white; transform: translateY(-1px); }
        .btn-hero-outline { background: rgba(255,255,255,0.1); color: white; border: 1px solid rgba(255,255,255,0.2); padding: 0.6rem 1.5rem; border-radius: 10px; font-weight: 600; font-size: 0.9rem; cursor: pointer; transition: all 0.2s; text-decoration: none; display: inline-flex; align-items: center; gap: 6px; backdrop-filter: blur(4px); }
        .btn-hero-outline:hover { background: rgba(255,255,255,0.18); color: white; transform: translateY(-1px); }

        /* ── STAT CARDS ── */
        .stats-row { display: grid; grid-template-columns: repeat(4, 1fr); gap: 1rem; padding: 1.5rem 2rem; }
        .stat-card { background: white; border-radius: 14px; padding: 1.25rem; border: 1px solid var(--border); display: flex; align-items: center; gap: 1rem; transition: all 0.2s; cursor: default; }
        .stat-card:hover { transform: translateY(-2px); box-shadow: 0 8px 24px rgba(0,0,0,0.08); }
        .stat-icon { width: 48px; height: 48px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 1.4rem; flex-shrink: 0; }
        .stat-num { font-family: 'Sora', sans-serif; font-size: 1.6rem; font-weight: 800; color: var(--text); line-height: 1; }
        .stat-label { color: var(--muted); font-size: 0.78rem; margin-top: 2px; font-weight: 500; }

        /* ── SECTION ── */
        .section { padding: 0 2rem 1.5rem; }
        .section-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 1rem; }
        .section-title { font-family: 'Sora', sans-serif; font-size: 1.05rem; font-weight: 700; color: var(--text); }
        .section-link { color: var(--accent); font-size: 0.82rem; font-weight: 600; text-decoration: none; display: flex; align-items: center; gap: 4px; }
        .section-link:hover { color: #2563eb; }

        /* ── COURSE CARDS ── */
        .courses-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 1rem; }
        .course-card { background: white; border-radius: 14px; border: 1px solid var(--border); overflow: hidden; transition: all 0.2s; }
        .course-card:hover { transform: translateY(-3px); box-shadow: 0 12px 32px rgba(0,0,0,0.1); border-color: var(--accent); }
        .course-card-header { height: 8px; }
        .course-card-body { padding: 1.25rem; }
        .course-tag { display: inline-block; background: rgba(59,130,246,0.1); color: var(--accent); border-radius: 6px; padding: 2px 10px; font-size: 0.72rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 0.6rem; }
        .course-name { font-family: 'Sora', sans-serif; font-weight: 700; font-size: 0.95rem; color: var(--text); margin-bottom: 0.5rem; }
        .course-instructor { color: var(--muted); font-size: 0.8rem; display: flex; align-items: center; gap: 5px; }
        .progress-bar-custom { height: 5px; background: var(--border); border-radius: 10px; margin: 0.75rem 0 0.4rem; overflow: hidden; }
        .progress-fill { height: 100%; border-radius: 10px; transition: width 0.5s ease; }
        .course-footer { display: flex; align-items: center; justify-content: space-between; padding: 0.75rem 1.25rem; border-top: 1px solid var(--border); background: #fafafa; }

        /* ── BATCH CARDS ── */
        .batch-mini-card { background: white; border-radius: 12px; border: 1px solid var(--border); padding: 1rem 1.25rem; display: flex; align-items: center; gap: 1rem; transition: all 0.2s; text-decoration: none; color: inherit; }
        .batch-mini-card:hover { border-color: var(--accent); background: rgba(59,130,246,0.02); transform: translateX(2px); }
        .batch-mini-icon { width: 40px; height: 40px; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 1.1rem; flex-shrink: 0; }
        .batch-mini-info { flex: 1; min-width: 0; }
        .batch-mini-name { font-weight: 700; font-size: 0.88rem; color: var(--text); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .batch-mini-meta { color: var(--muted); font-size: 0.75rem; }

        /* ── SCHEDULE CARD ── */
        .schedule-card { background: white; border-radius: 14px; border: 1px solid var(--border); overflow: hidden; }
        .schedule-item { display: flex; align-items: center; gap: 1rem; padding: 0.9rem 1.25rem; border-bottom: 1px solid var(--border); transition: background 0.15s; }
        .schedule-item:last-child { border-bottom: none; }
        .schedule-item:hover { background: var(--surface); }
        .schedule-date-box { width: 44px; height: 44px; border-radius: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center; flex-shrink: 0; font-family: 'Sora', sans-serif; }
        .schedule-day { font-size: 1rem; font-weight: 800; line-height: 1; }
        .schedule-month { font-size: 0.6rem; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px; }

        /* ── UPLOAD MODAL ── */
        .modal-content { border-radius: 16px; border: none; box-shadow: 0 20px 60px rgba(0,0,0,0.2); }

        /* ── RESPONSIVE ── */
        @media (max-width: 992px) {
            .sidebar { transform: translateX(-100%); }
            .sidebar.open { transform: translateX(0); }
            .main-layout { margin-left: 0; }
            .stats-row { grid-template-columns: repeat(2, 1fr); }
            .mobile-menu-btn { display: flex !important; }
            .sidebar-overlay { display: block !important; }
        }
        @media (max-width: 576px) {
            .stats-row { grid-template-columns: 1fr 1fr; gap: 0.75rem; padding: 1rem; }
            .hero { padding: 1.5rem 1rem; }
            .section { padding: 0 1rem 1.5rem; }
            .hero-name { font-size: 1.5rem; }
        }
        .mobile-menu-btn { display: none; width: 38px; height: 38px; border-radius: 10px; border: 1px solid var(--border); background: white; align-items: center; justify-content: center; cursor: pointer; color: var(--text); }
        .sidebar-overlay { display: none; position: fixed; inset: 0; background: rgba(0,0,0,0.5); z-index: 1049; }

        /* ── ANIMATIONS ── */
        @keyframes fadeUp { from { opacity:0; transform:translateY(16px); } to { opacity:1; transform:translateY(0); } }
        .fade-up { animation: fadeUp 0.4s ease both; }
        .delay-1 { animation-delay: 0.1s; }
        .delay-2 { animation-delay: 0.2s; }
        .delay-3 { animation-delay: 0.3s; }
    </style>
</head>
<body>

<%-- Session variables --%>
<c:set var="displayName"   value="${not empty name  ? name  : sessionScope.name}"/>
<c:set var="displayEmail"  value="${not empty email ? email : sessionScope.email}"/>
<c:set var="displayFileId" value="${not empty sessionScope.fileId ? sessionScope.fileId : ''}"/>

<%-- Mobile overlay --%>
<div class="sidebar-overlay" id="sidebarOverlay" onclick="closeSidebar()"></div>

<!-- ══════════════ SIDEBAR ══════════════ -->
<aside class="sidebar" id="sidebar">
    <div class="sidebar-logo">
        <img src="https://x-workz.com/Logo.png" alt="X-Workz">
        <div class="sidebar-logo-text">
            X-Workz
            <small>Learning Platform</small>
        </div>
    </div>

    <div class="sidebar-section">Main</div>
    <a href="<c:url value='/dashboard/Home'/>" class="nav-link-item active">
        <i class="bi bi-grid-1x2-fill"></i> Dashboard
    </a>
    <a href="<c:url value='/dashboard/viewBatches'/>" class="nav-link-item" id="myCoursesLink">
        <i class="bi bi-journal-bookmark-fill"></i> My Courses
        <c:if test="${not empty batches}">
            <span class="badge-count">${batches.size()}</span>
        </c:if>
    </a>
    <a href="<c:url value='/editProfile'/>?email=${displayEmail}" class="nav-link-item">
        <i class="bi bi-person-badge-fill"></i> My Profile
    </a>

    <div class="sidebar-section">Administration</div>
    <a href="<c:url value='/dashboard/addBatch'/>" class="nav-link-item">
        <i class="bi bi-plus-square-dotted"></i> Create Batch
    </a>
    <a href="<c:url value='/dashboard/viewBatches'/>" class="nav-link-item">
        <i class="bi bi-layers-fill"></i> Manage Batches
    </a>

    <div class="sidebar-section">System</div>
    <a href="#" class="nav-link-item">
        <i class="bi bi-sliders"></i> Settings
    </a>
    <a href="<c:url value='/logout'/>" class="nav-link-item" style="color:#f87171;">
        <i class="bi bi-box-arrow-right"></i> Logout
    </a>

    <%-- Sidebar footer: logged-in user --%>
    <div class="sidebar-footer">
        <div class="sidebar-user">
            <c:choose>
                <c:when test="${not empty displayFileId}">
                    <img src="<c:url value='/getImage?id=${displayFileId}'/>" class="sidebar-user-avatar" alt="avatar">
                </c:when>
                <c:otherwise>
                    <div class="sidebar-user-avatar-default">
                        <i class="bi bi-person-fill text-white" style="font-size:1rem;"></i>
                    </div>
                </c:otherwise>
            </c:choose>
            <div>
                <div class="sidebar-user-name">${displayName}</div>
                <div class="sidebar-user-email">${displayEmail}</div>
            </div>
        </div>
    </div>
</aside>

<!-- ══════════════ MAIN LAYOUT ══════════════ -->
<div class="main-layout">

    <!-- TOPBAR -->
    <div class="topbar">
        <div class="d-flex align-items-center gap-3">
            <button class="mobile-menu-btn" onclick="openSidebar()">
                <i class="bi bi-list fs-5"></i>
            </button>
            <span class="topbar-title">Dashboard</span>
        </div>
        <div class="topbar-right">
            <%-- Upload photo button --%>
            <button class="topbar-btn" data-bs-toggle="modal" data-bs-target="#uploadPhotoModal" title="Update photo">
                <i class="bi bi-camera"></i>
            </button>
            <%-- Profile dropdown --%>
            <div class="dropdown">
                <button class="d-flex align-items-center gap-2 border-0 bg-transparent p-0" data-bs-toggle="dropdown">
                    <c:choose>
                        <c:when test="${not empty displayFileId}">
                            <div class="avatar-btn">
                                <img src="<c:url value='/getImage?id=${displayFileId}'/>" alt="avatar">
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="avatar-btn-default">
                                <i class="bi bi-person-fill text-white"></i>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <span class="fw-semibold d-none d-md-inline" style="font-size:0.88rem; color:var(--text);">${displayName}</span>
                    <i class="bi bi-chevron-down text-muted d-none d-md-inline" style="font-size:0.7rem;"></i>
                </button>
                <ul class="dropdown-menu dropdown-menu-end shadow-lg" style="min-width:220px; border-radius:12px; border:1px solid var(--border); padding:0.5rem;">
                    <li class="px-3 py-2">
                        <div class="fw-bold" style="font-size:0.9rem;">${displayName}</div>
                        <div class="text-muted" style="font-size:0.78rem;">${displayEmail}</div>
                    </li>
                    <li><hr class="dropdown-divider my-1"></li>
                    <li><a class="dropdown-item rounded-2" href="<c:url value='/editProfile'/>?email=${displayEmail}"><i class="bi bi-pencil-square me-2"></i>Edit Profile</a></li>
                    <li><a class="dropdown-item rounded-2" href="<c:url value='/dashboard/viewBatches'/>"><i class="bi bi-journal-bookmark me-2"></i>My Courses</a></li>
                    <li><hr class="dropdown-divider my-1"></li>
                    <li><a class="dropdown-item text-danger rounded-2" href="<c:url value='/logout'/>"><i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- FLASH MESSAGES -->
    <c:if test="${not empty msg}">
        <div class="alert alert-success alert-dismissible fade show position-fixed"
             style="top:76px;right:20px;z-index:9999;border-radius:12px;min-width:300px;" role="alert">
            <i class="bi bi-check-circle me-2"></i>${msg}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show position-fixed"
             style="top:76px;right:20px;z-index:9999;border-radius:12px;min-width:300px;" role="alert">
            <i class="bi bi-exclamation-circle me-2"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- HERO SECTION -->
    <div class="hero fade-up">
        <div class="hero-greeting">Good day 👋</div>
        <div class="hero-name">Welcome Back, ${displayName}!</div>
        <div class="hero-sub">Your learning progress is looking great. Keep it up!</div>
        <div class="hero-actions">
            <a href="<c:url value='/dashboard/viewBatches'/>" class="btn-hero-primary">
                <i class="bi bi-play-circle-fill"></i> Continue Learning
            </a>
            <a href="<c:url value='/dashboard/viewBatches'/>" class="btn-hero-outline">
                <i class="bi bi-search"></i> Browse Courses
            </a>
        </div>
    </div>

    <!-- STATS ROW -->
    <div class="stats-row fade-up delay-1">
        <%-- Enrolled: real count from batches in session/model --%>
        <div class="stat-card">
            <div class="stat-icon" style="background:rgba(59,130,246,0.12);">
                <i class="bi bi-book-fill" style="color:var(--accent);"></i>
            </div>
            <div>
                <div class="stat-num">${not empty batches ? batches.size() : 0}</div>
                <div class="stat-label">Enrolled Batches</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon" style="background:rgba(16,185,129,0.12);">
                <i class="bi bi-trophy-fill" style="color:var(--green);"></i>
            </div>
            <div>
                <div class="stat-num">0</div>
                <div class="stat-label">Completed</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon" style="background:rgba(245,158,11,0.12);">
                <i class="bi bi-clock-fill" style="color:var(--gold);"></i>
            </div>
            <div>
                <div class="stat-num">0h</div>
                <div class="stat-label">Hours Learning</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon" style="background:rgba(6,182,212,0.12);">
                <i class="bi bi-patch-check-fill" style="color:var(--accent-2);"></i>
            </div>
            <div>
                <div class="stat-num">0</div>
                <div class="stat-label">Certificates</div>
            </div>
        </div>
    </div>

    <!-- MY COURSES / BATCHES -->
    <div class="section fade-up delay-2">
        <div class="section-header">
            <div class="section-title"><i class="bi bi-journal-bookmark-fill text-primary me-2"></i>My Enrolled Batches</div>
            <a href="<c:url value='/dashboard/viewBatches'/>" class="section-link">View all <i class="bi bi-arrow-right"></i></a>
        </div>

        <c:choose>
            <c:when test="${empty batches}">
                <%-- Empty state --%>
                <div style="background:white;border-radius:14px;border:1px solid var(--border);padding:3rem;text-align:center;">
                    <i class="bi bi-journal-x" style="font-size:3rem;color:#cbd5e1;"></i>
                    <div style="font-family:'Sora',sans-serif;font-weight:700;color:var(--text);margin-top:1rem;">No Batches Yet</div>
                    <div style="color:var(--muted);font-size:0.88rem;margin-top:0.4rem;">Create your first training batch to get started.</div>
                    <a href="<c:url value='/dashboard/addBatch'/>" class="btn-hero-primary d-inline-flex mt-3">
                        <i class="bi bi-plus-circle"></i> Create Batch
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="courses-grid">
                    <c:forEach var="batch" items="${batches}" varStatus="loop">
                        <%-- Pick a gradient based on index --%>
                        <c:set var="colors" value="${['#3b82f6','#10b981','#f59e0b','#8b5cf6','#06b6d4','#ef4444']}"/>
                        <div class="course-card">
                            <div class="course-card-header" style="background:linear-gradient(90deg,${loop.index % 2 == 0 ? '#3b82f6,#06b6d4' : '#10b981,#059669'});"></div>
                            <div class="course-card-body">
                                <span class="course-tag">${batch.batchType}</span>
                                <div class="course-name">${batch.batchName}</div>
                                <div class="course-instructor">
                                    <i class="bi bi-person-video3 text-primary"></i> ${batch.instructor}
                                    &nbsp;·&nbsp;
                                    <i class="bi bi-book text-success"></i> ${batch.course}
                                </div>
                                <div class="progress-bar-custom">
                                    <div class="progress-fill" style="width:0%;background:linear-gradient(90deg,#3b82f6,#06b6d4);"></div>
                                </div>
                                <div style="display:flex;justify-content:space-between;font-size:0.75rem;color:var(--muted);">
                                    <span>0% Complete</span>
                                    <span><i class="bi bi-calendar3"></i> ${batch.startDate}</span>
                                </div>
                            </div>
                            <div class="course-footer">
                                <span style="font-size:0.75rem;color:var(--muted);">
                                    <i class="bi bi-calendar-event me-1"></i>${batch.startDate}
                                </span>
                                <a href="<c:url value='/dashboard/batchDetails/${batch.id}'/>"
                                   style="background:var(--accent);color:white;border:none;padding:0.35rem 1rem;border-radius:8px;font-size:0.8rem;font-weight:600;text-decoration:none;display:inline-flex;align-items:center;gap:5px;">
                                    <i class="bi bi-arrow-right-circle"></i> Open
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- UPCOMING SCHEDULE (static for now) -->
    <div class="section fade-up delay-3">
        <div class="section-header">
            <div class="section-title"><i class="bi bi-calendar-week text-warning me-2"></i>Upcoming Schedule</div>
        </div>
        <div class="schedule-card">
            <div class="schedule-item">
                <div class="schedule-date-box" style="background:rgba(59,130,246,0.1);">
                    <div class="schedule-day" style="color:var(--accent);">17</div>
                    <div class="schedule-month" style="color:var(--accent);">FEB</div>
                </div>
                <div style="flex:1;">
                    <div style="font-weight:600;font-size:0.9rem;">Spring Boot Advanced</div>
                    <div style="color:var(--muted);font-size:0.78rem;"><i class="bi bi-clock me-1"></i>02:00 PM — Live Session</div>
                </div>
                <span style="background:rgba(16,185,129,0.1);color:var(--green);border-radius:6px;padding:3px 10px;font-size:0.72rem;font-weight:700;">TODAY</span>
            </div>
            <div class="schedule-item">
                <div class="schedule-date-box" style="background:rgba(245,158,11,0.1);">
                    <div class="schedule-day" style="color:var(--gold);">20</div>
                    <div class="schedule-month" style="color:var(--gold);">FEB</div>
                </div>
                <div style="flex:1;">
                    <div style="font-weight:600;font-size:0.9rem;">React Fundamentals</div>
                    <div style="color:var(--muted);font-size:0.78rem;"><i class="bi bi-clock me-1"></i>10:00 AM — Live Session</div>
                </div>
                <span style="background:rgba(59,130,246,0.1);color:var(--accent);border-radius:6px;padding:3px 10px;font-size:0.72rem;font-weight:700;">THU</span>
            </div>
            <div class="schedule-item">
                <div class="schedule-date-box" style="background:rgba(139,92,246,0.1);">
                    <div class="schedule-day" style="color:#8b5cf6;">22</div>
                    <div class="schedule-month" style="color:#8b5cf6;">FEB</div>
                </div>
                <div style="flex:1;">
                    <div style="font-weight:600;font-size:0.9rem;">MySQL & JPA Deep Dive</div>
                    <div style="color:var(--muted);font-size:0.78rem;"><i class="bi bi-clock me-1"></i>04:00 PM — Live Session</div>
                </div>
                <span style="background:rgba(139,92,246,0.1);color:#8b5cf6;border-radius:6px;padding:3px 10px;font-size:0.72rem;font-weight:700;">SAT</span>
            </div>
        </div>
    </div>

    <!-- FOOTER -->
    <footer style="padding:1.5rem 2rem;border-top:1px solid var(--border);background:white;text-align:center;">
        <span style="color:var(--muted);font-size:0.8rem;">© 2026 X-Workz Training Institute. All rights reserved.</span>
    </footer>
</div>

<!-- ══════════════ UPLOAD PHOTO MODAL ══════════════ -->
<div class="modal fade" id="uploadPhotoModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-title fw-bold"><i class="bi bi-camera me-2 text-primary"></i>Update Profile Photo</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="<c:url value='/uploadProfilePhoto'/>" method="post" enctype="multipart/form-data">
                <div class="modal-body pt-3">
                    <input type="hidden" name="email" value="${displayEmail}">
                    <div class="text-center mb-3">
                        <img id="photoPreview"
                             src="<c:choose><c:when test='${not empty displayFileId}'><c:url value='/getImage?id=${displayFileId}'/></c:when><c:otherwise>https://ui-avatars.com/api/?name=${displayName}&size=150&background=3b82f6&color=fff&bold=true</c:otherwise></c:choose>"
                             class="rounded-circle" width="120" height="120"
                             style="object-fit:cover;border:3px solid #e2e8f0;" alt="Preview">
                        <p class="text-muted small mt-2 mb-0">Preview updates when you select a file</p>
                    </div>
                    <div class="mb-3">
                        <input type="file" class="form-control" name="profilePhoto" id="profilePhotoInput"
                               accept="image/jpeg,image/png,image/gif,image/webp" required onchange="previewImage(this)"
                               style="border-radius:10px;">
                        <small class="text-muted">JPG, PNG, GIF or WebP · Max 5MB</small>
                    </div>
                </div>
                <div class="modal-footer border-0 pt-0">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary px-4" style="border-radius:10px;">
                        <i class="bi bi-upload me-1"></i>Upload
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function openSidebar()  { document.getElementById('sidebar').classList.add('open'); document.getElementById('sidebarOverlay').style.display = 'block'; }
    function closeSidebar() { document.getElementById('sidebar').classList.remove('open'); document.getElementById('sidebarOverlay').style.display = 'none'; }
    function previewImage(input) {
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = e => document.getElementById('photoPreview').src = e.target.result;
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>
</body>
</html>
