<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Speakers - ${conf.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <style>
        body { background: #f0f2f5; }
        .speaker-card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            transition: transform 0.15s;
        }
        .speaker-card:hover { transform: translateY(-2px); }
        .avatar {
            width: 56px; height: 56px;
            border-radius: 50%;
            background: linear-gradient(
                135deg, #667eea, #764ba2);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.4rem;
            font-weight: bold;
            flex-shrink: 0;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container py-4">
    <div class="d-flex justify-content-between
                align-items-center mb-4">
        <div>
            <h2 class="text-success mb-0">Speakers</h2>
            <p class="text-muted mb-0">${conf.title}</p>
        </div>
        <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}/schedule"
               class="btn btn-outline-info btn-sm">
                📅 Schedule
            </a>
            <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}"
               class="btn btn-outline-secondary btn-sm">
                Back
            </a>
        </div>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="row g-4">
        <%-- Add Speaker Form --%>
        <div class="col-md-4">
            <div class="card" style="border:none;
                 border-radius:10px;
                 box-shadow:0 2px 10px rgba(0,0,0,0.08)">
                <div class="card-header fw-bold
                             bg-success text-white">
                    ➕ Add Speaker
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/organizer/conference/${conf.id}/speakers/add"
                          method="post">
                        <input type="hidden"
                               name="${_csrf.parameterName}"
                               value="${_csrf.token}"/>

                        <div class="mb-2">
                            <label class="form-label
                                   small fw-semibold">
                                Full Name *
                            </label>
                            <input type="text"
                                   name="fullName"
                                   class="form-control
                                          form-control-sm"
                                   required/>
                        </div>
                        <div class="mb-2">
                            <label class="form-label
                                   small fw-semibold">
                                Designation
                            </label>
                            <input type="text"
                                   name="designation"
                                   class="form-control
                                          form-control-sm"
                                   placeholder="CEO, Professor"/>
                        </div>
                        <div class="mb-2">
                            <label class="form-label
                                   small fw-semibold">
                                Organization
                            </label>
                            <input type="text"
                                   name="organization"
                                   class="form-control
                                          form-control-sm"/>
                        </div>
                        <div class="mb-2">
                            <label class="form-label
                                   small fw-semibold">
                                Email
                            </label>
                            <input type="email"
                                   name="email"
                                   class="form-control
                                          form-control-sm"/>
                        </div>
                        <div class="mb-2">
                            <label class="form-label
                                   small fw-semibold">
                                LinkedIn URL
                            </label>
                            <input type="text"
                                   name="linkedinUrl"
                                   class="form-control
                                          form-control-sm"
                                   placeholder="https://linkedin.com/in/..."/>
                        </div>
                        <div class="mb-3">
                            <label class="form-label
                                   small fw-semibold">
                                Bio
                            </label>
                            <textarea name="bio"
                                      class="form-control
                                             form-control-sm"
                                      rows="3"
                                      placeholder="Brief speaker bio..."></textarea>
                        </div>
                        <button type="submit"
                                class="btn btn-success
                                       w-100 btn-sm">
                            Add Speaker
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <%-- Speakers List --%>
        <div class="col-md-8">
            <c:choose>
                <c:when test="${empty speakers}">
                    <div class="card" style="border:none;
                         border-radius:10px;
                         box-shadow:0 2px 8px rgba(0,0,0,0.08)">
                        <div class="card-body text-center
                                    py-5 text-muted">
                            <div style="font-size:3rem">
                                🎤
                            </div>
                            <h5 class="mt-2">
                                No speakers yet
                            </h5>
                            <p class="small">
                                Add speakers to your conference.
                                You can assign them to sessions
                                in the Schedule page.
                            </p>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row g-3">
                        <c:forEach var="sp"
                                   items="${speakers}">
                            <div class="col-md-6">
                                <div class="card
                                            speaker-card h-100">
                                    <div class="card-body">
                                        <div class="d-flex
                                            gap-3 align-items-start">
                                            <div class="avatar">
                                                ${sp.fullName.substring(0,1)}
                                            </div>
                                            <div class="flex-grow-1">
                                                <div class="d-flex
                                                    justify-content-between">
                                                    <strong>
                                                        ${sp.fullName}
                                                    </strong>
                                                    <form action="${pageContext.request.contextPath}/organizer/conference/${conf.id}/speakers/${sp.id}/delete"
                                                          method="post"
                                                          class="d-inline">
                                                        <input type="hidden"
                                                            name="${_csrf.parameterName}"
                                                            value="${_csrf.token}"/>
                                                        <button
                                                            type="submit"
                                                            class="btn btn-outline-danger btn-sm py-0"
                                                            onclick="return confirm('Remove speaker?')">
                                                            ✕
                                                        </button>
                                                    </form>
                                                </div>
                                                <c:if test="${not empty sp.designation}">
                                                    <div class="small text-muted">
                                                        ${sp.designation}
                                                        <c:if test="${not empty sp.organization}">
                                                            ,
                                                            ${sp.organization}
                                                        </c:if>
                                                    </div>
                                                </c:if>
                                                <c:if test="${sp.session != null}">
                                                    <div class="small mt-1">
                                                        <span class="badge bg-info text-dark">
                                                            📅
                                                            ${sp.session.title}
                                                        </span>
                                                    </div>
                                                </c:if>
                                                <c:if test="${sp.session == null}">
                                                    <div class="small text-muted mt-1">
                                                        Conference speaker
                                                        (not assigned to session)
                                                    </div>
                                                </c:if>
                                                <c:if test="${not empty sp.linkedinUrl}">
                                                    <a href="${sp.linkedinUrl}"
                                                       target="_blank"
                                                       class="small text-primary">
                                                        LinkedIn ↗
                                                    </a>
                                                </c:if>
                                                <c:if test="${not empty sp.bio}">
                                                    <p class="small text-muted mt-1 mb-0">
                                                        ${sp.bio}
                                                    </p>
                                                </c:if>
                                            </div>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>