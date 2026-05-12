<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Commission Settings - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
</head>
<body class="bg-light">

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container py-4">

  <!--Adding actual revenue section at the top -->

    <div class="row g-3 mb-4">
        <div class="col-md-6">
            <div class="card text-center p-3
                        border-success">
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
            <div class="card text-center p-3
                        border-primary">
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

    <!-- Recent Payments Table -->
    <c:if test="${not empty allPayments}">
    <div class="card mt-4">
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
                        <th class="text-end">
                            Platform
                        </th>
                        <th class="text-end">
                            Organizer
                        </th>
                        <th>Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="pay"
                               items="${allPayments}">
                        <tr>
                            <td>
                                <code style="font-size:
                                             0.72rem">
                                    ${pay.transactionRef}
                                </code>
                            </td>
                            <td class="small">
                                ${pay.conference.title}
                            </td>
                            <td class="small">
                                ${pay.payerUser.fullName}
                            </td>
                            <td class="text-end
                                       fw-semibold">
                                ₹${pay.amount}
                            </td>
                            <td class="text-end
                                       text-danger">
                                ₹${pay.platformCommission}
                            </td>
                            <td class="text-end
                                       text-success">
                                ₹${pay.organizerAmount}
                            </td>
                            <td class="text-muted small">
                                ${fn:substringBefore(
                                    pay.initiatedAt
                                        .toString(),
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



    <div class="d-flex justify-content-between
                align-items-center mb-4">
        <div>
            <h2 class="text-danger">Commission Settings</h2>
            <p class="text-muted mb-0">
                Platform earns base fee + per-delegate fee
                for each conference type
            </p>
        </div>
        <div class="text-end">
            <div class="fw-bold fs-5 text-success">
                Total Expected: ₹${totalRevenue}
            </div>
            <a href="${pageContext.request.contextPath}/admin/dashboard"
               class="btn btn-outline-secondary btn-sm mt-1">
                Back
            </a>
        </div>
    </div>

    <%-- How it works explanation --%>
    <div class="alert alert-info mb-4">
        <strong>How platform revenue works:</strong>
        For each conference, the organizer owes the platform:
        <strong>Base Fee</strong> (fixed listing fee) +
        <strong>Per-Delegate Fee × confirmed registrations</strong>.
        The organizer keeps the rest from delegate payments.
    </div>

    <div class="card">
        <div class="card-body p-0">
            <table class="table table-hover
                          table-bordered mb-0">
                <thead class="table-danger">
                    <tr>
                        <th>Conference Type</th>
                        <th>Base Fee (₹)</th>
                        <th>Per Delegate Fee (₹)</th>
                        <th>Description</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="s" items="${settings}">
                        <tr>
                            <td>
                                <strong>${s[0]}</strong>
                            </td>
                            <td class="text-danger fw-semibold">
                                ₹${s[1]}
                            </td>
                            <td class="text-warning fw-semibold">
                                ₹${s[2]}
                            </td>
                            <td class="text-muted small">
                                ${s[3]}
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${s[4]}">
                                        <span class="badge
                                            bg-success">
                                            Active
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge
                                            bg-secondary">
                                            Inactive
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

    <div class="alert alert-warning mt-4">
        <strong>Note:</strong> To modify commission rates,
        update the <code>commission_settings</code> table
        directly in the database. Future version will add
        an edit form here.
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>