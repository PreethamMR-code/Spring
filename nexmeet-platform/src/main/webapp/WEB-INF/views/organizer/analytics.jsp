<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"
    uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt"
    uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Analytics - NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet"/>
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: #f8f9fc;
        }
        .page-header {
            background: linear-gradient(135deg,
                #667eea 0%, #764ba2 100%);
            padding: 40px 0 56px;
            color: white;
        }
        .stat-card {
            background: white;
            border-radius: 14px;
            padding: 22px;
            border: 1.5px solid #e8ecf0;
            margin-top: -32px;
            position: relative;
            z-index: 10;
            text-align: center;
        }
        .stat-number {
            font-size: 2rem;
            font-weight: 800;
            line-height: 1;
        }
        .stat-label {
            font-size: 0.78rem;
            color: #64748b;
            margin-top: 6px;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        .chart-card {
            background: white;
            border-radius: 14px;
            border: 1.5px solid #e8ecf0;
            padding: 24px;
        }
        .chart-title {
            font-weight: 700;
            font-size: 0.95rem;
            color: #0f172a;
            margin-bottom: 20px;
        }
        .status-dot {
            width: 10px; height: 10px;
            border-radius: 50%;
            display: inline-block;
            margin-right: 6px;
        }
        .table-analytics th {
            font-size: 0.78rem;
            font-weight: 600;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.04em;
            border-bottom: 2px solid #e8ecf0;
        }
        .table-analytics td {
            font-size: 0.88rem;
            vertical-align: middle;
            border-color: #f1f5f9;
        }
        .capacity-bar {
            height: 6px;
            background: #f1f5f9;
            border-radius: 3px;
            overflow: hidden;
            margin-top: 4px;
        }
        .capacity-fill {
            height: 100%;
            border-radius: 3px;
            background: linear-gradient(90deg,
                #667eea, #764ba2);
        }
        .rating-star { color: #fbbf24; }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<!-- Page Header -->
<div class="page-header">
    <div class="container">
        <div class="d-flex justify-content-between
                    align-items-center">
            <div>
                <div style="font-size:0.82rem;
                     color:rgba(255,255,255,0.7);
                     margin-bottom:6px">
                    <a href="${pageContext.request.contextPath}/organizer/dashboard"
                       style="color:rgba(255,255,255,0.7);
                              text-decoration:none">
                        Dashboard
                    </a>
                    → Analytics
                </div>
                <h2 style="font-weight:800;
                     margin:0;color:white">
                    📊 Organizer Analytics
                </h2>
                <div style="color:rgba(255,255,255,0.7);
                     font-size:0.88rem;
                     margin-top:4px">
                    Performance overview across all
                    your conferences
                </div>
            </div>
            <a href="${pageContext.request.contextPath}/organizer/dashboard"
               class="btn btn-outline-light btn-sm">
                ← Dashboard
            </a>
        </div>
    </div>
</div>

<div class="container pb-5">

    <!-- ── Summary Stat Cards ──────────────────── -->
    <div class="row g-3">
        <div class="col-6 col-md-2">
            <div class="stat-card">
                <div class="stat-number text-primary">
                    ${totalConferences}
                </div>
                <div class="stat-label">Conferences</div>
            </div>
        </div>
        <div class="col-6 col-md-2">
            <div class="stat-card">
                <div class="stat-number text-success">
                    ${totalRegistrations}
                </div>
                <div class="stat-label">
                    Registrations
                </div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="stat-card">
                <div class="stat-number"
                     style="color:#059669">
                    ₹<fmt:formatNumber
                        value="${totalOrganizerRevenue}"
                        maxFractionDigits="0"/>
                </div>
                <div class="stat-label">
                    Your Earnings
                </div>
            </div>
        </div>
        <div class="col-6 col-md-2">
            <div class="stat-card">
                <div class="stat-number text-warning">
                    <c:choose>
                        <c:when test="${overallRating > 0}">
                            <fmt:formatNumber
                                value="${overallRating}"
                                maxFractionDigits="1"/>
                        </c:when>
                        <c:otherwise>—</c:otherwise>
                    </c:choose>
                </div>
                <div class="stat-label">
                    Avg Rating
                </div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="stat-card">
                <div class="d-flex
                            justify-content-center
                            gap-3 flex-wrap">
                    <div>
                        <div class="stat-number
                                    text-success"
                             style="font-size:1.3rem">
                            ${approvedCount}
                        </div>
                        <div class="stat-label">
                            Live
                        </div>
                    </div>
                    <div>
                        <div class="stat-number"
                             style="font-size:1.3rem;
                                    color:#334155">
                            ${completedCount}
                        </div>
                        <div class="stat-label">
                            Done
                        </div>
                    </div>
                    <div>
                        <div class="stat-number
                                    text-warning"
                             style="font-size:1.3rem">
                            ${submittedCount}
                        </div>
                        <div class="stat-label">
                            Pending
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- ── Charts Row ──────────────────────────── -->
    <c:choose>
        <c:when test="${totalConferences == 0}">
            <div class="text-center py-5 mt-4">
                <div style="font-size:3rem">📊</div>
                <h5 class="fw-bold mt-3">
                    No data yet
                </h5>
                <p class="text-muted">
                    Create your first conference
                    to see analytics here.
                </p>
                <a href="${pageContext.request.contextPath}/organizer/conference/create"
                   class="btn btn-primary">
                    + Create Conference
                </a>
            </div>
        </c:when>
        <c:otherwise>

    <div class="row g-4 mt-2">

        <!-- Registrations Bar Chart -->
        <div class="col-lg-8">
            <div class="chart-card">
                <div class="chart-title">
                    📋 Registrations per Conference
                </div>
                <canvas id="regChart"
                        height="120"></canvas>
            </div>
        </div>

        <!-- Status Doughnut Chart -->
        <div class="col-lg-4">
            <div class="chart-card h-100">
                <div class="chart-title">
                    🎯 Conference Status
                </div>
                <canvas id="statusChart"
                        height="200"></canvas>
                <div class="mt-3">
                    <div class="d-flex
                        justify-content-between
                        flex-wrap gap-2 small">
                        <span>
                            <span class="status-dot"
                                  style="background:#22c55e">
                            </span>Live: ${approvedCount}
                        </span>
                        <span>
                            <span class="status-dot"
                                  style="background:#334155">
                            </span>Done: ${completedCount}
                        </span>
                        <span>
                            <span class="status-dot"
                                  style="background:#f59e0b">
                            </span>Pending: ${submittedCount}
                        </span>
                        <span>
                            <span class="status-dot"
                                  style="background:#94a3b8">
                            </span>Draft: ${draftCount}
                        </span>
                        <span>
                            <span class="status-dot"
                                  style="background:#ef4444">
                            </span>Cancelled: ${cancelledCount}
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Revenue Bar Chart -->
        <c:if test="${totalOrganizerRevenue > 0}">
        <div class="col-12">
            <div class="chart-card">
                <div class="chart-title">
                    💰 Revenue Earned per Conference
                    (Your Share ₹)
                </div>
                <canvas id="revenueChart"
                        height="80"></canvas>
            </div>
        </div>
        </c:if>

    </div>

    <!-- ── Conference Comparison Table ─────────── -->
    <div class="chart-card mt-4">
        <div class="chart-title">
            📋 Conference Performance Breakdown
        </div>
        <c:choose>
            <c:when test="${empty conferences}">
                <p class="text-muted small">
                    No conferences yet.
                </p>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table
                                  table-analytics
                                  mb-0">
                        <thead>
                            <tr>
                                <th>Conference</th>
                                <th>Status</th>
                                <th>Type</th>
                                <th class="text-center">
                                    Registered
                                </th>
                                <th class="text-center">
                                    Capacity
                                </th>
                                <th class="text-center">
                                    Fill %
                                </th>
                                <th class="text-center">
                                    Attended
                                </th>
                                <th class="text-end">
                                    Your Revenue
                                </th>
                                <th class="text-center">
                                    Rating
                                </th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="conf"
                                       items="${conferences}"
                                       varStatus="loop">

                                <%-- Calculate fill % --%>
                                <c:set var="fillPct"
                                       value="0"/>
                                <c:if test="${conf.maxDelegates > 0}">
                                    <c:set var="fillPct"
                                           value="${conf.registeredCount * 100 / conf.maxDelegates}"/>
                                </c:if>

                                <tr>
                                    <td style="max-width:180px">
                                        <div class="fw-semibold small">
                                            ${conf.title}
                                        </div>
                                        <div class="text-muted"
                                             style="font-size:0.72rem">
                                            ${fn:substringBefore(
                                                conf.startDate.toString(),
                                                'T')}
                                        </div>
                                    </td>
                                    <td>
                                        <span class="badge small
                                            ${conf.status == 'APPROVED'
                                                ? 'bg-success'
                                            : conf.status == 'COMPLETED'
                                                ? 'bg-dark'
                                            : conf.status == 'SUBMITTED'
                                                ? 'bg-warning text-dark'
                                            : conf.status == 'CANCELLED'
                                                ? 'bg-danger'
                                            : 'bg-secondary'}">
                                            ${conf.status}
                                        </span>
                                    </td>
                                    <td class="small
                                               text-muted">
                                        ${conf.conferenceType}
                                    </td>
                                    <td class="text-center
                                               fw-semibold">
                                        ${conf.registeredCount}
                                    </td>
                                    <td class="text-center
                                               text-muted small">
                                        ${conf.maxDelegates}
                                    </td>
                                    <td class="text-center"
                                        style="min-width:90px">
                                        <div class="small fw-semibold
                                            ${fillPct > 80
                                                ? 'text-danger'
                                            : fillPct > 50
                                                ? 'text-warning'
                                            : 'text-success'}">
                                            <fmt:formatNumber
                                                value="${fillPct}"
                                                maxFractionDigits="0"/>%
                                        </div>
                                        <div class="capacity-bar">
                                            <div class="capacity-fill"
                                                 style="width:${fillPct}%">
                                            </div>
                                        </div>
                                    </td>
                                    <td class="text-center">
                                        ${attendanceCounts[loop.index]}
                                    </td>
                                    <td class="text-end
                                               fw-semibold
                                               text-success small">
                                        <c:if test="${!conf.free}">
                                            ₹<fmt:formatNumber
                                                value="${conf.delegateFee
                                                    * conf.registeredCount}"
                                                maxFractionDigits="0"/>
                                            <div class="text-muted"
                                                 style="font-size:0.7rem;
                                                        font-weight:400">
                                                (est.)
                                            </div>
                                        </c:if>
                                        <c:if test="${conf.free}">
                                            <span class="text-muted
                                                         small">
                                                Free
                                            </span>
                                        </c:if>
                                    </td>
                                    <td class="text-center">
                                        <!-- Rating not per-conf in model
                                             so show a dash -->
                                        <span class="rating-star
                                                     small">★</span>
                                        <span class="small text-muted">
                                            —
                                        </span>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}"
                                           class="btn btn-outline-primary
                                                  btn-sm"
                                           style="font-size:0.72rem;
                                                  padding:3px 10px">
                                            View
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

        </c:otherwise>
    </c:choose>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js">
</script>

<script>
/*
 * Chart data comes from Spring model attributes
 * rendered as JSON arrays directly into JS.
 * All escaping is done server-side in buildStringJson().
 */

const labels    = ${confTitlesJson};
const regData   = ${regCountsJson};
const revData   = ${revenueJson};
const attData   = ${attendanceJson};

/* ── Registrations Bar Chart ── */
const regCtx = document.getElementById('regChart');
if (regCtx) {
    new Chart(regCtx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [
                {
                    label: 'Registered',
                    data: regData,
                    backgroundColor:
                        'rgba(102,126,234,0.8)',
                    borderColor:
                        'rgba(102,126,234,1)',
                    borderWidth: 1,
                    borderRadius: 6
                },
                {
                    label: 'Attended',
                    data: attData,
                    backgroundColor:
                        'rgba(34,197,94,0.7)',
                    borderColor:
                        'rgba(34,197,94,1)',
                    borderWidth: 1,
                    borderRadius: 6
                }
            ]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'top',
                    labels: { font: { size: 12 } }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: { stepSize: 1 },
                    grid: {
                        color: 'rgba(0,0,0,0.04)'
                    }
                },
                x: {
                    grid: { display: false }
                }
            }
        }
    });
}

