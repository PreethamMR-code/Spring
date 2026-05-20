<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"
    uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Audit Logs - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
          rel="stylesheet"/>
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: #f8f9fc;
        }
        .page-header {
            background: linear-gradient(135deg,
                #667eea 0%, #764ba2 100%);
            padding: 36px 0 52px;
            color: white;
        }
        .log-card {
            background: white;
            border-radius: 12px;
            border: 1.5px solid #e8ecf0;
            margin-top: -28px;
            position: relative;
            z-index: 10;
        }
        .log-row {
            border-bottom: 1px solid #f1f5f9;
            padding: 12px 20px;
            font-size: 0.85rem;
            transition: background 0.1s;
        }
        .log-row:hover {
            background: #f8f9fc;
        }
        .log-row:last-child {
            border-bottom: none;
        }
        .action-badge {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 100px;
            font-size: 0.72rem;
            font-weight: 600;
            white-space: nowrap;
        }
        /* Color coding by action type */
        .action-CONFERENCE_APPROVED {
            background: #dcfce7;
            color: #166534;
        }
        .action-CONFERENCE_REJECTED {
            background: #fee2e2;
            color: #991b1b;
        }
        .action-CONFERENCE_CANCELLED {
            background: #fee2e2;
            color: #991b1b;
        }
        .action-CONFERENCE_COMPLETED {
            background: #e0e7ff;
            color: #3730a3;
        }
        .action-CONFERENCE_CREATED {
            background: #f0fdf4;
            color: #15803d;
        }
        .action-ORGANIZER_VERIFIED {
            background: #dcfce7;
            color: #166534;
        }
        .action-ORGANIZER_REJECTED {
            background: #fee2e2;
            color: #991b1b;
        }
        .action-USER_REGISTERED {
            background: #dbeafe;
            color: #1e40af;
        }
        .action-USER_ACTIVATED {
            background: #dcfce7;
            color: #166534;
        }
        .action-USER_DEACTIVATED {
            background: #fef3c7;
            color: #92400e;
        }
        .action-DELEGATE_REGISTERED {
            background: #dbeafe;
            color: #1e40af;
        }
        .action-DELEGATE_CANCELLED {
            background: #fef3c7;
            color: #92400e;
        }
        .action-BULK_UPLOAD_COMPLETED {
            background: #f0fdf4;
            color: #15803d;
        }
        .action-INSTITUTIONAL_ADMIN_APPROVED {
            background: #dcfce7;
            color: #166534;
        }
        .action-INSTITUTION_ADDED {
            background: #f0fdf4;
            color: #15803d;
        }
        .action-OUTREACH_SENT {
            background: #fdf4ff;
            color: #7e22ce;
        }
        .action-CERTIFICATE_ISSUED {
            background: #fef9c3;
            color: #854d0e;
        }
        .filter-bar {
            background: white;
            border-radius: 10px;
            border: 1.5px solid #e8ecf0;
            padding: 16px 20px;
            margin-bottom: 20px;
        }
        .details-text {
            color: #64748b;
            font-size: 0.78rem;
            max-width: 280px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .time-text {
            color: #94a3b8;
            font-size: 0.75rem;
            white-space: nowrap;
        }
        code {
            font-size: 0.75rem;
            background: #f1f5f9;
            padding: 1px 6px;
            border-radius: 4px;
            color: #334155;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<!-- Page Header -->
<div class="page-header">
    <div class="container">
        <div class="d-flex justify-content-between
                    align-items-center">
            <div>
                <div style="font-size:0.82rem;
                     color:rgba(255,255,255,0.7);
                     margin-bottom:6px">
                    <a href="${pageContext.request.contextPath}/admin/dashboard"
                       style="color:rgba(255,255,255,0.7);
                              text-decoration:none">
                        Dashboard
                    </a>
                    → Audit Logs
                </div>
                <h2 style="font-weight:800;
                     margin:0;color:white">
                    🔍 Audit Logs
                </h2>
                <div style="color:rgba(255,255,255,0.75);
                     font-size:0.88rem;
                     margin-top:4px">
                    ${totalCount} events recorded
                </div>
            </div>
            <a href="${pageContext.request.contextPath}/admin/dashboard"
               class="btn btn-outline-light btn-sm">
                ← Dashboard
            </a>
        </div>
    </div>
</div>

<div class="container pb-5">

    <!-- Filter Bar -->
    <div class="filter-bar mt-0"
         style="margin-top:-20px;
                position:relative;z-index:20">
        <form method="get"
              action="${pageContext.request.contextPath}/admin/audit-logs"
              class="d-flex gap-3 align-items-end
                     flex-wrap">
            <div style="flex:1;min-width:200px">
                <label class="form-label small
                              fw-semibold text-muted
                              mb-1">
                    Filter by Action
                </label>
                <select name="action"
                        class="form-select form-select-sm">
                    <option value="">
                        All Actions
                    </option>
                    <c:forEach var="at"
                               items="${actionTypes}">
                        <option value="${at}"
                            ${selectedAction == at
                                ? 'selected' : ''}>
                            ${at}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="d-flex gap-2">
                <button type="submit"
                        class="btn btn-primary
                               btn-sm px-4">
                    Filter
                </button>
                <a href="${pageContext.request.contextPath}/admin/audit-logs"
                   class="btn btn-outline-secondary
                          btn-sm">
                    Clear
                </a>
            </div>
        </form>
    </div>

    <!-- Logs Table -->
    <div class="log-card">
        <div class="d-flex justify-content-between
                    align-items-center px-4 py-3
                    border-bottom">
            <span class="fw-bold"
                  style="color:#0f172a">
                <c:choose>
                    <c:when test="${not empty
                                   selectedAction}">
                        Showing: ${selectedAction}
                    </c:when>
                    <c:otherwise>
                        Recent Activity
                    </c:otherwise>
                </c:choose>
            </span>
            <span class="text-muted small">
                ${fn:length(logs)} entries shown
            </span>
        </div>

        <c:choose>
            <c:when test="${empty logs}">
                <div class="text-center py-5">
                    <div style="font-size:3rem">
                        📋
                    </div>
                    <h5 class="fw-bold mt-3">
                        No logs yet
                    </h5>
                    <p class="text-muted small">
                        Audit events will appear here
                        as actions are performed in
                        the system.
                    </p>
                </div>
            </c:when>
            <c:otherwise>

                <%-- Desktop table --%>
                <div class="d-none d-md-block">
                    <table class="table mb-0">
                        <thead
                            class="table-light"
                            style="font-size:0.75rem">
                            <tr>
                                <th style="width:140px">
                                    Time
                                </th>
                                <th style="width:60px">
                                    #
                                </th>
                                <th style="width:220px">
                                    Action
                                </th>
                                <th>User</th>
                                <th>Entity</th>
                                <th>Details</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="log"
                                       items="${logs}">
                                <tr class="log-row"
                                    style="padding:0">
                                    <td class="time-text
                                               ps-4">
                                        ${fn:replace(
                                            fn:substring(
                                                log.performedAt
                                                .toString(),
                                                0, 16),
                                            'T', ' ')}
                                    </td>
                                    <td class="text-muted
                                               small">
                                        ${log.id}
                                    </td>
                                    <td>
                                        <span class="action-badge
                                            action-${log.action}">
                                            ${fn:replace(
                                                log.action,
                                                '_', ' ')}
                                        </span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when
                                                test="${not empty
                                                       log.user}">
                                                <div class="fw-semibold
                                                     small">
                                                    ${log.user.fullName}
                                                </div>
                                                <div class="text-muted"
                                                     style="font-size:0.72rem">
                                                    ${log.user.email}
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted
                                                      small
                                                      fst-italic">
                                                    System
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="small">
                                        <c:if test="${not empty
                                                      log.entityType}">
                                            <code>
                                                ${log.entityType}
                                            </code>
                                        </c:if>
                                        <c:if test="${log.entityId
                                                      != null}">
                                            <span class="text-muted">
                                                #${log.entityId}
                                            </span>
                                        </c:if>
                                    </td>
                                    <td>
                                        <div class="details-text"
                                             title="${log.details}">
                                            ${log.details}
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <%-- Mobile card list --%>
                <div class="d-block d-md-none">
                    <c:forEach var="log"
                               items="${logs}">
                        <div class="log-row">
                            <div class="d-flex
                                justify-content-between
                                align-items-start
                                mb-1">
                                <span class="action-badge
                                    action-${log.action}">
                                    ${fn:replace(
                                        log.action,
                                        '_', ' ')}
                                </span>
                                <span class="time-text">
                                    ${fn:replace(
                                        fn:substring(
                                            log.performedAt
                                            .toString(),
                                            0, 16),
                                        'T', ' ')}
                                </span>
                            </div>
                            <div class="small mt-1">
                                <c:choose>
                                    <c:when
                                        test="${not empty
                                               log.user}">
                                        👤
                                        ${log.user.fullName}
                                    </c:when>
                                    <c:otherwise>
                                        🤖 System
                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${not empty
                                             log.entityType}">
                                    · <code>
                                        ${log.entityType}
                                        <c:if test="${log.entityId
                                                      != null}">
                                            #${log.entityId}
                                        </c:if>
                                    </code>
                                </c:if>
                            </div>
                            <c:if test="${not empty
                                         log.details}">
                                <div class="details-text
                                            mt-1">
                                    ${log.details}
                                </div>
                            </c:if>
                        </div>
                    </c:forEach>
                </div>

            </c:otherwise>
        </c:choose>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>