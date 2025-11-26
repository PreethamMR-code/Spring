// Show form fields based on gender selection
function showFields(type){
    document.getElementById("extraFields").style.display = "block";
    document.getElementById("titleText").innerText = "Enter " + type + " Details ";
}

// Simple, readable form validation
function validateForm(){

    // Basic fields check
    if(document.getElementById("email").value.trim() === ""){
        alert("⚠ Please enter Email");
        document.getElementById("email").focus();
        return false;
    }

    if(document.getElementById("fullName").value.trim() === ""){
        alert("⚠ Please enter Full Name");
        document.getElementById("fullName").focus();
        return false;
    }

    if(document.getElementById("profileFor").value.trim() === ""){
        alert("⚠ Please select Profile For");
        document.getElementById("profileFor").focus();
        return false;
    }

    // Gender
    if(!document.querySelector("input[name='gender']:checked")){
        alert("⚠ Please select Gender");
        return false;
    }

    // Remaining fields after gender
    if(document.getElementById("dob").value.trim() === ""){
        alert("⚠ Please select Date of Birth");
        document.getElementById("dob").focus();
        return false;
    }

    if(document.getElementById("motherTongue").value.trim() === ""){
        alert("⚠ Please select Mother Tongue");
        document.getElementById("motherTongue").focus();
        return false;
    }

    if(document.getElementById("religion").value.trim() === ""){
        alert("⚠ Please select Religion");
        document.getElementById("religion").focus();
        return false;
    }

    if(document.getElementById("maritalStatus").value.trim() === ""){
        alert("⚠ Please select Marital Status");
        document.getElementById("maritalStatus").focus();
        return false;
    }

    // Height Validation
    let height = document.getElementById("height").value.trim();
    if(height === "" || height < 1 || height > 7){
        alert("⚠ Enter valid Height between 1–7");
        document.getElementById("height").focus();
        return false;
    }

    return true;  // Form ready to submit
}
