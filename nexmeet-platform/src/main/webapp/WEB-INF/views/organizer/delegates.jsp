<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delegates – ${conf.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <style>
        body { background: #f0f2f5; }
        .pay-badge-venue {
            background: #fef3c7;
            color: #92400e;
            border: 1px solid #fde68a;
            border-radius: 6px;
            padding: 2px 8px;
            font-size: 0.72rem;
            font-weight: 600;
            white-space: nowrap;
        }
        .pay-badge-confirmed {
            background: #dcfce7;
            color: #166534;
            border: 1px solid #bbf7d0;
            border-radius: 6px;
            padding: 2px 8px;
            font-size: 0.72rem;
            font-weight: 600;
            white-space: nowrap;
        }
        .pay-badge-free {
            background: #f0fdf4;
            color: #15803d;
            border: 1px solid #bbf7d0;
            border-radius: 6px;
            padding: 2px 8px;
            font-size: 0.72rem;
            font-weight: 600;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container py-4">

    <%-- Page header --%>
    <div class="d-flex justify-content-between
                align-items-start mb-4 flex-wrap gap-2">
        <div>
            <h2 class="text-success mb-1">
                Registered Delegates
            </h2>
            <p class="text-muted mb-0">${conf.title}</p>
            <small class="text-muted">
                ${fn:substringBefore(
                    conf.startDate.toString(),'T')}
                |
                <c:choose>
                    <c:when test="${not empty conf.city}">
                        ${conf.city}, ${conf.state}
                    </c:when>
                    <c:otherwise>Online</c:otherwise>
                </c:choose>
                | Mode: ${conf.mode}
            </small>
        </div>
        <div class="d-flex gap-2 flex-wrap">
            <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}/attendance"
               class="btn btn-success btn-sm">
                📋 Attendance
            </a>
            <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}/delegates/export?format=excel"
               class="btn btn-outline-success btn-sm">
                📥 Excel
            </a>
            <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}/delegates/export?format=csv"
               class="btn btn-outline-secondary btn-sm">
                📄 CSV
            </a>
            <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}"
               class="btn btn-outline-secondary btn-sm">
                ← Back
            </a>
        </div>
    </div>

    <%-- Flash messages --%>
    <c:if test="${not empty success}">
        <div class="alert alert-success
                    alert-dismissible fade show">
            ✅ ${success}
            <button type="button" class="btn-close"
                    data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger
                    alert-dismissible fade show">
            ❌ ${error}
            <button type="button" class="btn-close"
                    data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <%-- Venue payment info banner --%>
    <c:if test="${venuePaymentApplicable}">
        <div class="alert mb-3"
             style="background:#fff7ed;
                    border:1.5px solid #fed7aa;
                    border-radius:10px">
            <div class="d-flex align-items-start gap-2">
                <span style="font-size:1.2rem">🏛️</span>
                <div>
                    <strong style="color:#9a3412">
                        Offline Payment Mode
                    </strong>
                    <div class="small mt-1"
                         style="color:#c2410c">
                        Delegates pay ₹${conf.delegateFee}
                        at the venue (cash/UPI).
                        Use the
                        <strong>Mark Paid</strong>
                        button on each row after
                        you collect payment.
                        The delegate's dashboard will
                        update immediately.
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    <%-- Stats --%>
    <div class="row g-3 mb-4">
        <div class="col-6 col-md-3">
            <div class="card text-center p-3 h-100"
                 style="border:none;border-radius:12px;
                        box-shadow:0 2px 8px rgba(0,0,0,0.07);
                        border-left:4px solid #3b82f6 !important">
                <div class="text-muted small">Total Registered</div>
                <div style="font-size:2rem;font-weight:800;
                     color:#3b82f6">
                    ${registrations.size()}
                </div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="card text-center p-3 h-100"
                 style="border:none;border-radius:12px;
                        box-shadow:0 2px 8px rgba(0,0,0,0.07);
                        border-left:4px solid #22c55e !important">
                <div class="text-muted small">Confirmed</div>
                <div style="font-size:2rem;font-weight:800;
                     color:#22c55e">
                    ${confirmedCount}
                </div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="card text-center p-3 h-100"
                 style="border:none;border-radius:12px;
                        box-shadow:0 2px 8px rgba(0,0,0,0.07);
                        border-left:4px solid #ef4444 !important">
                <div class="text-muted small">Cancelled</div>
                <div style="font-size:2rem;font-weight:800;
                     color:#ef4444">
                    ${cancelledCount}
                </div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="card text-center p-3 h-100"
                 style="border:none;border-radius:12px;
                        box-shadow:0 2px 8px rgba(0,0,0,0.07);
                        border-left:4px solid #f59e0b !important">
                <div class="text-muted small">Seats Left</div>
                <div style="font-size:2rem;font-weight:800;
                     color:#f59e0b">
                    ${conf.maxDelegates - conf.registeredCount}
                </div>
            </div>
        </div>
    </div>

    <%-- Delegates Table --%>
    <div class="card"
         style="border:none;border-radius:14px;
                box-shadow:0 2px 12px rgba(0,0,0,0.09)">
        <div class="card-header fw-bold bg-white
                    d-flex justify-content-between
                    align-items-center"
             style="border-radius:14px 14px 0 0">
            <span>Delegate List</span>
            <span class="text-muted small fw-normal">
                ${conf.registeredCount}
                / ${conf.maxDelegates} seats filled
            </span>
        </div>
        <div class="card-body p-0">
            <c:choose>
                <c:when test="${empty registrations}">
                    <div class="text-center py-5
                                text-muted">
                        <div style="font-size:3rem">
                            👥
                        </div>
                        <div class="mt-2">
                            No delegates registered yet.
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                    <table class="table table-hover
                                  mb-0 small">
                        <thead
                            style="background:#f0fdf4">
                            <tr>
                                <th class="ps-3">#</th>
                                <th>Reg. Number</th>
                                <th>Full Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Organization</th>
                                <th>Designation</th>
                                <th>Registered On</th>
                                <th>Status</th>
                                <%--
                                    Payment column:
                                    shown for all conferences.
                                    Content differs based on
                                    free/paid and mode.
                                --%>
                                <th>💳 Payment</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="reg"
                                   items="${registrations}"
                                   varStatus="s">
                            <c:set var="pay"
                                   value="${paymentMap[reg.id]}"/>
                            <tr class="${reg.status == 'CANCELLED'
                                ? 'table-secondary' : ''}">

                                <td class="ps-3 text-muted">
                                    ${s.count}
                                </td>
                                <td>
                                    <code style="font-size:
                                                 0.78rem">
                                        ${reg.registrationNumber}
                                    </code>
                                </td>
                                <td class="fw-semibold">
                                    ${reg.user.fullName}
                                </td>
                                <td>
                                    <a href="mailto:${reg.user.email}"
                                       class="text-decoration-none
                                              text-muted">
                                        ${reg.user.email}
                                    </a>
                                </td>
                                <td class="text-muted">
                                    <c:choose>
                                        <c:when test="${not empty reg.user.phone}">
                                            ${reg.user.phone}
                                        </c:when>
                                        <c:otherwise>—</c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-muted">
                                    <c:choose>
                                        <c:when test="${not empty reg.user.delegate.organization}">
                                            ${reg.user.delegate.organization}
                                        </c:when>
                                        <c:otherwise>—</c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-muted">
                                    <c:choose>
                                        <c:when test="${not empty reg.user.delegate.designation}">
                                            ${reg.user.delegate.designation}
                                        </c:when>
                                        <c:otherwise>—</c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-muted">
                                    ${fn:substringBefore(
                                        reg.registeredAt
                                            .toString(),'T')}
                                </td>
                                <td>
                                    <span class="badge
                                        ${reg.status == 'CONFIRMED'
                                            ? 'bg-success'
                                            : 'bg-secondary'}">
                                        ${reg.status}
                                    </span>
                                </td>

                                <%-- ── PAYMENT COLUMN ─────────────── --%>
                                <td style="min-width:140px">
                                    <c:choose>

                                        <%-- CANCELLED: no payment needed --%>
                                        <c:when test="${reg.status == 'CANCELLED'}">
                                            <span class="text-muted">—</span>
                                        </c:when>

                                        <%-- FREE CONFERENCE --%>
                                        <c:when test="${conf.free}">
                                            <span class="pay-badge-free">
                                                Free
                                            </span>
                                        </c:when>

                                        <%--
                                            VENUE PAYMENT CONFIRMED:
                                            Organizer already marked paid.
                                            paymentMethod = VENUE_CASH or
                                            VENUE_UPI
                                        --%>
                                        <c:when test="${not empty pay
                                            && (pay.paymentMethod == 'VENUE_CASH'
                                               || pay.paymentMethod == 'VENUE_UPI')}">
                                            <span class="pay-badge-confirmed">
                                                ✅ Paid at Venue
                                            </span>
                                            <div class="text-muted mt-1"
                                                 style="font-size:0.65rem">
                                                ₹${pay.amount}
                                                ·
                                                ${pay.paymentMethod == 'VENUE_CASH'
                                                    ? 'Cash' : 'UPI'}
                                            </div>
                                            <c:if test="${not empty pay.transactionRef
                                                && !pay.transactionRef.startsWith('SIM-')}">
                                                <div style="font-size:0.62rem;
                                                     color:#94a3b8">
                                                    Ref: ${pay.transactionRef}
                                                </div>
                                            </c:if>
                                        </c:when>

                                        <%--
                                            VENUE APPLICABLE + NOT YET PAID:
                                            Show "Pay at Venue" badge +
                                            "Mark Paid" button.
                                            Condition:
                                              - OFFLINE or HYBRID mode
                                              - payment exists but is SIMULATED
                                                OR no payment record yet
                                        --%>
                                        <c:when test="${venuePaymentApplicable
                                            && reg.status == 'CONFIRMED'}">
                                            <span class="pay-badge-venue">
                                                🏛️ Pending
                                            </span>
                                            <div class="text-muted"
                                                 style="font-size:0.65rem;
                                                        margin-top:2px">
                                                ₹${conf.delegateFee} due
                                            </div>
                                            <%-- Mark Paid button --%>
                                            <button type="button"
                                                    class="btn btn-outline-success
                                                           btn-sm mt-1 fw-semibold"
                                                    style="font-size:0.7rem;
                                                           padding:3px 10px"
                                                    data-bs-toggle="modal"
                                                    data-bs-target="#payModal${reg.id}">
                                                ✓ Mark Paid
                                            </button>

                                            <%--
                                                Mark Payment Modal.
                                                One modal per row — unique ID
                                                via reg.id prevents conflicts.
                                            --%>
                                            <div class="modal fade"
                                                 id="payModal${reg.id}"
                                                 tabindex="-1">
                                                <div class="modal-dialog
                                                            modal-dialog-centered">
                                                    <div class="modal-content">
                                                        <div class="modal-header
                                                                    bg-success text-white">
                                                            <h5 class="modal-title
                                                                        fw-bold">
                                                                Confirm Payment Received
                                                            </h5>
                                                            <button type="button"
                                                                    class="btn-close
                                                                           btn-close-white"
                                                                    data-bs-dismiss="modal">
                                                            </button>
                                                        </div>
                                                        <form action="${pageContext.request.contextPath}/organizer/conference/${conf.id}/delegates/${reg.id}/mark-payment"
                                                              method="post">
                                                            <input type="hidden"
                                                                   name="${_csrf.parameterName}"
                                                                   value="${_csrf.token}"/>
                                                            <div class="modal-body">

                                                                <%-- Delegate info summary --%>
                                                                <div class="alert alert-light
                                                                            border mb-3">
                                                                    <div class="fw-semibold">
                                                                        ${reg.user.fullName}
                                                                    </div>
                                                                    <div class="text-muted small">
                                                                        ${reg.user.email}
                                                                    </div>
                                                                    <div class="small mt-1">
                                                                        Reg:
                                                                        <code>
                                                                            ${reg.registrationNumber}
                                                                        </code>
                                                                        · Amount:
                                                                        <strong>
                                                                            ₹${conf.delegateFee}
                                                                        </strong>
                                                                    </div>
                                                                </div>

                                                                <%-- Payment method --%>
                                                                <label class="form-label
                                                                              fw-semibold">
                                                                    Payment Method *
                                                                </label>
                                                                <div class="d-flex gap-3 mb-3">
                                                                    <div class="form-check">
                                                                        <input class="form-check-input"
                                                                               type="radio"
                                                                               name="paymentMethod"
                                                                               value="VENUE_CASH"
                                                                               id="cash${reg.id}"
                                                                               checked/>
                                                                        <label class="form-check-label"
                                                                               for="cash${reg.id}">
                                                                            💵 Cash
                                                                        </label>
                                                                    </div>
                                                                    <div class="form-check">
                                                                        <input class="form-check-input"
                                                                               type="radio"
                                                                               name="paymentMethod"
                                                                               value="VENUE_UPI"
                                                                               id="upi${reg.id}"/>
                                                                        <label class="form-check-label"
                                                                               for="upi${reg.id}">
                                                                            📱 UPI
                                                                        </label>
                                                                    </div>
                                                                </div>

                                                                <%-- Optional reference --%>
                                                                <label class="form-label
                                                                              fw-semibold">
                                                                    UPI Transaction ID
                                                                    <span class="text-muted
                                                                          fw-normal small">
                                                                        (optional — for UPI)
                                                                    </span>
                                                                </label>
                                                                <input type="text"
                                                                       name="paymentReference"
                                                                       class="form-control
                                                                              form-control-sm"
                                                                       placeholder="e.g. 123456789012"/>
                                                                <div class="form-text
                                                                            text-muted">
                                                                    Leave blank for cash.
                                                                    Delegate will be
                                                                    notified in-app.
                                                                </div>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button"
                                                                        class="btn btn-secondary"
                                                                        data-bs-dismiss="modal">
                                                                    Cancel
                                                                </button>
                                                                <button type="submit"
                                                                        class="btn btn-success
                                                                               fw-bold">
                                                                    ✅ Confirm Payment
                                                                </button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                            <%-- end payModal --%>

                                        </c:when>

                                        <%-- ONLINE paid conference (future Razorpay) --%>
                                        <c:when test="${not empty pay}">
                                            <c:choose>
                                                <c:when test="${pay.status == 'COMPLETED'}">
                                                    <span class="pay-badge-confirmed">
                                                        ✅ Paid
                                                    </span>
                                                    <div class="text-muted"
                                                         style="font-size:0.65rem">
                                                        ₹${pay.amount}
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="pay-badge-venue">
                                                        ⏳ Pending
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>

                                        <c:otherwise>
                                            <span class="text-muted small">—</span>
                                        </c:otherwise>

                                    </c:choose>
                                </td>
                                <%-- end payment column --%>

                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
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