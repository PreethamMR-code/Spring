<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Conferences - NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <style>
        .hero-banner {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 50px 0 30px;
        }
        .conference-card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.08);
            transition: transform 0.2s, box-shadow 0.2s;
            height: 100%;
        }
        .conference-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        .filter-card {
            border-radius: 12px;
            border: none;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }
        .badge-type {
            font-size: 0.7rem;
            padding: 4px 8px;
        }
        .seats-bar {
            height: 6px;
            border-radius: 3px;
        }
        .fee-badge {
            font-size: 1.1rem;
            font-weight: 700;
        }
        .no-results {
            text-align: center;
            padding: 80px 20px;
            color: #6c757d;
        }
        .no-results-icon { font-size: 4rem; }
    </style>
</head>
<body class="bg-light">

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<!-- Hero Banner -->
<div class="hero-banner">
    <div class="container">
        <h1 class="fw-bold mb-2">Upcoming Conferences</h1>
        <p class="opacity-75 mb-4">
            Discover and register for conferences in your field
        </p>

        <!-- Search Bar -->
        <form action="${pageContext.request.contextPath}/conferences"
              method="get">
            <div class="input-group input-group-lg" style="max-width: 600px;">
                <input type="text"
                       name="search"
                       class="form-control"
                       placeholder="Search by title, description or city..."
                       value="${search}"/>
                <button class="btn btn-light" type="submit">
                    Search
                </button>
                <c:if test="${not empty search || not empty selectedType
                              || not empty selectedMode || not empty selectedCity}">
                    <a href="${pageContext.request.contextPath}/conferences"
                       class="btn btn-outline-light">Clear</a>
                </c:if>
            </div>
        </form>
    </div>
</div>