/* ── Status Doughnut ── */
const statusCtx =
    document.getElementById('statusChart');
if (statusCtx) {
    new Chart(statusCtx, {
        type: 'doughnut',
        data: {
            labels: [
                'Live', 'Completed',
                'Pending', 'Draft', 'Cancelled'
            ],
            datasets: [{
                data: [
                    ${approvedCount},
                    ${completedCount},
                    ${submittedCount},
                    ${draftCount},
                    ${cancelledCount}
                ],
                backgroundColor: [
                    '#22c55e', '#334155',
                    '#f59e0b', '#94a3b8',
                    '#ef4444'
                ],
                borderWidth: 2,
                borderColor: '#fff'
            }]
        },
        options: {
            responsive: true,
            cutout: '65%',
            plugins: {
                legend: { display: false }
            }
        }
    });
}

/* ── Revenue Bar Chart ── */
const revCtx =
    document.getElementById('revenueChart');
if (revCtx) {
    new Chart(revCtx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'Revenue (₹)',
                data: revData,
                backgroundColor:
                    'rgba(5,150,105,0.75)',
                borderColor:
                    'rgba(5,150,105,1)',
                borderWidth: 1,
                borderRadius: 6
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { display: false }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: {
                        color: 'rgba(0,0,0,0.04)'
                    },
                    ticks: {
                        callback: function(v) {
                            return '₹' + v;
                        }
                    }
                },
                x: {
                    grid: { display: false }
                }
            }
        }
    });
}
</script>

</body>
</html>