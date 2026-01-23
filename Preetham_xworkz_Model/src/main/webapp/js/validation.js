//// ===== SIGNUP VALIDATION =====
//function validateSignupForm(event) {
//
//    const isSubmit = event.type === "submit";
//    let valid = true;
//
//    // clear ONLY client-side errors on submit
//    if (isSubmit) {
//        document.querySelectorAll("small.text-danger[id]")
//            .forEach(e => e.innerText = "");
//    }
//
//    // ===== NAME =====
//    if (isSubmit || event.target.name === "name") {
//        const name = document.getElementsByName("name")[0].value.trim();
//        const nameRegex = /^[A-Za-z ]+$/;
//
//        if (!name) {
//            showError("nameError", "Name is required");
//            valid = false;
//        } else if (name.length < 3) {
//            showError("nameError", "Name must be at least 3 characters");
//            valid = false;
//        } else if (!nameRegex.test(name)) {
//            showError("nameError", "Name must contain only letters");
//            valid = false;
//        } else {
//            clearError("nameError");
//        }
//    }
//
//    // ===== EMAIL =====
//    if (isSubmit || event.target.name === "email") {
//        const email = document.getElementsByName("email")[0].value.trim();
//        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
//
//        if (!email) {
//            showError("emailError", "Email is required");
//            valid = false;
//        } else if (!emailRegex.test(email)) {
//            showError("emailError", "Enter a valid email");
//            valid = false;
//        } else {
//            clearError("emailError");
//        }
//    }
//
//    // ===== PHONE =====
//    if (isSubmit || event.target.name === "phone") {
//        const phone = document.getElementsByName("phone")[0].value.trim();
//
//        if (!phone) {
//            showError("phoneError", "Phone number is required");
//            valid = false;
//        } else if (!/^[6-9][0-9]{9}$/.test(phone)) {
//            showError("phoneError",
//                      "Phone must start with 6–9 and be 10 digits");
//            valid = false;
//        } else {
//            clearError("phoneError");
//        }
//    }
//
//    // ===== AGE =====
//    if (isSubmit || event.target.name === "age") {
//        const age = document.getElementsByName("age")[0].value;
//
//        if (!age) {
//            showError("ageError", "Age is required");
//            valid = false;
//        } else if (age < 18 || age > 100) {
//            showError("ageError", "Age must be between 18 and 100");
//            valid = false;
//        } else {
//            clearError("ageError");
//        }
//    }
//
//    // ===== GENDER =====
//    if (isSubmit || event.target.name === "gender") {
//        const gender = document.querySelector('input[name="gender"]:checked');
//
//        if (!gender) {
//            showError("genderError", "Gender is required");
//            valid = false;
//        } else {
//            clearError("genderError");
//        }
//    }
//
//    // ===== ADDRESS =====
//    if (isSubmit || event.target.name === "address") {
//        const address = document.getElementsByName("address")[0].value.trim();
//
//        if (!address) {
//            showError("addressError", "Address is required");
//            valid = false;
//        } else if (address.length < 5) {
//            showError("addressError", "Address must be at least 5 characters");
//            valid = false;
//        } else {
//            clearError("addressError");
//        }
//    }
//
//    // ===== PASSWORD =====
//    if (isSubmit || event.target.id === "password") {
//        const pwd = document.getElementById("password").value;
//
//        if (!pwd) {
//            showError("passwordError", "Password is required");
//            valid = false;
//        } else {
//            clearError("passwordError");
//        }
//    }
//
//    // ===== CONFIRM PASSWORD =====
//    if (isSubmit || event.target.id === "confirmPassword") {
//        const pwd = document.getElementById("password").value;
//        const cpwd = document.getElementById("confirmPassword").value;
//
//        if (!cpwd) {
//            showError("confirmPasswordError", "Confirm password is required");
//            valid = false;
//        } else if (pwd !== cpwd) {
//            showError("confirmPasswordError", "Passwords do not match");
//            valid = false;
//        } else {
//            clearError("confirmPasswordError");
//        }
//    }
//
//    if (!valid && isSubmit) {
//        event.preventDefault();
//    }
//
//    return valid;
//}
//
//// ===== Helper functions =====
//function showError(id, msg) {
//    const el = document.getElementById(id);
//    if (el) el.innerText = msg;
//}
//
//function clearError(id) {
//    const el = document.getElementById(id);
//    if (el) el.innerText = "";
//}
//
//
//
//// ===== LOGIN VALIDATION (optional) =====
//function validateLoginForm(event) {
//
//    document.getElementById("loginEmailError").innerText = "";
//    document.getElementById("loginPasswordError").innerText = "";
//
//    let valid = true;
//
//    const email = document.getElementsByName("email")[0].value.trim();
//    const pwd = document.getElementsByName("password")[0].value;
//
//    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
//
//    if (!email) {
//        document.getElementById("loginEmailError").innerText =
//            "Email is required";
//        valid = false;
//    } else if (!emailRegex.test(email)) {
//        document.getElementById("loginEmailError").innerText =
//            "Enter a valid email address";
//        valid = false;
//    }
//
//    if (!pwd) {
//        document.getElementById("loginPasswordError").innerText =
//            "Password is required";
//        valid = false;
//    } else if (pwd.length < 8) {
//        document.getElementById("loginPasswordError").innerText =
//            "Password must be at least 8 characters";
//        valid = false;
//    }
//
//    if (!valid) {
//        event.preventDefault();
//    }
//
//    return valid;
//}