<div class="container py-4">
    <div class="row g-4">

        <!-- Left: Filters -->
        <div class="col-lg-3">
            <div class="card filter-card p-3 sticky-top" style="top: 20px;">
                <h6 class="fw-bold mb-3">Filter Conferences</h6>

                <form action="${pageContext.request.contextPath}/conferences"
                      method="get" id="filterForm">
                    <input type="hidden" name="search" value="${search}"/>

                    <!-- Type Filter -->
                    <div class="mb-3">
                        <label class="form-label fw-semibold small text-muted">
                            CONFERENCE TYPE
                        </label>

                        <select name="type" class="form-select form-select-sm">
                            <option value="">All Types</option>
                            <option value="STUDENT"
                                ${selectedType == 'STUDENT' ? 'selected':''}>
                                Student Academic</option>
                            <option value="ACADEMIC"
                                ${selectedType == 'ACADEMIC' ? 'selected':''}>
                                Academic</option>
                            <option value="RESEARCH"
                                ${selectedType == 'RESEARCH' ? 'selected':''}>
                                Research</option>
                            <option value="TECHNICAL"
                                ${selectedType == 'TECHNICAL' ? 'selected':''}>
                                Technical</option>
                            <option value="AI_ML"
                                ${selectedType == 'AI_ML' ? 'selected':''}>
                                AI / ML</option>
                            <option value="DATA_SCIENCE"
                                ${selectedType == 'DATA_SCIENCE' ? 'selected':''}>
                                Data Science</option>
                            <option value="CORPORATE"
                                ${selectedType == 'CORPORATE' ? 'selected':''}>
                                Corporate</option>
                            <option value="BUSINESS"
                                ${selectedType == 'BUSINESS' ? 'selected':''}>
                                Business</option>
                            <option value="STARTUP"
                                ${selectedType == 'STARTUP' ? 'selected':''}>
                                Startup</option>
                            <option value="HEALTHCARE"
                                ${selectedType == 'HEALTHCARE' ? 'selected':''}>
                                Healthcare</option>
                            <option value="ENGINEERING"
                                ${selectedType == 'ENGINEERING' ? 'selected':''}>
                                Engineering</option>
                            <option value="WORKSHOP"
                                ${selectedType == 'WORKSHOP' ? 'selected':''}>
                                Workshop</option>
                            <option value="SEMINAR"
                                ${selectedType == 'SEMINAR' ? 'selected':''}>
                                Seminar</option>
                            <option value="WEBINAR"
                                ${selectedType == 'WEBINAR' ? 'selected':''}>
                                Webinar</option>
                            <option value="NGO"
                                ${selectedType == 'NGO' ? 'selected':''}>
                                NGO</option>
                            <option value="GOVERNMENT"
                                ${selectedType == 'GOVERNMENT' ? 'selected':''}>
                                Government</option>
                            <option value="GENERAL"
                                ${selectedType == 'GENERAL' ? 'selected':''}>
                                General</option>
                        </select>

                    </div>

                    <!-- Mode Filter -->
                    <div class="mb-3">
                        <label class="form-label fw-semibold small text-muted">
                            MODE
                        </label>
                        <div>
                            <div class="form-check">
                                <input type="radio" name="mode" value=""
                                       class="form-check-input" id="modeAll"
                                       ${empty selectedMode ? 'checked' : ''}
                                       onchange="document.getElementById('filterForm').submit()"/>
                                <label class="form-check-label" for="modeAll">
                                    All Modes</label>
                            </div>
                            <div class="form-check">
                                <input type="radio" name="mode" value="ONLINE"
                                       class="form-check-input" id="modeOnline"
                                       ${selectedMode == 'ONLINE' ? 'checked' : ''}
                                       onchange="document.getElementById('filterForm').submit()"/>
                                <label class="form-check-label" for="modeOnline">
                                    Online</label>
                            </div>
                            <div class="form-check">
                                <input type="radio" name="mode" value="OFFLINE"
                                       class="form-check-input" id="modeOffline"
                                       ${selectedMode == 'OFFLINE' ? 'checked' : ''}
                                       onchange="document.getElementById('filterForm').submit()"/>
                                <label class="form-check-label" for="modeOffline">
                                    Offline</label>
                            </div>
                            <div class="form-check">
                                <input type="radio" name="mode" value="HYBRID"
                                       class="form-check-input" id="modeHybrid"
                                       ${selectedMode == 'HYBRID' ? 'checked' : ''}
                                       onchange="document.getElementById('filterForm').submit()"/>
                                <label class="form-check-label" for="modeHybrid">
                                    Hybrid</label>
                            </div>
                        </div>
                    </div>

                    <!-- City Filter -->
                    <c:if test="${not empty cities}">
                        <div class="mb-3">
                            <label class="form-label fw-semibold small text-muted">
                                CITY
                            </label>
                            <select name="city" class="form-select form-select-sm"
                                    onchange="document.getElementById('filterForm').submit()">
                                <option value="">All Cities</option>
                                <c:forEach var="ct" items="${cities}">
                                    <option value="${ct}"
                                        ${selectedCity == ct ? 'selected' : ''}>
                                        ${ct}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </c:if>

                    <!-- Fee Filter -->
                    <div class="mb-3">
                        <label class="form-label fw-semibold small text-muted">
                            ENTRY FEE
                        </label>
                        <div class="d-flex gap-2 flex-wrap">
                            <a href="${pageContext.request.contextPath}/conferences?search=${search}&type=${selectedType}&mode=${selectedMode}&city=${selectedCity}"
                               class="btn btn-sm ${empty param.free ? 'btn-primary' : 'btn-outline-secondary'}">
                                All
                            </a>
                            <a href="${pageContext.request.contextPath}/conferences?search=${search}&type=${selectedType}&mode=${selectedMode}&city=${selectedCity}&free=true"
                               class="btn btn-sm ${param.free == 'true' ? 'btn-success' : 'btn-outline-success'}">
                                Free
                            </a>
                            <a href="${pageContext.request.contextPath}/conferences?search=${search}&type=${selectedType}&mode=${selectedMode}&city=${selectedCity}&free=false"
                               class="btn btn-sm ${param.free == 'false' ? 'btn-warning' : 'btn-outline-warning'}">
                                Paid
                            </a>
                        </div>
                    </div>

                    <!-- Clear All -->
                    <a href="${pageContext.request.contextPath}/conferences"
                       class="btn btn-outline-danger btn-sm w-100 mt-2">
                        Clear All Filters
                    </a>
                </form>
            </div>
        </div>

        <!-- Right: Conference Cards -->
        <div class="col-lg-9">

            <!-- Results Count -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <p class="text-muted mb-0">
                    Showing <strong>${filteredCount}</strong>
                    <c:if test="${filteredCount != totalCount}">
                        of <strong>${totalCount}</strong>
                    </c:if>
                    conference<c:if test="${filteredCount != 1}">s</c:if>
                    <c:if test="${not empty search}">
                        for "<strong>${search}</strong>"
                    </c:if>
                </p>
                <c:if test="${not empty search || not empty selectedType
                              || not empty selectedMode || not empty selectedCity}">
                    <a href="${pageContext.request.contextPath}/conferences"
                       class="btn btn-sm btn-outline-secondary">
                        Clear filters
                    </a>
                </c:if>
            </div>

            <!-- No Results -->
            <c:if test="${empty conferences}">
                <div class="no-results">
                    <div class="no-results-icon">🔍</div>
                    <h4 class="mt-3">No conferences found</h4>
                    <p>Try adjusting your search or filters.</p>
                    <a href="${pageContext.request.contextPath}/conferences"
                       class="btn btn-primary mt-2">Show All Conferences</a>
                </div>
            </c:if>

            <!-- Conference Cards Grid -->
            <div class="row g-4">
                <c:forEach var="conf" items="${conferences}">
                    <div class="col-md-6">
                        <div class="card conference-card">
                            <!-- Card Header with Type/Mode Badges -->
                            <div class="card-body pb-2">
                                <div class="d-flex gap-2 mb-2">
                                    <span class="badge bg-primary badge-type">
                                        ${conf.conferenceType}
                                    </span>
                                    <span class="badge
                                        ${conf.mode == 'ONLINE' ? 'bg-info' :
                                          conf.mode == 'OFFLINE' ? 'bg-secondary' :
                                          'bg-warning text-dark'} badge-type">
                                        ${conf.mode}
                                    </span>
                                    <c:if test="${conf.free}">
                                        <span class="badge bg-success badge-type">FREE</span>
                                    </c:if>
                                </div>

                                <!-- Title -->
                                <h5 class="card-title fw-bold mb-1">
                                    ${conf.title}
                                </h5>

                                <!-- Location -->
                                <c:if test="${not empty conf.city}">
                                    <p class="text-muted small mb-2">
                                        📍 ${conf.city}
                                        <c:if test="${not empty conf.state}">
                                            , ${conf.state}
                                        </c:if>
                                    </p>
                                </c:if>

                                <!-- Description Preview -->
                                <c:if test="${not empty conf.description}">
                                    <p class="text-muted small mb-3"
                                       style="display:-webkit-box;
                                              -webkit-line-clamp:2;
                                              -webkit-box-orient:vertical;
                                              overflow:hidden;">
                                        ${conf.description}
                                    </p>
                                </c:if>

                                <!-- Dates -->
                                <div class="row text-muted small mb-3">
                                    <div class="col-6">
                                        📅 <strong>Date:</strong><br/>
                                        ${fn:substringBefore(
                                            conf.startDate.toString(),'T')}
                                    </div>
                                    <div class="col-6">
                                        ⏰ <strong>Register by:</strong><br/>
                                        ${fn:substringBefore(
                                            conf.registrationDeadline.toString(),'T')}
                                    </div>
                                </div>

                                <!-- Seats Progress Bar -->
                                <div class="mb-3">
                                    <div class="d-flex justify-content-between
                                                small text-muted mb-1">
                                        <span>
                                            ${conf.registeredCount} / ${conf.maxDelegates}
                                            registered
                                        </span>
                                        <span>
                                            ${conf.maxDelegates - conf.registeredCount}
                                            left
                                        </span>
                                    </div>
                                    <div class="progress seats-bar">
                                        <div class="progress-bar
                                            ${conf.registeredCount >= conf.maxDelegates ?
                                              'bg-danger' :
                                              conf.registeredCount * 100 / conf.maxDelegates > 75 ?
                                              'bg-warning' : 'bg-success'}"
                                             style="width:${conf.registeredCount * 100 /
                                                conf.maxDelegates}%">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Card Footer -->
                            <div class="card-footer bg-white border-top-0
                                        d-flex justify-content-between
                                        align-items-center pt-0 pb-3 px-3">
                                <div class="fee-badge
                                    ${conf.free ? 'text-success' : 'text-primary'}">
                                    <c:choose>
                                        <c:when test="${conf.free}">Free</c:when>
                                        <c:otherwise>₹${conf.delegateFee}</c:otherwise>
                                    </c:choose>
                                </div>
                                <a href="${pageContext.request.contextPath}/conference/${conf.id}"
                                   class="btn btn-primary btn-sm px-4">
                                    View Details
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="py-4 mt-5 bg-dark text-center text-white-50">
    <div class="container">
        <p class="mb-0">
            &copy; 2026 NexMeet Conference Platform
        </p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>