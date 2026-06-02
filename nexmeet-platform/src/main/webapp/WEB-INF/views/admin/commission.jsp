<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Commission Settings – Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
</head>
<body class="bg-light">

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container py-4">

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

    <%-- Revenue summary cards --%>
    <div class="row g-3 mb-4">
        <div class="col-md-6">
            <div class="card text-center p-3 border-success">
                <h6 class="text-muted small">
                    Actual Platform Revenue
                </h6>
                <h3 class="text-success fw-bold">
                    ₹${totalRevenue}
                </h3>
                <small class="text-muted">
                    From completed payments
                </small>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card text-center p-3 border-primary">
                <h6 class="text-muted small">
                    Projected Revenue
                </h6>
                <h3 class="text-primary fw-bold">
                    ₹${projectedRevenue}
                </h3>
                <small class="text-muted">
                    Calculated from registrations
                </small>
            </div>
        </div>
    </div>

    <%-- Recent Payments Table --%>
    <c:if test="${not empty allPayments}">
        <div class="card mb-4">
            <div class="card-header fw-bold">
                Recent Payments
            </div>
            <div class="card-body p-0">
                <table class="table table-hover
                              table-sm mb-0 small">
                    <thead class="table-light">
                        <tr>
                            <th>Transaction Ref</th>
                            <th>Conference</th>
                            <th>Delegate</th>
                            <th class="text-end">Amount</th>
                            <th class="text-end">Platform</th>
                            <th class="text-end">Organizer</th>
                            <th>Date</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="pay"
                                   items="${allPayments}">
                            <tr>
                                <td>
                                    <code style="font-size:0.72rem">
                                        ${pay.transactionRef}
                                    </code>
                                </td>
                                <td class="small">
                                    ${pay.conference.title}
                                </td>
                                <td class="small">
                                    ${pay.payerUser.fullName}
                                </td>
                                <td class="text-end fw-semibold">
                                    ₹${pay.amount}
                                </td>
                                <td class="text-end text-danger">
                                    ₹${pay.platformCommission}
                                </td>
                                <td class="text-end text-success">
                                    ₹${pay.organizerAmount}
                                </td>
                                <td class="text-muted small">
                                    ${fn:substringBefore(
                                        pay.initiatedAt.toString(),
                                        'T')}
                                </td>
                                <td>
                                    <span class="badge
                                        ${pay.status == 'COMPLETED'
                                            ? 'bg-success'
                                            : 'bg-warning text-dark'}">
                                        ${pay.status}
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </c:if>

    <%-- Commission Settings Header --%>
    <div class="d-flex justify-content-between
                align-items-center mb-3">
        <div>
            <h2 class="text-danger mb-1">
                Commission Settings
            </h2>
            <p class="text-muted mb-0 small">
                Platform earns base fee
                + per-delegate fee per conference type.
                Click ✏️ Edit to update any rate.
            </p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/dashboard"
           class="btn btn-outline-secondary btn-sm">
            ← Back
        </a>
    </div>

    <div class="alert alert-info small mb-3">
        <strong>How it works:</strong>
        Organizer owes:
        <strong>Base Fee</strong> (listing fee, charged once) +
        <strong>Per-Delegate Fee × registered count</strong>
        (success fee after event).
        Rate changes apply to <strong>future invoices only</strong>
        — existing invoices are not affected.
    </div>

    <%-- Commission Rates Table --%>
    <div class="card">
        <div class="card-body p-0">
            <table class="table table-hover
                          table-bordered mb-0 small">
                <thead class="table-danger">
                    <tr>
                        <th>Conference Type</th>
                        <th>Base Fee (₹)</th>
                        <th>Per-Delegate (₹)</th>
                        <th>Description</th>
                        <th>Status</th>
                        <th>Edit</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="s" items="${settings}">
                        <tr>
                            <td><strong>${s[0]}</strong></td>
                            <td class="text-danger fw-semibold">
                                ₹${s[1]}
                            </td>
                            <td class="text-warning fw-semibold">
                                ₹${s[2]}
                            </td>
                            <td class="text-muted">
                                ${s[3]}
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${s[4]}">
                                        <span class="badge bg-success">
                                            Active
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">
                                            Inactive
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <button class="btn btn-outline-primary
                                               btn-sm"
                                        data-bs-toggle="modal"
                                        data-bs-target="#editModal${s[0]}">
                                    ✏️ Edit
                                </button>

                                <%--
                                    Edit Modal — one per row.
                                    ID uses conference type string
                                    (unique per row) to avoid
                                    modal ID collisions.
                                --%>
                                <div class="modal fade"
                                     id="editModal${s[0]}"
                                     tabindex="-1">
                                    <div class="modal-dialog
                                                modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header
                                                        bg-danger
                                                        text-white">
                                                <h5 class="modal-title
                                                            fw-bold">
                                                    Edit: ${s[0]}
                                                </h5>
                                                <button type="button"
                                                        class="btn-close
                                                               btn-close-white"
                                                        data-bs-dismiss="modal">
                                                </button>
                                            </div>
                                            <form action="${pageContext.request.contextPath}/admin/commission/update"
                                                  method="post">
                                                <input type="hidden"
                                                       name="${_csrf.parameterName}"
                                                       value="${_csrf.token}"/>
                                                <input type="hidden"
                                                       name="conferenceType"
                                                       value="${s[0]}"/>
                                                <div class="modal-body">
                                                    <div class="mb-3">
                                                        <label class="form-label
                                                                      fw-semibold">
                                                            Base Fee (₹)
                                                            <span class="text-muted
                                                                  fw-normal small">
                                                                — fixed listing fee
                                                            </span>
                                                        </label>
                                                        <input type="number"
                                                               name="baseFee"
                                                               class="form-control"
                                                               value="${s[1]}"
                                                               min="0"
                                                               step="0.01"
                                                               required/>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label
                                                                      fw-semibold">
                                                            Per-Delegate Fee (₹)
                                                            <span class="text-muted
                                                                  fw-normal small">
                                                                — per registration
                                                            </span>
                                                        </label>
                                                        <input type="number"
                                                               name="perDelegateFee"
                                                               class="form-control"
                                                               value="${s[2]}"
                                                               min="0"
                                                               step="0.01"
                                                               required/>
                                                    </div>
                                                    <div class="alert alert-warning
                                                                small py-2 mb-0">
                                                        ⚠️ Changes apply to
                                                        <strong>future invoices only</strong>.
                                                        Existing invoices are not changed.
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button"
                                                            class="btn btn-secondary"
                                                            data-bs-dismiss="modal">
                                                        Cancel
                                                    </button>
                                                    <button type="submit"
                                                            class="btn btn-danger
                                                                   fw-bold">
                                                        Save Changes
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>