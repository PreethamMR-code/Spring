// ===== SIGNUP VALIDATION =====
function validateSignupForm(event) {
    const name    = document.getElementsByName('name')[0].value.trim();
    const email   = document.getElementsByName('email')[0].value.trim();
    const phone   = document.getElementsByName('phone')[0].value.trim();
    const ageStr  = document.getElementsByName('age')[0].value.trim();
    const gender  = document.querySelector('input[name="gender"]:checked');
    const address = document.getElementsByName('address')[0].value.trim();
    const pwd     = document.getElementById('password').value;
    const cpwd    = document.getElementById('confirmPassword').value;

    // Name
    if (!name) {
        alert("Please enter your full name");
        event.preventDefault();
        return false;
    }

    // Email (simple pattern)
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!email || !emailRegex.test(email)) {
        alert("Please enter a valid email address");
        event.preventDefault();
        return false;
    }

    // Phone: digits and length >= 10
    const phoneRegex = /^[0-9]{10,}$/;
    if (!phone || !phoneRegex.test(phone)) {
        alert("Please enter a valid mobile number (at least 10 digits)");
        event.preventDefault();
        return false;
    }

    // Age: between 10 and 100
    const age = parseInt(ageStr, 10);
    if (isNaN(age) || age < 10 || age > 100) {
        alert("Please enter a valid age between 10 and 100");
        event.preventDefault();
        return false;
    }

    // Gender
    if (!gender) {
        alert("Please select gender");
        event.preventDefault();
        return false;
    }

    // Address
    if (!address || address.length < 5) {
        alert("Please enter a valid address (minimum 5 characters)");
        event.preventDefault();
        return false;
    }

    // Password
    if (!pwd || !cpwd) {
        alert("Please enter password and confirm password");
        event.preventDefault();
        return false;
    }

    if (pwd.length < 8) {
        alert("Password must be at least 8 characters");
        event.preventDefault();
        return false;
    }

    if (pwd !== cpwd) {
        alert("Password and Confirm Password must match");
        event.preventDefault();
        return false;
    }

    return true;
}

// ===== LOGIN VALIDATION =====
function validateLoginForm(event) {
    const email = document.getElementsByName('email')[0].value.trim();
    const pwd   = document.getElementsByName('password')[0].value;

    if (!email || !pwd) {
        alert("Email and Password are required");
        event.preventDefault();
        return false;
    }

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        alert("Please enter a valid email address");
        event.preventDefault();
        return false;
    }

    if (pwd.length < 8) {
        alert("Password must be at least 8 characters");
        event.preventDefault();
        return false;
    }

    return true;
}
