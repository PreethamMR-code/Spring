
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign Up | X-Workz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        main {
            flex: 1;
            padding-top: 90px;
        }
        .logo-img {
            height: 45px;
        }
    </style>
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow fixed-top px-4">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="<c:url value='/'/>">
            <img src="https://x-workz.com/Logo.png" class="logo-img me-2" alt="X-Workz">
            X-Workz Modules
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link fw-semibold" href="">Home</a>
                </li>
            </ul>
            <div class="d-flex gap-2">
                <a href="signIn" class="btn btn-light text-primary px-3 fw-semibold">Sign In</a>
                <a href="signUp" class="btn btn-outline-light px-3 fw-semibold">Sign Up</a>
            </div>
        </div>
    </div>
</nav>

<main class="d-flex align-items-center justify-content-center">
    <div class="card shadow p-4" style="width:100%; max-width:520px;">
        <div class="text-center mb-4">
            <h4 class="fw-bold text-primary">Create Account</h4>
        </div>

        <form action="signUp" method="post">
            <div class="mb-3">
                <label class="form-label">Full Name</label>
                <input type="text" id="name" name="name" class="form-control" value="${dto.name}"
                       oninput="validateName()" onchange="validateName()">
                <div class="text-danger small" id="nameError">${nameError}</div>
            </div>

            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" id="email" name="email" class="form-control" value="${dto.email}"
                       oninput="validateEmail()" onchange="validateEmail()">
                <div class="text-danger small" id="emailError">${emailError}</div>
            </div>

            <div class="mb-3">
                <label class="form-label">Phone</label>
                <input type="text" id="phone" name="phone" class="form-control" maxlength="10" value="${dto.phone}"
                       oninput="validatePhone()" onchange="validatePhone()">
                <div class="text-danger small" id="phoneError">${phoneError}</div>
            </div>

            <div class="mb-3">
                <label class="form-label">Age</label>
                <input type="number" id="age" name="age" class="form-control" value="${dto.age}"
                       oninput="validateAge()" onchange="validateAge()">
                <div class="text-danger small" id="ageError">${ageError}</div>
            </div>

            <div class="mb-3">
                <label class="form-label">Gender</label>
                <div class="d-flex gap-3">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="gender" value="Male" onchange="validateGender()">
                        <label class="form-check-label">Male</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="gender" value="Female" onchange="validateGender()">
                        <label class="form-check-label">Female</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="gender" value="Other" onchange="validateGender()">
                        <label class="form-check-label">Other</label>
                    </div>
                </div>
                <div class="text-danger small" id="genderError">${genderError}</div>
            </div>

            <div class="mb-3">
                <label class="form-label">Address</label>
                <input type="text" id="address" name="address" class="form-control" value="${dto.address}"
                       oninput="validateAddress()" onchange="validateAddress()">
                <div class="text-danger small" id="addressError">${addressError}</div>
            </div>

            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" id="password" name="password" class="form-control"
                       oninput="validatePassword()" onchange="validatePassword()">
                <div class="text-danger small" id="passwordError">${passwordError}</div>
            </div>

            <div class="mb-3">
                <label class="form-label">Confirm Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" class="form-control"
                       oninput="validateConfirmPassword()" onchange="validateConfirmPassword()">
                <div class="text-danger small" id="confirmPasswordError">${confirmPasswordError}</div>
            </div>

            <div class="d-grid mb-3">
                <button type="submit" class="btn btn-primary fw-semibold">Sign Up</button>
            </div>

            <c:if test="${not empty msg}">
                <div class="alert alert-success">${msg}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
        </form>
    </div>
</main>

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

    function validateEmail() {
        const email = document.getElementById("email").value.trim();
        const emailError = document.getElementById("emailError");

        if (!/^[a-zA-Z0-9._%+-]+@gmail\.com$/.test(email)) {
            emailError.textContent = "Email must end with @gmail.com";
            return false;
        }
        emailError.textContent = "";
        return true;
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

<footer class="bg-primary text-white text-center py-3 mt-auto">
    <p class="mb-0 fw-semibold">© 2026 X-Workz Training Institute</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>