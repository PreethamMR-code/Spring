<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Invoices – NexMeet</title>
    <meta name="viewport"
          content="width=device-width, initial-scale=1"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet"/>
    <style>
        body {
            background: #f0f2f5;
            font-family: 'Inter', sans-serif;
        }
        .stat-card {
            border: none;
            border-radius: 14px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.07);
            padding: 24px;
        }
        .stat-num {
            font-size: 2rem;
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
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container py-4"
     style="max-width:960px">

    <%-- Header --%>
    <div class="d-flex justify-content-between
                align-items-center mb-4">
        <div>
            <h2 class="mb-0 fw-800"
                style="font-weight:800;color:#0f172a">
                🧾 My Invoices
            </h2>
            <p class="text-muted mb-0 small">
                Platform commission invoices
                for your conferences
            </p>
        </div>
        <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/organizer/conferences"
               class="btn btn-outline-secondary btn-sm">
                My Conferences
            </a>
            <a href="${pageContext.request.contextPath}/organizer/dashboard"
               class="btn btn-outline-secondary btn-sm">
                Dashboard
            </a>
        </div>
    </div>

    <%-- Pending payment instruction banner --%>
    <c:if test="${pendingCount > 0}">
        <div class="mb-4"
             style="background:#fff7ed;
                    border:2px solid #fed7aa;
                    border-radius:14px;
                    padding:20px 24px">
            <div class="fw-bold mb-2"
                 style="color:#9a3412;font-size:1rem">
                ⚠️ You have ${pendingCount}
                unpaid invoice<c:if
                    test="${pendingCount > 1}">s</c:if>
                totalling
                ₹<fmt:formatNumber
                    value="${totalPending}"
                    maxFractionDigits="2"/>
            </div>
            <div class="small"
                 style="color:#c2410c;line-height:1.8">
                To clear your balance, transfer the
                amount for each invoice to NexMeet
                and reference the <strong>invoice
                number</strong> in your payment
                description. The admin will confirm
                receipt and mark it as paid.
                <br/>
                <strong>UPI:</strong> nexmeet@upi
                &nbsp;·&nbsp;
                <strong>Bank:</strong> Axis Bank,
                A/C 123456789012, IFSC UTIB0001234
                &nbsp;·&nbsp;
                <strong>Contact:</strong>
                billing@nexmeet.com
            </div>
        </div>
    </c:if>

    <%-- Stat cards --%>
    <div class="row g-3 mb-4">
        <div class="col-6 col-md-3">
            <div class="stat-card text-center bg-white"
                 style="border-left:5px solid
                        #f59e0b !important">
                <div class="text-muted small mb-1
                            text-uppercase fw-semibold"
                     style="font-size:0.72rem;
                            letter-spacing:0.05em">
                    Pending
                </div>
                <div class="stat-num text-warning">
                    ${pendingCount}
                </div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="stat-card text-center bg-white"
                 style="border-left:5px solid
                        #ef4444 !important">
                <div class="text-muted small mb-1
                            text-uppercase fw-semibold"
                     style="font-size:0.72rem;
                            letter-spacing:0.05em">
                    Amount Due
                </div>
                <div class="stat-num"
                     style="color:#ef4444;
                            font-size:1.6rem">
                    ₹<fmt:formatNumber
                        value="${totalPending}"
                        maxFractionDigits="0"/>
                </div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="stat-card text-center bg-white"
                 style="border-left:5px solid
                        #22c55e !important">
                <div class="text-muted small mb-1
                            text-uppercase fw-semibold"
                     style="font-size:0.72rem;
                            letter-spacing:0.05em">
                    Paid
                </div>
                <div class="stat-num text-success">
                    ${paidCount}
                </div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="stat-card text-center bg-white"
                 style="border-left:5px solid
                        #94a3b8 !important">
                <div class="text-muted small mb-1
                            text-uppercase fw-semibold"
                     style="font-size:0.72rem;
                            letter-spacing:0.05em">
                    Waived
                </div>
                <div class="stat-num text-secondary">
                    ${waivedCount}
                </div>
            </div>
        </div>
    </div>

    <%-- Invoice list --%>
    <div class="card"
         style="border:none;border-radius:14px;
                box-shadow:0 2px 12px rgba(0,0,0,0.09)">
        <div class="card-header fw-bold bg-white
                    py-3"
             style="border-radius:14px 14px 0 0">
            All Invoices
            <span class="text-muted fw-normal small ms-2">
                ${fn:length(invoices)} total
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
                            No invoices yet.
                        </div>
                        <div class="small mt-1">
                            Invoices are generated by
                            admin after your conferences
                            complete.
                        </div>
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
                                <th>Breakdown</th>
                                <th class="text-end">
                                    Total Due
                                </th>
                                <th>Generated</th>
                                <th>Status</th>
                                <th>Details</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="inv"
                                   items="${invoices}">
                            <tr>
                                <td class="ps-3">
                                    <code style="
                                        font-weight:700;
                                        font-size:0.8rem">
                                        ${inv.invoiceNumber}
                                    </code>
                                </td>

                                <td>
                                    <div class="fw-semibold">
                                        ${fn:length(inv.conference.title) > 28
                                            ? fn:substring(inv.conference.title,0,28).concat('…')
                                            : inv.conference.title}
                                    </div>
                                    <div class="text-muted"
                                         style="font-size:0.68rem">
                                        ${inv.conference.conferenceType}
                                        · ${inv.conference.mode}
                                    </div>
                                </td>

                                <td>
                                    <div style="font-size:0.72rem;
                                         color:#64748b;
                                         line-height:1.7">
                                        Base: ₹${inv.baseFee}
                                        <br/>
                                        Per-delegate
                                        (×${inv.registeredCount}):
                                        ₹${inv.perDelegateFee}
                                    </div>
                                </td>

                                <td class="text-end">
                                    <span style="font-size:
                                         1.05rem;
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
                                        </c:when>
                                        <c:when test="${inv.status == 'WAIVED'}">
                                            <span class="inv-badge-waived">
                                                WAIVED
                                            </span>
                                        </c:when>
                                    </c:choose>
                                </td>

                                <td style="min-width:160px">
                                    <c:choose>
                                                                            <%-- PENDING: show payment instructions --%>
                                                                            <c:when test="${inv.status == 'PENDING'}">
                                                                                <div style="font-size:0.7rem;
                                                                                     color:#9a3412;
                                                                                     line-height:1.6">
                                                                                    Transfer
                                                                                    <strong>
                                                                                        ₹${inv.totalAmount}
                                                                                    </strong>
                                                                                    to UPI:
                                                                                    <code>
                                                                                        nexmeet@upi
                                                                                    </code>
                                                                                    <br/>
                                                                                    Reference:
                                                                                    <code class="fw-bold">
                                                                                        ${inv.invoiceNumber}
                                                                                    </code>
                                                                                </div>

                                                                                <%--
                                                                                    If organizer already submitted
                                                                                    a reference, show it as
                                                                                    "awaiting confirmation" instead
                                                                                    of the submit form again.
                                                                                --%>
                                                                                <c:choose>
                                                                                    <c:when test="${not empty inv.submittedPaymentReference}">
                                                                                        <div class="mt-2 p-2"
                                                                                             style="background:#eff6ff;
                                                                                                    border:1px solid #bfdbfe;
                                                                                                    border-radius:8px;
                                                                                                    font-size:0.7rem;
                                                                                                    line-height:1.6">
                                                                                            <span style="color:#1d4ed8;
                                                                                                  font-weight:700">
                                                                                                ⏱ Awaiting admin confirmation
                                                                                            </span>
                                                                                            <br/>
                                                                                            <span class="text-muted">
                                                                                                Submitted ref:
                                                                                            </span>
                                                                                            <code>
                                                                                                ${inv.submittedPaymentReference}
                                                                                            </code>
                                                                                            <br/>
                                                                                            <span class="text-muted">
                                                                                                On:
                                                                                            </span>
                                                                                            ${fn:substringBefore(
                                                                                                inv.submittedAt
                                                                                                    .toString(),
                                                                                                'T')}
                                                                                        </div>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <form action="${pageContext.request.contextPath}/organizer/invoice/${inv.id}/submit-payment"
                                                                                              method="post"
                                                                                              class="mt-2 d-flex gap-1">
                                                                                            <input type="hidden"
                                                                                                   name="${_csrf.parameterName}"
                                                                                                   value="${_csrf.token}"/>
                                                                                            <input type="text"
                                                                                                   name="paymentReference"
                                                                                                   class="form-control form-control-sm"
                                                                                                   style="font-size:0.7rem"
                                                                                                   placeholder="UTR/UPI/Cheque No."
                                                                                                   required/>
                                                                                            <button type="submit"
                                                                                                    class="btn btn-sm
                                                                                                           fw-bold
                                                                                                           text-white"
                                                                                                    style="background:#ea580c;
                                                                                                           border:none;
                                                                                                           white-space:nowrap;
                                                                                                           font-size:0.7rem">
                                                                                                I've Paid
                                                                                            </button>
                                                                                        </form>
                                                                                    </c:otherwise>
                                                 </c:choose>
                                            </c:when>
                                        <%-- PAID: show reference + date --%>
                                        <c:when test="${inv.status == 'PAID'}">
                                            <div style="font-size:0.7rem;
                                                 line-height:1.7">
                                                <span class="text-muted">
                                                    Ref:
                                                </span>
                                                <code>
                                                    ${inv.paymentReference}
                                                </code>
                                                <br/>
                                                <span class="text-muted">
                                                    Paid:
                                                </span>
                                                ${fn:substringBefore(
                                                    inv.paidAt
                                                        .toString(),
                                                    'T')}
                                            </div>
                                        </c:when>

                                        <%-- WAIVED: show reason --%>
                                        <c:when test="${inv.status == 'WAIVED'}">
                                            <div class="text-muted"
                                                 style="font-size:0.7rem">
                                                ${not empty inv.notes
                                                    ? inv.notes
                                                    : 'Waived by admin'}
                                            </div>
                                        </c:when>
                                    </c:choose>
                                    <%-- Always link to conference --%>
                                    <a href="${pageContext.request.contextPath}/organizer/conference/${inv.conference.id}"
                                       class="text-decoration-none mt-1 d-block"
                                       style="font-size:0.68rem;
                                              color:#667eea">
                                        View conference →
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    </div>


                    <%-- Footer totals --%>
                    <div class="card-footer bg-white
                                d-flex justify-content-between
                                align-items-center py-2
                                small text-muted"
                         style="border-radius:
                                0 0 14px 14px">
                        <span>
                            ${fn:length(invoices)}
                            invoice(s) total
                        </span>
                        <span>
                            Due:
                            <strong
                                class="text-warning">
                                ₹<fmt:formatNumber
                                    value="${totalPending}"
                                    maxFractionDigits="0"/>
                            </strong>
                            &nbsp;·&nbsp;
                            Paid:
                            <strong
                                class="text-success">
                                ₹<fmt:formatNumber
                                    value="${totalPaid}"
                                    maxFractionDigits="0"/>
                            </strong>
                        </span>
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