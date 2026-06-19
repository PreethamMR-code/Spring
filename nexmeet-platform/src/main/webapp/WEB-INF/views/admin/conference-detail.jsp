<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>${conf.title} - Admin Review</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body class="bg-light">
<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="text-danger">Admin Review</h2>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-secondary">← Back</a>
    </div>

    <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>
    <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

    <!-- Conference Info -->
    <div class="card mb-3">
        <div class="card-header fw-bold bg-danger text-white">Conference Details</div>
        <div class="card-body">
            <h4>${conf.title}</h4>
            <p class="text-muted">${conf.description}</p>
            <div class="row">
                <div class="col-md-4"><strong>Type:</strong> ${conf.conferenceType}</div>
                <div class="col-md-4"><strong>Mode:</strong> ${conf.mode}</div>
                <div class="col-md-4"><strong>Status:</strong>
                    <span class="badge bg-warning">${conf.status}</span>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-md-4"><strong>Start:</strong> ${fn:substringBefore(conf.startDate.toString(),'T')}</div>
                <div class="col-md-4"><strong>End:</strong> ${fn:substringBefore(conf.endDate.toString(),'T')}</div>
                <div class="col-md-4"><strong>Reg. Deadline:</strong> ${fn:substringBefore(conf.registrationDeadline.toString(),'T')}</div>
            </div>
            <div class="row mt-2">
                <div class="col-md-4"><strong>Target Audience:</strong> ${conf.targetAudience}</div>
                <div class="col-md-4"><strong>Target Domains:</strong> ${conf.targetDomains}</div>
            </div>
        </div>
    </div>

    <!-- Venue -->
    <div class="card mb-3">
        <div class="card-header fw-bold">Venue / Online Info</div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6"><strong>Venue:</strong> ${conf.venueName}</div>
                <div class="col-md-6"><strong>Address:</strong> ${conf.venueAddress}</div>
            </div>
            <div class="row mt-2">
                <div class="col-md-4"><strong>City:</strong> ${conf.city}</div>
                <div class="col-md-4"><strong>State:</strong> ${conf.state}</div>
            </div>
            <c:if test="${not empty conf.streamingLink}">
                <div class="mt-2"><strong>Streaming Link:</strong>
                    <a href="${conf.streamingLink}" target="_blank">${conf.streamingLink}</a>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Capacity & Pricing -->
    <div class="card mb-3">
        <div class="card-header fw-bold">Capacity & Pricing</div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-4"><strong>Max Delegates:</strong> ${conf.maxDelegates}</div>
                <div class="col-md-4"><strong>Free Event:</strong> ${conf.free ? 'Yes' : 'No'}</div>
                <div class="col-md-4"><strong>Delegate Fee:</strong>
                    <c:choose>
                        <c:when test="${conf.free}">Free</c:when>
                        <c:otherwise>₹${conf.delegateFee} (collected at venue)</c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- Features -->
    <div class="card mb-3">
        <div class="card-header fw-bold">Features</div>
        <div class="card-body">
            <span class="badge ${conf.certificateEnabled ? 'bg-success' : 'bg-secondary'} me-2">
                Certificate: ${conf.certificateEnabled ? 'Yes' : 'No'}
            </span>
            <span class="badge ${conf.qrCheckinEnabled ? 'bg-success' : 'bg-secondary'} me-2">
                QR Check-in: ${conf.qrCheckinEnabled ? 'Yes' : 'No'}
            </span>
            <span class="badge ${conf.bulkUploadAllowed ? 'bg-success' : 'bg-secondary'}">
                Bulk Upload: ${conf.bulkUploadAllowed ? 'Yes' : 'No'}
            </span>
        </div>
    </div>

    <c:if test="${!conf.free}">
        <div class="card mb-3">
            <div class="card-header fw-bold bg-warning text-dark">
                Revenue Breakdown
            </div>
            <div class="card-body">
                <div class="row text-center">
                    <div class="col-md-4">
                        <h6 class="text-muted">Delegate Fee</h6>
                        <h4>₹${conf.delegateFee}</h4>
                        <small>per delegate</small>
                    </div>
                    <div class="col-md-4">
                        <h6 class="text-muted">
                            Gross Revenue
                        </h6>
                        <h4 class="text-success">
                            ₹<fmt:formatNumber
                                value="${conf.registeredCount *
                                    conf.delegateFee}"
                                maxFractionDigits="0"/>
                        </h4>
                        <small>
                            ${conf.registeredCount}
                            delegate(s) × ₹${conf.delegateFee}
                        </small>
                    </div>
                    <div class="col-md-4">
                        <h6 class="text-muted">Platform Commission</h6>
                        <div class="small text-muted mb-1">
                            Base: ₹${baseFee} +
                            ₹${perDelegateFee}/delegate
                        </div>
                        <h4 class="text-danger">₹${platformEarnings}</h4>
                        <small class="text-success">
                            Organizer gets: ₹${organizerPayout}
                        </small>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    <!-- Organizer Info -->
    <div class="card mb-4">
        <div class="card-header fw-bold">Organizer Information</div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-4"><strong>Name:</strong> ${conf.organizer.user.fullName}</div>
                <div class="col-md-4"><strong>Email:</strong> ${conf.organizer.user.email}</div>
                <div class="col-md-4"><strong>Phone:</strong> ${conf.organizer.user.phone}</div>
            </div>
            <div class="row mt-2">
                <div class="col-md-4"><strong>Organization:</strong> ${conf.organizer.organizationName}</div>
                <div class="col-md-4"><strong>Org Type:</strong> ${conf.organizer.organizationType}</div>
                <div class="col-md-4"><strong>Website:</strong>
                    <c:if test="${not empty conf.organizer.websiteUrl}">
                        <a href="${conf.organizer.websiteUrl}" target="_blank">${conf.organizer.websiteUrl}</a>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- Action Buttons -->
    <c:if test="${conf.status == 'SUBMITTED'}">
        <div class="d-flex gap-3">
            <form action="${pageContext.request.contextPath}/admin/conference/${conf.id}/approve" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <button class="btn btn-success btn-lg">✅ Approve Conference</button>
            </form>

            <button class="btn btn-danger btn-lg" data-bs-toggle="modal" data-bs-target="#rejectModal">
                ❌ Reject Conference
            </button>
        </div>

        <!-- Reject Modal -->
        <div class="modal fade" id="rejectModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Reject Conference</h5>
                    </div>
                    <form action="${pageContext.request.contextPath}/admin/conference/${conf.id}/reject" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <div class="modal-body">
                            <label class="form-label">Reason for rejection</label>
                            <textarea name="reason" class="form-control" rows="4" required></textarea>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-danger">Confirm Reject</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </c:if>

    <c:if test="${conf.status == 'APPROVED'}">
        <div class="mt-3">
            <c:choose>
                <c:when test="${endDatePassed}">
                    <form action="${pageContext.request.contextPath}/admin/conference/${conf.id}/complete"
                          method="post" class="d-inline">
                        <input type="hidden"
                               name="${_csrf.parameterName}"
                               value="${_csrf.token}"/>
                        <button class="btn btn-secondary btn-lg">
                            ✓ Mark as Completed
                        </button>
                    </form>
                    <small class="text-muted ms-2">
                        Conference end date has passed.
                    </small>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-info py-2 mt-2">
                        Conference is live and active.
                        Completion option appears after end date passes.
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </c:if>

    <c:if test="${conf.status == 'COMPLETED'}">
        <div class="alert alert-secondary mt-3">
            This conference is <strong>COMPLETED</strong>.
            Delegates can now submit feedback and
            download certificates.
        </div>
    </c:if>

    <%-- Add after the existing status display --%>
    <c:if test="${conf.status == 'COMPLETED'
                 && conf.certificateEnabled}">
        <div class="alert alert-info d-flex
                    justify-content-between
                    align-items-center mt-3">
            <span>
                <strong>Missing certificates?</strong>
                If delegates attended but didn't receive
                their certificate email, use this to
                reissue all missing ones.
                Safe to run multiple times.
            </span>
            <form action="${pageContext.request.contextPath}/admin/conference/${conf.id}/reissue-certificates"
                  method="post" class="ms-3">
                <input type="hidden"
                       name="${_csrf.parameterName}"
                       value="${_csrf.token}"/>
                <button class="btn btn-info btn-sm
                               fw-bold text-white">
                    🔄 Reissue Certificates
                </button>
            </form>
        </div>
    </c:if>

    <%-- ── Commission Invoice Section (Admin) ─────── --%>
    <c:if test="${conf.status == 'COMPLETED' && !conf.free}">
        <div class="card mt-4"
             style="border:none;border-radius:14px;
                    box-shadow:0 2px 12px rgba(0,0,0,0.09)">
            <div class="card-header fw-bold
                        d-flex justify-content-between
                        align-items-center py-3"
                 style="background:#fff8f0;
                        border-bottom:1px solid #fed7aa;
                        border-radius:14px 14px 0 0">
                <span>🧾 Platform Commission Invoice</span>
                <c:choose>
                    <c:when test="${empty commissionInvoice}">
                        <span class="badge bg-secondary">
                            Not Generated
                        </span>
                    </c:when>
                    <c:when test="${commissionInvoice.status == 'PENDING'}">
                        <span class="badge bg-warning text-dark">
                            ⏳ PENDING PAYMENT
                        </span>
                    </c:when>
                    <c:when test="${commissionInvoice.status == 'PAID'}">
                        <span class="badge bg-success">
                            ✅ PAID
                        </span>
                    </c:when>
                    <c:when test="${commissionInvoice.status == 'WAIVED'}">
                        <span class="badge bg-secondary">
                            WAIVED
                        </span>
                    </c:when>
                </c:choose>
            </div>

            <div class="card-body">
                <c:choose>

                    <%-- NO INVOICE YET — show generate button --%>
                    <c:when test="${empty commissionInvoice}">
                        <div class="d-flex justify-content-between
                                    align-items-center">
                            <div>
                                <div class="fw-semibold mb-1">
                                    Generate commission invoice
                                    for this conference.
                                </div>
                                <div class="text-muted small">
                                    Calculation: ₹${baseFee} base
                                    + ₹${perDelegateFee}
                                    × ${conf.registeredCount}
                                    delegates =
                                    <strong>
                                        ₹<fmt:formatNumber
                                            value="${baseFee +
                                                (perDelegateFee *
                                                conf.registeredCount)}"
                                            maxFractionDigits="2"/>
                                    </strong>
                                </div>
                                <div class="text-muted small mt-1">
                                    Organizer will be notified
                                    in-app to arrange payment.
                                </div>
                            </div>
                            <form action="${pageContext.request.contextPath}/admin/conference/${conf.id}/generate-invoice"
                                  method="post" class="ms-3">
                                <input type="hidden"
                                       name="${_csrf.parameterName}"
                                       value="${_csrf.token}"/>
                                <button class="btn btn-warning
                                               fw-bold"
                                        style="white-space:nowrap">
                                    🧾 Generate Invoice
                                </button>
                            </form>
                        </div>
                    </c:when>

                    <%-- INVOICE EXISTS — show details --%>
                    <c:otherwise>
                        <div class="row g-3 mb-3">
                            <div class="col-md-3">
                                <div class="text-muted small
                                            text-uppercase
                                            fw-semibold mb-1"
                                     style="letter-spacing:0.05em">
                                    Invoice No.
                                </div>
                                <code class="fw-bold"
                                      style="font-size:0.9rem">
                                    ${commissionInvoice.invoiceNumber}
                                </code>
                            </div>
                            <div class="col-md-3">
                                <div class="text-muted small
                                            text-uppercase
                                            fw-semibold mb-1"
                                     style="letter-spacing:0.05em">
                                    Base Fee
                                </div>
                                <div class="fw-semibold">
                                    ₹${commissionInvoice.baseFee}
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="text-muted small
                                            text-uppercase
                                            fw-semibold mb-1"
                                     style="letter-spacing:0.05em">
                                    Per-Delegate
                                    × ${commissionInvoice.registeredCount}
                                </div>
                                <div class="fw-semibold">
                                    ₹${commissionInvoice.perDelegateFee}
                                    each
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="text-muted small
                                            text-uppercase
                                            fw-semibold mb-1"
                                     style="letter-spacing:0.05em">
                                    Total Due
                                </div>
                                <div style="font-size:1.3rem;
                                     font-weight:800;
                                     color:#d97706">
                                    ₹${commissionInvoice.totalAmount}
                                </div>
                            </div>
                        </div>

                        <div class="text-muted small mb-3">
                            Generated on
                            ${fn:substringBefore(
                                commissionInvoice.generatedAt
                                    .toString(), 'T')}
                            by
                            ${commissionInvoice.generatedBy != null
                                ? commissionInvoice.generatedBy.fullName
                                : 'System'}
                        </div>

                        <%-- PENDING: show mark-paid and waive --%>
                        <c:if test="${commissionInvoice.status
                                     == 'PENDING'}">
                            <div class="alert
                                                                    ${not empty commissionInvoice.submittedPaymentReference
                                                                        ? 'alert-info' : 'alert-warning'}
                                                                    d-flex
                                                                    justify-content-between
                                                                    align-items-start
                                                                    flex-wrap gap-2">
                                                            <div>
                                                                <c:choose>
                                                                    <%--
                                                                        Organizer has submitted a
                                                                        reference — admin just needs
                                                                        to verify against the bank
                                                                        statement and confirm.
                                                                    --%>
                                                                    <c:when test="${not empty commissionInvoice.submittedPaymentReference}">
                                                                        <strong>
                                                                            💬 Organizer submitted
                                                                            a payment reference.
                                                                        </strong>
                                                                        <div class="small mt-1">
                                                                            Reference:
                                                                            <code class="fw-bold">
                                                                                ${commissionInvoice.submittedPaymentReference}
                                                                            </code>
                                                                            &nbsp;·&nbsp;
                                                                            Submitted on
                                                                            ${fn:substringBefore(
                                                                                commissionInvoice.submittedAt
                                                                                    .toString(), 'T')}
                                                                            <br/>
                                                                            Please verify against your
                                                                            bank/UPI statement before
                                                                            confirming.
                                                                        </div>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <strong>
                                                                            ⏳ Awaiting payment
                                                                            from organizer.
                                                                        </strong>
                                                                        <div class="small mt-1">
                                                                            Ask organizer to transfer
                                                                            ₹${commissionInvoice.totalAmount}
                                                                            and reference invoice
                                                                            ${commissionInvoice.invoiceNumber}.
                                                                            Once received, enter the
                                                                            UTR/UPI reference below.
                                                                        </div>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                            <div class="d-flex gap-2">

                                    <%-- Mark Paid --%>
                                    <button class="btn btn-success
                                                   btn-sm fw-bold"
                                            data-bs-toggle="modal"
                                            data-bs-target="#markPaidModal">
                                        ✅ Mark as Paid
                                    </button>

                                    <%-- Waive --%>
                                    <button class="btn btn-outline-secondary
                                                   btn-sm"
                                            data-bs-toggle="modal"
                                            data-bs-target="#waiveModal">
                                        Waive
                                    </button>
                                </div>
                            </div>

                            <%-- Mark Paid Modal --%>
                            <div class="modal fade"
                                 id="markPaidModal" tabindex="-1">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header
                                                    bg-success text-white">
                                            <h5 class="modal-title">
                                                Confirm Payment Received
                                            </h5>
                                        </div>
                                        <form action="${pageContext.request.contextPath}/admin/invoice/${commissionInvoice.id}/mark-paid"
                                              method="post">
                                            <input type="hidden"
                                                   name="${_csrf.parameterName}"
                                                   value="${_csrf.token}"/>
                                            <input type="hidden"
                                                   name="conferenceId"
                                                   value="${conf.id}"/>
                                            <div class="modal-body">
                                                <div class="alert alert-info small">
                                                    Invoice:
                                                    <strong>
                                                        ${commissionInvoice.invoiceNumber}
                                                    </strong>
                                                    <br/>
                                                    Amount:
                                                    <strong>
                                                        ₹${commissionInvoice.totalAmount}
                                                    </strong>
                                                </div>
                                                <label class="form-label
                                                              fw-semibold">
                                                    Payment Reference *
                                                    <span class="text-muted
                                                          fw-normal small">
                                                        (UTR / UPI Ref / Cheque No.)
                                                    </span>
                                                </label>
                                                <input type="text"
                                                                                                       name="paymentReference"
                                                                                                       class="form-control"
                                                                                                       placeholder="e.g. UTR123456789012"
                                                                                                       value="${commissionInvoice.submittedPaymentReference}"
                                                                                                       required/>
                                                                                                <div class="form-text text-muted">
                                                                                                    <c:if test="${not empty commissionInvoice.submittedPaymentReference}">
                                                                                                        Pre-filled with the
                                                                                                        organizer's submission —
                                                                                                        verify and edit if needed.
                                                                                                        <br/>
                                                                                                    </c:if>
                                                                                                    This reference will be stored
                                                                                                    for reconciliation.
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

                            <%-- Waive Modal --%>
                            <div class="modal fade"
                                 id="waiveModal" tabindex="-1">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">
                                                Waive Invoice
                                            </h5>
                                        </div>
                                        <form action="${pageContext.request.contextPath}/admin/invoice/${commissionInvoice.id}/waive"
                                              method="post">
                                            <input type="hidden"
                                                   name="${_csrf.parameterName}"
                                                   value="${_csrf.token}"/>
                                            <input type="hidden"
                                                   name="conferenceId"
                                                   value="${conf.id}"/>
                                            <div class="modal-body">
                                                <label class="form-label
                                                              fw-semibold">
                                                    Reason for waiver *
                                                </label>
                                                <textarea name="notes"
                                                          class="form-control"
                                                          rows="3"
                                                          placeholder="e.g. NGO event, goodwill waiver"
                                                          required></textarea>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button"
                                                        class="btn btn-secondary"
                                                        data-bs-dismiss="modal">
                                                    Cancel
                                                </button>
                                                <button type="submit"
                                                        class="btn btn-warning">
                                                    Waive Invoice
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                        <%-- PAID: show confirmation --%>
                        <c:if test="${commissionInvoice.status
                                     == 'PAID'}">
                            <div class="alert alert-success mb-0">
                                <strong>✅ Payment confirmed.</strong>
                                Reference:
                                <code>
                                    ${commissionInvoice.paymentReference}
                                </code>
                                on
                                ${fn:substringBefore(
                                    commissionInvoice.paidAt
                                        .toString(), 'T')}
                            </div>
                        </c:if>

                        <%-- WAIVED --%>
                        <c:if test="${commissionInvoice.status
                                     == 'WAIVED'}">
                            <div class="alert alert-secondary mb-0">
                                <strong>Invoice waived.</strong>
                                Reason:
                                ${commissionInvoice.notes}
                            </div>
                        </c:if>

                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </c:if>


    <%-- Admin cancel for APPROVED conferences --%>
    <c:if test="${conf.status == 'APPROVED' ||
                 conf.status == 'SUBMITTED'}">
        <div class="mt-3">
            <button class="btn btn-outline-danger"
                    data-bs-toggle="modal"
                    data-bs-target="#adminCancelModal">
                Cancel This Conference
            </button>
        </div>

        <div class="modal fade" id="adminCancelModal"
             tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title">
                            Admin: Cancel Conference
                        </h5>
                    </div>
                    <form action="${pageContext.request.contextPath}/admin/conference/${conf.id}/cancel"
                          method="post">
                        <input type="hidden"
                               name="${_csrf.parameterName}"
                               value="${_csrf.token}"/>
                        <div class="modal-body">
                            <div class="alert alert-warning">
                                <strong>⚠ Warning:</strong>
                                All registered delegates will be
                                notified of the cancellation.
                            </div>
                            <label class="form-label fw-semibold">
                                Reason *
                            </label>
                            <textarea name="reason"
                                      class="form-control"
                                      rows="3"
                                      required></textarea>
                        </div>
                        <div class="modal-footer">
                            <button type="button"
                                    class="btn btn-secondary"
                                    data-bs-dismiss="modal">
                                Back
                            </button>
                            <button type="submit"
                                    class="btn btn-danger">
                                Cancel Conference
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </c:if>

    <c:if test="${conf.status == 'CANCELLED'}">
        <div class="alert alert-danger mt-3">
            ❌ This conference has been
            <strong>CANCELLED</strong>.
        </div>
    </c:if>


    <%-- ── Delegate & Attendance Overview ──────── --%>
    <c:if test="${not empty registrations}">
        <div class="card mt-4">
            <div class="card-header bg-white fw-bold
                        d-flex justify-content-between
                        align-items-center py-3">
                <span>👥 Delegate Overview</span>
                <div class="d-flex gap-3 small">
                    <span class="text-success fw-semibold">
                        ✅ Confirmed: ${confirmedCount}
                    </span>
                    <span class="text-primary fw-semibold">
                        📋 Attended: ${attendedCount}
                    </span>
                    <span class="text-warning fw-semibold">
                        🏆 Certified: ${certIssuedCount}
                    </span>
                    <span class="text-danger fw-semibold">
                        ❌ Cancelled: ${cancelledCount}
                    </span>
                </div>
            </div>

            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover
                                  table-sm mb-0 small">
                        <thead class="table-light">
                            <tr>
                                <th class="ps-3">#</th>
                                <th>Reg. Number</th>
                                <th>Full Name</th>
                                <th>Email</th>
                                <th>Registered</th>
                                <th class="text-center">
                                    Status
                                </th>
                                <th class="text-center">
                                    Attended
                                </th>
                                <th class="text-center">
                                    Certificate
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="reg"
                                items="${registrations}"
                                varStatus="loop">
                                <tr>
                                    <td class="ps-3
                                               text-muted">
                                        ${loop.index + 1}
                                    </td>
                                    <td>
                                        <code style="font-size:0.75rem">
                                            ${reg.registrationNumber}
                                        </code>
                                    </td>
                                    <td class="fw-semibold">
                                        ${reg.user.fullName}
                                    </td>
                                    <td class="text-muted">
                                        ${reg.user.email}
                                    </td>
                                    <td class="text-muted">
                                        ${fn:substringBefore(
                                            reg.registeredAt
                                                .toString(),
                                            'T')}
                                    </td>
                                    <td class="text-center">
                                        <span class="badge
                                            ${reg.status == 'CONFIRMED'
                                                ? 'bg-success'
                                            : reg.status == 'CANCELLED'
                                                ? 'bg-danger'
                                                : 'bg-secondary'}">
                                            ${reg.status}
                                        </span>
                                    </td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${attendedRegIds
                                                    .contains(reg.id)}">
                                                <span class="badge
                                                    bg-primary">
                                                    ✓ Yes
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted
                                                    small">
                                                    —
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${not empty
                                                certMap[reg.id]}">
                                                <span class="badge
                                                    bg-warning
                                                    text-dark"
                                                    title="${certMap[reg.id]
                                                        .certificateNumber}">
                                                    🏆 Issued
                                                </span>
                                                <div class="text-muted"
                                                    style="font-size:
                                                           0.68rem;
                                                           margin-top:2px">
                                                    ${certMap[reg.id]
                                                        .certificateNumber}
                                                </div>
                                            </c:when>
                                            <c:when test="${attendedRegIds
                                                    .contains(reg.id)
                                                    && conf.status
                                                        != 'COMPLETED'}">
                                                <span class="text-muted
                                                    small fst-italic">
                                                    After completion
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted
                                                    small">
                                                    —
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <%-- Export link for admin --%>
            <div class="card-footer bg-white
                        d-flex justify-content-between
                        align-items-center py-2">
                <span class="text-muted small">
                    ${fn:length(registrations)} total
                    registration(s) across all statuses
                </span>
                <div class="d-flex gap-2">
                    <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}/delegates/export?format=excel"
                       class="btn btn-outline-success
                              btn-sm"
                       onclick="return confirm(
                           'Note: This uses organizer export. '
                           + 'Continue?')">
                        📥 Export Excel
                    </a>
                    <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}/delegates/export?format=csv"
                       class="btn btn-outline-secondary
                              btn-sm"
                       onclick="return confirm(
                           'Note: This uses organizer export. '
                           + 'Continue?')">
                        📥 Export CSV
                    </a>
                </div>
            </div>
        </div>
    </c:if>

    <c:if test="${empty registrations
                 && (conf.status == 'APPROVED'
                 || conf.status == 'COMPLETED')}">
        <div class="card mt-4">
            <div class="card-body text-center
                        text-muted py-4">
                <div style="font-size:2rem">👥</div>
                <p class="mt-2 mb-0">
                    No delegates have registered
                    for this conference yet.
                </p>
            </div>
        </div>
    </c:if>


</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>