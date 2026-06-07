<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1"/>
    <title>Speakers – ${conf.title}</title>
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

        /* ── Add Speaker Form ──────────────────── */
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
        .form-control {
            border: 1.5px solid #e2e8f0;
            border-radius: 8px;
            padding: 8px 12px;
            font-size: 0.85rem;
            font-family: 'Inter', sans-serif;
            background: #fafbfc;
        }
        .form-control:focus {
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

        /* ── Speaker Cards ─────────────────────── */
        .speaker-card {
            background: white;
            border-radius: 14px;
            border: 1.5px solid #e8ecf0;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            transition: transform 0.15s,
                        box-shadow 0.15s;
            height: 100%;
        }
        .speaker-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px
                rgba(0,0,0,0.09);
        }
        .avatar {
            width: 52px;
            height: 52px;
            border-radius: 50%;
            background: linear-gradient(135deg,
                #667eea, #764ba2);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3rem;
            font-weight: 800;
            flex-shrink: 0;
        }
        .speaker-name {
            font-weight: 700;
            color: #0f172a;
            font-size: 0.95rem;
        }
        .speaker-meta {
            font-size: 0.78rem;
            color: #64748b;
            margin-top: 2px;
        }
        .session-tag {
            display: inline-block;
            background: #dbeafe;
            color: #1e40af;
            border-radius: 6px;
            padding: 2px 8px;
            font-size: 0.72rem;
            font-weight: 600;
            margin: 2px;
        }
        .bio-text {
            font-size: 0.78rem;
            color: #64748b;
            line-height: 1.5;
            margin-top: 8px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .linkedin-link {
            font-size: 0.75rem;
            color: #0077b5;
            text-decoration: none;
            font-weight: 600;
        }
        .linkedin-link:hover {
            text-decoration: underline;
        }
        .btn-remove {
            background: none;
            border: 1.5px solid #e2e8f0;
            border-radius: 8px;
            padding: 4px 8px;
            font-size: 0.72rem;
            color: #94a3b8;
            cursor: pointer;
            transition: all 0.15s;
        }
        .btn-remove:hover {
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
        .not-assigned {
            font-size: 0.75rem;
            color: #94a3b8;
            font-style: italic;
            margin-top: 6px;
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
            → Speakers
        </div>
        <div class="d-flex justify-content-between
                    align-items-start">
            <div>
                <h2 style="font-weight:800;margin:0;
                     letter-spacing:-0.02em">
                    🎤 Conference Speakers
                </h2>
                <div style="color:rgba(255,255,255,0.75);
                     font-size:0.88rem;margin-top:4px">
                    Add speakers, then assign them
                    to sessions in the schedule.
                </div>
            </div>
            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}/schedule"
                   class="btn btn-light btn-sm fw-semibold">
                    📅 Schedule
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

            <%-- ── Left: Add Speaker Form ─────────── --%>
            <div class="col-lg-4">
                <div class="add-card">
                    <div class="add-card-header">
                        ➕ Add Speaker
                    </div>
                    <div class="add-card-body">
                        <form action="${pageContext.request.contextPath}/organizer/conference/${conf.id}/speakers/add"
                              method="post">
                            <input type="hidden"
                                   name="${_csrf.parameterName}"
                                   value="${_csrf.token}"/>

                            <div class="mb-2">
                                <label class="form-label">
                                    Full Name *
                                </label>
                                <input type="text"
                                       name="fullName"
                                       class="form-control"
                                       placeholder="e.g. Rohan Mehta"
                                       required/>
                            </div>

                            <div class="mb-2">
                                <label class="form-label">
                                    Designation
                                </label>
                                <input type="text"
                                       name="designation"
                                       class="form-control"
                                       placeholder="CEO · Professor · Founder"/>
                            </div>

                            <div class="mb-2">
                                <label class="form-label">
                                    Organization
                                </label>
                                <input type="text"
                                       name="organization"
                                       class="form-control"
                                       placeholder="Company or institution"/>
                            </div>

                            <div class="mb-2">
                                <label class="form-label">
                                    Email
                                </label>
                                <input type="email"
                                       name="email"
                                       class="form-control"
                                       placeholder="speaker@org.com"/>
                            </div>

                            <div class="mb-2">
                                <label class="form-label">
                                    LinkedIn URL
                                </label>
                                <input type="text"
                                       name="linkedinUrl"
                                       class="form-control"
                                       placeholder="https://linkedin.com/in/..."/>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">
                                    Bio
                                </label>
                                <textarea name="bio"
                                          class="form-control"
                                          rows="3"
                                          placeholder="Brief speaker biography (1-2 sentences)..."></textarea>
                            </div>

                            <button type="submit"
                                    class="btn-add">
                                Add Speaker
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <%-- ── Right: Speakers Grid ───────────── --%>
            <div class="col-lg-8">

                <c:choose>
                    <c:when test="${empty speakers}">
                        <div class="empty-state">
                            <div style="font-size:3rem">
                                🎤
                            </div>
                            <h5 class="fw-bold mt-3 mb-2"
                                style="color:#0f172a">
                                No speakers yet
                            </h5>
                            <p class="text-muted small mb-0">
                                Add speakers using the form.
                                Once added, you can assign them
                                to specific sessions in the
                                Schedule page.
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
                            ${speakers.size()} speaker(s)
                        </div>

                        <div class="row g-3">
                        <c:forEach var="sp"
                                   items="${speakers}">
                            <div class="col-md-6">
                                <div class="speaker-card">
                                    <div class="d-flex
                                        gap-3
                                        align-items-start">

                                        <%-- Avatar --%>
                                        <div class="avatar">
                                            ${fn:substring(
                                                sp.fullName,
                                                0, 1)}
                                        </div>

                                        <div class="flex-grow-1
                                                    min-width-0">

                                            <%-- Name + Delete --%>
                                            <div class="d-flex
                                                justify-content-between
                                                align-items-start
                                                gap-2">
                                                <div class="speaker-name">
                                                    ${sp.fullName}
                                                </div>
                                                <form action="${pageContext.request.contextPath}/organizer/conference/${conf.id}/speakers/${sp.id}/delete"
                                                      method="post"
                                                      style="flex-shrink:0">
                                                    <input type="hidden"
                                                        name="${_csrf.parameterName}"
                                                        value="${_csrf.token}"/>
                                                    <button type="submit"
                                                            class="btn-remove"
                                                            onclick="return confirm('Remove ${sp.fullName} from this conference?')">
                                                        ✕
                                                    </button>
                                                </form>
                                            </div>

                                            <%-- Designation + Org --%>
                                            <c:if test="${not empty sp.designation
                                                          || not empty sp.organization}">
                                                <div class="speaker-meta">
                                                    ${sp.designation}
                                                    <c:if test="${not empty sp.designation
                                                                  && not empty sp.organization}">
                                                        ·
                                                    </c:if>
                                                    ${sp.organization}
                                                </div>
                                            </c:if>

                                            <%-- LinkedIn --%>
                                            <c:if test="${not empty sp.linkedinUrl}">
                                                <div style="margin-top:4px">
                                                    <a href="${sp.linkedinUrl}"
                                                       target="_blank"
                                                       class="linkedin-link">
                                                        🔗 LinkedIn ↗
                                                    </a>
                                                </div>
                                            </c:if>

                                            <%--
                                                Session assignments.
                                                Accessing sp.sessions triggers
                                                lazy load — safe because
                                                SessionService loads with JOIN
                                                or we're in an open session.
                                            --%>
                                            <c:choose>
                                                <c:when test="${not empty sp.sessions}">
                                                    <div style="margin-top:8px">
                                                        <c:forEach var="sess"
                                                                   items="${sp.sessions}">
                                                            <span class="session-tag">
                                                                📅 ${sess.title}
                                                            </span>
                                                        </c:forEach>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="not-assigned">
                                                        Not yet assigned to a session.
                                                        <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}/schedule"
                                                           style="color:#10b981;
                                                                  text-decoration:none;
                                                                  font-style:normal">
                                                            Assign →
                                                        </a>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>

                                            <%-- Bio --%>
                                            <c:if test="${not empty sp.bio}">
                                                <p class="bio-text">
                                                    ${sp.bio}
                                                </p>
                                            </c:if>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        </div>

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