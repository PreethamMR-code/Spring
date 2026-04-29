<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Browse Conferences - NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet"/>
    <style>
        :root {
            --brand: #667eea;
            --brand-gradient: linear-gradient(135deg,
                #667eea 0%, #764ba2 100%);
            --surface: #f8f9fc;
            --border: #e8ecf0;
            --radius: 14px;
            --shadow: 0 4px 16px rgba(0,0,0,0.08);
        }
        body {
            font-family: 'Inter', sans-serif;
            background: var(--surface);
            -webkit-font-smoothing: antialiased;
        }
        .page-header {
            background: var(--brand-gradient);
            padding: 48px 0 60px;
            color: white;
        }
        .page-header h1 {
            font-size: 2.2rem;
            font-weight: 800;
            margin-bottom: 8px;
        }
        .page-header p {
            color: rgba(255,255,255,0.8);
            font-size: 1rem;
        }
        /* Filter Bar */
        .filter-bar {
            background: white;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 20px 24px;
            margin-top: -32px;
            position: relative;
            z-index: 10;
            margin-bottom: 32px;
        }
        .filter-bar .form-control,
        .filter-bar .form-select {
            border: 1.5px solid var(--border);
            border-radius: 10px;
            font-size: 0.88rem;
            padding: 9px 14px;
            background: var(--surface);
            transition: border-color 0.15s;
        }
        .filter-bar .form-control:focus,
        .filter-bar .form-select:focus {
            border-color: var(--brand);
            box-shadow: 0 0 0 3px rgba(102,126,234,0.1);
        }
        .btn-filter {
            background: var(--brand-gradient);
            color: white;
            border: none;
            border-radius: 10px;
            padding: 9px 20px;
            font-weight: 600;
            font-size: 0.88rem;
            transition: opacity 0.15s;
        }
        .btn-filter:hover {
            opacity: 0.9;
            color: white;
        }
        .btn-reset {
            border: 1.5px solid var(--border);
            background: white;
            border-radius: 10px;
            padding: 8px 16px;
            font-size: 0.88rem;
            color: #64748b;
            transition: all 0.15s;
        }
        .btn-reset:hover {
            border-color: #94a3b8;
            color: #334155;
        }
        /* Result count */
        .result-meta {
            font-size: 0.88rem;
            color: #64748b;
            margin-bottom: 20px;
        }
        .result-meta strong { color: #0f172a; }

        /* Conference Card */
        .conf-card {
            background: white;
            border: 1.5px solid var(--border);
            border-radius: var(--radius);
            overflow: hidden;
            transition: all 0.25s ease;
            text-decoration: none;
            color: inherit;
            display: flex;
            flex-direction: column;
            height: 100%;
        }
        .conf-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 16px 40px rgba(102,126,234,0.15);
            border-color: var(--brand);
            color: inherit;
        }
        .conf-card-top {
            background: linear-gradient(135deg,
                #f5f7ff 0%, #f0f2ff 100%);
            padding: 20px 20px 16px;
            border-bottom: 1px solid var(--border);
        }
        .conf-card-badges {
            display: flex;
            gap: 6px;
            flex-wrap: wrap;
            margin-bottom: 12px;
        }
        .badge-type {
            background: white;
            color: var(--brand);
            border: 1px solid rgba(102,126,234,0.25);
            border-radius: 100px;
            padding: 3px 10px;
            font-size: 0.7rem;
            font-weight: 600;
        }
        .badge-mode {
            background: #f1f5f9;
            color: #475569;
            border-radius: 100px;
            padding: 3px 10px;
            font-size: 0.7rem;
            font-weight: 500;
        }
        .badge-free {
            background: #dcfce7;
            color: #166534;
            border-radius: 100px;
            padding: 3px 10px;
            font-size: 0.7rem;
            font-weight: 600;
        }
        .conf-card-title {
            font-size: 1rem;
            font-weight: 700;
            color: #0f172a;
            line-height: 1.4;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .conf-card-body {
            padding: 16px 20px;
            flex-grow: 1;
        }
        .meta-item {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.82rem;
            color: #64748b;
            margin-bottom: 8px;
        }
        .meta-item:last-child { margin-bottom: 0; }
        .meta-icon {
            width: 22px;
            text-align: center;
            font-size: 0.9rem;
            flex-shrink: 0;
        }
        /* Seats progress */
        .seats-progress-wrap {
            margin: 14px 0 6px;
        }
        .seats-progress-bar {
            height: 5px;
            background: #f1f5f9;
            border-radius: 3px;
            overflow: hidden;
        }
        .seats-progress-fill {
            height: 100%;
            border-radius: 3px;
            background: var(--brand-gradient);
            transition: width 0.5s ease;
        }
        .seats-progress-fill.almost-full {
            background: linear-gradient(90deg,
                #f59e0b, #ef4444);
        }
        .seats-progress-meta {
            display: flex;
            justify-content: space-between;
            font-size: 0.75rem;
            color: #94a3b8;
            margin-top: 5px;
        }
        /* Card footer */
        .conf-card-footer {
            padding: 14px 20px;
            border-top: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #fafbfc;
        }
        .price-display {
            font-size: 1rem;
            font-weight: 700;
            color: #0f172a;
        }
        .price-display.free {
            color: #059669;
        }
        .btn-register {
            background: var(--brand-gradient);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 7px 16px;
            font-size: 0.82rem;
            font-weight: 600;
            text-decoration: none;
            transition: opacity 0.15s, transform 0.15s;
        }
        .btn-register:hover {
            opacity: 0.9;
            color: white;
            transform: translateX(2px);
        }
        /* Empty state */
        .empty-state {
            text-align: center;
            padding: 80px 40px;
            background: white;
            border-radius: var(--radius);
            border: 2px dashed var(--border);
        }
        .empty-icon {
            font-size: 4rem;
            margin-bottom: 20px;
        }
        .empty-title {
            font-size: 1.2rem;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 8px;
        }
        .empty-desc {
            font-size: 0.9rem;
            color: #64748b;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<!-- Page Header -->
<div class="page-header">
    <div class="container">
        <h1>Browse Conferences</h1>
        <p>
            Discover ${totalCount} professional conferences
            across India
        </p>
    </div>
</div>

<div class="container pb-5">

    <!-- Filter Bar -->
    <div class="filter-bar">
        <form method="get"
              action="${pageContext.request.contextPath}/conferences">
            <div class="row g-2 align-items-end">
                <div class="col-md-3">
                    <label class="form-label small fw-semibold
                                  text-muted mb-1">
                        Search
                    </label>
                    <input type="text" name="search"
                           class="form-control"
                           placeholder="Title, city, keyword..."
                           value="${search}"/>
                </div>
                <div class="col-md-2">
                    <label class="form-label small fw-semibold
                                  text-muted mb-1">
                        Type
                    </label>
                    <select name="type" class="form-select">
                        <option value="">All Types</option>
                        <option value="STUDENT"
                            ${selectedType=='STUDENT'?'selected':''}>
                            Student Academic</option>
                        <option value="ACADEMIC"
                            ${selectedType=='ACADEMIC'?'selected':''}>
                            Academic</option>
                        <option value="RESEARCH"
                            ${selectedType=='RESEARCH'?'selected':''}>
                            Research</option>
                        <option value="TECHNICAL"
                            ${selectedType=='TECHNICAL'?'selected':''}>
                            Technical</option>
                        <option value="AI_ML"
                            ${selectedType=='AI_ML'?'selected':''}>
                            AI/ML</option>
                        <option value="CORPORATE"
                            ${selectedType=='CORPORATE'?'selected':''}>
                            Corporate</option>
                        <option value="BUSINESS"
                            ${selectedType=='BUSINESS'?'selected':''}>
                            Business</option>
                        <option value="STARTUP"
                            ${selectedType=='STARTUP'?'selected':''}>
                            Startup</option>
                        <option value="HEALTHCARE"
                            ${selectedType=='HEALTHCARE'?'selected':''}>
                            Healthcare</option>
                        <option value="ENGINEERING"
                            ${selectedType=='ENGINEERING'?'selected':''}>
                            Engineering</option>
                        <option value="WORKSHOP"
                            ${selectedType=='WORKSHOP'?'selected':''}>
                            Workshop</option>
                        <option value="SEMINAR"
                            ${selectedType=='SEMINAR'?'selected':''}>
                            Seminar</option>
                        <option value="WEBINAR"
                            ${selectedType=='WEBINAR'?'selected':''}>
                            Webinar</option>
                        <option value="NGO"
                            ${selectedType=='NGO'?'selected':''}>
                            NGO</option>
                        <option value="GENERAL"
                            ${selectedType=='GENERAL'?'selected':''}>
                            General</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <label class="form-label small fw-semibold
                                  text-muted mb-1">
                        Mode
                    </label>
                    <select name="mode" class="form-select">
                        <option value="">All Modes</option>
                        <option value="OFFLINE"
                            ${selectedMode=='OFFLINE'?'selected':''}>
                            Offline</option>
                        <option value="ONLINE"
                            ${selectedMode=='ONLINE'?'selected':''}>
                            Online</option>
                        <option value="HYBRID"
                            ${selectedMode=='HYBRID'?'selected':''}>
                            Hybrid</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <label class="form-label small fw-semibold
                                  text-muted mb-1">
                        City
                    </label>
                    <select name="city" class="form-select">
                        <option value="">All Cities</option>
                        <c:forEach var="ct" items="${cities}">
                            <option value="${ct}"
                                ${selectedCity==ct?'selected':''}>
                                ${ct}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-1">
                    <label class="form-label small fw-semibold
                                  text-muted mb-1">
                        Price
                    </label>
                    <select name="free" class="form-select">
                        <option value="">Any</option>
                        <option value="true"
                            ${selectedFree=='true'?'selected':''}>
                            Free</option>
                        <option value="false"
                            ${selectedFree=='false'?'selected':''}>
                            Paid</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <div class="d-flex gap-2">
                        <button type="submit"
                                class="btn btn-filter flex-grow-1">
                            Search
                        </button>
                        <a href="${pageContext.request.contextPath}/conferences"
                           class="btn btn-reset">
                            ✕
                        </a>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <!-- Result Meta -->
    <div class="result-meta">
        Showing <strong>${filteredCount}</strong> of
        <strong>${totalCount}</strong> conferences
        <c:if test="${not empty search}">
            for "<strong>${search}</strong>"
        </c:if>
    </div>

    <!-- Conference Grid -->
    <c:choose>
        <c:when test="${empty conferences}">
            <div class="empty-state">
                <div class="empty-icon">🔍</div>
                <div class="empty-title">
                    No conferences found
                </div>
                <p class="empty-desc">
                    Try adjusting your filters or search terms.
                    New conferences are added regularly.
                </p>
                <a href="${pageContext.request.contextPath}/conferences"
                   class="btn btn-filter mt-3">
                    Clear Filters
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row g-4">
                <c:forEach var="conf"
                           items="${conferences}">
                    <div class="col-md-6 col-lg-4">
                        <a href="${pageContext.request.contextPath}/conference/${conf.id}"
                           class="conf-card">

                            <div class="conf-card-top">
                                <div class="conf-card-badges">
                                    <span class="badge-type">
                                        ${conf.conferenceType.name()}
                                    </span>
                                    <span class="badge-mode">
                                        ${conf.mode}
                                    </span>
                                    <c:if test="${conf.free}">
                                        <span class="badge-free">
                                            FREE
                                        </span>
                                    </c:if>
                                </div>
                                <div class="conf-card-title">
                                    ${conf.title}
                                </div>
                            </div>

                            <div class="conf-card-body">
                                <div class="meta-item">
                                    <span class="meta-icon">
                                        📅
                                    </span>
                                    <span>
                                        ${fn:substringBefore(
                                            conf.startDate.toString(),
                                            'T')}
                                        <c:if test="${conf.endDate.toLocalDate() != conf.startDate.toLocalDate()}">
                                            —
                                            ${fn:substringBefore(
                                                conf.endDate.toString(),
                                                'T')}
                                        </c:if>
                                    </span>
                                </div>
                                <c:if test="${not empty conf.city}">
                                    <div class="meta-item">
                                        <span class="meta-icon">
                                            📍
                                        </span>
                                        <span>
                                            ${conf.city},
                                            ${conf.state}
                                        </span>
                                    </div>
                                </c:if>
                                <c:if test="${not empty conf.organizer.organizationName}">
                                    <div class="meta-item">
                                        <span class="meta-icon">
                                            🏢
                                        </span>
                                        <span>
                                            ${conf.organizer.organizationName}
                                        </span>
                                    </div>
                                </c:if>

                                <%-- Seats progress --%>
                                <c:if test="${conf.maxDelegates > 0}">
                                    <div class="seats-progress-wrap">
                                        <div class="seats-progress-bar">
                                            <div class="seats-progress-fill
                                                ${conf.registeredCount * 100 / conf.maxDelegates > 80
                                                  ? 'almost-full' : ''}"
                                                 style="width:${conf.registeredCount * 100 / conf.maxDelegates}%">
                                            </div>
                                        </div>
                                        <div class="seats-progress-meta">
                                            <span>
                                                ${conf.registeredCount}
                                                registered
                                            </span>
                                            <span>
                                                ${conf.maxDelegates - conf.registeredCount}
                                                left
                                            </span>
                                        </div>
                                    </div>
                                </c:if>
                            </div>

                            <div class="conf-card-footer">
                                <div class="price-display
                                    ${conf.free ? 'free' : ''}">
                                    <c:choose>
                                        <c:when test="${conf.free}">
                                            Free
                                        </c:when>
                                        <c:otherwise>
                                            ₹${conf.delegateFee}
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <span class="btn-register">
                                    View Details →
                                </span>
                            </div>
                        </a>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>