<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"
    uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1"/>
    <title>Institution Dashboard – NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet"/>
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: #f8f9fc;
            -webkit-font-smoothing: antialiased;
        }
        .page-header {
            background: linear-gradient(135deg,
                #0ea5e9 0%, #0284c7 100%);
            padding: 40px 0 56px;
            color: white;
        }
        .stat-card {
            background: white;
            border-radius: 14px;
            padding: 24px;
            border: 1.5px solid #e8ecf0;
            margin-top: -32px;
            position: relative;
            z-index: 10;
            box-shadow: 0 4px 16px rgba(0,0,0,0.07);
        }
        .stat-number {
            font-size: 2rem;
            font-weight: 800;
            line-height: 1;
        }
        .stat-label {
            font-size: 0.78rem;
            color: #64748b;
            margin-top: 5px;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        .action-card {
            background: white;
            border-radius: 14px;
            border: 1.5px solid #e8ecf0;
            padding: 24px;
            text-decoration: none;
            color: inherit;
            display: block;
            transition: all 0.2s;
            height: 100%;
        }
        .action-card:hover {
            border-color: #0ea5e9;
            box-shadow: 0 8px 24px
                rgba(14,165,233,0.12);
            transform: translateY(-2px);
            color: inherit;
        }
        .action-icon {
            font-size: 1.8rem;
            margin-bottom: 12px;
        }
        .action-title {
            font-weight: 700;
            font-size: 0.95rem;
            color: #0f172a;
            margin-bottom: 4px;
        }
        .action-desc {
            font-size: 0.82rem;
            color: #64748b;
            line-height: 1.5;
        }
        .info-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            padding: 10px 0;
            border-bottom: 1px solid #f1f5f9;
            font-size: 0.88rem;
        }
        .info-row:last-child { border-bottom: none; }
        .info-label { color: #64748b; font-weight: 500; }
        .info-value {
            font-weight: 600;
            color: #0f172a;
            text-align: right;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<%-- Page Header --%>
<div class="page-header">
    <div class="container">
        <div class="d-flex justify-content-between
                    align-items-start">
            <div>
                <div style="font-size:0.82rem;
                     color:rgba(255,255,255,0.7);
                     margin-bottom:6px">
                    Institution Dashboard
                </div>
                <h2 style="font-weight:800;
                     margin:0;color:white;
                     letter-spacing:-0.02em">
                    Welcome,
                    ${instAdmin.institution.name} 🏫
                </h2>
                <div style="color:rgba(255,255,255,0.7);
                     font-size:0.88rem;margin-top:4px">
                    ${currentUser.email}
                    ·
                    ${instAdmin.jobTitle}
                    <c:if test="${not empty instAdmin.department}">
                        — ${instAdmin.department}
                    </c:if>
                </div>
            </div>
            <div>
                <c:choose>
                    <c:when test="${instAdmin.verified}">
                        <span style="background:rgba(74,222,128,0.2);
                              border:1px solid rgba(74,222,128,0.4);
                              color:white;
                              border-radius:100px;
                              padding:5px 14px;
                              font-size:0.82rem;
                              font-weight:600">
                            ✅ Verified
                        </span>
                    </c:when>
                    <c:otherwise>
                        <span style="background:rgba(251,191,36,0.2);
                              border:1px solid rgba(251,191,36,0.4);
                              color:white;
                              border-radius:100px;
                              padding:5px 14px;
                              font-size:0.82rem;
                              font-weight:600">
                            ⏳ Pending Verification
                        </span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<div class="container pb-5">

    <c:if test="${not empty success}">
        <div class="alert alert-success mt-3
                    alert-dismissible fade show">
            ✅ ${success}
            <button type="button" class="btn-close"
                    data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <%-- Pending verification banner --%>
    <c:if test="${not instAdmin.verified}">
        <div class="mt-4 mb-2 p-4"
             style="background:#fffbeb;
                    border:2px solid #fde68a;
                    border-radius:14px">
            <div class="d-flex align-items-start gap-3">
                <span style="font-size:1.8rem;
                      flex-shrink:0">⏳</span>
                <div>
                    <div style="font-weight:800;
                         color:#92400e;font-size:1rem">
                        Awaiting Admin Verification
                    </div>
                    <div style="color:#b45309;
                         font-size:0.88rem;
                         margin-top:4px;
                         line-height:1.6">
                        Your institutional admin account
                        is pending verification by the
                        NexMeet admin team. You will be
                        notified once approved. Bulk
                        registration is locked until then.
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    <%-- Institution Info Card --%>
    <div class="row g-3 mt-1">
        <div class="col-lg-5">
            <div class="card border-0 shadow-sm
                        p-4 h-100"
                 style="border-radius:14px">
                <div style="font-size:0.75rem;
                     font-weight:700;
                     text-transform:uppercase;
                     letter-spacing:0.06em;
                     color:#94a3b8;
                     margin-bottom:16px">
                    Your Institution
                </div>

                <div class="info-row">
                    <span class="info-label">Name</span>
                    <span class="info-value">
                        ${instAdmin.institution.name}
                    </span>
                </div>
                <div class="info-row">
                    <span class="info-label">Type</span>
                    <span class="info-value">
                        ${instAdmin.institution.type}
                    </span>
                </div>
                <div class="info-row">
                    <span class="info-label">City</span>
                    <span class="info-value">
                        ${instAdmin.institution.city},
                        ${instAdmin.institution.state}
                    </span>
                </div>
                <c:if test="${not empty instAdmin.institution.domains}">
                    <div class="info-row">
                        <span class="info-label">
                            Domains
                        </span>
                        <span class="info-value"
                              style="font-size:0.82rem">
                            ${instAdmin.institution.domains}
                        </span>
                    </div>
                </c:if>
                <div class="info-row">
                    <span class="info-label">Your Role</span>
                    <span class="info-value">
                        ${instAdmin.jobTitle}
                    </span>
                </div>
                <c:if test="${not empty instAdmin.department}">
                    <div class="info-row">
                        <span class="info-label">
                            Department
                        </span>
                        <span class="info-value">
                            ${instAdmin.department}
                        </span>
                    </div>
                </c:if>
            </div>
        </div>

        <%-- Actions (only when verified) --%>
        <div class="col-lg-7">
            <c:choose>
                <c:when test="${instAdmin.verified}">
                    <div class="row g-3">
                        <div class="col-sm-6">
                            <a href="${pageContext.request.contextPath}/conferences"
                               class="action-card">
                                <div class="action-icon">
                                    🔍
                                </div>
                                <div class="action-title">
                                    Browse Conferences
                                </div>
                                <div class="action-desc">
                                    Find conferences accepting
                                    bulk registrations from
                                    institutions.
                                </div>
                            </a>
                        </div>
                        <div class="col-sm-6">
                            <a href="${pageContext.request.contextPath}/profile"
                               class="action-card">
                                <div class="action-icon">
                                    👤
                                </div>
                                <div class="action-title">
                                    My Profile
                                </div>
                                <div class="action-desc">
                                    View and update your
                                    account and contact
                                    details.
                                </div>
                            </a>
                        </div>
                        <div class="col-12">
                            <div style="background:#f0f9ff;
                                 border:1.5px solid #bae6fd;
                                 border-radius:12px;
                                 padding:16px 20px;
                                 font-size:0.88rem;
                                 color:#075985">
                                <strong>How bulk upload works:</strong>
                                Browse conferences →
                                click "Bulk Register My Students" →
                                upload a CSV with student names,
                                emails and phone numbers.
                                Students get tickets automatically.
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <%-- Locked state when not verified --%>
                    <div class="card border-0 shadow-sm
                                p-4 h-100"
                         style="border-radius:14px;
                                background:#fafbfc">
                        <div style="font-size:0.75rem;
                             font-weight:700;
                             text-transform:uppercase;
                             letter-spacing:0.06em;
                             color:#94a3b8;
                             margin-bottom:16px">
                            What you can do after verification
                        </div>
                        <div class="d-flex flex-column gap-3">
                            <div style="display:flex;
                                 align-items:center;
                                 gap:12px;
                                 color:#64748b;
                                 font-size:0.88rem">
                                <span style="font-size:1.2rem;
                                      opacity:0.4">🔍</span>
                                Browse and find conferences
                            </div>
                            <div style="display:flex;
                                 align-items:center;
                                 gap:12px;
                                 color:#64748b;
                                 font-size:0.88rem">
                                <span style="font-size:1.2rem;
                                      opacity:0.4">📋</span>
                                Bulk register students / employees
                            </div>
                            <div style="display:flex;
                                 align-items:center;
                                 gap:12px;
                                 color:#64748b;
                                 font-size:0.88rem">
                                <span style="font-size:1.2rem;
                                      opacity:0.4">🎫</span>
                                Tickets auto-sent to each student
                            </div>
                        </div>
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