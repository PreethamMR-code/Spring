<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Notifications - NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <style>
        body { background: #f0f2f5; }
        .notif-card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.08);
            max-width: 700px;
            margin: 0 auto;
        }
        .notif-item {
            border-left: 4px solid transparent;
            padding: 14px 16px;
            border-bottom: 1px solid #f0f0f0;
            transition: background 0.15s;
        }
        .notif-item:last-child {
            border-bottom: none;
        }
        .notif-item.unread {
            border-left-color: #667eea;
            background: #fafbff;
        }
        .notif-item:hover {
            background: #f8f9ff;
        }
        .notif-icon {
            font-size: 1.4rem;
            width: 40px;
            text-align: center;
            flex-shrink: 0;
        }
        .notif-time {
            font-size: 0.75rem;
            color: #adb5bd;
        }
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #adb5bd;
        }
        .empty-icon { font-size: 3.5rem; }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container py-4">
    <div class="notif-card card">

        <!-- Header -->
        <div class="card-header bg-white d-flex
                    justify-content-between align-items-center
                    py-3 px-4" style="border-radius:12px 12px 0 0;">
            <h5 class="fw-bold mb-0">🔔 Notifications</h5>
            <c:if test="${not empty notifications}">
                <form action="${pageContext.request.contextPath}/notifications/read-all"
                      method="post" class="d-inline">
                    <input type="hidden"
                           name="${_csrf.parameterName}"
                           value="${_csrf.token}"/>
                    <button type="submit"
                            class="btn btn-sm btn-outline-secondary">
                        Mark all as read
                    </button>
                </form>
            </c:if>
        </div>

        <!-- Notifications List -->
        <div class="card-body p-0">
            <c:choose>
                <c:when test="${empty notifications}">
                    <div class="empty-state">
                        <div class="empty-icon">🔔</div>
                        <h5 class="mt-3">No notifications yet</h5>
                        <p class="small">
                            You will be notified here when
                            something important happens.
                        </p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="n" items="${notifications}">
                        <div class="notif-item d-flex gap-3
                            ${not n.read ? 'unread' : ''}">

                            <!-- Icon based on title keywords -->
                            <div class="notif-icon">
                                <c:choose>
                                    <c:when test="${fn:containsIgnoreCase(n.title,'approved')}">✅</c:when>
                                    <c:when test="${fn:containsIgnoreCase(n.title,'rejected')}">❌</c:when>
                                    <c:when test="${fn:containsIgnoreCase(n.title,'registration')}">📋</c:when>
                                    <c:when test="${fn:containsIgnoreCase(n.title,'attendance')}">✔️</c:when>
                                    <c:when test="${fn:containsIgnoreCase(n.title,'feedback')}">⭐</c:when>
                                    <c:when test="${fn:containsIgnoreCase(n.title,'certificate')}">📄</c:when>
                                    <c:otherwise>🔔</c:otherwise>
                                </c:choose>
                            </div>

                            <!-- Content -->
                            <div class="flex-grow-1">
                                <div class="d-flex justify-content-between
                                            align-items-start">
                                    <strong class="small">
                                        ${n.title}
                                    </strong>
                                    <c:if test="${not n.read}">
                                        <span class="badge bg-primary ms-2"
                                              style="font-size:0.65rem">
                                            NEW
                                        </span>
                                    </c:if>
                                </div>
                                <p class="mb-1 text-muted small mt-1">
                                    ${n.message}
                                </p>
                                <div class="notif-time">
                                    ${fn:replace(
                                        fn:substringBefore(
                                            n.sentAt.toString(), '.'),
                                        'T', ' ')}
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>