<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up | X-Workz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@400;600;700;800;900&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <style>
        :root { --navy:#0f172a; --accent:#3b82f6; --text:#1e293b; --muted:#64748b; }
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family:'Inter',sans-serif; background:linear-gradient(135deg,#f5f7fa 0%,#c3cfe2 100%); min-height:100vh; display:flex; flex-direction:column; }
        h1,h2,h3,h4,h5,h6 { font-family:'Sora',sans-serif; }

        .navbar-custom { background:rgba(255,255,255,0.95); backdrop-filter:blur(20px); box-shadow:0 2px 20px rgba(0,0,0,0.06); }
        .navbar-brand { font-family:'Sora',sans-serif; font-weight:800; font-size:1.3rem; color:var(--navy)!important; }
        .nav-link-custom { color:var(--text)!important; font-weight:600; font-size:0.9rem; padding:0.5rem 1.25rem!important; }
        .btn-nav-primary { background:var(--accent); color:white; border:none; padding:0.6rem 1.75rem; border-radius:50px; font-weight:700; font-size:0.9rem; }
        .btn-nav-outline { border:2px solid var(--accent); color:var(--accent); background:transparent; padding:0.55rem 1.5rem; border-radius:50px; font-weight:700; font-size:0.9rem; }

        main { flex:1; display:flex; align-items:center; justify-content:center; padding:6rem 1rem 2rem; }
        .signup-card { background:rgba(255,255,255,0.98); backdrop-filter:blur(20px); border-radius:24px; border:1px solid rgba(255,255,255,0.3); box-shadow:0 20px 60px rgba(0,0,0,0.15); padding:3rem; max-width:540px; width:100%; }
        .signup-title { font-family:'Sora',sans-serif; font-size:2rem; font-weight:800; margin-bottom:0.5rem; background:linear-gradient(135deg,#60a5fa,#3b82f6); -webkit-background-clip:text; -webkit-text-fill-color:transparent; background-clip:text; }
        .form-floating > .form-control { border-radius:12px; border:2px solid #e2e8f0; padding:0.85rem 1.25rem; font-size:0.95rem; }
        .form-floating > .form-control:focus { border-color:var(--accent); box-shadow:0 0 0 4px rgba(59,130,246,0.12); }
        .form-floating > label { color:var(--muted); }
        .error-message { font-size:0.85rem; margin-top:4px; min-height:1.5rem; }
        .gender-box { background:#f8fafc; border:2px solid #e2e8f0; border-radius:12px; padding:1rem; }
        .form-check-input:checked { background-color:var(--accent); border-color:var(--accent); }
        .btn-signup { background:linear-gradient(135deg,#3b82f6,#2563eb); border:none; border-radius:12px; padding:0.85rem 2rem; font-weight:700; font-size:1rem; box-shadow:0 8px 25px rgba(59,130,246,0.4); }
        .btn-signup:hover { transform:translateY(-2px); box-shadow:0 12px 35px rgba(59,130,246,0.5); }
        footer { background:rgba(0,0,0,0.9); color:white; text-align:center; padding:1.5rem; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-custom fixed-top px-4">
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
                <li class="nav-item"><a class="nav-link-custom" href="<c:url value='/'/>">Home</a></li>
                <li class="nav-item"><a class="nav-link-custom" href="#courses">Courses</a></li>
            </ul>
            <div class="d-flex gap-2">
                <a href="<c:url value='/signIn'/>" class="btn btn-nav-outline">Sign In</a>
                <a href="<c:url value='/signUp'/>" class="btn btn-nav-primary">Sign Up</a>
            </div>
        </div>
    </div>
</nav>

<main>
    <div class="signup-card">
        <div class="text-center mb-4">
            <div class="mb-3"><i class="bi bi-person-plus-fill" style="font-size:3.5rem;color:var(--accent);"></i></div>
            <h1 class="signup-title">Create Account</h1>
            <p style="color:var(--muted);font-size:0.95rem;">Join X-Workz and start your learning journey</p>
        </div>

        <form action="<c:url value='/signUp'/>" method="post">
            <div class="mb-3">
                <div class="form-floating">
                    <input type="text" id="name" name="name" class="form-control" value="${dto.name}" placeholder="Full Name" oninput="validateName()" onchange="validateName()">
                    <label for="name"><i class="bi bi-person me-2"></i>Full Name</label>
                </div>
                <div class="text-danger error-message" id="nameError">${nameError}</div>
            </div>

            <div class="mb-3">
                <div class="form-floating">
                    <input type="email" id="email" name="email" class="form-control" value="${dto.email}" placeholder="Email" onblur="checkEmailAvailability()" oninput="clearServerError()">
                    <label for="email"><i class="bi bi-envelope me-2"></i>Email</label>
                </div>
                <div class="error-message" id="emailError">${emailError}</div>
            </div>

            <div class="mb-3">
                <div class="form-floating">
                    <input type="text" id="phone" name="phone" class="form-control" maxlength="10" value="${dto.phone}" placeholder="Phone" oninput="validatePhone()" onchange="validatePhone()">
                    <label for="phone"><i class="bi bi-phone me-2"></i>Phone</label>
                </div>
                <div class="text-danger error-message" id="phoneError">${phoneError}</div>
            </div>

            <div class="mb-3">
                <div class="form-floating">
                    <input type="number" id="age" name="age" class="form-control" value="${dto.age}" placeholder="Age" oninput="validateAge()" onchange="validateAge()">
                    <label for="age"><i class="bi bi-calendar-alt me-2"></i>Age</label>
                </div>
                <div class="text-danger error-message" id="ageError">${ageError}</div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold" style="font-size:0.85rem;"><i class="bi bi-gender-ambiguous me-2"></i>Gender</label>
                <div class="gender-box">
                    <div class="d-flex gap-4 justify-content-center">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="gender" value="Male" id="male" onchange="validateGender()">
                            <label class="form-check-label fw-medium" for="male">Male</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="gender" value="Female" id="female" onchange="validateGender()">
                            <label class="form-check-label fw-medium" for="female">Female</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="gender" value="Other" id="other" onchange="validateGender()">
                            <label class="form-check-label fw-medium" for="other">Other</label>
                        </div>
                    </div>
                </div>
                <div class="text-danger error-message" id="genderError">${genderError}</div>
            </div>

            <div class="mb-3">
                <div class="form-floating">
                    <input type="text" id="address" name="address" class="form-control" value="${dto.address}" placeholder="Address" oninput="validateAddress()" onchange="validateAddress()">
                    <label for="address"><i class="bi bi-map-marker-alt me-2"></i>Address</label>
                </div>
                <div class="text-danger error-message" id="addressError">${addressError}</div>
            </div>

            <div class="mb-3">
                <div class="form-floating">
                    <input type="password" id="password" name="password" class="form-control" placeholder="Password" oninput="validatePassword()" onchange="validatePassword()">
                    <label for="password"><i class="bi bi-lock me-2"></i>Password</label>
                </div>
                <div class="text-danger error-message" id="passwordError">${passwordError}</div>
            </div>

            <div class="mb-4">
                <div class="form-floating">
                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Confirm Password" oninput="validateConfirmPassword()" onchange="validateConfirmPassword()">
                    <label for="confirmPassword"><i class="bi bi-lock-fill me-2"></i>Confirm Password</label>
                </div>
                <div class="text-danger error-message" id="confirmPasswordError">${confirmPasswordError}</div>
            </div>

            <div class="d-grid mb-3">
                <button type="submit" class="btn btn-signup text-white">
                    <i class="bi bi-rocket-takeoff me-2"></i>Create Account
                </button>
            </div>

            <div class="text-center">
                <span style="color:var(--muted);font-size:0.9rem;">Already have an account?</span>
                <a href="<c:url value='/signIn'/>" style="color:var(--accent);font-weight:700;text-decoration:none;"> Sign In</a>
            </div>

            <c:if test="${not empty msg}">
                <div class="alert alert-success border-0 mt-3" style="border-radius:12px;background:rgba(16,185,129,0.1);color:#065f46;">
                    <i class="bi bi-check-circle me-2"></i>${msg}
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div id="serverErrorAlert" class="alert alert-danger border-0 mt-3" style="border-radius:12px;background:rgba(239,68,68,0.1);color:#991b1b;">
                    <i class="bi bi-exclamation-triangle me-2"></i>${error}
                </div>
            </c:if>
        </form>
    </div>
</main>

<footer>
    <p class="mb-0">© 2026 X-Workz Training Institute. All rights reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
function validateName() {
    const nameInput = document.getElementById("name");
    const nameError = document.getElementById("nameError");
    const v = nameInput.value.trim();
    const nameRegex = /^[A-Za-z ]{3,50}$/;
    if (v === "") { nameError.textContent = "Name is required"; return false; }
    if (!nameRegex.test(v)) { nameError.textContent = "Enter a valid name (3-50 alphabets only)"; return false; }
    nameError.textContent = ""; return true;
}

async function checkEmailAvailability() {
    const emailInput = document.getElementById("email");
    const emailError = document.getElementById("emailError");
    const email = emailInput.value.trim();
    if (email === "") { emailError.textContent = ""; return; }
    if (!/^[a-zA-Z0-9._%+-]+@gmail\.com$/.test(email)) { emailError.textContent = "Email must end with @gmail.com"; return; }
    try {
        const response = await axios.get('checkEmail', {params: { email: email }});
        const result = response.data.trim();
        if (result === "exists") { emailError.textContent = "This email is already registered!"; emailError.style.color = "red"; }
        else { emailError.textContent = "Email is available"; emailError.style.color = "green"; }
    } catch (error) { console.error("Axios check failed:", error); }
}

function clearServerError() {
    const alertBox = document.getElementById("serverErrorAlert");
    if (alertBox) alertBox.style.display = 'none';
}

function validatePhone() {
    const phone = document.getElementById("phone").value.trim();
    const phoneError = document.getElementById("phoneError");
    if (!/^[6-9][0-9]{9}$/.test(phone)) { phoneError.textContent = "Phone must start with 6-9 and contain 10 digits"; return false; }
    phoneError.textContent = ""; return true;
}

function validateAge() {
    const age = document.getElementById("age").value;
    const ageError = document.getElementById("ageError");
    if (age < 18 || age > 60) { ageError.textContent = "Age must be between 18 and 60"; return false; }
    ageError.textContent = ""; return true;
}

function validateGender() {
    const genderError = document.getElementById("genderError");
    const gender = document.querySelector('input[name="gender"]:checked');
    if (!gender) { genderError.textContent = "Please select gender"; return false; }
    genderError.textContent = ""; return true;
}

function validateAddress() {
    const address = document.getElementById("address").value.trim();
    const addressError = document.getElementById("addressError");
    if (address.length < 10) { addressError.textContent = "Address must contain at least 10 characters"; return false; }
    addressError.textContent = ""; return true;
}

function validatePassword() {
    const password = document.getElementById("password").value;
    const passwordError = document.getElementById("passwordError");
    const regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$/;
    if (!regex.test(password)) { passwordError.textContent = "Password must have uppercase, lowercase, number & special character"; return false; }
    passwordError.textContent = ""; return true;
}

function validateConfirmPassword() {
    const password = document.getElementById("password").value;
    const confirmPassword = document.getElementById("confirmPassword").value;
    const confirmPasswordError = document.getElementById("confirmPasswordError");
    if (password !== confirmPassword) { confirmPasswordError.textContent = "Passwords do not match"; return false; }
    confirmPasswordError.textContent = ""; return true;
}
</script>
</body>
</html>
