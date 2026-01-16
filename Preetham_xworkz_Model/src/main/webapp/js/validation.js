function validateSignupForm(event){

    // Clear old errors
    document.querySelectorAll("small.text-danger").forEach(e => e.innerText = "");


    let valid = true;

    function validateName() {
        const name = document.getElementsByName("name")[0].value.trim();
        document.getElementById("nameError").innerText =
            name ? "" : "Name is required";
    }

    function validateEmail() {
        const email = document.getElementsByName("email")[0].value.trim();
        const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        document.getElementById("emailError").innerText =
            regex.test(email) ? "" : "Enter a valid email";
    }

    function validatePhone() {
        const phone = document.getElementsByName("phone")[0].value.trim();
        document.getElementById("phoneError").innerText =
            /^[6-9][0-9]{9}$/.test(phone)
                ? ""
                : "Mobile must start with 6–9 and be 10 digits";
    }

    function validateAge() {
        const age = document.getElementsByName("age")[0].value;
        document.getElementById("ageError").innerText =
            age >= 18 ? "" : "Age must be 18 or above";
    }

    function validateGender() {
        const gender = document.querySelector('input[name="gender"]:checked');
        document.getElementById("genderError").innerText =
            gender ? "" : "Please select gender";
    }

    function validateAddress() {
        const address = document.getElementsByName("address")[0].value.trim();
        document.getElementById("addressError").innerText =
            address.length >= 5 ? "" : "Address must be at least 5 characters";
    }

    function validatePassword() {
        const pwd = document.getElementById("password").value;
        const regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$/;
        document.getElementById("passwordError").innerText =
            regex.test(pwd)
                ? ""
                : "Must contain uppercase, lowercase, number & special character";
    }

    function validateConfirmPassword() {
        const pwd = document.getElementById("password").value;
        const cpwd = document.getElementById("confirmPassword").value;
        document.getElementById("confirmPasswordError").innerText =
            pwd === cpwd ? "" : "Passwords do not match";
    }



    if(!valid){
        event.preventDefault();
    }

    return valid;
}




/// ===== LOGIN VALIDATION (INLINE) =====
 function validateLoginForm(event) {

     // Clear previous errors
     document.getElementById("loginEmailError").innerText = "";
     document.getElementById("loginPasswordError").innerText = "";

     let valid = true;

     const email = document.getElementsByName("email")[0].value.trim();
     const pwd   = document.getElementsByName("password")[0].value;

     // Email validation
     const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
     if (!email) {
         document.getElementById("loginEmailError").innerText = "Email is required";
         valid = false;
     } else if (!emailRegex.test(email)) {
         document.getElementById("loginEmailError").innerText = "Enter a valid email address";
         valid = false;
     }

     // Password validation
     if (!pwd) {
         document.getElementById("loginPasswordError").innerText = "Password is required";
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
