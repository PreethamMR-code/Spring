<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Schedule - ${conf.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <style>
        body { background: #f0f2f5; }
        .session-card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            border-left: 5px solid #667eea;
        }
        .session-card.KEYNOTE {
            border-left-color: #f6c90e;
        }
        .session-card.WORKSHOP {
            border-left-color: #4caf50;
        }
        .session-card.PANEL {
            border-left-color: #2196f3;
        }
        .session-card.PRESENTATION {
            border-left-color: #9c27b0;
        }
        .session-card.BREAK {
            border-left-color: #9e9e9e;
        }
        .time-pill {
            background: #eef2ff;
            color: #3c4cc4;
            border-radius: 20px;
            padding: 2px 10px;
            font-size: 0.78rem;
            font-weight: 600;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container py-4">
    <div class="d-flex justify-content-between
                align-items-center mb-4">
        <div>
            <h2 class="text-success mb-0">Schedule</h2>
            <p class="text-muted mb-0">${conf.title}</p>
        </div>
        <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}/speakers"
               class="btn btn-outline-success btn-sm">
                🎤 Speakers (${speakers.size()})
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
        <%-- Add Session Form --%>
        <div class="col-md-4">
            <div class="card" style="border:none;
                 border-radius:10px;
                 box-shadow:0 2px 10px rgba(0,0,0,0.08)">
                <div class="card-header fw-bold
                             bg-success text-white">
                    ➕ Add Session
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/organizer/conference/${conf.id}/schedule/add"
                          method="post">
                        <input type="hidden"
                               name="${_csrf.parameterName}"
                               value="${_csrf.token}"/>

                        <div class="mb-2">
                            <label class="form-label
                                   small fw-semibold">
                                Session Title *
                            </label>
                            <input type="text"
                                   name="title"
                                   class="form-control
                                          form-control-sm"
                                   required/>
                        </div>

                        <div class="mb-2">
                            <label class="form-label
                                   small fw-semibold">
                                Type
                            </label>
                            <select name="sessionType"
                                    class="form-select
                                           form-select-sm">
                                <option value="KEYNOTE">
                                    🌟 Keynote
                                </option>
                                <option value="WORKSHOP">
                                    🛠 Workshop
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
                            <label class="form-label
                                   small fw-semibold">
                                Start Time *
                            </label>
                            <input type="datetime-local"
                                   name="startTime"
                                   class="form-control
                                          form-control-sm"
                                   required/>
                        </div>

                        <div class="mb-2">
                            <label class="form-label
                                   small fw-semibold">
                                End Time *
                            </label>
                            <input type="datetime-local"
                                   name="endTime"
                                   class="form-control
                                          form-control-sm"
                                   required/>
                        </div>

                        <div class="mb-2">
                            <label class="form-label
                                   small fw-semibold">
                                Room / Link
                            </label>
                            <input type="text"
                                   name="roomOrLink"
                                   class="form-control
                                          form-control-sm"
                                   placeholder="Hall A / Zoom link"/>
                        </div>

                        <div class="mb-2">
                            <label class="form-label
                                   small fw-semibold">
                                Capacity
                                <span class="text-muted
                                      fw-normal">(optional)</span>
                            </label>
                            <input type="number"
                                   name="capacity"
                                   class="form-control
                                          form-control-sm"
                                   min="1"/>
                        </div>

                        <div class="mb-3">
                            <label class="form-label
                                   small fw-semibold">
                                Description
                            </label>
                            <textarea name="description"
                                      class="form-control
                                             form-control-sm"
                                      rows="2"></textarea>
                        </div>

                        <button type="submit"
                                class="btn btn-success
                                       w-100 btn-sm">
                            Add to Schedule
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <%-- Schedule Timeline --%>
        <div class="col-md-8">
            <c:choose>
                <c:when test="${empty sessions}">
                    <div class="card" style="border:none;
                         border-radius:10px;
                         box-shadow:0 2px 8px rgba(0,0,0,0.08)">
                        <div class="card-body text-center
                                    py-5 text-muted">
                            <div style="font-size:3rem">
                                📅
                            </div>
                            <h5 class="mt-2">
                                No sessions yet
                            </h5>
                            <p class="small">
                                Add sessions to build your
                                conference agenda.
                                Then assign speakers to each
                                session.
                            </p>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="sess" items="${sessions}">
                        <div class="card session-card
                             ${sess.sessionType} mb-3">
                            <div class="card-body py-3">
                                <div class="d-flex
                                    justify-content-between
                                    align-items-start">
                                    <div class="flex-grow-1">

                                        <%-- Title + Type --%>
                                        <div class="d-flex
                                            gap-2
                                            align-items-center
                                            mb-1 flex-wrap">
                                            <span class="fw-bold">
                                                ${sess.title}
                                            </span>
                                            <c:if test="${not empty sess.sessionType}">
                                                <span class="badge bg-light text-dark border small">
                                                    ${sess.sessionType}
                                                </span>
                                            </c:if>
                                        </div>

                                        <%-- Time --%>
                                        <div class="time-pill d-inline-block mb-2">
                                            🕐
                                            ${fn:replace(
                                                sess.startTime.toString().substring(0,16),
                                                'T', ' ')}
                                            →
                                            ${fn:replace(
                                                sess.endTime.toString().substring(0,16),
                                                'T', ' ')}
                                        </div>

                                        <%-- Room --%>
                                        <c:if test="${not empty sess.roomOrLink}">
                                            <div class="small text-muted">
                                                📍 ${sess.roomOrLink}
                                            </div>
                                        </c:if>

                                        <%-- Assigned speakers --%>
                                        <c:if test="${not empty sess.speakers}">
                                            <div class="mt-1">
                                                <c:forEach
                                                    var="sp"
                                                    items="${sess.speakers}">
                                                    <span class="badge bg-success small">
                                                        🎤
                                                        ${sp.fullName}
                                                    </span>
                                                </c:forEach>
                                            </div>
                                        </c:if>

                                        <%-- Assign speaker form --%>
                                        <c:if test="${not empty speakers}">
                                            <div class="mt-2">
                                                <form action="${pageContext.request.contextPath}/organizer/conference/${conf.id}/schedule/${sess.id}/assign-speaker"
                                                      method="post"
                                                      class="d-flex gap-1">
                                                    <input type="hidden"
                                                        name="${_csrf.parameterName}"
                                                        value="${_csrf.token}"/>
                                                    <select
                                                        name="speakerId"
                                                        class="form-select form-select-sm"
                                                        style="max-width:180px">
                                                        <option value="">
                                                            Assign speaker...
                                                        </option>
                                                        <c:forEach
                                                            var="sp"
                                                            items="${speakers}">
                                                            <option value="${sp.id}">
                                                                ${sp.fullName}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                    <button type="submit"
                                                            class="btn btn-outline-success btn-sm">
                                                        Assign
                                                    </button>
                                                </form>
                                            </div>
                                        </c:if>

                                        <%-- Description --%>
                                        <c:if test="${not empty sess.description}">
                                            <p class="small text-muted mb-0 mt-1">
                                                ${sess.description}
                                            </p>
                                        </c:if>
                                    </div>

                                    <%-- Delete button --%>
                                    <form action="${pageContext.request.contextPath}/organizer/conference/${conf.id}/schedule/${sess.id}/delete"
                                          method="post"
                                          class="ms-2">
                                        <input type="hidden"
                                            name="${_csrf.parameterName}"
                                            value="${_csrf.token}"/>
                                        <button type="submit"
                                            class="btn btn-outline-danger btn-sm"
                                            onclick="return confirm('Remove session?')">
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>