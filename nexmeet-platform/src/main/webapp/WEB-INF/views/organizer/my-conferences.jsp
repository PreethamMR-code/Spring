<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Conferences – NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <style>
        body { background: #f0f2f5; }
        .inv-pending {
            background:#fef3c7;color:#92400e;
            border:1px solid #fde68a;
            border-radius:5px;padding:2px 7px;
            font-size:0.68rem;font-weight:700;
            white-space:nowrap;display:inline-block;
        }
        .inv-paid {
            background:#dcfce7;color:#166534;
            border:1px solid #bbf7d0;
            border-radius:5px;padding:2px 7px;
            font-size:0.68rem;font-weight:700;
            white-space:nowrap;display:inline-block;
        }
        .inv-waived {
            background:#f1f5f9;color:#475569;
            border:1px solid #e2e8f0;
            border-radius:5px;padding:2px 7px;
            font-size:0.68rem;font-weight:700;
            white-space:nowrap;display:inline-block;
        }
        .inv-none {
            color:#94a3b8;font-size:0.68rem;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container py-4">

    <div class="d-flex justify-content-between
                align-items-center mb-4">
        <h2 class="text-success mb-0">
            My Conferences
        </h2>
        <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/organizer/invoices"
               class="btn btn-outline-warning btn-sm">
                🧾 My Invoices
            </a>
            <a href="${pageContext.request.contextPath}/organizer/conference/create"
               class="btn btn-success btn-sm">
                + Create New
            </a>
            <a href="${pageContext.request.contextPath}/organizer/dashboard"
               class="btn btn-outline-secondary btn-sm">
                Dashboard
            </a>
        </div>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success
                    alert-dismissible fade show">
            ${success}
            <button type="button" class="btn-close"
                    data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger
                    alert-dismissible fade show">
            ${error}
            <button type="button" class="btn-close"
                    data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:choose>
        <c:when test="${empty conferences}">
            <div class="card p-5 text-center
                        border-0 shadow-sm">
                <div style="font-size:3rem">📋</div>
                <h5 class="text-muted mt-3">
                    No conferences yet.
                </h5>
                <a href="${pageContext.request.contextPath}/organizer/conference/create"
                   class="btn btn-success mt-3">
                    Create Your First Conference
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="card border-0 shadow-sm">
                <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead style="background:#f0fdf4">
                        <tr>
                            <th class="ps-3">Title</th>
                            <th>Type</th>
                            <th>Mode</th>
                            <th>Start Date</th>
                            <th>Registered</th>
                            <th>Fee</th>
                            <th>Status</th>
                            <%--
                                Invoice column:
                                Shows commission invoice
                                status for COMPLETED
                                paid conferences.
                                Empty for others.
                            --%>
                            <th>Invoice</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="conf"
                               items="${conferences}">
                        <c:set var="inv"
                               value="${invoiceMap[conf.id]}"/>
                        <tr>
                            <td class="ps-3 fw-semibold">
                                ${conf.title}
                            </td>
                            <td class="text-muted small">
                                ${conf.conferenceType}
                            </td>
                            <td class="text-muted small">
                                ${conf.mode}
                            </td>
                            <td class="text-muted small">
                                ${fn:substringBefore(
                                    conf.startDate
                                        .toString(),'T')}
                            </td>
                            <td class="text-center">
                                ${conf.registeredCount}
                                /
                                ${conf.maxDelegates}
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${conf.free}">
                                        <span class="badge
                                              bg-success">
                                            Free
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="fw-semibold
                                              small">
                                            ₹${conf.delegateFee}
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${conf.status == 'DRAFT'}">
                                        <span class="badge bg-secondary">
                                            DRAFT
                                        </span>
                                    </c:when>
                                    <c:when test="${conf.status == 'SUBMITTED'}">
                                        <span class="badge bg-warning text-dark">
                                            PENDING
                                        </span>
                                    </c:when>
                                    <c:when test="${conf.status == 'APPROVED'}">
                                        <span class="badge bg-success">
                                            APPROVED
                                        </span>
                                    </c:when>
                                    <c:when test="${conf.status == 'REJECTED'}">
                                        <span class="badge bg-danger">
                                            REJECTED
                                        </span>
                                    </c:when>
                                    <c:when test="${conf.status == 'COMPLETED'}">
                                        <span class="badge bg-dark">
                                            COMPLETED
                                        </span>
                                    </c:when>
                                    <c:when test="${conf.status == 'CANCELLED'}">
                                        <span class="badge bg-danger">
                                            CANCELLED
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">
                                            ${conf.status}
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <%-- Invoice status column --%>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty inv
                                        && inv.status == 'PENDING'}">
                                        <span class="inv-pending">
                                            ⏳ ₹${inv.totalAmount}
                                        </span>
                                        <div style="font-size:0.62rem;
                                             color:#b45309;
                                             margin-top:2px">
                                            Due
                                        </div>
                                    </c:when>
                                    <c:when test="${not empty inv
                                        && inv.status == 'PAID'}">
                                        <span class="inv-paid">
                                            ✅ Paid
                                        </span>
                                    </c:when>
                                    <c:when test="${not empty inv
                                        && inv.status == 'WAIVED'}">
                                        <span class="inv-waived">
                                            Waived
                                        </span>
                                    </c:when>
                                    <c:when test="${conf.status == 'COMPLETED'
                                        && !conf.free}">
                                        <span class="inv-none">
                                            Not generated
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted"
                                              style="font-size:0.72rem">
                                            —
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td>
                                <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}"
                                   class="btn btn-outline-success
                                          btn-sm">
                                    View
                                </a>
                                <c:if test="${conf.status == 'APPROVED'}">
                                    <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}/delegates"
                                       class="btn btn-outline-primary
                                              btn-sm ms-1">
                                        Delegates
                                    </a>
                                    <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}/attendance"
                                       class="btn btn-outline-success
                                              btn-sm ms-1">
                                        Attendance
                                    </a>
                                </c:if>
                                <c:if test="${conf.status == 'DRAFT'
                                    || conf.status == 'REJECTED'}">
                                    <%--
                                        Direct submit — POST to new quick-submit endpoint.
                                        Organizer no longer needs to open the edit form
                                        just to submit a conference for approval.
                                    --%>
                                    <form action="${pageContext.request.contextPath}/organizer/conference/${conf.id}/submit"
                                          method="post"
                                          class="d-inline ms-1">
                                        <input type="hidden"
                                               name="${_csrf.parameterName}"
                                               value="${_csrf.token}"/>
                                        <button type="submit"
                                                class="btn btn-success btn-sm"
                                                onclick="return confirm('Submit \'${conf.title}\' for admin approval?')">
                                            ✅ Submit
                                        </button>
                                    </form>
                                    <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}/edit"
                                       class="btn btn-outline-warning btn-sm ms-1">
                                        Edit
                                    </a>
                                </c:if>
                                <c:if test="${conf.status == 'REJECTED'}">
                                    <div class="text-danger"
                                         style="font-size:0.72rem;margin-top:4px;
                                                max-width:160px">
                                        ↳ ${conf.rejectionReason}
                                    </div>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>