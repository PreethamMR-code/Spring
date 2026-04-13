<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>NexMeet - Conference Management Platform</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <style>
        .hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 100px 0;
        }
        .hero h1 { font-size: 3.5rem; font-weight: 800; }
        .hero p  { font-size: 1.3rem; opacity: 0.9; }
        .feature-card {
            border: none;
            border-radius: 12px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            transition: transform 0.2s;
            height: 100%;
        }
        .feature-card:hover { transform: translateY(-5px); }
        .feature-icon { font-size: 2.5rem; margin-bottom: 15px; }
        .role-card {
            border-radius: 12px;
            padding: 25px;
            color: white;
            text-align: center;
        }
        .stats-section { background: #f8f9fa; padding: 60px 0; }
        .stat-number { font-size: 2.5rem; font-weight: 800; }
        .navbar-brand { font-size: 1.5rem; font-weight: 800; color: #667eea !important; }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            NexMeet
        </a>
        <div class="ms-auto d-flex gap-2">
            <a href="${pageContext.request.contextPath}/conferences"
               class="btn btn-outline-secondary">Browse Conferences</a>
            <a href="${pageContext.request.contextPath}/login"
               class="btn btn-outline-primary">Login</a>
            <a href="${pageContext.request.contextPath}/register"
               class="btn btn-primary">Register</a>
        </div>
    </div>
</nav>

<!-- Hero -->
<section class="hero text-center">
    <div class="container">
        <h1>Manage Conferences<br>The Smart Way</h1>
        <p class="mt-3 mb-4">
            NexMeet brings organizers, delegates, and admins together<br>
            on one seamless platform — from creation to certificate.
        </p>
        <div class="d-flex justify-content-center gap-3 flex-wrap">
            <a href="${pageContext.request.contextPath}/conferences"
               class="btn btn-light btn-lg px-5">
                Browse Conferences
            </a>
            <a href="${pageContext.request.contextPath}/register"
               class="btn btn-outline-light btn-lg px-5">
                Get Started Free
            </a>
        </div>
    </div>
</section>

<!-- Stats -->
<section class="stats-section">
    <div class="container text-center">
        <div class="row g-4">
            <div class="col-md-3">
                <div class="stat-number text-primary">
                    ${totalConferences}
                </div>
                <p class="text-muted">Active Conferences</p>
            </div>
            <div class="col-md-3">
                <div class="stat-number text-success">QR</div>
                <p class="text-muted">Smart Check-in</p>
            </div>
            <div class="col-md-3">
                <div class="stat-number text-warning">PDF</div>
                <p class="text-muted">Instant Tickets</p>
            </div>
            <div class="col-md-3">
                <div class="stat-number text-danger">
                    ${totalUsers}
                </div>
                <p class="text-muted">Registered Users</p>
            </div>
        </div>
    </div>
</section>

<!-- Features -->
<section class="py-5">
    <div class="container">
        <h2 class="text-center fw-bold mb-2">Everything You Need</h2>
        <p class="text-center text-muted mb-5">
            End-to-end conference management in one platform
        </p>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="feature-card bg-white">
                    <div class="feature-icon">📋</div>
                    <h5 class="fw-bold">Easy Registration</h5>
                    <p class="text-muted">
                        Delegates register in seconds. Instant confirmation
                        with a unique registration number.
                    </p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card bg-white">
                    <div class="feature-icon">🎫</div>
                    <h5 class="fw-bold">PDF Admission Ticket</h5>
                    <p class="text-muted">
                        Auto-generated ticket PDF with large QR code,
                        venue details, and entry instructions.
                    </p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card bg-white">
                    <div class="feature-icon">📱</div>
                    <h5 class="fw-bold">QR Check-in</h5>
                    <p class="text-muted">
                        Organizers scan QR codes at the venue for
                        instant, paperless attendance marking.
                    </p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card bg-white">
                    <div class="feature-icon">📄</div>
                    <h5 class="fw-bold">Auto Certificates</h5>
                    <p class="text-muted">
                        Delegates get beautiful participation certificates
                        automatically after attending the conference.
                    </p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card bg-white">
                    <div class="feature-icon">✅</div>
                    <h5 class="fw-bold">Admin Approval</h5>
                    <p class="text-muted">
                        Platform admins review and approve conferences
                        before they go live to the public.
                    </p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card bg-white">
                    <div class="feature-icon">📊</div>
                    <h5 class="fw-bold">Real-time Analytics</h5>
                    <p class="text-muted">
                        Organizers track registrations, attendance, and
                        seat availability in real time.
                    </p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Roles Section -->
<section class="py-5 bg-light">
    <div class="container">
        <h2 class="text-center fw-bold mb-2">Built for Everyone</h2>
        <p class="text-center text-muted mb-5">One platform, four roles</p>
        <div class="row g-4">
            <div class="col-md-3">
                <div class="role-card"
                     style="background: linear-gradient(135deg,#dc3545,#c82333)">
                    <h3>👑</h3>
                    <h5 class="fw-bold">Admin</h5>
                    <p class="small opacity-90">
                        Approve conferences, manage users,
                        oversee the entire platform
                    </p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="role-card"
                     style="background: linear-gradient(135deg,#28a745,#1e7e34)">
                    <h3>🎯</h3>
                    <h5 class="fw-bold">Organizer</h5>
                    <p class="small opacity-90">
                        Create conferences, manage delegates,
                        run check-in at the venue
                    </p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="role-card"
                     style="background: linear-gradient(135deg,#007bff,#0056b3)">
                    <h3>🎓</h3>
                    <h5 class="fw-bold">Delegate</h5>
                    <p class="small opacity-90">
                        Browse conferences, register, download
                        tickets and certificates
                    </p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="role-card"
                     style="background: linear-gradient(135deg,#ffc107,#e0a800)">
                    <h3>🏛️</h3>
                    <h5 class="fw-bold">Institution</h5>
                    <p class="small opacity-90">
                        Bulk register students and manage
                        institutional participation
                    </p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- How It Works -->
<section class="py-5">
    <div class="container">
        <h2 class="text-center fw-bold mb-2">How It Works</h2>
        <p class="text-center text-muted mb-5">Simple 5-step process</p>
        <div class="row g-0 justify-content-center">
            <c:forEach var="step" begin="1" end="5">
                <div class="col text-center px-2">
                    <div class="rounded-circle bg-primary text-white d-inline-flex
                                align-items-center justify-content-center mb-3"
                         style="width:50px;height:50px;font-weight:bold">
                        ${step}
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="row g-3 text-center">
            <div class="col-md">
                <h6 class="fw-bold">Organizer Creates</h6>
                <p class="text-muted small">Fills conference form and submits</p>
            </div>
            <div class="col-md">
                <h6 class="fw-bold">Admin Approves</h6>
                <p class="text-muted small">Reviews and publishes the conference</p>
            </div>
            <div class="col-md">
                <h6 class="fw-bold">Delegate Registers</h6>
                <p class="text-muted small">Books spot and gets ticket PDF</p>
            </div>
            <div class="col-md">
                <h6 class="fw-bold">QR Check-in</h6>
                <p class="text-muted small">Organizer scans at venue gate</p>
            </div>
            <div class="col-md">
                <h6 class="fw-bold">Get Certificate</h6>
                <p class="text-muted small">Auto-generated after attendance</p>
            </div>
        </div>
    </div>
</section>

<!-- CTA -->
<section class="py-5 text-center"
         style="background: linear-gradient(135deg,#667eea,#764ba2); color:white">
    <div class="container">
        <h2 class="fw-bold mb-3">Ready to Get Started?</h2>
        <p class="mb-4 opacity-90">
            Join NexMeet today — free for delegates, simple for organizers.
        </p>
        <div class="d-flex justify-content-center gap-3 flex-wrap">
            <a href="${pageContext.request.contextPath}/register"
               class="btn btn-light btn-lg px-5">Create Account</a>
            <a href="${pageContext.request.contextPath}/conferences"
               class="btn btn-outline-light btn-lg px-5">View Conferences</a>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="py-4 bg-dark text-center text-white-50">
    <div class="container">
        <p class="mb-0">
            &copy; 2026 NexMeet Conference Platform.
            Built with Spring MVC + Hibernate + MySQL.
        </p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>