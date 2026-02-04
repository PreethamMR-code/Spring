<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign Up | X-Workz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --card-shadow: 0 20px 40px rgba(0,0,0,0.1);
            --input-focus: #667eea;
        }
        
        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        main {
            min-height: calc(100vh - 140px);
            padding-top: 100px;
        }
        
        .logo-img {
            height: 50px;
            filter: drop-shadow(0 4px 8px rgba(0,0,0,0.2));
        }
        
        .navbar {
            background: rgba(255,255,255,0.95) !important;
            backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(0,0,0,0.1);
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }
        
        .navbar-brand {
            font-weight: 700;
            font-size: 1.4rem;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .hero-card {
            background: rgba(255,255,255,0.95);
            backdrop-filter: blur(20px);
            border-radius: 24px;
            border: 1px solid rgba(255,255,255,0.2);
            box-shadow: var(--card-shadow);
            transition: all 0.3s ease;
        }
        
        .hero-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 30px 60px rgba(0,0,0,0.15);
        }
        
        .form-floating > .form-control:focus {
            border-color: var(--input-focus);
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        
        .form-floating > label {
            color: #6c757d;
        }
        
        .btn-gradient {
            background: var(--primary-gradient);
            border: none;
            border-radius: 16px;
            padding: 12px 32px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }
        
        .btn-gradient:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 35px rgba(102, 126, 234, 0.5);
        }
        
        .nav-link {
            color: #495057 !important;
            font-weight: 500;
        }
        
        .nav-link:hover {
            color: var(--input-focus) !important;
        }
        
        .error-message {
            font-size: 0.85rem;
            margin-top: 4px;
        }
        
        .gender-options {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 16px;
            border: 2px solid #e9ecef;
        }
        
        .form-check-input:checked {
            background-color: var(--input-focus);
            border-color: var(--input-focus);
        }
        
        footer {
            background: rgba(0,0,0,0.85);
            backdrop-filter: blur(20px);
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg fixed-top px-4">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="<c:url value='/'/>">
            <img src="https://x-workz.com/Logo.png" class="logo-img me-3" alt="X-Workz">
            X-Workz Modules
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="fas fa-home me-1"></i>Home</a>
                </li>
            </ul>
            <div class="d-flex gap-2">
                <a href="signIn" class="btn btn-outline-primary px-4 fw-semibold">
                    <i class="fas fa-sign-in-alt me-1"></i>Sign In
                </a>
                <a href="signUp" class="btn-gradient text-white px-4 fw-semibold">
                    <i class="fas fa-user-plus me-1"></i>Sign Up
                </a>
            </div>
        </div>
    </div>
</nav>

<main class="d-flex align-items-center justify-content-center py-5">
    <div class="hero-card p-5" style="width:100%; max-width:520px;">
        <div class="text-center mb-5">
            <div class="mb-3">
                <i class="fas fa-user-plus fa-3x text-primary mb-3" style="background: var(--primary-gradient); -webkit-background-clip: text; -webkit-text-fill-color: transparent;"></i>
            </div>
            <h2 class="fw-bold mb-2" style="background: var(--primary-gradient); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Create Your Account</h2>
            <p class="text-muted">Join X-Workz today and get started!</p>
        </div>

        <form action="signUp" method="post">
            <div class="mb-4">
                <div class="form-floating">
                    <input type="text" id="name" name="name" class="form-control form-control-lg" value="${dto.name}"
                           oninput="validateName()" onchange="validateName()" placeholder="Full Name">
                    <label for="name"><i class="fas fa-user me-2"></i>Full Name</label>
                </div>
                <div class="text-danger error-message" id="nameError">${nameError}</div>
            </div>

            <div class="mb-4">
                <div class="form-floating">
                    <input type="email" id="email" name="email" class="form-control form-control-lg" value="${dto.email}"
                           onblur="checkEmailAvailability()" oninput="clearServerError();"
                            placeholder="Email">
                    <label for="email"><i class="fas fa-envelope me-2"></i>Email</label>
                </div>
                <div class="error-message" id="emailError">${emailError}</div>
            </div>

            <div class="mb-4">
                <div class="form-floating">
                    <input type="text" id="phone" name="phone" class="form-control form-control-lg" maxlength="10" value="${dto.phone}"
                           oninput="validatePhone()" onchange="validatePhone()" placeholder="Phone">
                    <label for="phone"><i class="fas fa-phone me-2"></i>Phone</label>
                </div>
                <div class="text-danger error-message" id="phoneError">${phoneError}</div>
            </div>

            <div class="mb-4">
                <div class="form-floating">
                    <input type="number" id="age" name="age" class="form-control form-control-lg" value="${dto.age}"
                           oninput="validateAge()" onchange="validateAge()" placeholder="Age">
                    <label for="age"><i class="fas fa-calendar-alt me-2"></i>Age</label>
                </div>
                <div class="text-danger error-message" id="ageError">${ageError}</div>
            </div>

            <div class="mb-4">
                <label class="form-label fw-semibold mb-3">Gender</label>
                <div class="gender-options">
                    <div class="d-flex gap-4 justify-content-center">
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="gender" value="Male" id="male" onchange="validateGender()">
                            <label class="form-check-label fw-medium" for="male">Male</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="gender" value="Female" id="female" onchange="validateGender()">
                            <label class="form-check-label fw-medium" for="female">Female</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="gender" value="Other" id="other" onchange="validateGender()">
                            <label class="form-check-label fw-medium" for="other">Other</label>
                        </div>
                    </div>
                </div>
                <div class="text-danger error-message" id="genderError">${genderError}</div>
            </div>

            <div class="mb-4">
                <div class="form-floating">
                    <input type="text" id="address" name="address" class="form-control form-control-lg" value="${dto.address}"
                           oninput="validateAddress()" onchange="validateAddress()" placeholder="Address">
                    <label for="address"><i class="fas fa-map-marker-alt me-2"></i>Address</label>
                </div>
                <div class="text-danger error-message" id="addressError">${addressError}</div>
            </div>

            <div class="mb-4">
                <div class="form-floating">
                    <input type="password" id="password" name="password" class="form-control form-control-lg"
                           oninput="validatePassword()" onchange="validatePassword()" placeholder="Password">
                    <label for="password"><i class="fas fa-lock me-2"></i>Password</label>
                </div>
                <div class="text-danger error-message" id="passwordError">${passwordError}</div>
            </div>

            <div class="mb-5">
                <div class="form-floating">
                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-control form-control-lg"
                           oninput="validateConfirmPassword()" onchange="validateConfirmPassword()" placeholder="Confirm Password">
                    <label for="confirmPassword"><i class="fas fa-lock-open me-2"></i>Confirm Password</label>
                </div>
                <div class="text-danger error-message" id="confirmPasswordError">${confirmPasswordError}</div>
            </div>

            <div class="d-grid">
                <button type="submit" class="btn btn-gradient text-white fw-semibold">
                    <i class="fas fa-rocket me-2"></i>Create Account
                </button>
            </div>

            <c:if test="${not empty msg}">
                <div class="alert alert-success border-0 alert-dismissible fade show mt-4" role="alert">
                    <i class="fas fa-check-circle me-2"></i>${msg}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
           <c:if test="${not empty error}">
               <div id="serverErrorAlert" class="alert alert-danger border-0 alert-dismissible fade show mt-4" role="alert">
                   <i class="fas fa-exclamation-triangle me-2"></i>${error}
                   <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
               </div>
           </c:if>
        </form>
    </div>
</main>

<footer class="text-white text-center py-4 mt-auto">
    <p class="mb-0 fw-semibold">© 2026 X-Workz Training Institute. All rights reserved.</p>
</footer>

<script>
    function validateName() {
        const nameInput = document.getElementById("name");
        const nameError = document.getElementById("nameError");
        const v = nameInput.value.trim();
        const nameRegex = /^[A-Za-z ]{3,50}$/;

        if (v === "") {
            nameError.textContent = "Name is required";
            return false;
        }
        if (!nameRegex.test(v)) {
            nameError.textContent = "Enter a valid name (3-50 alphabets only)";
            return false;
        }
        nameError.textContent = "";
        return true;
    }

   async function checkEmailAvailability() {
           const emailInput = document.getElementById("email");
           const emailError = document.getElementById("emailError");
           const email = emailInput.value.trim();


           if (email === "") {
                   emailError.textContent = "";
                   return;
               }

           if (!/^[a-zA-Z0-9._%+-]+@gmail\.com$/.test(email)) {
               emailError.textContent = "Email must end with @gmail.com";
               return;
           }

           try {
                   // Axios sends the request and waits for the server's Promise to resolve
                 //  const response = await axios.get(`checkEmail?email=${email}`);

                  const response = await axios.get('checkEmail', {params: { email: email }});
                   const result = response.data.trim();

                   if (result === "exists") {
                       emailError.textContent = "This email is already registered!";
                       emailError.style.color = "red";
                     //  document.querySelector('button[type="submit"]').disabled = true;
                   } else {
                       emailError.textContent = "Email is available";
                       emailError.style.color = "green";
                    //   document.querySelector('button[type="submit"]').disabled = false;
                   }
               } catch (error) {
                   console.error("Axios check failed:", error);
               }
           }

        function clearServerError() {
            const alertBox = document.getElementById("serverErrorAlert");
            if (alertBox) {
                // This hides the server alert as soon as the user starts typing
                alertBox.style.display = 'none';
            }
        }

    function validatePhone() {
        const phone = document.getElementById("phone").value.trim();
        const phoneError = document.getElementById("phoneError");

        if (!/^[6-9][0-9]{9}$/.test(phone)) {
            phoneError.textContent = "Phone must start with 6-9 and contain 10 digits";
            return false;
        }
        phoneError.textContent = "";
        return true;
    }

    function validateAge() {
        const age = document.getElementById("age").value;
        const ageError = document.getElementById("ageError");

        if (age < 18 || age > 60) {
            ageError.textContent = "Age must be between 18 and 60";
            return false;
        }
        ageError.textContent = "";
        return true;
    }

    function validateGender() {
        const genderError = document.getElementById("genderError");
        const gender = document.querySelector('input[name="gender"]:checked');

        if (!gender) {
            genderError.textContent = "Please select gender";
            return false;
        }
        genderError.textContent = "";
        return true;
    }

    function validateAddress() {
        const address = document.getElementById("address").value.trim();
        const addressError = document.getElementById("addressError");

        if (address.length < 10) {
            addressError.textContent = "Address must contain at least 10 characters";
            return false;
        }
        addressError.textContent = "";
        return true;
    }

    function validatePassword() {
        const password = document.getElementById("password").value;
        const passwordError = document.getElementById("passwordError");
        const regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$/;

        if (!regex.test(password)) {
            passwordError.textContent = "Password must have uppercase, lowercase, number & special character";
            return false;
        }
        passwordError.textContent = "";
        return true;
    }

    function validateConfirmPassword() {
        const password = document.getElementById("password").value;
        const confirmPassword = document.getElementById("confirmPassword").value;
        const confirmPasswordError = document.getElementById("confirmPasswordError");

        if (password !== confirmPassword) {
            confirmPasswordError.textContent = "Passwords do not match";
            return false;
        }
        confirmPasswordError.textContent = "";
        return true;
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
