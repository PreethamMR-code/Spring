<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="sec"
    uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"
    uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Organizer Dashboard - NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet"/>
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: #f8f9fc;
        }
        .page-header {
            background: linear-gradient(135deg,
                #667eea 0%, #764ba2 100%);
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
        }
        .stat-number {
            font-size: 2.2rem;
            font-weight: 800;
            line-height: 1;
        }
        .stat-label {
            font-size: 0.82rem;
            color: #64748b;
            margin-top: 6px;
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
        }
        .action-card:hover {
            border-color: #667eea;
            box-shadow: 0 8px 24px
                rgba(102,126,234,0.12);
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
        }
        .action-desc {
            font-size: 0.8rem;
            color: #64748b;
            margin-top: 4px;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<!-- Page Header -->
<div class="page-header">
    <div class="container">
        <div class="d-flex justify-content-between
                    align-items-start">
            <div>
                <div style="font-size:0.82rem;
                     color:rgba(255,255,255,0.7);
                     margin-bottom:6px">
                    Organizer Dashboard
                </div>
                <h2 style="font-weight:800;
                     margin:0;color:white">
                    Welcome back,
                    ${currentUser.fullName} 👋
                </h2>
                <div style="color:rgba(255,255,255,0.7);
                     font-size:0.88rem;margin-top:4px">
                    ${currentUser.email}
                </div>
            </div>
            <form action="${pageContext.request.contextPath}/logout"
                  method="post">
                <input type="hidden"
                       name="${_csrf.parameterName}"
                       value="${_csrf.token}"/>
                <button type="submit"
                        class="btn btn-outline-light
                               btn-sm">
                    Logout
                </button>
            </form>
        </div>
    </div>
</div>

<div class="container pb-5">

    <c:if test="${not empty success}">
        <div class="alert alert-success mt-3">
            ${success}
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger mt-3">
            ${error}
        </div>
    </c:if>

    <!-- Stat Cards -->
    <div class="row g-3">
        <div class="col-md-4">
            <div class="stat-card text-center">
                <div class="stat-number text-primary">
                    ${myConferences}
                </div>
                <div class="stat-label">
                    Total Conferences
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card text-center">
                <div class="stat-number text-success">
                    ${totalRegistrations}
                </div>
                <div class="stat-label">
                    Total Registrations
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card text-center">
                <div class="stat-number
                            text-warning">
                    ${pendingApproval}
                </div>
                <div class="stat-label">
                    Pending Approval
                </div>
            </div>
        </div>
    </div>

    <!-- Revenue Card (only if non-zero) -->
    <c:if test="${totalRevenue != null
                  && totalRevenue > 0}">
        <div class="card border-0 shadow-sm
                    mt-3 p-3 text-center">
            <div style="font-size:1.8rem;
                 font-weight:800;color:#059669">
                ₹<fmt:formatNumber
                    value="${totalRevenue}"
                    maxFractionDigits="2"/>
            </div>
            <div class="text-muted small mt-1">
                Your total earnings
                (organizer share)
            </div>
        </div>
    </c:if>

    <!-- Quick Actions -->
    <h5 class="fw-bold mt-4 mb-3"
        style="color:#0f172a">
        Quick Actions
    </h5>
    <div class="row g-3">

        <div class="col-md-4">
            <a href="${pageContext.request.contextPath}/organizer/conference/create"
               class="action-card">
                <div class="action-icon">➕</div>
                <div class="action-title">
                    Create Conference
                </div>
                <div class="action-desc">
                    Submit a new conference
                    for admin approval
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="${pageContext.request.contextPath}/organizer/conferences"
               class="action-card">
                <div class="action-icon">📋</div>
                <div class="action-title">
                    My Conferences
                </div>
                <div class="action-desc">
                    View and manage all
                    your conferences
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="${pageContext.request.contextPath}/organizer/analytics"
               class="action-card">
                <div class="action-icon">📊</div>
                <div class="action-title">
                    Analytics
                </div>
                <div class="action-desc">
                    Charts, revenue and
                    performance insights
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="${pageContext.request.contextPath}/profile"
               class="action-card">
                <div class="action-icon">👤</div>
                <div class="action-title">
                    My Profile
                </div>
                <div class="action-desc">
                    Update your organizer
                    profile details
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="${pageContext.request.contextPath}/conferences"
               class="action-card">
                <div class="action-icon">🔍</div>
                <div class="action-title">
                    Browse Conferences
                </div>
                <div class="action-desc">
                    See all conferences
                    on NexMeet
                </div>
            </a>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>