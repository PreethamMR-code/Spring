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
    <title>Schedule – ${conf.title}</title>
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
                #10b981 0%, #059669 100%);
            padding: 32px 0 52px;
            color: white;
        }
        .layout-wrap {
            margin-top: -28px;
            position: relative;
            z-index: 10;
        }

        /* ── Add Session Form ──────────────────── */
        .add-card {
            background: white;
            border-radius: 14px;
            border: 1.5px solid #e8ecf0;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
            overflow: hidden;
            position: sticky;
            top: 16px;
        }
        .add-card-header {
            background: linear-gradient(135deg,
                #10b981, #059669);
            color: white;
            padding: 14px 20px;
            font-weight: 700;
            font-size: 0.9rem;
        }
        .add-card-body { padding: 20px; }
        .form-label {
            font-weight: 600;
            font-size: 0.8rem;
            color: #374151;
            margin-bottom: 4px;
        }
        .form-control,
        .form-select {
            border: 1.5px solid #e2e8f0;
            border-radius: 8px;
            padding: 8px 12px;
            font-size: 0.85rem;
            font-family: 'Inter', sans-serif;
            background: #fafbfc;
        }
        .form-control:focus,
        .form-select:focus {
            border-color: #10b981;
            box-shadow: 0 0 0 3px rgba(16,185,129,0.12);
            background: white;
        }
        .form-control::placeholder { color: #94a3b8; }
        .btn-add {
            background: linear-gradient(135deg,
                #10b981, #059669);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 10px;
            width: 100%;
            font-weight: 700;
            font-size: 0.88rem;
            font-family: 'Inter', sans-serif;
            cursor: pointer;
            transition: opacity 0.15s;
        }
        .btn-add:hover { opacity: 0.9; }

        /* ── Session Cards ─────────────────────── */
        .session-card {
            background: white;
            border-radius: 12px;
            border: 1.5px solid #e8ecf0;
            border-left: 5px solid #667eea;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            margin-bottom: 14px;
            overflow: hidden;
        }
        .session-card.KEYNOTE     { border-left-color: #f59e0b; }
        .session-card.WORKSHOP    { border-left-color: #10b981; }
        .session-card.PANEL       { border-left-color: #3b82f6; }
        .session-card.PRESENTATION{ border-left-color: #8b5cf6; }
        .session-card.BREAK       { border-left-color: #94a3b8; }
        .session-card.OTHER       { border-left-color: #f97316; }

        .session-body { padding: 16px 18px; }

        .type-badge {
            display: inline-block;
            border-radius: 6px;
            padding: 2px 8px;
            font-size: 0.7rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.04em;
        }
        .type-KEYNOTE      { background:#fef3c7; color:#92400e; }
        .type-WORKSHOP     { background:#dcfce7; color:#166534; }
        .type-PANEL        { background:#dbeafe; color:#1e40af; }
        .type-PRESENTATION { background:#ede9fe; color:#5b21b6; }
        .type-BREAK        { background:#f1f5f9; color:#475569; }
        .type-OTHER        { background:#ffedd5; color:#9a3412; }

        .time-pill {
            background: #f0f9ff;
            color: #0369a1;
            border-radius: 20px;
            padding: 3px 12px;
            font-size: 0.75rem;
            font-weight: 600;
            display: inline-block;
            margin-top: 6px;
        }
        .room-tag {
            color: #64748b;
            font-size: 0.78rem;
            margin-top: 4px;
        }

        /* Speaker badge with remove */
        .speaker-badge {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            background: #dcfce7;
            color: #166534;
            border-radius: 20px;
            padding: 3px 10px;
            font-size: 0.75rem;
            font-weight: 600;
            margin: 2px;
        }
        .speaker-badge .remove-btn {
            background: none;
            border: none;
            cursor: pointer;
            padding: 0;
            line-height: 1;
            color: #166534;
            font-size: 0.65rem;
            opacity: 0.7;
            transition: opacity 0.15s;
        }
        .speaker-badge .remove-btn:hover {
            opacity: 1;
        }

        /* Assign speaker inline form */
        .assign-form {
            display: flex;
            gap: 6px;
            margin-top: 8px;
            align-items: center;
        }
        .assign-form select {
            max-width: 180px;
            font-size: 0.78rem;
            padding: 5px 8px;
            border-radius: 8px;
            border: 1.5px solid #e2e8f0;
            font-family: 'Inter', sans-serif;
        }
        .btn-assign {
            background: #f0fdf4;
            color: #166534;
            border: 1.5px solid #bbf7d0;
            border-radius: 8px;
            padding: 5px 10px;
            font-size: 0.75rem;
            font-weight: 600;
            cursor: pointer;
            font-family: 'Inter', sans-serif;
            transition: all 0.15s;
        }
        .btn-assign:hover {
            background: #dcfce7;
            border-color: #86efac;
        }

        /* Delete button */
        .btn-delete-session {
            background: none;
            border: 1.5px solid #e2e8f0;
            border-radius: 8px;
            padding: 6px 10px;
            font-size: 0.75rem;
            color: #94a3b8;
            cursor: pointer;
            transition: all 0.15s;
        }
        .btn-delete-session:hover {
            border-color: #ef4444;
            color: #ef4444;
            background: #fef2f2;
        }

        .empty-state {
            background: white;
            border-radius: 14px;
            border: 1.5px solid #e8ecf0;
            padding: 48px 24px;
            text-align: center;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<%-- Page Header --%>
<div class="page-header">
    <div class="container">
        <div style="font-size:0.8rem;
             color:rgba(255,255,255,0.7);
             margin-bottom:6px">
            <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}"
               style="color:rgba(255,255,255,0.7);
                      text-decoration:none">
                ${conf.title}
            </a>
            → Schedule
        </div>
        <div class="d-flex justify-content-between
                    align-items-start">
            <div>
                <h2 style="font-weight:800;margin:0;
                     letter-spacing:-0.02em">
                    📅 Conference Schedule
                </h2>
                <div style="color:rgba(255,255,255,0.75);
                     font-size:0.88rem;margin-top:4px">
                    Add sessions and assign speakers
                </div>
            </div>
            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}/speakers"
                   class="btn btn-light btn-sm fw-semibold">
                    🎤 Speakers
                    <c:if test="${not empty speakers}">
                        (${speakers.size()})
                    </c:if>
                </a>
                <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}"
                   class="btn btn-outline-light btn-sm">
                    ← Back
                </a>
            </div>
        </div>
    </div>
</div>

<div class="container pb-5">
    <div class="layout-wrap">

        <c:if test="${not empty success}">
            <div class="alert alert-success
                        alert-dismissible fade show mb-3">
                ✅ ${success}
                <button type="button" class="btn-close"
                        data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger
                        alert-dismissible fade show mb-3">
                ⚠️ ${error}
                <button type="button" class="btn-close"
                        data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="row g-4">

            <%-- ── Left: Add Session Form ─────────── --%>
            <div class="col-lg-4">
                <div class="add-card">
                    <div class="add-card-header">
                        ➕ Add Session
                    </div>
                    <div class="add-card-body">
                        <form action="${pageContext.request.contextPath}/organizer/conference/${conf.id}/schedule/add"
                              method="post">
                            <input type="hidden"
                                   name="${_csrf.parameterName}"
                                   value="${_csrf.token}"/>

                            <div class="mb-2">
                                <label class="form-label">
                                    Session Title *
                                </label>
                                <input type="text"
                                       name="title"
                                       class="form-control"
                                       placeholder="e.g. Opening Keynote"
                                       required/>
                            </div>

                            <div class="mb-2">
                                <label class="form-label">
                                    Session Type
                                </label>
                                <select name="sessionType"
                                        class="form-select">
                                    <option value="KEYNOTE">
                                        🌟 Keynote
                                    </option>
                                    <option value="WORKSHOP">
                                        🛠️ Workshop
                                    </option>
                                    <option value="PANEL">
                                        💬 Panel Discussion
                                    </option>
                                    <option value="PRESENTATION"
                                            selected>
                                        📊 Presentation
                                    </option>
                                    <option value="BREAK">
                                        ☕ Break / Lunch
                                    </option>
                                    <option value="OTHER">
                                        📌 Other
                                    </option>
                                </select>
                            </div>

                            <div class="mb-2">
                                <label class="form-label">
                                    Start Time *
                                </label>
                                <input type="datetime-local"
                                       name="startTime"
                                       class="form-control"
                                       required/>
                            </div>

                            <div class="mb-2">
                                <label class="form-label">
                                    End Time *
                                </label>
                                <input type="datetime-local"
                                       name="endTime"
                                       class="form-control"
                                       required/>
                            </div>

                            <div class="mb-2">
                                <label class="form-label">
                                    Room / Link
                                </label>
                                <input type="text"
                                       name="roomOrLink"
                                       class="form-control"
                                       placeholder="Hall A · Room 201 · Zoom link"/>
                            </div>

                            <div class="mb-2">
                                <label class="form-label">
                                    Capacity
                                    <span style="color:#94a3b8;
                                          font-weight:400">
                                        (optional)
                                    </span>
                                </label>
                                <input type="number"
                                       name="capacity"
                                       class="form-control"
                                       placeholder="Leave blank for unlimited"
                                       min="1"/>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">
                                    Description
                                </label>
                                <textarea name="description"
                                          class="form-control"
                                          rows="2"
                                          placeholder="Brief session description..."></textarea>
                            </div>

                            <button type="submit"
                                    class="btn-add">
                                Add to Schedule
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <%-- ── Right: Session Timeline ────────── --%>
            <div class="col-lg-8">

                <c:choose>
                    <c:when test="${empty sessions}">
                        <div class="empty-state">
                            <div style="font-size:3rem">
                                📅
                            </div>
                            <h5 class="fw-bold mt-3
                                       mb-2"
                                style="color:#0f172a">
                                No sessions yet
                            </h5>
                            <p class="text-muted small
                                       mb-0">
                                Add sessions using the
                                form on the left.
                                Then assign speakers from
                                your conference speaker
                                roster.
                            </p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div style="font-size:0.75rem;
                             font-weight:700;
                             text-transform:uppercase;
                             letter-spacing:0.06em;
                             color:#94a3b8;
                             margin-bottom:14px">
                            ${sessions.size()} session(s)
                        </div>

                        <c:forEach var="sess"
                                   items="${sessions}">
                            <div class="session-card
                                 ${sess.sessionType}">
                                <div class="session-body">
                                    <div class="d-flex
                                        justify-content-between
                                        align-items-start">

                                        <div class="flex-grow-1
                                                    pe-3">

                                            <%-- Title + type badge --%>
                                            <div class="d-flex
                                                gap-2
                                                align-items-center
                                                flex-wrap
                                                mb-1">
                                                <span style="font-weight:700;
                                                      font-size:0.95rem;
                                                      color:#0f172a">
                                                    ${sess.title}
                                                </span>
                                                <c:if test="${not empty sess.sessionType}">
                                                    <span class="type-badge
                                                        type-${sess.sessionType}">
                                                        ${sess.sessionType}
                                                    </span>
                                                </c:if>
                                            </div>

                                            <%-- Time pill --%>
                                            <div class="time-pill">
                                                🕐
                                                ${fn:replace(
                                                    sess.startTime
                                                        .toString()
                                                        .substring(0,16),
                                                    'T', '  ')}
                                                →
                                                ${fn:replace(
                                                    sess.endTime
                                                        .toString()
                                                        .substring(0,16),
                                                    'T', '  ')}
                                            </div>

                                            <%-- Room --%>
                                            <c:if test="${not empty sess.roomOrLink}">
                                                <div class="room-tag">
                                                    📍 ${sess.roomOrLink}
                                                </div>
                                            </c:if>

                                            <%-- Description --%>
                                            <c:if test="${not empty sess.description}">
                                                <p style="font-size:0.8rem;
                                                   color:#64748b;
                                                   margin:6px 0 0;
                                                   line-height:1.5">
                                                    ${sess.description}
                                                </p>
                                            </c:if>

                                            <%-- Speaker badges (assigned) --%>
                                            <c:if test="${not empty sess.speakers}">
                                                <div style="margin-top:10px">
                                                    <c:forEach var="sp"
                                                               items="${sess.speakers}">
                                                        <span class="speaker-badge">
                                                            🎤 ${sp.fullName}
                                                            <form action="${pageContext.request.contextPath}/organizer/conference/${conf.id}/schedule/${sess.id}/unassign-speaker"
                                                                  method="post"
                                                                  style="display:inline;
                                                                         margin:0">
                                                                <input type="hidden"
                                                                    name="${_csrf.parameterName}"
                                                                    value="${_csrf.token}"/>
                                                                <input type="hidden"
                                                                    name="speakerId"
                                                                    value="${sp.id}"/>
                                                                <button type="submit"
                                                                    class="remove-btn"
                                                                    onclick="return confirm('Remove ${sp.fullName} from this session?')"
                                                                    title="Remove speaker">
                                                                    ✕
                                                                </button>
                                                            </form>
                                                        </span>
                                                    </c:forEach>
                                                </div>
                                            </c:if>

                                            <%-- Assign speaker dropdown --%>
                                            <c:if test="${not empty speakers}">
                                                <form action="${pageContext.request.contextPath}/organizer/conference/${conf.id}/schedule/${sess.id}/assign-speaker"
                                                      method="post"
                                                      class="assign-form">
                                                    <input type="hidden"
                                                        name="${_csrf.parameterName}"
                                                        value="${_csrf.token}"/>
                                                    <select name="speakerId">
                                                        <option value="">
                                                            + Assign speaker...
                                                        </option>
                                                        <c:forEach var="sp"
                                                                   items="${speakers}">
                                                            <option value="${sp.id}">
                                                                ${sp.fullName}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                    <button type="submit"
                                                            class="btn-assign">
                                                        Assign
                                                    </button>
                                                </form>
                                            </c:if>

                                            <c:if test="${empty speakers}">
                                                <div style="font-size:0.75rem;
                                                     color:#94a3b8;
                                                     margin-top:8px">
                                                    <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}/speakers"
                                                       style="color:#10b981;
                                                              text-decoration:none">
                                                        + Add speakers
                                                    </a>
                                                    to assign to sessions
                                                </div>
                                            </c:if>

                                        </div>

                                        <%-- Delete session --%>
                                        <form action="${pageContext.request.contextPath}/organizer/conference/${conf.id}/schedule/${sess.id}/delete"
                                              method="post"
                                              style="flex-shrink:0">
                                            <input type="hidden"
                                                name="${_csrf.parameterName}"
                                                value="${_csrf.token}"/>
                                            <button type="submit"
                                                    class="btn-delete-session"
                                                    onclick="return confirm('Remove this session?')">
                                                ✕
                                            </button>
                                        </form>

                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                    </c:otherwise>
                </c:choose>

            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>