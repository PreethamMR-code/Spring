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
    <title>My Dashboard – NexMeet</title>
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

        /* ── Page Header ──────────────────────────── */
        .page-header {
            background: linear-gradient(135deg,
                #667eea 0%, #764ba2 100%);
            padding: 36px 0 56px;
            color: white;
        }

        /* ── Stat Cards ───────────────────────────── */
        .stat-row {
            margin-top: -32px;
            position: relative;
            z-index: 10;
            margin-bottom: 24px;
        }
        .stat-card {
            background: white;
            border-radius: 14px;
            padding: 20px 24px;
            border: 1.5px solid #e8ecf0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.07);
            text-align: center;
            height: 100%;
        }
        .stat-number {
            font-size: 2.2rem;
            font-weight: 800;
            line-height: 1;
        }
        .stat-label {
            font-size: 0.75rem;
            color: #64748b;
            margin-top: 6px;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        /* ── Content Cards ────────────────────────── */
        .content-card {
            background: white;
            border-radius: 14px;
            border: 1.5px solid #e8ecf0;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            margin-bottom: 20px;
            overflow: hidden;
        }
        .content-card-header {
            padding: 16px 20px;
            border-bottom: 1px solid #f1f5f9;
            font-weight: 700;
            font-size: 0.92rem;
            color: #0f172a;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: white;
        }
        .content-card-count {
            font-size: 0.78rem;
            color: #94a3b8;
            font-weight: 500;
        }

        /* ── Table ────────────────────────────────── */
        .table th {
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.04em;
            color: #64748b;
            border-bottom: 1.5px solid #e8ecf0 !important;
            padding: 10px 16px;
            background: #fafbfc;
        }
        .table td {
            font-size: 0.85rem;
            vertical-align: middle;
            padding: 12px 16px;
            border-color: #f1f5f9;
        }
        .reg-number {
            font-family: monospace;
            font-size: 0.78rem;
            color: #667eea;
            background: #f0eeff;
            padding: 2px 7px;
            border-radius: 5px;
        }

        /* ── Profile Banner ───────────────────────── */
        .profile-banner {
            background: #fffbeb;
            border: 1.5px solid #fde68a;
            border-radius: 12px;
            padding: 16px 20px;
            margin-bottom: 20px;
            display: flex;
            align-items: flex-start;
            gap: 14px;
        }

        /* ── Action Buttons ───────────────────────── */
        .btn-action-row {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            padding: 16px 20px;
            border-top: 1px solid #f1f5f9;
            background: #fafbfc;
        }
        .btn-browse {
            background: linear-gradient(135deg,
                #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 9px 20px;
            font-weight: 600;
            font-size: 0.88rem;
            font-family: 'Inter', sans-serif;
            text-decoration: none;
            transition: opacity 0.15s;
            cursor: pointer;
        }
        .btn-browse:hover {
            opacity: 0.9;
            color: white;
        }
        .btn-outline-action {
            border: 1.5px solid #e2e8f0;
            background: white;
            color: #374151;
            border-radius: 8px;
            padding: 8px 16px;
            font-weight: 600;
            font-size: 0.88rem;
            font-family: 'Inter', sans-serif;
            text-decoration: none;
            transition: all 0.15s;
            cursor: pointer;
        }
        .btn-outline-action:hover {
            border-color: #667eea;
            color: #667eea;
        }
        .btn-logout {
            border: 1.5px solid #fecaca;
            background: white;
            color: #ef4444;
            border-radius: 8px;
            padding: 8px 16px;
            font-weight: 600;
            font-size: 0.88rem;
            font-family: 'Inter', sans-serif;
            cursor: pointer;
            transition: all 0.15s;
        }
        .btn-logout:hover {
            background: #fef2f2;
            border-color: #ef4444;
        }

        .empty-state {
            text-align: center;
            padding: 48px 24px;
            color: #94a3b8;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<%-- ── Page Header ─────────────────────────────── --%>
<div class="page-header">
    <div class="container">
        <div style="font-size:0.82rem;
             color:rgba(255,255,255,0.7);
             margin-bottom:4px">
            Delegate Dashboard
        </div>
        <h2 style="font-weight:800;margin:0;
             letter-spacing:-0.02em">
            Welcome back, ${currentUser.fullName} 👋
        </h2>
        <div style="color:rgba(255,255,255,0.72);
             font-size:0.88rem;margin-top:4px">
            ${currentUser.email}
        </div>
    </div>
</div>

<div class="container pb-5">

    <%-- ── Stat Cards (overlap header) ───────────── --%>
    <div class="row g-3 stat-row">
        <div class="col-4">
            <div class="stat-card">
                <div class="stat-number text-primary">
                    ${myRegistrations}
                </div>
                <div class="stat-label">
                    Registered
                </div>
            </div>
        </div>
        <div class="col-4">
            <div class="stat-card">
                <div class="stat-number text-success">
                    ${attendedCount}
                </div>
                <div class="stat-label">
                    Attended
                </div>
            </div>
        </div>
        <div class="col-4">
            <div class="stat-card">
                <div class="stat-number text-warning">
                    ${certificateCount}
                </div>
                <div class="stat-label">
                    Certificates
                </div>
            </div>
        </div>
    </div>

    <%-- ── Flash Messages ──────────────────────── --%>
    <c:if test="${not empty success}">
        <div class="alert alert-success
                    alert-dismissible fade show">
            ✅ ${success}
            <button type="button"
                    class="btn-close"
                    data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger
                    alert-dismissible fade show">
            ⚠️ ${error}
            <button type="button"
                    class="btn-close"
                    data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <%-- ── Profile Completion Banner ─────────────── --%>
    <c:if test="${not profileComplete}">
        <div class="profile-banner">
            <span style="font-size:1.6rem;
                  flex-shrink:0">⚠️</span>
            <div class="flex-grow-1">
                <div style="font-weight:700;
                     color:#92400e;
                     font-size:0.95rem">
                    Complete your profile to register
                    for conferences
                </div>
                <div style="color:#b45309;
                     font-size:0.82rem;
                     margin-top:4px;
                     line-height:1.6">
                    Takes 30 seconds — required before
                    any conference registration.
                </div>
                <a href="${pageContext.request.contextPath}/delegate/profile/setup"
                   class="btn-browse d-inline-block
                          mt-2"
                   style="font-size:0.82rem;
                          padding:7px 16px">
                    Complete My Profile →
                </a>
            </div>
            <span class="badge bg-warning text-dark">
                Action Required
            </span>
        </div>
    </c:if>

    <%-- ── Registrations Table ────────────────────── --%>
    <div class="content-card">
        <div class="content-card-header">
            <span>📋 My Registered Conferences</span>
            <span class="content-card-count">
                ${fn:length(registrations)} total
            </span>
        </div>

        <c:choose>
            <c:when test="${empty registrations}">
                <div class="empty-state">
                    <div style="font-size:3rem">🎫</div>
                    <div class="fw-semibold mt-2"
                         style="color:#0f172a">
                        No registrations yet
                    </div>
                    <p class="small mt-1 mb-3">
                        Browse upcoming conferences and
                        register for events that interest you.
                    </p>
                    <a href="${pageContext.request.contextPath}/conferences"
                       class="btn-browse">
                        Browse Conferences
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead>
                        <tr>
                            <th class="ps-4">
                                Reg. Number
                            </th>
                            <th>Conference</th>
                            <th>Mode</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                            <th>💳 Payment</th>
                            <th>QR Code</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="reg"
                               items="${registrations}">
                        <tr>
                            <td class="ps-4">
                                <span class="reg-number">
                                    ${reg.registrationNumber}
                                </span>
                            </td>
                            <td>
                                <div class="fw-semibold"
                                     style="font-size:0.88rem">
                                    ${fn:length(
                                        reg.conference.title)
                                        > 32
                                        ? fn:substring(
                                            reg.conference.title,
                                            0, 32).concat('…')
                                        : reg.conference.title}
                                </div>
                            </td>
                            <td>
                                <span class="badge
                                    ${reg.conference.mode
                                        == 'OFFLINE'
                                        ? 'bg-secondary'
                                    : reg.conference.mode
                                        == 'ONLINE'
                                        ? 'bg-info text-dark'
                                        : 'bg-primary'}"
                                      style="font-size:0.68rem">
                                    ${reg.conference.mode}
                                </span>
                            </td>
                            <td class="text-muted small">
                                ${fn:substringBefore(
                                    reg.conference
                                        .startDate
                                        .toString(), 'T')}
                            </td>
                            <td>
                                <span class="badge
                                    ${reg.status
                                        == 'CONFIRMED'
                                        ? 'bg-success'
                                        : 'bg-secondary'}">
                                    ${reg.status}
                                </span>
                            </td>
                            <td>
                                <%-- Ticket --%>
                                <c:if test="${reg.status
                                    == 'CONFIRMED'}">
                                    <a href="${pageContext.request.contextPath}/delegate/registration/${reg.id}/ticket"
                                       class="btn btn-primary
                                              btn-sm"
                                       style="font-size:0.75rem">
                                        🎫 Ticket
                                    </a>
                                </c:if>

                                <%-- Cancel --%>
                                <c:if test="${reg.status
                                    != 'CANCELLED'}">
                                    <form action="${pageContext.request.contextPath}/delegate/registration/${reg.id}/cancel"
                                          method="post"
                                          class="d-inline ms-1"
                                          onsubmit="return confirm('Cancel this registration?')">
                                        <input type="hidden"
                                               name="${_csrf.parameterName}"
                                               value="${_csrf.token}"/>
                                        <button class="btn
                                                btn-outline-danger
                                                btn-sm"
                                                style="font-size:0.75rem">
                                            Cancel
                                        </button>
                                    </form>
                                </c:if>

                                <%-- Certificate --%>
                                <c:if test="${attendedIds.contains(reg.id) && reg.conference.status == 'COMPLETED'}">
                                    <c:set var="cert"
                                           value="${certificateMap[reg.id]}"/>
                                    <c:choose>
                                        <c:when test="${not empty cert}">
                                            <div class="mt-1">
                                                <span class="badge bg-success"
                                                      style="font-size:0.68rem">
                                                    🏆 Certified
                                                </span>
                                                <div class="text-muted"
                                                     style="font-size:0.65rem;
                                                            margin:2px 0">
                                                    ${cert.certificateNumber}
                                                </div>
                                                <a href="${pageContext.request.contextPath}/delegate/registration/${reg.id}/certificate"
                                                   class="btn btn-warning
                                                          btn-sm"
                                                   style="font-size:0.7rem;
                                                          padding:3px 8px">
                                                    ⬇ Certificate PDF
                                                </a>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/delegate/registration/${reg.id}/certificate"
                                               class="btn
                                                      btn-outline-warning
                                                      btn-sm ms-1"
                                               style="font-size:0.72rem">
                                                📄 Certificate
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>

                                <%-- Feedback --%>
                                <c:if test="${attendedIds.contains(reg.id)}">
                                    <c:choose>
                                        <c:when test="${feedbackSubmitted.contains(reg.conference.id)}">
                                            <span class="badge
                                                  bg-success
                                                  ms-1"
                                                  style="font-size:0.68rem">
                                                ✓ Reviewed
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/delegate/conference/${reg.conference.id}/feedback"
                                               class="btn
                                                      btn-outline-warning
                                                      btn-sm ms-1"
                                               style="font-size:0.72rem">
                                                ⭐ Feedback
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>

                                <c:if test="${reg.status
                                    == 'CANCELLED'}">
                                    <span class="text-muted
                                                 small">—</span>
                                </c:if>
                            </td>

                            <%-- Payment column --%>
                            <td>
                                <c:choose>
                                    <c:when test="${reg.conference.free}">
                                        <span class="badge bg-success"
                                              style="font-size:0.72rem">
                                            Free Event
                                        </span>
                                    </c:when>
                                    <c:when test="${not empty paymentMap[reg.conference.id]}">
                                        <c:set var="pay"
                                               value="${paymentMap[reg.conference.id]}"/>
                                        <c:choose>
                                            <c:when test="${pay.paymentMethod == 'VENUE_CASH' || pay.paymentMethod == 'VENUE_UPI'}">
                                                <span class="badge bg-success"
                                                      style="font-size:0.72rem">
                                                    ✅ Paid at Venue
                                                </span>
                                                <div class="text-muted"
                                                     style="font-size:0.65rem;margin-top:2px">
                                                    ₹${pay.amount}
                                                    · ${pay.paymentMethod == 'VENUE_CASH' ? 'Cash' : 'UPI'}
                                                </div>
                                            </c:when>
                                            <c:when test="${pay.paymentMethod == 'SIMULATED' && (reg.conference.mode == 'OFFLINE' || reg.conference.mode == 'HYBRID')}">
                                                <span class="badge bg-warning text-dark"
                                                      style="font-size:0.72rem">
                                                    🏛️ Pay at Venue
                                                </span>
                                                <div class="text-muted"
                                                     style="font-size:0.65rem;margin-top:2px">
                                                    ₹${pay.amount} due on conference day
                                                </div>
                                            </c:when>
                                            <c:when test="${pay.paymentMethod == 'SIMULATED' && reg.conference.mode == 'ONLINE'}">
                                                <span class="badge bg-info text-dark"
                                                      style="font-size:0.72rem">
                                                    ⏳ Pending
                                                </span>
                                                <div class="text-muted"
                                                     style="font-size:0.65rem">
                                                    ₹${pay.amount}
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-success"
                                                      style="font-size:0.72rem">
                                                    ✅ ${pay.status}
                                                </span>
                                                <div style="font-size:0.65rem;
                                                     color:#64748b">
                                                    ₹${pay.amount}
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        <c:if test="${not reg.conference.free}">
                                            <span class="badge bg-warning text-dark"
                                                  style="font-size:0.72rem">
                                                🏛️ Pay at Venue
                                            </span>
                                            <div class="text-muted"
                                                 style="font-size:0.65rem">
                                                ₹${reg.conference.delegateFee}
                                            </div>
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <%-- QR Code --%>
                            <td>
                                <c:if test="${reg.status == 'CONFIRMED' && not empty qrCodes[reg.id]}">
                                    <img src="data:image/png;base64,${qrCodes[reg.id]}"
                                         width="56" height="56"
                                         alt="QR"
                                         style="cursor:pointer;
                                                border-radius:6px"
                                         data-bs-toggle="modal"
                                         data-bs-target="#qrModal${reg.id}"/>

                                    <div class="modal fade"
                                         id="qrModal${reg.id}"
                                         tabindex="-1">
                                        <div class="modal-dialog
                                                    modal-sm
                                                    text-center">
                                            <div class="modal-content
                                                        p-4">
                                                <h6 class="fw-bold">
                                                    ${reg.conference.title}
                                                </h6>
                                                <p class="text-muted small">
                                                    ${reg.registrationNumber}
                                                </p>
                                                <img src="data:image/png;base64,${qrCodes[reg.id]}"
                                                     width="200"
                                                     height="200"
                                                     alt="QR Code"/>
                                                <p class="text-muted
                                                           small mt-2">
                                                    Show this at the venue
                                                </p>
                                                <button class="btn
                                                        btn-secondary
                                                        btn-sm mt-2"
                                                        data-bs-dismiss="modal">
                                                    Close
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test="${reg.status == 'CANCELLED'}">
                                    <span class="text-muted">—</span>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                </div>
            </c:otherwise>
        </c:choose>

        <%-- Action Row --%>
        <div class="btn-action-row">
            <a href="${pageContext.request.contextPath}/conferences"
               class="btn-browse">
                🔍 Browse Conferences
            </a>
            <c:if test="${profileComplete}">
                <a href="${pageContext.request.contextPath}/delegate/profile/edit"
                   class="btn-outline-action">
                    ✏️ Edit Profile
                </a>
            </c:if>
            <a href="${pageContext.request.contextPath}/profile"
               class="btn-outline-action">
                👤 My Account
            </a>
            <form action="${pageContext.request.contextPath}/logout"
                  method="post"
                  class="d-inline">
                <input type="hidden"
                       name="${_csrf.parameterName}"
                       value="${_csrf.token}"/>
                <button type="submit"
                        class="btn-logout">
                    Logout
                </button>
            </form>
        </div>
    </div>

    <%-- ── Payment History ────────────────────────── --%>
    <c:if test="${not empty myPayments}">
        <div class="content-card">
            <div class="content-card-header">
                <span>💳 Payment History</span>
                <span class="content-card-count">
                    ${fn:length(myPayments)} transaction(s)
                </span>
            </div>
            <div class="table-responsive">
            <table class="table table-hover mb-0 small">
                <thead>
                    <tr>
                        <th class="ps-4">
                            Transaction Ref
                        </th>
                        <th>Conference</th>
                        <th class="text-end">Amount</th>
                        <th>Method</th>
                        <th>Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="pay"
                           items="${myPayments}">
                    <tr>
                        <td class="ps-4">
                            <code style="font-size:0.72rem;
                                  color:#667eea">
                                ${pay.transactionRef}
                            </code>
                        </td>
                        <td class="text-muted">
                            ${fn:length(
                                pay.conference.title)
                                > 30
                                ? fn:substring(
                                    pay.conference.title,
                                    0, 30).concat('…')
                                : pay.conference.title}
                        </td>
                        <td class="text-end fw-bold
                                   text-success">
                            ₹${pay.amount}
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${pay.paymentMethod == 'VENUE_CASH'}">
                                    <span class="badge bg-success">Cash</span>
                                </c:when>
                                <c:when test="${pay.paymentMethod == 'VENUE_UPI'}">
                                    <span class="badge bg-success">UPI</span>
                                </c:when>
                                <c:when test="${pay.paymentMethod == 'SIMULATED' && (pay.conference.mode == 'OFFLINE' || pay.conference.mode == 'HYBRID')}">
                                    <span class="badge bg-warning text-dark">Pay at Venue</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary">
                                        ${pay.paymentMethod}
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="text-muted">
                            ${fn:substringBefore(
                                pay.initiatedAt
                                    .toString(), 'T')}
                        </td>
                        <td>
                            <span class="badge
                                ${pay.status == 'COMPLETED'
                                    ? 'bg-success'
                                    : pay.status == 'FAILED'
                                    ? 'bg-danger'
                                    : 'bg-warning text-dark'}">
                                ${pay.status}
                            </span>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            </div>
        </div>
    </c:if>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>