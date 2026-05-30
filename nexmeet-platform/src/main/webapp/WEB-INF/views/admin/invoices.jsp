<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Commission Invoices – Admin</title>
    <meta name="viewport" content="width=device-width,
          initial-scale=1"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <style>
        body { background: #f0f2f5;
               font-family: 'Inter', sans-serif; }

        .stat-card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.07);
        }
        .stat-num {
            font-size: 2.2rem;
            font-weight: 800;
            line-height: 1;
        }

        .inv-badge-pending {
            background: #fef3c7;
            color: #92400e;
            border: 1px solid #fde68a;
            border-radius: 6px;
            padding: 3px 10px;
            font-size: 0.78rem;
            font-weight: 700;
        }
        .inv-badge-paid {
            background: #dcfce7;
            color: #166534;
            border: 1px solid #bbf7d0;
            border-radius: 6px;
            padding: 3px 10px;
            font-size: 0.78rem;
            font-weight: 700;
        }
        .inv-badge-waived {
            background: #f1f5f9;
            color: #475569;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            padding: 3px 10px;
            font-size: 0.78rem;
            font-weight: 700;
        }

        .filter-btn {
            border-radius: 20px;
            padding: 5px 16px;
            font-size: 0.85rem;
            font-weight: 600;
            border: 2px solid transparent;
        }
        .filter-btn.active-filter {
            border-color: #667eea;
            color: #667eea;
            background: #f0eeff;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container py-4" style="max-width:1100px">

    <%-- Page header --%>
    <div class="d-flex justify-content-between
                align-items-center mb-4">
        <div>
            <h2 class="mb-0 fw-800"
                style="color:#dc2626;font-weight:800">
                🧾 Commission Invoices
            </h2>
            <p class="text-muted mb-0">
                Platform billing overview —
                all organizer commission invoices
            </p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/dashboard"
           class="btn btn-outline-secondary btn-sm">
            ← Dashboard
        </a>
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

    <%-- Summary stat cards --%>
    <div class="row g-3 mb-4">

        <div class="col-6 col-md-3">
            <div class="card stat-card p-4 text-center"
                 style="border-left:5px solid
                        #f59e0b !important">
                <div class="text-muted small mb-1
                            text-uppercase fw-semibold"
                     style="letter-spacing:0.05em">
                    Pending Payment
                </div>
                <div class="stat-num text-warning">
                    ${pendingCount}
                </div>
                <div class="text-muted small mt-1">
                    invoices
                </div>
            </div>
        </div>

        <div class="col-6 col-md-3">
            <div class="card stat-card p-4 text-center"
                 style="border-left:5px solid
                        #ef4444 !important">
                <div class="text-muted small mb-1
                            text-uppercase fw-semibold"
                     style="letter-spacing:0.05em">
                    Total Pending
                </div>
                <div class="stat-num"
                     style="color:#ef4444">
                    ₹<fmt:formatNumber
                        value="${totalPending}"
                        maxFractionDigits="0"/>
                </div>
                <div class="text-muted small mt-1">
                    amount owed
                </div>
            </div>
        </div>

        <div class="col-6 col-md-3">
            <div class="card stat-card p-4 text-center"
                 style="border-left:5px solid
                        #22c55e !important">
                <div class="text-muted small mb-1
                            text-uppercase fw-semibold"
                     style="letter-spacing:0.05em">
                    Collected
                </div>
                <div class="stat-num text-success">
                    ₹<fmt:formatNumber
                        value="${totalCollected}"
                        maxFractionDigits="0"/>
                </div>
                <div class="text-muted small mt-1">
                    ${paidCount} paid invoice(s)
                </div>
            </div>
        </div>

        <div class="col-6 col-md-3">
            <div class="card stat-card p-4 text-center"
                 style="border-left:5px solid
                        #94a3b8 !important">
                <div class="text-muted small mb-1
                            text-uppercase fw-semibold"
                     style="letter-spacing:0.05em">
                    Waived
                </div>
                <div class="stat-num text-secondary">
                    ${waivedCount}
                </div>
                <div class="text-muted small mt-1">
                    invoices
                </div>
            </div>
        </div>
    </div>

    <%-- Status filter tabs --%>
    <div class="d-flex gap-2 mb-3 flex-wrap">
        <a href="${pageContext.request.contextPath}/admin/invoices"
           class="btn btn-outline-secondary filter-btn
                  ${empty selectedStatus ? 'active-filter' : ''}">
            All
        </a>
        <a href="${pageContext.request.contextPath}/admin/invoices?status=PENDING"
           class="btn btn-outline-warning filter-btn
                  ${selectedStatus == 'PENDING' ? 'active-filter' : ''}">
            ⏳ Pending
            <c:if test="${pendingCount > 0}">
                <span class="badge bg-warning text-dark
                             ms-1">
                    ${pendingCount}
                </span>
            </c:if>
        </a>
        <a href="${pageContext.request.contextPath}/admin/invoices?status=PAID"
           class="btn btn-outline-success filter-btn
                  ${selectedStatus == 'PAID' ? 'active-filter' : ''}">
            ✅ Paid
        </a>
        <a href="${pageContext.request.contextPath}/admin/invoices?status=WAIVED"
           class="btn btn-outline-secondary filter-btn
                  ${selectedStatus == 'WAIVED' ? 'active-filter' : ''}">
            Waived
        </a>
    </div>

    <%-- Invoice table --%>
    <div class="card"
         style="border:none;border-radius:14px;
                box-shadow:0 2px 12px rgba(0,0,0,0.09)">
        <div class="card-header fw-bold bg-white
                    d-flex justify-content-between
                    align-items-center py-3"
             style="border-radius:14px 14px 0 0">
            <span>Invoice List</span>
            <span class="text-muted small fw-normal">
                ${fn:length(invoices)}
                invoice(s)
                <c:if test="${not empty selectedStatus}">
                    — filtered: ${selectedStatus}
                </c:if>
            </span>
        </div>

        <div class="card-body p-0">
            <c:choose>
                <c:when test="${empty invoices}">
                    <div class="text-center py-5
                                text-muted">
                        <div style="font-size:3rem">
                            🧾
                        </div>
                        <div class="mt-2 fw-semibold">
                            No invoices found.
                        </div>
                        <c:if test="${not empty selectedStatus}">
                            <div class="small mt-1">
                                No
                                ${selectedStatus}
                                invoices.
                                <a href="${pageContext.request.contextPath}/admin/invoices">
                                    View all →
                                </a>
                            </div>
                        </c:if>
                        <c:if test="${empty selectedStatus}">
                            <div class="small mt-1">
                                Invoices are generated
                                from completed
                                paid conferences.
                            </div>
                        </c:if>
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="table-responsive">
                    <table class="table table-hover
                                  mb-0 small">
                        <thead
                            style="background:#fafafa">
                            <tr>
                                <th class="ps-3">
                                    Invoice No.
                                </th>
                                <th>Conference</th>
                                <th>Organizer</th>
                                <th>Base</th>
                                <th>Per-Del</th>
                                <th>Delegates</th>
                                <th class="text-end">
                                    Total
                                </th>
                                <th>Generated</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="inv"
                                   items="${invoices}">
                            <tr>
                                <td class="ps-3">
                                    <code style="font-size:
                                                 0.78rem;
                                                 font-weight:700">
                                        ${inv.invoiceNumber}
                                    </code>
                                </td>

                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/conference/${inv.conference.id}"
                                       class="text-decoration-none
                                              fw-semibold"
                                       style="color:#0f172a">
                                        ${fn:length(inv.conference.title) > 30
                                            ? fn:substring(inv.conference.title,0,30).concat('…')
                                            : inv.conference.title}
                                    </a>
                                    <div class="text-muted"
                                         style="font-size:
                                                0.68rem">
                                        ${inv.conference.conferenceType}
                                        ·
                                        ${inv.conference.mode}
                                    </div>
                                </td>

                                <td>
                                    <div class="fw-semibold">
                                        ${inv.organizer.organizationName}
                                    </div>
                                    <div class="text-muted"
                                         style="font-size:
                                                0.68rem">
                                        ${inv.organizer.user.email}
                                    </div>
                                </td>

                                <td class="text-muted">
                                    ₹${inv.baseFee}
                                </td>

                                <td class="text-muted">
                                    ₹${inv.perDelegateFee}
                                </td>

                                <td class="text-center
                                           fw-semibold">
                                    ${inv.registeredCount}
                                </td>

                                <td class="text-end">
                                    <span style="font-size:
                                           1rem;
                                           font-weight:800;
                                           color:#d97706">
                                        ₹<fmt:formatNumber
                                            value="${inv.totalAmount}"
                                            maxFractionDigits="2"/>
                                    </span>
                                </td>

                                <td class="text-muted">
                                    ${fn:substringBefore(
                                        inv.generatedAt
                                            .toString(),
                                        'T')}
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${inv.status == 'PENDING'}">
                                            <span class="inv-badge-pending">
                                                ⏳ PENDING
                                            </span>
                                        </c:when>
                                        <c:when test="${inv.status == 'PAID'}">
                                            <span class="inv-badge-paid">
                                                ✅ PAID
                                            </span>
                                            <div style="font-size:
                                                 0.65rem;
                                                 color:#94a3b8;
                                                 margin-top:2px">
                                                ${fn:substringBefore(
                                                    inv.paidAt
                                                        .toString(),
                                                    'T')}
                                            </div>
                                        </c:when>
                                        <c:when test="${inv.status == 'WAIVED'}">
                                            <span class="inv-badge-waived">
                                                WAIVED
                                            </span>
                                        </c:when>
                                    </c:choose>
                                </td>

                                <%-- Action column --%>
                                <td style="min-width:110px">
                                    <c:choose>

                                        <%-- PENDING: show Mark Paid + Waive --%>
                                        <c:when test="${inv.status == 'PENDING'}">
                                            <button type="button"
                                                    class="btn btn-success
                                                           btn-sm fw-bold"
                                                    style="font-size:0.72rem"
                                                    data-bs-toggle="modal"
                                                    data-bs-target="#markPaidModal${inv.id}">
                                                ✅ Mark Paid
                                            </button>
                                            <button type="button"
                                                    class="btn btn-outline-secondary
                                                           btn-sm mt-1"
                                                    style="font-size:0.68rem"
                                                    data-bs-toggle="modal"
                                                    data-bs-target="#waiveModal${inv.id}">
                                                Waive
                                            </button>

                                            <%-- Mark Paid Modal --%>
                                            <div class="modal fade"
                                                 id="markPaidModal${inv.id}"
                                                 tabindex="-1">
                                                <div class="modal-dialog
                                                            modal-dialog-centered">
                                                    <div class="modal-content">
                                                        <div class="modal-header
                                                                    bg-success
                                                                    text-white">
                                                            <h5 class="modal-title
                                                                        fw-bold">
                                                                Confirm Payment
                                                            </h5>
                                                            <button type="button"
                                                                    class="btn-close
                                                                           btn-close-white"
                                                                    data-bs-dismiss="modal">
                                                            </button>
                                                        </div>
                                                        <form action="${pageContext.request.contextPath}/admin/invoice/${inv.id}/mark-paid"
                                                              method="post">
                                                            <input type="hidden"
                                                                   name="${_csrf.parameterName}"
                                                                   value="${_csrf.token}"/>
                                                            <input type="hidden"
                                                                   name="conferenceId"
                                                                   value="${inv.conference.id}"/>
                                                            <div class="modal-body">
                                                                <div class="alert
                                                                            alert-light
                                                                            border mb-3"
                                                                     style="border-radius:
                                                                            10px">
                                                                    <div class="fw-semibold">
                                                                        ${inv.conference.title}
                                                                    </div>
                                                                    <div class="text-muted small">
                                                                        ${inv.organizer.organizationName}
                                                                        ·
                                                                        ${inv.organizer.user.email}
                                                                    </div>
                                                                    <div class="mt-2">
                                                                        Invoice:
                                                                        <code class="fw-bold">
                                                                            ${inv.invoiceNumber}
                                                                        </code>
                                                                    </div>
                                                                    <div style="font-size:
                                                                         1.3rem;
                                                                         font-weight:800;
                                                                         color:#d97706;
                                                                         margin-top:6px">
                                                                        ₹${inv.totalAmount}
                                                                    </div>
                                                                </div>
                                                                <label class="form-label
                                                                              fw-semibold">
                                                                    Payment Reference *
                                                                    <span class="text-muted
                                                                          fw-normal small">
                                                                        (UTR / UPI Ref /
                                                                        Cheque No.)
                                                                    </span>
                                                                </label>
                                                                <input type="text"
                                                                       name="paymentReference"
                                                                       class="form-control"
                                                                       placeholder="e.g. UTR123456789012"
                                                                       required/>
                                                                <div class="form-text
                                                                            text-muted">
                                                                    Stored for
                                                                    reconciliation.
                                                                    Organizer will be
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
                                                                    ✅ Confirm
                                                                </button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>

                                            <%-- Waive Modal --%>
                                            <div class="modal fade"
                                                 id="waiveModal${inv.id}"
                                                 tabindex="-1">
                                                <div class="modal-dialog
                                                            modal-dialog-centered">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">
                                                                Waive Invoice
                                                            </h5>
                                                            <button type="button"
                                                                    class="btn-close"
                                                                    data-bs-dismiss="modal">
                                                            </button>
                                                        </div>
                                                        <form action="${pageContext.request.contextPath}/admin/invoice/${inv.id}/waive"
                                                              method="post">
                                                            <input type="hidden"
                                                                   name="${_csrf.parameterName}"
                                                                   value="${_csrf.token}"/>
                                                            <input type="hidden"
                                                                   name="conferenceId"
                                                                   value="${inv.conference.id}"/>
                                                            <div class="modal-body">
                                                                <div class="alert
                                                                            alert-light
                                                                            border mb-3">
                                                                    <code>${inv.invoiceNumber}</code>
                                                                    ·
                                                                    <strong>
                                                                        ₹${inv.totalAmount}
                                                                    </strong>
                                                                    <br/>
                                                                    <small class="text-muted">
                                                                        ${inv.conference.title}
                                                                    </small>
                                                                </div>
                                                                <label class="form-label
                                                                              fw-semibold">
                                                                    Reason for waiver *
                                                                </label>
                                                                <textarea name="notes"
                                                                          class="form-control"
                                                                          rows="3"
                                                                          placeholder="e.g. NGO event, goodwill gesture, promotional partnership"
                                                                          required></textarea>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button"
                                                                        class="btn btn-secondary"
                                                                        data-bs-dismiss="modal">
                                                                    Cancel
                                                                </button>
                                                                <button type="submit"
                                                                        class="btn btn-warning
                                                                               fw-bold">
                                                                    Waive Invoice
                                                                </button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:when>

                                        <%-- PAID: show reference --%>
                                        <c:when test="${inv.status == 'PAID'}">
                                            <div class="text-muted"
                                                 style="font-size:0.7rem">
                                                Ref:
                                                <code>
                                                    ${inv.paymentReference}
                                                </code>
                                            </div>
                                            <a href="${pageContext.request.contextPath}/admin/conference/${inv.conference.id}"
                                               class="text-decoration-none
                                                      small"
                                               style="color:#667eea">
                                                View conference →
                                            </a>
                                        </c:when>

                                        <%-- WAIVED: show reason --%>
                                        <c:when test="${inv.status == 'WAIVED'}">
                                            <div class="text-muted"
                                                 style="font-size:0.68rem">
                                                ${not empty inv.notes
                                                    ? fn:substring(inv.notes,0,40)
                                                    : '—'}
                                            </div>
                                        </c:when>

                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <%-- Table footer with totals --%>
        <c:if test="${not empty invoices}">
            <div class="card-footer bg-white
                        d-flex justify-content-between
                        align-items-center py-2 small
                        text-muted"
                 style="border-radius:0 0 14px 14px">
                <span>
                    ${fn:length(invoices)}
                    invoice(s) shown
                </span>
                <span>
                    Pending: <strong
                        class="text-warning">
                        ₹<fmt:formatNumber
                            value="${totalPending}"
                            maxFractionDigits="0"/>
                    </strong>
                    &nbsp;·&nbsp;
                    Collected: <strong
                        class="text-success">
                        ₹<fmt:formatNumber
                            value="${totalCollected}"
                            maxFractionDigits="0"/>
                    </strong>
                </span>
            </div>
        </c:if>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>