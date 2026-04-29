<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>${conference.title} - NexMeet</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
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
        /* Hero Banner */
        .conf-hero {
            background: var(--brand-gradient);
            padding: 56px 0 80px;
            color: white;
            position: relative;
            overflow: hidden;
        }
        .conf-hero::after {
            content: '';
            position: absolute;
            bottom: -2px; left: 0; right: 0;
            height: 40px;
            background: var(--surface);
            border-radius: 40px 40px 0 0;
        }
        .conf-hero-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: rgba(255,255,255,0.15);
            border: 1px solid rgba(255,255,255,0.25);
            border-radius: 100px;
            padding: 4px 14px;
            font-size: 0.78rem;
            font-weight: 600;
            margin-bottom: 18px;
        }
        .conf-hero h1 {
            font-size: clamp(1.6rem, 3.5vw, 2.6rem);
            font-weight: 800;
            line-height: 1.2;
            margin-bottom: 16px;
            letter-spacing: -0.02em;
        }
        .conf-hero-meta {
            display: flex;
            gap: 24px;
            flex-wrap: wrap;
            margin-top: 20px;
        }
        .conf-hero-meta-item {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.9rem;
            color: rgba(255,255,255,0.85);
        }

        /* Layout */
        .detail-layout {
            margin-top: -24px;
            position: relative;
            z-index: 10;
            padding-bottom: 60px;
        }

        /* Card */
        .detail-card {
            background: white;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 28px;
            margin-bottom: 20px;
        }
        .detail-card-title {
            font-size: 1rem;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* Registration Card (sticky) */
        .reg-card {
            background: white;
            border: 2px solid var(--brand);
            border-radius: var(--radius);
            overflow: hidden;
            position: sticky;
            top: 20px;
        }
        .reg-card-header {
            background: var(--brand-gradient);
            padding: 20px 24px;
            color: white;
        }
        .reg-card-price {
            font-size: 2rem;
            font-weight: 800;
            line-height: 1;
        }
        .reg-card-price-label {
            font-size: 0.8rem;
            opacity: 0.8;
            margin-top: 4px;
        }
        .reg-card-body {
            padding: 20px 24px;
        }
        .reg-detail-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            padding: 10px 0;
            border-bottom: 1px solid var(--border);
            font-size: 0.88rem;
        }
        .reg-detail-row:last-child {
            border-bottom: none;
            padding-bottom: 0;
        }
        .reg-detail-label {
            color: #64748b;
        }
        .reg-detail-value {
            font-weight: 600;
            color: #0f172a;
            text-align: right;
        }
        .btn-register-main {
            display: block;
            width: 100%;
            background: var(--brand-gradient);
            color: white;
            border: none;
            border-radius: 10px;
            padding: 14px;
            font-weight: 700;
            font-size: 1rem;
            text-align: center;
            text-decoration: none;
            margin-top: 18px;
            transition: opacity 0.15s, transform 0.15s;
        }
        .btn-register-main:hover {
            opacity: 0.9;
            color: white;
            transform: translateY(-1px);
        }

        /* Seats indicator */
        .seats-bar-lg {
            height: 8px;
            background: #f1f5f9;
            border-radius: 4px;
            overflow: hidden;
            margin: 14px 0 6px;
        }
        .seats-bar-lg-fill {
            height: 100%;
            border-radius: 4px;
            background: var(--brand-gradient);
        }

        /* Feature tags */
        .feature-tag {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: #f8f9fc;
            border: 1px solid var(--border);
            border-radius: 8px;
            padding: 6px 12px;
            font-size: 0.8rem;
            font-weight: 500;
            color: #334155;
            margin: 4px;
        }
        .feature-tag.active {
            background: #f0fdf4;
            border-color: #bbf7d0;
            color: #166534;
        }

        /* Speaker cards */
        .speaker-chip {
            display: flex;
            align-items: center;
            gap: 12px;
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 14px 16px;
        }
        .speaker-chip-avatar {
            width: 44px; height: 44px;
            border-radius: 50%;
            background: var(--brand-gradient);
            color: white;
            font-size: 1.1rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }
        .speaker-chip-name {
            font-weight: 600;
            font-size: 0.92rem;
            color: #0f172a;
        }
        .speaker-chip-role {
            font-size: 0.78rem;
            color: #64748b;
        }

        /* Session timeline */
        .session-row {
            display: flex;
            gap: 16px;
            padding: 14px 0;
            border-bottom: 1px solid var(--border);
        }
        .session-row:last-child { border-bottom: none; }
        .session-time {
            min-width: 80px;
            text-align: right;
            font-size: 0.78rem;
            font-weight: 600;
            color: #64748b;
            padding-top: 2px;
        }
        .session-dot {
            width: 10px; height: 10px;
            border-radius: 50%;
            background: var(--brand);
            margin-top: 5px;
            flex-shrink: 0;
            position: relative;
        }
        .session-dot::after {
            content: '';
            position: absolute;
            top: 10px; left: 4px;
            width: 2px; height: 60px;
            background: var(--border);
        }
        .session-content-title {
            font-weight: 600;
            font-size: 0.92rem;
            color: #0f172a;
        }
        .session-content-meta {
            font-size: 0.78rem;
            color: #94a3b8;
            margin-top: 4px;
        }

        /* Feedback */
        .star-display { color: #fbbf24; }
        .feedback-item {
            padding: 16px 0;
            border-bottom: 1px solid var(--border);
        }
        .feedback-item:last-child { border-bottom: none; }
        .feedback-stars { font-size: 0.85rem; }
        .feedback-name {
            font-weight: 600;
            font-size: 0.9rem;
        }
        .feedback-text {
            font-size: 0.88rem;
            color: #475569;
            margin-top: 6px;
            line-height: 1.6;
        }
        .feedback-date {
            font-size: 0.75rem;
            color: #94a3b8;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<!-- Conference Hero -->
<div class="conf-hero">
    <div class="container">
        <!-- Breadcrumb -->
        <div style="font-size:0.82rem;
             color:rgba(255,255,255,0.6);
             margin-bottom:12px">
            <a href="${pageContext.request.contextPath}/conferences"
               style="color:rgba(255,255,255,0.6);
                      text-decoration:none">
                Conferences
            </a>
            → ${conference.title}
        </div>

        <!-- Type + Mode badges -->
        <div class="d-flex gap-2 mb-3 flex-wrap">
            <span class="conf-hero-badge">
                ${conference.conferenceType}
            </span>
            <span class="conf-hero-badge">
                ${conference.mode}
            </span>
            <c:if test="${conference.free}">
                <span class="conf-hero-badge"
                      style="background:rgba(74,222,128,0.2);
                             border-color:rgba(74,222,128,0.4)">
                    FREE EVENT
                </span>
            </c:if>
        </div>

        <h1>${conference.title}</h1>

        <!-- Organizer -->
        <div style="color:rgba(255,255,255,0.75);
             font-size:0.9rem">
            By
            <strong style="color:white">
                ${conference.organizer.organizationName}
            </strong>
        </div>

        <!-- Key Meta -->
        <div class="conf-hero-meta">
            <div class="conf-hero-meta-item">
                <span>📅</span>
                <span>
                    ${fn:substringBefore(
                        conference.startDate.toString(),'T')}
                    —
                    ${fn:substringBefore(
                        conference.endDate.toString(),'T')}
                </span>
            </div>
            <c:if test="${not empty conference.city}">
                <div class="conf-hero-meta-item">
                    <span>📍</span>
                    <span>
                        ${conference.city},
                        ${conference.state}
                    </span>
                </div>
            </c:if>
            <div class="conf-hero-meta-item">
                <span>👥</span>
                <span>
                    ${conference.registeredCount}
                    /
                    ${conference.maxDelegates}
                    registered
                </span>
            </div>
            <c:if test="${feedbackCount > 0}">
                <div class="conf-hero-meta-item">
                    <span>⭐</span>
                    <span>
                        <fmt:formatNumber value="${avgRating}"
                            maxFractionDigits="1"/>
                        (${feedbackCount} reviews)
                    </span>
                </div>
            </c:if>
        </div>
    </div>
</div>

<!-- Main Content -->
<div class="detail-layout">
    <div class="container">
        <div class="row g-4">

            <!-- LEFT COLUMN -->
            <div class="col-lg-8">

                <!-- About -->
                <div class="detail-card">
                    <div class="detail-card-title">
                        📖 About This Conference
                    </div>
                    <p style="color:#475569;line-height:1.75;
                       margin:0;font-size:0.95rem">
                        ${conference.description}
                    </p>
                </div>

                <!-- Details -->
                <div class="detail-card">
                    <div class="detail-card-title">
                        ℹ️ Event Details
                    </div>
                    <div class="row g-3">
                        <div class="col-sm-6">
                            <div style="font-size:0.75rem;
                                 color:#94a3b8;
                                 text-transform:uppercase;
                                 letter-spacing:0.05em;
                                 margin-bottom:4px">
                                Start Date
                            </div>
                            <div style="font-weight:600;
                                 font-size:0.92rem">
                                ${fn:substringBefore(
                                    conference.startDate.toString(),
                                    'T')}
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div style="font-size:0.75rem;
                                 color:#94a3b8;
                                 text-transform:uppercase;
                                 letter-spacing:0.05em;
                                 margin-bottom:4px">
                                End Date
                            </div>
                            <div style="font-weight:600;
                                 font-size:0.92rem">
                                ${fn:substringBefore(
                                    conference.endDate.toString(),
                                    'T')}
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div style="font-size:0.75rem;
                                 color:#94a3b8;
                                 text-transform:uppercase;
                                 letter-spacing:0.05em;
                                 margin-bottom:4px">
                                Reg. Deadline
                            </div>
                            <div style="font-weight:600;
                                 font-size:0.92rem">
                                ${fn:substringBefore(
                                    conference.registrationDeadline.toString(),
                                    'T')}
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div style="font-size:0.75rem;
                                 color:#94a3b8;
                                 text-transform:uppercase;
                                 letter-spacing:0.05em;
                                 margin-bottom:4px">
                                Mode
                            </div>
                            <div style="font-weight:600;
                                 font-size:0.92rem">
                                ${conference.mode}
                            </div>
                        </div>
                        <c:if test="${not empty conference.venueName}">
                            <div class="col-12">
                                <div style="font-size:0.75rem;
                                     color:#94a3b8;
                                     text-transform:uppercase;
                                     letter-spacing:0.05em;
                                     margin-bottom:4px">
                                    Venue
                                </div>
                                <div style="font-weight:600;
                                     font-size:0.92rem">
                                    ${conference.venueName}
                                </div>
                                <c:if test="${not empty conference.venueAddress}">
                                    <div style="font-size:0.85rem;
                                         color:#64748b;
                                         margin-top:2px">
                                        ${conference.venueAddress},
                                        ${conference.city},
                                        ${conference.state}
                                    </div>
                                </c:if>
                            </div>
                        </c:if>
                        <c:if test="${not empty conference.targetAudience}">
                            <div class="col-sm-6">
                                <div style="font-size:0.75rem;
                                     color:#94a3b8;
                                     text-transform:uppercase;
                                     letter-spacing:0.05em;
                                     margin-bottom:4px">
                                    Target Audience
                                </div>
                                <div style="font-size:0.88rem;
                                     color:#475569">
                                    ${conference.targetAudience}
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${not empty conference.targetDomains}">
                            <div class="col-sm-6">
                                <div style="font-size:0.75rem;
                                     color:#94a3b8;
                                     text-transform:uppercase;
                                     letter-spacing:0.05em;
                                     margin-bottom:4px">
                                    Domains
                                </div>
                                <div style="font-size:0.88rem;
                                     color:#475569">
                                    ${conference.targetDomains}
                                </div>
                            </div>
                        </c:if>
                    </div>

                    <!-- Streaming link for online -->
                    <c:if test="${conference.mode == 'ONLINE' ||
                                 conference.mode == 'HYBRID'}">
                        <c:if test="${not empty conference.streamingLink}">
                            <div style="margin-top:16px;
                                 padding-top:16px;
                                 border-top:1px solid var(--border)">
                                <div style="font-size:0.75rem;
                                     color:#94a3b8;
                                     text-transform:uppercase;
                                     letter-spacing:0.05em;
                                     margin-bottom:6px">
                                    🔗 Streaming Link
                                </div>
                                <sec:authorize
                                    access="isAuthenticated()">
                                    <a href="${conference.streamingLink}"
                                       target="_blank"
                                       style="font-size:0.88rem;
                                              color:var(--brand)">
                                        ${conference.streamingLink}
                                    </a>
                                </sec:authorize>
                                <sec:authorize
                                    access="isAnonymous()">
                                    <span style="font-size:0.88rem;
                                          color:#94a3b8">
                                        Login to view link
                                    </span>
                                </sec:authorize>
                            </div>
                        </c:if>
                    </c:if>

                    <!-- Feature Tags -->
                    <div style="margin-top:16px;
                         padding-top:16px;
                         border-top:1px solid var(--border)">
                        <span class="feature-tag
                            ${conference.certificateEnabled ? 'active' : ''}">
                            📄
                            Certificate
                            ${conference.certificateEnabled ? 'Included' : 'Not included'}
                        </span>
                        <span class="feature-tag
                            ${conference.qrCheckinEnabled ? 'active' : ''}">
                            📱
                            QR Check-in
                        </span>
                        <c:if test="${conference.bulkUploadAllowed}">
                            <span class="feature-tag active">
                                📋 Bulk Registration
                            </span>
                        </c:if>
                    </div>
                </div>

                <!-- Speakers -->
                <c:if test="${not empty speakers}">
                    <div class="detail-card">
                        <div class="detail-card-title">
                            🎤 Speakers (${fn:length(speakers)})
                        </div>
                        <div class="row g-3">
                            <c:forEach var="sp"
                                       items="${speakers}">
                                <div class="col-md-6">
                                    <div class="speaker-chip">
                                        <div class="speaker-chip-avatar">
                                            ${sp.fullName.substring(0,1)}
                                        </div>
                                        <div>
                                            <div class="speaker-chip-name">
                                                ${sp.fullName}
                                            </div>
                                            <c:if test="${not empty sp.designation}">
                                                <div class="speaker-chip-role">
                                                    ${sp.designation}
                                                    <c:if test="${not empty sp.organization}">
                                                        · ${sp.organization}
                                                    </c:if>
                                                </div>
                                            </c:if>
                                            <c:if test="${sp.session != null}">
                                                <div style="font-size:0.72rem;
                                                     color:var(--brand);
                                                     margin-top:3px">
                                                    ${sp.session.title}
                                                </div>
                                            </c:if>
                                            <c:if test="${not empty sp.linkedinUrl}">
                                                <a href="${sp.linkedinUrl}"
                                                   target="_blank"
                                                   style="font-size:0.72rem;
                                                          color:#0a66c2">
                                                    LinkedIn ↗
                                                </a>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>

                <!-- Schedule -->
                <c:if test="${not empty sessions}">
                    <div class="detail-card">
                        <div class="detail-card-title">
                            📅 Schedule
                        </div>
                        <c:forEach var="sess"
                                   items="${sessions}">
                            <div class="session-row">
                                <div class="session-time">
                                    ${fn:replace(
                                        sess.startTime.toString().substring(11,16),
                                        'T', ' ')}
                                </div>
                                <div class="session-dot"></div>
                                <div class="flex-grow-1">
                                    <div class="session-content-title">
                                        ${sess.title}
                                    </div>
                                    <div class="session-content-meta">
                                        <c:if test="${not empty sess.sessionType}">
                                            <span style="background:#f1f5f9;
                                                  padding:2px 8px;
                                                  border-radius:4px;
                                                  font-size:0.7rem;
                                                  font-weight:600">
                                                ${sess.sessionType}
                                            </span>
                                        </c:if>
                                        <c:if test="${not empty sess.roomOrLink}">
                                            · 📍 ${sess.roomOrLink}
                                        </c:if>
                                        <c:if test="${sess.speaker != null}">
                                            · 🎤
                                            ${sess.speaker.fullName}
                                        </c:if>
                                    </div>
                                </div>
                                <div style="font-size:0.75rem;
                                     color:#94a3b8;white-space:nowrap">
                                    ${fn:replace(
                                        sess.endTime.toString().substring(11,16),
                                        'T', '')}
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>

                <!-- Feedback -->
                <c:if test="${feedbackCount > 0}">
                    <div class="detail-card">
                        <div class="detail-card-title">
                            ⭐ Reviews
                            <span style="font-size:0.82rem;
                                  font-weight:400;
                                  color:#64748b">
                                (${feedbackCount})
                            </span>
                        </div>

                        <!-- Rating Summary -->
                        <div class="d-flex align-items-center
                                    gap-4 mb-20"
                             style="padding:16px;
                                    background:#fafbfc;
                                    border-radius:10px;
                                    margin-bottom:20px">
                            <div class="text-center">
                                <div style="font-size:2.8rem;
                                     font-weight:800;
                                     color:#0f172a;
                                     line-height:1">
                                    <fmt:formatNumber
                                        value="${avgRating}"
                                        maxFractionDigits="1"/>
                                </div>
                                <div class="star-display">
                                    <c:forEach begin="1" end="5"
                                               var="s">
                                        <c:choose>
                                            <c:when test="${avgRating >= s}">★</c:when>
                                            <c:otherwise>☆</c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                                <div style="font-size:0.75rem;
                                     color:#94a3b8">
                                    ${feedbackCount} reviews
                                </div>
                            </div>
                        </div>

                        <!-- Individual Reviews -->
                        <c:forEach var="fb"
                                   items="${feedbackList}">
                            <div class="feedback-item">
                                <div class="d-flex
                                    justify-content-between
                                    align-items-start">
                                    <div>
                                        <div class="feedback-name">
                                            ${fb.user.fullName}
                                        </div>
                                        <div class="star-display
                                             feedback-stars">
                                            <c:forEach begin="1"
                                                       end="5"
                                                       var="s">
                                                <c:choose>
                                                    <c:when test="${fb.overallRating >= s}">★</c:when>
                                                    <c:otherwise>☆</c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <div class="feedback-date">
                                        ${fn:substringBefore(
                                            fb.submittedAt.toString(),
                                            'T')}
                                    </div>
                                </div>
                                <c:if test="${not empty fb.comments}">
                                    <div class="feedback-text">
                                        "${fb.comments}"
                                    </div>
                                </c:if>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>

            </div>

            <!-- RIGHT COLUMN — Registration Card -->
            <div class="col-lg-4">
                <div class="reg-card">
                    <!-- Price Header -->
                    <div class="reg-card-header">
                        <div class="reg-card-price">
                            <c:choose>
                                <c:when test="${conference.free}">
                                    Free
                                </c:when>
                                <c:otherwise>
                                    ₹${conference.delegateFee}
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="reg-card-price-label">
                            <c:choose>
                                <c:when test="${conference.free}">
                                    No registration fee
                                </c:when>
                                <c:otherwise>
                                    per delegate (collected at venue)
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="reg-card-body">
                        <!-- Seats Progress -->
                        <c:if test="${conference.maxDelegates > 0}">
                            <div class="seats-bar-lg">
                                <div class="seats-bar-lg-fill"
                                     style="width:${conference.registeredCount * 100 / conference.maxDelegates}%">
                                </div>
                            </div>
                            <div style="display:flex;
                                 justify-content:space-between;
                                 font-size:0.78rem;
                                 color:#64748b;
                                 margin-bottom:16px">
                                <span>
                                    ${conference.registeredCount}
                                    registered
                                </span>
                                <span>
                                    ${conference.maxDelegates - conference.registeredCount}
                                    seats left
                                </span>
                            </div>
                        </c:if>

                        <!-- Key info -->
                        <div class="reg-detail-row">
                            <span class="reg-detail-label">
                                📅 Start
                            </span>
                            <span class="reg-detail-value">
                                ${fn:substringBefore(
                                    conference.startDate.toString(),
                                    'T')}
                            </span>
                        </div>
                        <div class="reg-detail-row">
                            <span class="reg-detail-label">
                                📅 End
                            </span>
                            <span class="reg-detail-value">
                                ${fn:substringBefore(
                                    conference.endDate.toString(),
                                    'T')}
                            </span>
                        </div>
                        <div class="reg-detail-row">
                            <span class="reg-detail-label">
                                ⏰ Deadline
                            </span>
                            <span class="reg-detail-value">
                                ${fn:substringBefore(
                                    conference.registrationDeadline.toString(),
                                    'T')}
                            </span>
                        </div>
                        <div class="reg-detail-row">
                            <span class="reg-detail-label">
                                🎯 Mode
                            </span>
                            <span class="reg-detail-value">
                                ${conference.mode}
                            </span>
                        </div>
                        <c:if test="${conference.certificateEnabled}">
                            <div class="reg-detail-row">
                                <span class="reg-detail-label">
                                    📄 Certificate
                                </span>
                                <span class="reg-detail-value"
                                      style="color:#059669">
                                    Included
                                </span>
                            </div>
                        </c:if>

                        <!-- CTA Button -->
                        <sec:authorize access="isAnonymous()">
                            <a href="${pageContext.request.contextPath}/login"
                               class="btn-register-main">
                                Login to Register →
                            </a>
                            <div style="text-align:center;
                                 font-size:0.78rem;
                                 color:#94a3b8;
                                 margin-top:10px">
                                Don't have an account?
                                <a href="${pageContext.request.contextPath}/register"
                                   style="color:var(--brand)">
                                    Sign up free
                                </a>
                            </div>
                        </sec:authorize>

                        <sec:authorize access="hasRole('ROLE_DELEGATE')">
                            <form action="${pageContext.request.contextPath}/delegate/conference/${conference.id}/register"
                                  method="post">
                                <input type="hidden"
                                    name="${_csrf.parameterName}"
                                    value="${_csrf.token}"/>
                                <button type="submit"
                                        class="btn-register-main">
                                    Register Now →
                                </button>
                            </form>
                        </sec:authorize>

                        <sec:authorize access="hasRole('ROLE_ORGANIZER')">
                            <div style="background:#fef9c3;
                                 border:1px solid #fde047;
                                 border-radius:10px;
                                 padding:12px;
                                 font-size:0.82rem;
                                 color:#854d0e;
                                 margin-top:16px;
                                 text-align:center">
                                Organizers cannot register as delegates.
                                Switch to a delegate account to register.
                            </div>
                        </sec:authorize>

                        <sec:authorize access="hasRole('ROLE_SUPER_ADMIN')">
                            <div style="background:#f0f9ff;
                                 border:1px solid #bae6fd;
                                 border-radius:10px;
                                 padding:12px;
                                 font-size:0.82rem;
                                 color:#075985;
                                 margin-top:16px;
                                 text-align:center">
                                Admin view — not available for registration.
                            </div>
                        </sec:authorize>

                        <!-- Organizer info -->
                        <div style="margin-top:20px;
                             padding-top:16px;
                             border-top:1px solid var(--border)">
                            <div style="font-size:0.75rem;
                                 color:#94a3b8;
                                 margin-bottom:6px">
                                Organized by
                            </div>
                            <div style="font-weight:600;
                                 font-size:0.9rem">
                                ${conference.organizer.organizationName}
                            </div>
                            <div style="font-size:0.8rem;
                                 color:#64748b">
                                ${conference.organizer.user.fullName}
                            </div>
                            <c:if test="${conference.organizer.averageRating > 0}">
                                <div style="font-size:0.8rem;
                                     color:#94a3b8;margin-top:4px">
                                    ⭐
                                    <fmt:formatNumber
                                        value="${conference.organizer.averageRating}"
                                        maxFractionDigits="1"/>
                                    organizer rating
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>