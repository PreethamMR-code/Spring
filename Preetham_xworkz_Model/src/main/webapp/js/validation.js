function validateSignupForm(event) {

    // Clear old errors
    document.querySelectorAll("small.text-danger").forEach(e => e.innerText = "");

    let valid = true;

    // ===== NAME =====
    const name = document.getElementsByName("name")[0].value.trim();
    const nameRegex = /^[A-Za-z ]+$/;
    if (!name) {
        document.getElementById("nameError").innerText = "Name is required";
        valid = false;
    } else if (name.length < 3) {
        document.getElementById("nameError").innerText =
            "Name must be at least 3 characters";
        valid = false;
    } else if (!nameRegex.test(name)) {
        document.getElementById("nameError").innerText =
            "Name must not contain numbers or symbols";
        valid = false;
    }

    // ===== EMAIL =====
    const email = document.getElementsByName("email")[0].value.trim();
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!email) {
        document.getElementById("emailError").innerText = "Email is required";
        valid = false;
    } else if (!emailRegex.test(email)) {
        document.getElementById("emailError").innerText = "Enter a valid email";
        valid = false;
    }

    // ===== PHONE =====
    const phone = document.getElementsByName("phone")[0].value.trim();
    if (!/^[6-9][0-9]{9}$/.test(phone)) {
        document.getElementById("phoneError").innerText =
            "Mobile must start with 6–9 and be 10 digits";
        valid = false;
    }

    // ===== AGE =====
    const age = document.getElementsByName("age")[0].value;
    if (age < 18 || age > 100) {
        document.getElementById("ageError").innerText =
            "Age must be between 18 and 100";
        valid = false;
    }

    // ===== GENDER =====
    const gender = document.querySelector('input[name="gender"]:checked');
    if (!gender) {
        document.getElementById("genderError").innerText =
            "Please select gender";
        valid = false;
    }

    // ===== ADDRESS =====
    const address = document.getElementsByName("address")[0].value.trim();
    if (address.length < 5) {
        document.getElementById("addressError").innerText =
            "Address must be at least 5 characters";
        valid = false;
    }

    // ===== PASSWORD =====
    const pwd = document.getElementById("password").value;
    const pwdRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$/;
    if (!pwdRegex.test(pwd)) {
        document.getElementById("passwordError").innerText =
            "Must contain uppercase, lowercase, number & special character";
        valid = false;
    }

    // ===== CONFIRM PASSWORD =====
    const cpwd = document.getElementById("confirmPassword").value;
    if (pwd !== cpwd) {
        document.getElementById("confirmPasswordError").innerText =
            "Passwords do not match";
        valid = false;
    }

    if (!valid) {
        event.preventDefault();
    }

    return valid;
}





function validateLoginForm(event) {

    document.getElementById("loginEmailError").innerText = "";
    document.getElementById("loginPasswordError").innerText = "";

    let valid = true;

    const email = document.getElementsByName("email")[0].value.trim();
    const pwd = document.getElementsByName("password")[0].value;

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (!email) {
        document.getElementById("loginEmailError").innerText =
            "Email is required";
        valid = false;
    } else if (!emailRegex.test(email)) {
        document.getElementById("loginEmailError").innerText =
            "Enter a valid email address";
        valid = false;
    }

    if (!pwd) {
        document.getElementById("loginPasswordError").innerText =
            "Password is required";
        valid = false;
    } else if (pwd.length < 8) {
        document.getElementById("loginPasswordError").innerText =
            "Password must be at least 8 characters";
        valid = false;
    }

    if (!valid) {
        event.preventDefault();
    }

    return valid;
}
