<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Institution Outreach - NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
</head>
<body class="bg-light">
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container py-4">

    <!-- Conference header -->
    <div class="card border-0 shadow-sm mb-4">
        <div class="card-body d-flex
                    justify-content-between
                    align-items-center">
            <div>
                <div class="text-muted small mb-1">
                    Institution Outreach for
                </div>
                <h4 class="fw-bold mb-0">
                    ${conf.title}
                </h4>
                <div class="small text-muted mt-1">
                    ${fn:substringBefore(
                        conf.startDate.toString(),'T')}
                    <c:if test="${not empty conf.city}">
                        · ${conf.city}
                    </c:if>
                </div>
            </div>
            <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}"
               class="btn btn-outline-secondary btn-sm">
                ← Back to Conference
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

        <!-- LEFT — select institutions -->
        <div class="col-lg-7">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white fw-bold
                            border-bottom d-flex
                            justify-content-between
                            align-items-center">
                    <span>📣 Send Invitations</span>
                    <span class="badge bg-primary">
                        ${fn:length(institutions)} institutions
                    </span>
                </div>
                <div class="card-body">

                    <p class="text-muted small mb-3">
                        NexMeet will send a professional
                        invitation email to each institution's
                        contact email on your behalf.
                        Institutions already contacted for this
                        conference cannot be selected again.
                    </p>

                    <c:choose>
                        <c:when test="${empty institutions}">
                            <div class="alert alert-warning">
                                No active institutions found.
                                Ask admin to add institutions first.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <form action="${pageContext.request.contextPath}/organizer/conference/${conf.id}/outreach"
                                  method="post">
                                <input type="hidden"
                                       name="${_csrf.parameterName}"
                                       value="${_csrf.token}"/>

                                <!-- Select All -->
                                <div class="mb-3">
                                    <div class="form-check">
                                        <input class="form-check-input"
                                               type="checkbox"
                                               id="selectAll"/>
                                        <label class="form-check-label
                                               fw-semibold small"
                                               for="selectAll">
                                            Select all not yet contacted
                                        </label>
                                    </div>
                                </div>

                                <div style="max-height:420px;
                                            overflow-y:auto;
                                            padding-right:4px">

                                    <c:forEach var="inst"
                                               items="${institutions}">
                                        <c:set var="alreadySent"
                                               value="${sentIds.contains(inst.id)}"/>
                                        <div class="border rounded
                                            p-3 mb-2
                                            ${alreadySent
                                                ? 'bg-light'
                                                : 'bg-white'}">
                                            <div class="d-flex
                                                        gap-3
                                                        align-items-start">
                                                <input class="form-check-input
                                                       mt-1 inst-cb"
                                                       type="checkbox"
                                                       name="institutionIds"
                                                       value="${inst.id}"
                                                       id="i${inst.id}"
                                                       ${alreadySent
                                                           ? 'disabled'
                                                           : ''}/>
                                                <label class="flex-grow-1"
                                                       for="i${inst.id}"
                                                       style="${alreadySent
                                                           ? ''
                                                           : 'cursor:pointer'}">
                                                    <div class="d-flex
                                                        justify-content-between
                                                        align-items-start">
                                                        <strong class="small">
                                                            ${inst.name}
                                                        </strong>
                                                        <div>
                                                            <span class="badge
                                                                bg-secondary
                                                                me-1
                                                                small">
                                                                ${inst.type}
                                                            </span>
                                                            <c:if test="${alreadySent}">
                                                                <span class="badge
                                                                    bg-success
                                                                    small">
                                                                    ✓ Sent
                                                                </span>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                    <div class="text-muted"
                                                         style="font-size:0.78rem;
                                                                margin-top:3px">
                                                        <c:if test="${not empty inst.city}">
                                                            📍 ${inst.city}
                                                        </c:if>
                                                        <c:choose>
                                                            <c:when test="${not empty inst.email}">
                                                                · ✉ ${inst.email}
                                                            </c:when>
                                                            <c:otherwise>
                                                                · <span class="text-warning">
                                                                    ⚠ No contact email
                                                                  </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <c:if test="${not empty inst.domains}">
                                                            · ${inst.domains}
                                                        </c:if>
                                                    </div>
                                                </label>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>

                                <button type="submit"
                                        class="btn btn-primary
                                               w-100 mt-3 fw-bold">
                                    📤 Send Invitation Emails
                                </button>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- RIGHT — history + info -->
        <div class="col-lg-5">

            <!-- Outreach History -->
            <div class="card border-0 shadow-sm mb-3">
                <div class="card-header bg-white fw-bold
                            border-bottom">
                    📋 Outreach History
                    (${fn:length(sentHistory)})
                </div>
                <div class="card-body p-0">
                    <c:choose>
                        <c:when test="${empty sentHistory}">
                            <p class="text-muted small p-3 mb-0">
                                No outreach sent yet
                                for this conference.
                            </p>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="oc"
                                       items="${sentHistory}">
                                <div class="p-3 border-bottom
                                            small">
                                    <div class="fw-semibold">
                                        ${oc.institution.name}
                                    </div>
                                    <div class="text-muted">
                                        <c:choose>
                                           <c:when test="${not empty oc.institution.email}">
                                               ✉ ${oc.institution.email}
                                           </c:when>
                                           <c:otherwise>
                                               <span class="text-warning">No email on file</span>
                                           </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="d-flex
                                        justify-content-between
                                        align-items-center
                                        mt-1">
                                        <span class="text-muted">
                                            ${fn:substringBefore(
                                                oc.contactedAt.toString(),
                                                'T')}
                                        </span>
                                        <span class="badge
                                                        ${oc.status == 'CONTACTED' ? 'bg-primary'
                                                        : oc.status == 'INTERESTED' ? 'bg-success'
                                                        : oc.status == 'NOT_INTERESTED' ? 'bg-danger'
                                                        : oc.status == 'RESPONDED' ? 'bg-info'
                                                        : 'bg-secondary'}
                                                        small">
                                                        ${oc.status}
                                        </span>
                                    </div>
                                    <c:if test="${not empty oc.notes}">
                                                <div class="text-muted mt-1"
                                                     style="font-size:0.72rem">
                                                    📝 ${oc.notes}
                                                </div>
                                    </c:if>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- How it works -->
            <div class="card border-0 shadow-sm">
                <div class="card-body small">
                    <strong>📬 How outreach works</strong>
                    <ul class="mt-2 mb-0 ps-3
                               text-muted
                               lh-lg">
                        <li>NexMeet sends email
                            from its SMTP on your behalf</li>
                        <li>Email goes to institution's
                            registered contact email</li>
                        <li>Contains conference details
                            + registration link</li>
                        <li>Each institution contacted
                            only once per conference</li>
                        <li>Institutions with no email
                            show ⚠ warning — record is
                            saved but no email sent</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
<script>
    document.getElementById('selectAll')
        .addEventListener('change', function () {
        document.querySelectorAll('.inst-cb:not(:disabled)')
            .forEach(cb => cb.checked = this.checked);
    });
</script>
</body>
</html>