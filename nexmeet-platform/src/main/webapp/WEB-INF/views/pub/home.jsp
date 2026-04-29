<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>NexMeet — Professional Conference Management Platform</title>
    <meta name="description"
          content="Host, manage and attend professional conferences with NexMeet. QR check-in, certificates, speaker management and more."/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
          rel="stylesheet"/>
    <style>
        /* ── Design System ─────────────────────────────── */
        :root {
            --brand-primary: #667eea;
            --brand-secondary: #764ba2;
            --brand-gradient: linear-gradient(135deg,
                #667eea 0%, #764ba2 100%);
            --brand-gradient-light: linear-gradient(135deg,
                #f0f2ff 0%, #f5f0ff 100%);
            --surface: #ffffff;
            --surface-alt: #f8f9fc;
            --border: #e8ecf0;
            --text-primary: #0f172a;
            --text-secondary: #475569;
            --text-muted: #94a3b8;
            --radius-sm: 8px;
            --radius-md: 12px;
            --radius-lg: 20px;
            --radius-xl: 28px;
            --shadow-sm: 0 1px 3px rgba(0,0,0,0.06),
                         0 1px 2px rgba(0,0,0,0.04);
            --shadow-md: 0 4px 16px rgba(0,0,0,0.08);
            --shadow-lg: 0 12px 40px rgba(0,0,0,0.12);
            --shadow-brand: 0 8px 32px rgba(102,126,234,0.25);
        }

        * { box-sizing: border-box; }
        body {
            font-family: 'Inter', -apple-system, sans-serif;
            color: var(--text-primary);
            line-height: 1.6;
            background: #fff;
            -webkit-font-smoothing: antialiased;
        }

        /* ── Hero Section ──────────────────────────────── */
        .hero {
            background: var(--brand-gradient);
            min-height: 92vh;
            display: flex;
            align-items: center;
            position: relative;
            overflow: hidden;
        }
        .hero::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -20%;
            width: 700px;
            height: 700px;
            background: rgba(255,255,255,0.06);
            border-radius: 50%;
        }
        .hero::after {
            content: '';
            position: absolute;
            bottom: -30%;
            left: -10%;
            width: 500px;
            height: 500px;
            background: rgba(255,255,255,0.04);
            border-radius: 50%;
        }
        .hero-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.2);
            color: white;
            padding: 6px 16px;
            border-radius: 100px;
            font-size: 0.85rem;
            font-weight: 500;
            margin-bottom: 24px;
        }
        .hero-badge .dot {
            width: 6px; height: 6px;
            background: #4ade80;
            border-radius: 50%;
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.4; }
        }
        .hero h1 {
            font-size: clamp(2.2rem, 5vw, 4rem);
            font-weight: 800;
            line-height: 1.15;
            color: white;
            letter-spacing: -0.02em;
            margin-bottom: 20px;
        }
        .hero h1 .highlight {
            background: linear-gradient(135deg,
                #fbbf24, #f59e0b);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        .hero-subtitle {
            font-size: 1.15rem;
            color: rgba(255,255,255,0.85);
            line-height: 1.7;
            margin-bottom: 36px;
            max-width: 520px;
        }
        .btn-hero-primary {
            background: white;
            color: var(--brand-primary);
            border: none;
            padding: 14px 32px;
            border-radius: var(--radius-md);
            font-weight: 700;
            font-size: 1rem;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s;
            box-shadow: 0 4px 16px rgba(0,0,0,0.15);
        }
        .btn-hero-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(0,0,0,0.2);
            color: var(--brand-primary);
        }
        .btn-hero-secondary {
            background: rgba(255,255,255,0.12);
            color: white;
            border: 1.5px solid rgba(255,255,255,0.3);
            padding: 14px 28px;
            border-radius: var(--radius-md);
            font-weight: 600;
            font-size: 1rem;
            text-decoration: none;
            backdrop-filter: blur(10px);
            transition: all 0.2s;
        }
        .btn-hero-secondary:hover {
            background: rgba(255,255,255,0.2);
            color: white;
            transform: translateY(-2px);
        }

        /* ── Hero Stats ────────────────────────────────── */
        .hero-stats {
            display: flex;
            gap: 32px;
            margin-top: 48px;
            flex-wrap: wrap;
        }
        .hero-stat-item {
            text-align: center;
        }
        .hero-stat-number {
            font-size: 2rem;
            font-weight: 800;
            color: white;
            line-height: 1;
        }
        .hero-stat-label {
            font-size: 0.8rem;
            color: rgba(255,255,255,0.7);
            margin-top: 4px;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        .hero-stat-divider {
            width: 1px;
            background: rgba(255,255,255,0.2);
            align-self: stretch;
        }

        /* ── Hero Visual Card ──────────────────────────── */
        .hero-visual {
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255,255,255,0.2);
            border-radius: var(--radius-xl);
            padding: 28px;
            position: relative;
            z-index: 1;
        }
        .hero-visual-card {
            background: white;
            border-radius: var(--radius-lg);
            padding: 20px;
            box-shadow: var(--shadow-lg);
        }
        .conf-preview-badge {
            display: inline-block;
            background: #ecfdf5;
            color: #059669;
            border-radius: 100px;
            padding: 4px 12px;
            font-size: 0.75rem;
            font-weight: 600;
        }
        .conf-preview-title {
            font-size: 1.05rem;
            font-weight: 700;
            color: var(--text-primary);
            margin: 10px 0 6px;
        }
        .conf-preview-meta {
            font-size: 0.8rem;
            color: var(--text-secondary);
            display: flex;
            align-items: center;
            gap: 16px;
        }
        .mini-avatar-stack {
            display: flex;
            margin-top: 14px;
        }
        .mini-avatar {
            width: 28px; height: 28px;
            border-radius: 50%;
            background: var(--brand-gradient);
            color: white;
            font-size: 0.6rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 2px solid white;
            margin-left: -8px;
        }
        .mini-avatar:first-child { margin-left: 0; }
        .mini-avatar-more {
            background: #f1f5f9;
            color: var(--text-secondary);
        }
        .progress-mini {
            height: 6px;
            background: #f1f5f9;
            border-radius: 3px;
            margin-top: 14px;
            overflow: hidden;
        }
        .progress-mini-bar {
            height: 100%;
            background: var(--brand-gradient);
            border-radius: 3px;
            width: 68%;
        }
        .hero-floating-badge {
            position: absolute;
            background: white;
            border-radius: var(--radius-md);
            padding: 10px 14px;
            box-shadow: var(--shadow-lg);
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        .hfb-1 { top: -16px; right: -16px; }
        .hfb-2 { bottom: -16px; left: -16px; }

        /* ── Section Styles ────────────────────────────── */
        section { padding: 80px 0; }
        .section-badge {
            display: inline-block;
            background: var(--brand-gradient-light);
            color: var(--brand-primary);
            border-radius: 100px;
            padding: 6px 16px;
            font-size: 0.82rem;
            font-weight: 600;
            margin-bottom: 16px;
        }
        .section-title {
            font-size: clamp(1.8rem, 3.5vw, 2.8rem);
            font-weight: 800;
            letter-spacing: -0.02em;
            color: var(--text-primary);
            line-height: 1.2;
            margin-bottom: 16px;
        }
        .section-subtitle {
            font-size: 1.05rem;
            color: var(--text-secondary);
            max-width: 520px;
            margin: 0 auto;
            line-height: 1.7;
        }

        /* ── Feature Cards ─────────────────────────────── */
        .feature-card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            padding: 32px;
            height: 100%;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        .feature-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0;
            right: 0; height: 3px;
            background: var(--brand-gradient);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }
        .feature-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-lg);
            border-color: transparent;
        }
        .feature-card:hover::before {
            transform: scaleX(1);
        }
        .feature-icon {
            width: 52px; height: 52px;
            border-radius: var(--radius-md);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin-bottom: 20px;
        }
        .feature-icon.purple {
            background: linear-gradient(135deg,
                #f5f0ff, #ede9fe);
        }
        .feature-icon.blue {
            background: linear-gradient(135deg,
                #eff6ff, #dbeafe);
        }
        .feature-icon.green {
            background: linear-gradient(135deg,
                #f0fdf4, #dcfce7);
        }
        .feature-icon.orange {
            background: linear-gradient(135deg,
                #fff7ed, #fed7aa);
        }
        .feature-icon.pink {
            background: linear-gradient(135deg,
                #fdf2f8, #fce7f3);
        }
        .feature-icon.teal {
            background: linear-gradient(135deg,
                #f0fdfa, #ccfbf1);
        }
        .feature-title {
            font-size: 1.05rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 10px;
        }
        .feature-desc {
            font-size: 0.9rem;
            color: var(--text-secondary);
            line-height: 1.65;
            margin: 0;
        }

        /* ── How It Works ──────────────────────────────── */
        .steps-section {
            background: var(--surface-alt);
        }
        .step-card {
            text-align: center;
            padding: 32px 24px;
            position: relative;
        }
        .step-number {
            width: 52px; height: 52px;
            background: var(--brand-gradient);
            color: white;
            border-radius: 50%;
            font-size: 1.2rem;
            font-weight: 800;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            box-shadow: var(--shadow-brand);
        }
        .step-connector {
            position: absolute;
            top: 58px;
            right: -16%;
            width: 32%;
            height: 2px;
            background: linear-gradient(90deg,
                var(--brand-primary), var(--brand-secondary));
            opacity: 0.3;
        }
        .step-title {
            font-size: 1.05rem;
            font-weight: 700;
            margin-bottom: 10px;
            color: var(--text-primary);
        }
        .step-desc {
            font-size: 0.88rem;
            color: var(--text-secondary);
            line-height: 1.65;
        }

        /* ── Conference Cards ──────────────────────────── */
        .conf-card {
            background: white;
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            overflow: hidden;
            transition: all 0.3s ease;
            text-decoration: none;
            color: inherit;
            display: block;
            height: 100%;
        }
        .conf-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-lg);
            border-color: var(--brand-primary);
            color: inherit;
            text-decoration: none;
        }
        .conf-card-header {
            padding: 24px 24px 16px;
            background: var(--brand-gradient-light);
            border-bottom: 1px solid var(--border);
        }
        .conf-type-badge {
            display: inline-block;
            background: white;
            color: var(--brand-primary);
            border-radius: 100px;
            padding: 3px 12px;
            font-size: 0.72rem;
            font-weight: 600;
            border: 1px solid rgba(102,126,234,0.2);
            margin-bottom: 10px;
        }
        .conf-card-title {
            font-size: 1rem;
            font-weight: 700;
            color: var(--text-primary);
            line-height: 1.35;
            margin: 0;
        }
        .conf-card-body {
            padding: 16px 24px 20px;
        }
        .conf-meta-row {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 0.82rem;
            color: var(--text-secondary);
            margin-bottom: 8px;
        }
        .conf-meta-row:last-child { margin-bottom: 0; }
        .conf-footer {
            padding: 14px 24px;
            border-top: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .seats-bar {
            height: 5px;
            background: #f1f5f9;
            border-radius: 3px;
            margin: 12px 0;
            overflow: hidden;
        }
        .seats-bar-fill {
            height: 100%;
            border-radius: 3px;
            background: var(--brand-gradient);
        }

        /* ── Testimonial / Trust ───────────────────────── */
        .trust-section {
            background: var(--brand-gradient);
            color: white;
        }
        .trust-stat {
            text-align: center;
            padding: 24px;
        }
        .trust-stat-number {
            font-size: 2.8rem;
            font-weight: 800;
            line-height: 1;
            color: white;
        }
        .trust-stat-label {
            font-size: 0.9rem;
            color: rgba(255,255,255,0.75);
            margin-top: 6px;
        }

        /* ── CTA Section ───────────────────────────────── */
        .cta-section {
            background: var(--surface-alt);
        }
        .cta-card {
            background: var(--brand-gradient);
            border-radius: var(--radius-xl);
            padding: 64px 48px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        .cta-card::before {
            content: '';
            position: absolute;
            top: -60px; right: -60px;
            width: 300px; height: 300px;
            background: rgba(255,255,255,0.08);
            border-radius: 50%;
        }

        /* ── Footer ────────────────────────────────────── */
        footer {
            background: #0f172a;
            color: rgba(255,255,255,0.6);
            padding: 48px 0 28px;
        }
        .footer-brand {
            font-size: 1.4rem;
            font-weight: 800;
            color: white;
            margin-bottom: 8px;
        }
        .footer-tagline {
            font-size: 0.88rem;
            color: rgba(255,255,255,0.5);
        }
        .footer-heading {
            font-size: 0.82rem;
            font-weight: 600;
            color: white;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            margin-bottom: 16px;
        }
        .footer-link {
            display: block;
            font-size: 0.88rem;
            color: rgba(255,255,255,0.5);
            text-decoration: none;
            margin-bottom: 8px;
            transition: color 0.15s;
        }
        .footer-link:hover {
            color: rgba(255,255,255,0.9);
        }
        .footer-divider {
            border-top: 1px solid rgba(255,255,255,0.08);
            margin: 32px 0 24px;
        }

        /* ── Utility ───────────────────────────────────── */
        .text-gradient {
            background: var(--brand-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        @media (max-width: 768px) {
            .hero { min-height: auto; padding: 80px 0 60px; }
            .hero-stats { gap: 20px; }
            .step-connector { display: none; }
            .cta-card { padding: 40px 24px; }
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<!-- ══════════════════════════════════════════════ -->
<!-- HERO SECTION                                   -->
<!-- ══════════════════════════════════════════════ -->
<section class="hero">
    <div class="container position-relative" style="z-index:1">
        <div class="row align-items-center g-5">

            <!-- Left: Copy -->
            <div class="col-lg-6">
                <div class="hero-badge">
                    <span class="dot"></span>
                    Professional Conference Platform
                </div>

                <h1>
                    Where Great<br/>
                    <span class="highlight">Conferences</span><br/>
                    Come to Life
                </h1>

                <p class="hero-subtitle">
                    NexMeet is the all-in-one platform to host, manage,
                    and attend professional conferences. From registration
                    to certificates — everything in one place.
                </p>

                <div class="d-flex gap-3 flex-wrap">
                    <sec:authorize access="isAnonymous()">
                        <a href="${pageContext.request.contextPath}/register"
                           class="btn-hero-primary">
                            Get Started Free →
                        </a>
                        <a href="${pageContext.request.contextPath}/conferences"
                           class="btn-hero-secondary">
                            Browse Conferences
                        </a>
                    </sec:authorize>
                    <sec:authorize access="isAuthenticated()">
                        <a href="${pageContext.request.contextPath}/conferences"
                           class="btn-hero-primary">
                            Browse Conferences →
                        </a>
                    </sec:authorize>
                </div>

                <!-- Live Stats -->
                <div class="hero-stats">
                    <div class="hero-stat-item">
                        <div class="hero-stat-number">
                            ${totalConferences}+
                        </div>
                        <div class="hero-stat-label">
                            Conferences
                        </div>
                    </div>
                    <div class="hero-stat-divider"></div>
                    <div class="hero-stat-item">
                        <div class="hero-stat-number">
                            ${totalUsers}+
                        </div>
                        <div class="hero-stat-label">
                            Delegates
                        </div>
                    </div>
                    <div class="hero-stat-divider"></div>
                    <div class="hero-stat-item">
                        <div class="hero-stat-number">
                            ${totalOrganizers}+
                        </div>
                        <div class="hero-stat-label">
                            Organizers
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right: Visual -->
            <div class="col-lg-6 d-none d-lg-block">
                <div class="hero-visual">
                    <!-- Floating badges -->
                    <div class="hero-floating-badge hfb-1">
                        <span>✅</span>
                        <span>QR Check-in Ready</span>
                    </div>
                    <div class="hero-floating-badge hfb-2">
                        <span>📄</span>
                        <span>Certificate Generated</span>
                    </div>

                    <!-- Conference Preview Card -->
                    <div class="hero-visual-card">
                        <span class="conf-preview-badge">
                            ● LIVE
                        </span>
                        <div class="conf-preview-title">
                            AI &amp; Machine Learning Summit 2026
                        </div>
                        <div class="conf-preview-meta">
                            <span>📅 June 10–11, 2026</span>
                            <span>📍 Bengaluru</span>
                        </div>
                        <div class="progress-mini">
                            <div class="progress-mini-bar"></div>
                        </div>
                        <div style="display:flex;
                             justify-content:space-between;
                             font-size:0.78rem;
                             color:#64748b;margin-top:6px">
                            <span>68% seats filled</span>
                            <span>🎤 4 Speakers</span>
                        </div>
                        <div class="mini-avatar-stack">
                            <div class="mini-avatar">R</div>
                            <div class="mini-avatar">P</div>
                            <div class="mini-avatar">A</div>
                            <div class="mini-avatar">K</div>
                            <div class="mini-avatar mini-avatar-more">
                                +42
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>

<!-- ══════════════════════════════════════════════ -->
<!-- FEATURES SECTION                               -->
<!-- Why choose NexMeet — like Stripe's feature grid -->
<!-- ══════════════════════════════════════════════ -->
<section style="background:#fff">
    <div class="container">
        <div class="text-center mb-5">
            <span class="section-badge">
                ✦ Everything You Need
            </span>
            <h2 class="section-title">
                Built for serious event organizers
            </h2>
            <p class="section-subtitle">
                Every feature you need to run a professional conference
                — no duct tape, no third-party tools.
            </p>
        </div>

        <div class="row g-4">
            <div class="col-md-6 col-lg-4">
                <div class="feature-card">
                    <div class="feature-icon purple">📋</div>
                    <div class="feature-title">
                        Smart Registration
                    </div>
                    <p class="feature-desc">
                        Delegates register in seconds. Auto-generated
                        unique registration numbers, instant confirmation
                        and PDF tickets delivered immediately.
                    </p>
                </div>
            </div>
            <div class="col-md-6 col-lg-4">
                <div class="feature-card">
                    <div class="feature-icon blue">📱</div>
                    <div class="feature-title">
                        QR Code Check-in
                    </div>
                    <p class="feature-desc">
                        Scan and verify delegates at the door in under
                        2 seconds. No paper lists, no manual lookup —
                        just scan and go.
                    </p>
                </div>
            </div>
            <div class="col-md-6 col-lg-4">
                <div class="feature-card">
                    <div class="feature-icon green">📜</div>
                    <div class="feature-title">
                        Auto Certificates
                    </div>
                    <p class="feature-desc">
                        Attendance-verified certificates generated
                        automatically as PDF. Delegates download them
                        the moment attendance is marked.
                    </p>
                </div>
            </div>
            <div class="col-md-6 col-lg-4">
                <div class="feature-card">
                    <div class="feature-icon orange">🎤</div>
                    <div class="feature-title">
                        Speaker Management
                    </div>
                    <p class="feature-desc">
                        Add speaker profiles, assign them to sessions,
                        display bios and LinkedIn — everything delegates
                        need to know about presenters.
                    </p>
                </div>
            </div>
            <div class="col-md-6 col-lg-4">
                <div class="feature-card">
                    <div class="feature-icon pink">📅</div>
                    <div class="feature-title">
                        Session Scheduling
                    </div>
                    <p class="feature-desc">
                        Build a full conference agenda with keynotes,
                        workshops, and panels. Delegates see the
                        live schedule on the event page.
                    </p>
                </div>
            </div>
            <div class="col-md-6 col-lg-4">
                <div class="feature-card">
                    <div class="feature-icon teal">⭐</div>
                    <div class="feature-title">
                        Feedback &amp; Ratings
                    </div>
                    <p class="feature-desc">
                        Post-conference star ratings and reviews.
                        Organizers improve. Delegates choose
                        better events. Platform grows smarter.
                    </p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ══════════════════════════════════════════════ -->
<!-- HOW IT WORKS                                   -->
<!-- Linear-style step flow                         -->
<!-- ══════════════════════════════════════════════ -->
<section class="steps-section">
    <div class="container">
        <div class="text-center mb-5">
            <span class="section-badge">
                ✦ Simple Process
            </span>
            <h2 class="section-title">
                From idea to event in minutes
            </h2>
        </div>

        <div class="row g-0">
            <div class="col-md-3">
                <div class="step-card">
                    <div class="step-number">1</div>
                    <div class="step-connector"></div>
                    <div class="step-title">Register</div>
                    <p class="step-desc">
                        Sign up as an organizer. Fill your
                        profile. Get verified by our admin team.
                    </p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="step-card">
                    <div class="step-number">2</div>
                    <div class="step-connector"></div>
                    <div class="step-title">Create Conference</div>
                    <p class="step-desc">
                        Add conference details, schedule sessions,
                        set pricing and submit for approval.
                    </p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="step-card">
                    <div class="step-number">3</div>
                    <div class="step-connector"></div>
                    <div class="step-title">Go Live</div>
                    <p class="step-desc">
                        Once approved, delegates can register.
                        Use QR check-in on the day.
                    </p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="step-card">
                    <div class="step-number">4</div>
                    <div class="step-title">Certificates</div>
                    <p class="step-desc">
                        After the event, certificates are
                        auto-generated for all attendees.
                    </p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ══════════════════════════════════════════════ -->
<!-- UPCOMING CONFERENCES                           -->
<!-- ══════════════════════════════════════════════ -->
<c:if test="${not empty upcomingConferences}">
<section style="background:#fff">
    <div class="container">
        <div class="d-flex justify-content-between
                    align-items-end mb-5">
            <div>
                <span class="section-badge">
                    ✦ Live Now
                </span>
                <h2 class="section-title mb-0">
                    Upcoming Conferences
                </h2>
            </div>
            <a href="${pageContext.request.contextPath}/conferences"
               class="text-decoration-none fw-semibold"
               style="color:var(--brand-primary)">
                View all →
            </a>
        </div>

        <div class="row g-4">
            <c:forEach var="conf"
                       items="${upcomingConferences}"
                       end="5">
                <div class="col-md-6 col-lg-4">
                    <a href="${pageContext.request.contextPath}/conference/${conf.id}"
                       class="conf-card">
                        <div class="conf-card-header">
                            <span class="conf-type-badge">
                                ${conf.conferenceType.name()}
                            </span>
                            <p class="conf-card-title">
                                ${conf.title}
                            </p>
                        </div>
                        <div class="conf-card-body">
                            <div class="conf-meta-row">
                                <span>📅</span>
                                <span>
                                    ${fn:substringBefore(
                                        conf.startDate.toString(),
                                        'T')}
                                </span>
                            </div>
                            <c:if test="${not empty conf.city}">
                                <div class="conf-meta-row">
                                    <span>📍</span>
                                    <span>
                                        ${conf.city},
                                        ${conf.state}
                                    </span>
                                </div>
                            </c:if>
                            <div class="conf-meta-row">
                                <span>🎯</span>
                                <span>${conf.mode}</span>
                            </div>
                            <c:if test="${conf.maxDelegates > 0}">
                                <div class="seats-bar">
                                    <div class="seats-bar-fill"
                                         style="width:${conf.registeredCount * 100 / conf.maxDelegates}%">
                                    </div>
                                </div>
                                <div style="font-size:0.78rem;
                                     color:var(--text-muted)">
                                    ${conf.registeredCount}
                                    /
                                    ${conf.maxDelegates}
                                    registered
                                </div>
                            </c:if>
                        </div>
                        <div class="conf-footer">
                            <span style="font-size:0.82rem;
                                  color:var(--text-secondary)">
                                <c:choose>
                                    <c:when test="${conf.free}">
                                        <span style="color:#059669;
                                              font-weight:600">
                                            Free
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="font-weight:600">
                                            ₹${conf.delegateFee}
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </span>
                            <span style="font-size:0.82rem;
                                  color:var(--brand-primary);
                                  font-weight:600">
                                Register →
                            </span>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
</section>
</c:if>

<!-- ══════════════════════════════════════════════ -->
<!-- TRUST / STATS BAR                              -->
<!-- Like Stripe's "trusted by" section             -->
<!-- ══════════════════════════════════════════════ -->
<section class="trust-section">
    <div class="container">
        <div class="row g-0 justify-content-center">
            <div class="col-6 col-md-3">
                <div class="trust-stat">
                    <div class="trust-stat-number">
                        ${totalConferences}+
                    </div>
                    <div class="trust-stat-label">
                        Conferences Hosted
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="trust-stat">
                    <div class="trust-stat-number">
                        ${totalUsers}+
                    </div>
                    <div class="trust-stat-label">
                        Registered Users
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="trust-stat">
                    <div class="trust-stat-number">
                        ${totalOrganizers}+
                    </div>
                    <div class="trust-stat-label">
                        Active Organizers
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="trust-stat">
                    <div class="trust-stat-number">29+</div>
                    <div class="trust-stat-label">
                        Conference Types
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ══════════════════════════════════════════════ -->
<!-- CTA SECTION                                    -->
<!-- ══════════════════════════════════════════════ -->
<section class="cta-section">
    <div class="container">
        <div class="cta-card">
            <div class="position-relative" style="z-index:1">
                <span class="section-badge"
                      style="background:rgba(255,255,255,0.15);
                             color:white;">
                    ✦ Ready to Start?
                </span>
                <h2 class="section-title text-white mb-3">
                    Host your next conference<br/>
                    on NexMeet today
                </h2>
                <p style="color:rgba(255,255,255,0.8);
                   font-size:1.05rem;margin-bottom:36px">
                    Join hundreds of organizers who trust NexMeet
                    for professional event management.
                </p>
                <div class="d-flex gap-3 justify-content-center
                            flex-wrap">
                    <sec:authorize access="isAnonymous()">
                        <a href="${pageContext.request.contextPath}/register"
                           class="btn-hero-primary">
                            Create Free Account →
                        </a>
                        <a href="${pageContext.request.contextPath}/conferences"
                           class="btn-hero-secondary">
                            Browse Conferences
                        </a>
                    </sec:authorize>
                    <sec:authorize access="isAuthenticated()">
                        <a href="${pageContext.request.contextPath}/conferences"
                           class="btn-hero-primary">
                            Browse Conferences →
                        </a>
                    </sec:authorize>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ══════════════════════════════════════════════ -->
<!-- FOOTER                                         -->
<!-- ══════════════════════════════════════════════ -->
<footer>
    <div class="container">
        <div class="row g-4">
            <div class="col-md-4">
                <div class="footer-brand">NexMeet</div>
                <div class="footer-tagline">
                    Professional Conference Management Platform
                </div>
                <div class="mt-3" style="font-size:0.85rem;
                     color:rgba(255,255,255,0.4)">
                    Built with Spring MVC · Hibernate · MySQL
                </div>
            </div>
            <div class="col-md-2">
                <div class="footer-heading">Platform</div>
                <a href="${pageContext.request.contextPath}/conferences"
                   class="footer-link">
                    Browse Conferences
                </a>
                <a href="${pageContext.request.contextPath}/register"
                   class="footer-link">
                    Register
                </a>
                <a href="${pageContext.request.contextPath}/login"
                   class="footer-link">
                    Login
                </a>
            </div>
            <div class="col-md-3">
                <div class="footer-heading">For Organizers</div>
                <a href="${pageContext.request.contextPath}/register"
                   class="footer-link">
                    Create Conference
                </a>
                <a href="${pageContext.request.contextPath}/organizer/dashboard"
                   class="footer-link">
                    Organizer Dashboard
                </a>
            </div>
            <div class="col-md-3">
                <div class="footer-heading">For Delegates</div>
                <a href="${pageContext.request.contextPath}/conferences"
                   class="footer-link">
                    Find Conferences
                </a>
                <a href="${pageContext.request.contextPath}/delegate/dashboard"
                   class="footer-link">
                    My Registrations
                </a>
            </div>
        </div>

        <div class="footer-divider"></div>

        <div class="d-flex justify-content-between
                    align-items-center flex-wrap gap-3">
            <div style="font-size:0.82rem;
                 color:rgba(255,255,255,0.35)">
                © 2026 NexMeet. All rights reserved.
            </div>
            <div style="font-size:0.82rem;
                 color:rgba(255,255,255,0.35)">
                Made with ❤ for professional events
            </div>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>

<%-- Animated counter for stats --%>
<script>
    document.addEventListener('DOMContentLoaded', () => {
        const nums = document.querySelectorAll(
            '.trust-stat-number');
        nums.forEach(el => {
            const text = el.textContent.trim();
            const num = parseInt(text.replace(/\D/g, ''));
            if (isNaN(num) || num === 0) return;
            const suffix = text.replace(/[\d]/g, '');
            let start = 0;
            const duration = 1800;
            const step = (timestamp) => {
                if (!start) start = timestamp;
                const progress = Math.min(
                    (timestamp - start) / duration, 1);
                const ease = 1 - Math.pow(1 - progress, 3);
                el.textContent = Math.floor(
                    ease * num) + suffix;
                if (progress < 1) {
                    requestAnimationFrame(step);
                }
            };
            requestAnimationFrame(step);
        });
    });
</script>

</body>
</html>