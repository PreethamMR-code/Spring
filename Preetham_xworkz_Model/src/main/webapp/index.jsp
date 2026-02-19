<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>X-Workz | Transform Your Career with Industry-Leading Training</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@400;600;700;800;900&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --navy: #0f172a;
            --navy-light: #1e293b;
            --accent: #3b82f6;
            --accent-2: #06b6d4;
            --gold: #f59e0b;
            --text: #1e293b;
            --muted: #64748b;
        }
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family:'Inter',sans-serif; overflow-x:hidden; color:var(--text); }
        h1,h2,h3,h4,h5,h6 { font-family:'Sora',sans-serif; }

        /* ── NAVBAR ── */
        .navbar-custom { background:rgba(255,255,255,0.95); backdrop-filter:blur(20px); box-shadow:0 2px 20px rgba(0,0,0,0.06); transition:all 0.3s; }
        .navbar-custom.scrolled { background:white; box-shadow:0 4px 24px rgba(0,0,0,0.1); }
        .navbar-brand { font-family:'Sora',sans-serif; font-weight:800; font-size:1.3rem; color:var(--navy)!important; }
        .nav-link-custom { color:var(--text)!important; font-weight:600; font-size:0.9rem; padding:0.5rem 1.25rem!important; transition:all 0.2s; }
        .nav-link-custom:hover { color:var(--accent)!important; }
        .btn-nav-primary { background:var(--accent); color:white; border:none; padding:0.6rem 1.75rem; border-radius:50px; font-weight:700; font-size:0.9rem; transition:all 0.3s; }
        .btn-nav-primary:hover { background:#2563eb; color:white; transform:translateY(-2px); box-shadow:0 8px 20px rgba(59,130,246,0.3); }
        .btn-nav-outline { border:2px solid var(--accent); color:var(--accent); background:transparent; padding:0.55rem 1.5rem; border-radius:50px; font-weight:700; font-size:0.9rem; transition:all 0.3s; }
        .btn-nav-outline:hover { background:var(--accent); color:white; transform:translateY(-2px); }

        /* ── HERO ── */
        .hero { min-height:100vh; background:linear-gradient(135deg,#0f172a 0%,#1e3a5f 50%,#2d4a6f 100%); position:relative; overflow:hidden; display:flex; align-items:center; padding:6rem 0 4rem; }
        .hero::before { content:''; position:absolute; width:600px; height:600px; border-radius:50%; background:radial-gradient(circle,rgba(59,130,246,0.15),transparent 70%); top:-200px; right:-100px; }
        .hero::after { content:''; position:absolute; width:400px; height:400px; border-radius:50%; background:radial-gradient(circle,rgba(6,182,212,0.12),transparent 70%); bottom:-100px; left:-50px; }
        .hero-content { position:relative; z-index:2; }
        .hero-badge { display:inline-block; background:rgba(255,255,255,0.1); border:1px solid rgba(255,255,255,0.2); color:white; padding:0.5rem 1.25rem; border-radius:50px; font-size:0.85rem; font-weight:600; margin-bottom:1.5rem; backdrop-filter:blur(10px); }
        .hero-title { font-family:'Sora',sans-serif; font-size:clamp(2.5rem,6vw,4.5rem); font-weight:900; color:white; line-height:1.1; margin-bottom:1.5rem; }
        .hero-title .gradient-text { background:linear-gradient(135deg,#60a5fa,#34d399); -webkit-background-clip:text; -webkit-text-fill-color:transparent; background-clip:text; }
        .hero-subtitle { font-size:1.25rem; color:rgba(255,255,255,0.8); margin-bottom:2.5rem; max-width:600px; }
        .hero-cta { display:flex; gap:1rem; flex-wrap:wrap; }
        .btn-hero-lg { padding:1rem 2.5rem; font-size:1.05rem; border-radius:50px; font-weight:700; transition:all 0.3s; text-decoration:none; display:inline-flex; align-items:center; gap:0.75rem; }
        .btn-hero-primary { background:var(--accent); color:white; border:none; }
        .btn-hero-primary:hover { background:#2563eb; color:white; transform:translateY(-3px); box-shadow:0 12px 32px rgba(59,130,246,0.4); }
        .btn-hero-outline { background:rgba(255,255,255,0.1); border:2px solid rgba(255,255,255,0.3); color:white; backdrop-filter:blur(10px); }
        .btn-hero-outline:hover { background:rgba(255,255,255,0.2); color:white; border-color:rgba(255,255,255,0.5); transform:translateY(-3px); }
        .hero-image { position:relative; }
        .hero-image img { border-radius:24px; box-shadow:0 25px 60px rgba(0,0,0,0.4); }
        .hero-stat { background:rgba(255,255,255,0.95); border-radius:16px; padding:1.5rem; box-shadow:0 12px 32px rgba(0,0,0,0.15); backdrop-filter:blur(10px); }
        .hero-stat-num { font-family:'Sora',sans-serif; font-size:2.5rem; font-weight:800; color:var(--accent); }
        .hero-stat-label { color:var(--muted); font-size:0.9rem; font-weight:600; }

        /* ── SECTIONS ── */
        .section { padding:5rem 0; position:relative; }
        .section-title { font-family:'Sora',sans-serif; font-size:clamp(2rem,4vw,2.75rem); font-weight:800; margin-bottom:1rem; }
        .section-subtitle { font-size:1.15rem; color:var(--muted); max-width:700px; margin:0 auto 3rem; }

        /* ── FEATURES ── */
        .feature-card { background:white; border-radius:20px; padding:2rem; box-shadow:0 4px 20px rgba(0,0,0,0.06); transition:all 0.3s; height:100%; border:1px solid #f1f5f9; }
        .feature-card:hover { transform:translateY(-8px); box-shadow:0 20px 50px rgba(0,0,0,0.12); border-color:var(--accent); }
        .feature-icon { width:64px; height:64px; border-radius:16px; display:flex; align-items:center; justify-content:center; font-size:1.75rem; margin-bottom:1.25rem; }
        .feature-title { font-family:'Sora',sans-serif; font-weight:700; font-size:1.25rem; margin-bottom:0.75rem; }
        .feature-text { color:var(--muted); line-height:1.7; }

        /* ── COURSES ── */
        .course-card { background:white; border-radius:20px; overflow:hidden; box-shadow:0 4px 20px rgba(0,0,0,0.06); transition:all 0.3s; border:1px solid #f1f5f9; }
        .course-card:hover { transform:translateY(-10px); box-shadow:0 20px 50px rgba(0,0,0,0.15); border-color:var(--accent); }
        .course-img { height:220px; background:linear-gradient(135deg,#667eea,#764ba2); display:flex; align-items:center; justify-content:center; position:relative; overflow:hidden; }
        .course-img::before { content:''; position:absolute; inset:0; background:url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="40" fill="white" opacity="0.1"/></svg>'); opacity:0.3; }
        .course-body { padding:1.75rem; }
        .course-tag { display:inline-block; background:rgba(59,130,246,0.1); color:var(--accent); padding:0.25rem 0.75rem; border-radius:6px; font-size:0.75rem; font-weight:700; text-transform:uppercase; letter-spacing:0.5px; margin-bottom:0.75rem; }
        .course-title { font-family:'Sora',sans-serif; font-weight:700; font-size:1.15rem; margin-bottom:0.5rem; }
        .course-meta { color:var(--muted); font-size:0.85rem; }

        /* ── STATS ── */
        .stats-section { background:linear-gradient(135deg,var(--navy),var(--navy-light)); color:white; }
        .stat-box { text-align:center; }
        .stat-number { font-family:'Sora',sans-serif; font-size:3.5rem; font-weight:900; margin-bottom:0.5rem; background:linear-gradient(135deg,#60a5fa,#34d399); -webkit-background-clip:text; -webkit-text-fill-color:transparent; background-clip:text; }
        .stat-label { font-size:1.05rem; font-weight:600; opacity:0.8; }

        /* ── CTA ── */
        .cta-section { background:linear-gradient(135deg,#3b82f6,#2563eb); color:white; border-radius:32px; padding:4rem 3rem; position:relative; overflow:hidden; }
        .cta-section::before { content:''; position:absolute; width:500px; height:500px; border-radius:50%; background:rgba(255,255,255,0.1); top:-200px; right:-100px; }

        /* ── FOOTER ── */
        .footer { background:var(--navy); color:white; padding:3rem 0 1.5rem; }
        .footer-link { color:rgba(255,255,255,0.7); text-decoration:none; transition:all 0.2s; }
        .footer-link:hover { color:white; }

        /* ── ANIMATIONS ── */
        @keyframes fadeUp { from{opacity:0;transform:translateY(30px);} to{opacity:1;transform:translateY(0);} }
        @keyframes float { 0%,100%{transform:translateY(0);} 50%{transform:translateY(-20px);} }
        .fade-up { animation:fadeUp 0.6s ease both; }
        .delay-1 { animation-delay:0.1s; }
        .delay-2 { animation-delay:0.2s; }
        .delay-3 { animation-delay:0.3s; }
        .delay-4 { animation-delay:0.4s; }
        .float { animation:float 6s ease-in-out infinite; }
    </style>
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-custom fixed-top px-4" id="navbar">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="<c:url value='/'/>">
            <img src="https://x-workz.com/Logo.png" height="40" class="me-2" alt="X-Workz">
            <span>X-Workz</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item"><a class="nav-link-custom" href="#home">Home</a></li>
                <li class="nav-item"><a class="nav-link-custom" href="#courses">Courses</a></li>
                <li class="nav-item"><a class="nav-link-custom" href="#features">Features</a></li>
                <li class="nav-item"><a class="nav-link-custom" href="#about">About</a></li>
            </ul>
            <div class="d-flex gap-2">
                <a href="<c:url value='/signIn'/>" class="btn btn-nav-outline">Sign In</a>
                <a href="<c:url value='/signUp'/>" class="btn btn-nav-primary">Get Started</a>
            </div>
        </div>
    </div>
</nav>

<!-- HERO -->
<section class="hero" id="home">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6 hero-content">
                <div class="fade-up">
                    <div class="hero-badge"><i class="bi bi-star-fill me-2"></i>India's Premier Tech Training Institute</div>
                    <h1 class="hero-title">
                        Transform Your Career with
                        <span class="gradient-text">Industry-Leading Training</span>
                    </h1>
                    <p class="hero-subtitle">
                        Master in-demand skills with real-world projects, expert mentorship, and guaranteed placement support.
                    </p>
                    <div class="hero-cta">
                        <a href="<c:url value='/signUp'/>" class="btn-hero-lg btn-hero-primary">
                            <i class="bi bi-rocket-takeoff-fill"></i> Start Learning Today
                        </a>
                        <a href="#courses" class="btn-hero-lg btn-hero-outline">
                            <i class="bi bi-play-circle-fill"></i> Explore Courses
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 mt-5 mt-lg-0">
                <div class="row g-3 fade-up delay-2">
                    <div class="col-6"><div class="hero-stat"><div class="hero-stat-num">5K+</div><div class="hero-stat-label">Students Trained</div></div></div>
                    <div class="col-6"><div class="hero-stat"><div class="hero-stat-num">95%</div><div class="hero-stat-label">Placement Rate</div></div></div>
                    <div class="col-6"><div class="hero-stat"><div class="hero-stat-num">50+</div><div class="hero-stat-label">Expert Trainers</div></div></div>
                    <div class="col-6"><div class="hero-stat"><div class="hero-stat-num">100+</div><div class="hero-stat-label">Partner Companies</div></div></div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- COURSES -->
<section class="section" id="courses" style="background:#f8fafc;">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="section-title fade-up">Popular Courses</h2>
            <p class="section-subtitle fade-up delay-1">Choose from our industry-aligned programs designed to make you job-ready</p>
        </div>
        <div class="row g-4">
            <div class="col-md-6 col-lg-4 fade-up delay-1">
                <div class="course-card">
                    <div class="course-img"><i class="bi bi-code-slash text-white" style="font-size:4rem;"></i></div>
                    <div class="course-body">
                        <span class="course-tag">Most Popular</span>
                        <h3 class="course-title">Java Full Stack Development</h3>
                        <p class="course-meta"><i class="bi bi-clock me-2"></i>6 Months · <i class="bi bi-people ms-2 me-2"></i>500+ Enrolled</p>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-lg-4 fade-up delay-2">
                <div class="course-card">
                    <div class="course-img" style="background:linear-gradient(135deg,#667eea,#764ba2);"><i class="bi bi-graph-up-arrow text-white" style="font-size:4rem;"></i></div>
                    <div class="course-body">
                        <span class="course-tag">Trending</span>
                        <h3 class="course-title">Data Science & Analytics</h3>
                        <p class="course-meta"><i class="bi bi-clock me-2"></i>5 Months · <i class="bi bi-people ms-2 me-2"></i>350+ Enrolled</p>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-lg-4 fade-up delay-3">
                <div class="course-card">
                    <div class="course-img" style="background:linear-gradient(135deg,#f093fb,#f5576c);"><i class="bi bi-phone text-white" style="font-size:4rem;"></i></div>
                    <div class="course-body">
                        <span class="course-tag">New</span>
                        <h3 class="course-title">Mobile App Development</h3>
                        <p class="course-meta"><i class="bi bi-clock me-2"></i>4 Months · <i class="bi bi-people ms-2 me-2"></i>200+ Enrolled</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="text-center mt-5">
            <a href="<c:url value='/signUp'/>" class="btn-hero-lg btn-hero-primary">View All Courses</a>
        </div>
    </div>
</section>

<!-- FEATURES -->
<section class="section" id="features">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="section-title fade-up">Why Choose X-Workz?</h2>
            <p class="section-subtitle fade-up delay-1">Everything you need to succeed in your tech career journey</p>
        </div>
        <div class="row g-4">
            <div class="col-md-6 col-lg-3 fade-up delay-1">
                <div class="feature-card">
                    <div class="feature-icon" style="background:rgba(59,130,246,0.1);"><i class="bi bi-mortarboard-fill" style="color:var(--accent);"></i></div>
                    <h3 class="feature-title">Expert Trainers</h3>
                    <p class="feature-text">Learn from industry professionals with 10+ years of real-world experience</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-3 fade-up delay-2">
                <div class="feature-card">
                    <div class="feature-icon" style="background:rgba(16,185,129,0.1);"><i class="bi bi-laptop-fill" style="color:#10b981;"></i></div>
                    <h3 class="feature-title">Hands-On Projects</h3>
                    <p class="feature-text">Build real-world applications to strengthen your portfolio</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-3 fade-up delay-3">
                <div class="feature-card">
                    <div class="feature-icon" style="background:rgba(245,158,11,0.1);"><i class="bi bi-briefcase-fill" style="color:#f59e0b;"></i></div>
                    <h3 class="feature-title">Placement Support</h3>
                    <p class="feature-text">100% placement assistance with top tech companies</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-3 fade-up delay-4">
                <div class="feature-card">
                    <div class="feature-icon" style="background:rgba(139,92,246,0.1);"><i class="bi bi-award-fill" style="color:#8b5cf6;"></i></div>
                    <h3 class="feature-title">Certification</h3>
                    <p class="feature-text">Industry-recognized certificates to boost your resume</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- STATS -->
<section class="section stats-section">
    <div class="container">
        <div class="row g-5">
            <div class="col-md-3 col-6"><div class="stat-box fade-up delay-1"><div class="stat-number">5,000+</div><div class="stat-label">Students Trained</div></div></div>
            <div class="col-md-3 col-6"><div class="stat-box fade-up delay-2"><div class="stat-number">95%</div><div class="stat-label">Placement Rate</div></div></div>
            <div class="col-md-3 col-6"><div class="stat-box fade-up delay-3"><div class="stat-number">100+</div><div class="stat-label">Hiring Partners</div></div></div>
            <div class="col-md-3 col-6"><div class="stat-box fade-up delay-4"><div class="stat-number">50+</div><div class="stat-label">Expert Trainers</div></div></div>
        </div>
    </div>
</section>

<!-- CTA -->
<section class="section" id="about">
    <div class="container">
        <div class="cta-section">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <h2 class="section-title text-white mb-3">Ready to Start Your Journey?</h2>
                    <p style="font-size:1.15rem;opacity:0.9;">Join thousands of successful students who transformed their careers with X-Workz</p>
                </div>
                <div class="col-lg-4 mt-4 mt-lg-0 text-lg-end">
                    <a href="<c:url value='/signUp'/>" class="btn-hero-lg btn-hero-primary" style="background:white;color:var(--accent);">
                        <i class="bi bi-arrow-right-circle-fill"></i> Enroll Now
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- FOOTER -->
<footer class="footer">
    <div class="container">
        <div class="row">
            <div class="col-lg-4 mb-4 mb-lg-0">
                <div class="d-flex align-items-center mb-3">
                    <img src="https://x-workz.com/Logo.png" height="35" class="me-2" alt="X-Workz">
                    <span style="font-family:'Sora',sans-serif;font-weight:700;font-size:1.2rem;">X-Workz</span>
                </div>
                <p style="color:rgba(255,255,255,0.7);">Empowering careers through world-class technical training and placement support.</p>
            </div>
            <div class="col-lg-2 col-6 mb-4 mb-lg-0">
                <h6 style="font-family:'Sora',sans-serif;font-weight:700;margin-bottom:1rem;">Quick Links</h6>
                <ul style="list-style:none;padding:0;">
                    <li class="mb-2"><a href="#courses" class="footer-link">Courses</a></li>
                    <li class="mb-2"><a href="#features" class="footer-link">Features</a></li>
                    <li class="mb-2"><a href="#about" class="footer-link">About Us</a></li>
                </ul>
            </div>
            <div class="col-lg-3 col-6 mb-4 mb-lg-0">
                <h6 style="font-family:'Sora',sans-serif;font-weight:700;margin-bottom:1rem;">Resources</h6>
                <ul style="list-style:none;padding:0;">
                    <li class="mb-2"><a href="<c:url value='/signIn'/>" class="footer-link">Sign In</a></li>
                    <li class="mb-2"><a href="<c:url value='/signUp'/>" class="footer-link">Sign Up</a></li>
                    <li class="mb-2"><a href="#" class="footer-link">Contact Us</a></li>
                </ul>
            </div>
            <div class="col-lg-3">
                <h6 style="font-family:'Sora',sans-serif;font-weight:700;margin-bottom:1rem;">Connect With Us</h6>
                <div class="d-flex gap-2">
                    <a href="#" style="width:40px;height:40px;background:rgba(255,255,255,0.1);border-radius:10px;display:flex;align-items:center;justify-content:center;color:white;text-decoration:none;"><i class="bi bi-facebook"></i></a>
                    <a href="#" style="width:40px;height:40px;background:rgba(255,255,255,0.1);border-radius:10px;display:flex;align-items:center;justify-content:center;color:white;text-decoration:none;"><i class="bi bi-twitter"></i></a>
                    <a href="#" style="width:40px;height:40px;background:rgba(255,255,255,0.1);border-radius:10px;display:flex;align-items:center;justify-content:center;color:white;text-decoration:none;"><i class="bi bi-linkedin"></i></a>
                    <a href="#" style="width:40px;height:40px;background:rgba(255,255,255,0.1);border-radius:10px;display:flex;align-items:center;justify-content:center;color:white;text-decoration:none;"><i class="bi bi-instagram"></i></a>
                </div>
            </div>
        </div>
        <hr style="border-color:rgba(255,255,255,0.1);margin:2rem 0 1.5rem;">
        <div class="text-center" style="color:rgba(255,255,255,0.6);">
            <p class="mb-0">© 2026 X-Workz Training Institute. All rights reserved.</p>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
// Navbar scroll effect
window.addEventListener('scroll',()=>{
    const navbar=document.getElementById('navbar');
    if(window.scrollY>50)navbar.classList.add('scrolled');
    else navbar.classList.remove('scrolled');
});
// Smooth scroll
document.querySelectorAll('a[href^="#"]').forEach(a=>{
    a.addEventListener('click',function(e){
        e.preventDefault();
        const target=document.querySelector(this.getAttribute('href'));
        if(target)target.scrollIntoView({behavior:'smooth',block:'start'});
    });
});
</script>
</body>
</html>
