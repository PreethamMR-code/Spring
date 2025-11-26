<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Matrimony Form</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body{background:#f4f6f9;padding-top:30px;}
        .card{max-width:850px;margin:auto;}
    </style>
</head>
<body>

<div class="card shadow p-4">
<h3 class="text-center mb-3">Matrimony Registration Form</h3>

<form onsubmit="return validateForm()" method="post" action="matrimony" >

    <!-- Step 1 Email -->
    <div class="mb-3">
        <label>Email</label>
        <input type="email" id="email" name="email" class="form-control">
    </div>

    <!-- Step 2 Full Name -->
    <div class="mb-3">
        <label>Full Name</label>
        <input type="text" id="fullName" name="fullName" class="form-control">
    </div>

    <!-- Step 3 Profile -->
    <div class="mb-3">
        <label>Profile For</label>
        <select id="profileFor" class="form-select" name="profileFor">
            <option value="">-- Select --</option>
            <option>Self</option>
            <option>Son</option>
            <option>Daughter</option>
            <option>Brother</option>
            <option>Sister</option>
        </select>
    </div>

    <!-- Step 4 Gender -->
    <div class="mb-3">
        <label>Gender</label><br>
        <input type="radio" name="gender" value="Male" onclick="showFields('Groom')"> Male
        <input type="radio" name="gender" value="Female" onclick="showFields('Bride')" class="ms-2"> Female
    </div>

    <!-- Fields appear here -->
    <div id="extraFields" style="display:none;">
        <h5 id="titleText" class="text-primary fw-bold"></h5>

        <div class="row g-3">

            <div class="col-md-6">
                <label>Date of Birth</label>
                <input type="date" id="dob" class="form-control" name="dob">
            </div>

            <div class="col-md-6">
                <label>Mother Tongue</label>
                <select id="motherTongue" class="form-select" name="motherTongue">
                    <option value="">-- Select --</option>
                    <option>Kannada</option>
                    <option>Telugu</option>
                    <option>Tamil</option>
                    <option>Hindi</option>
                </select>
            </div>

            <div class="col-md-6">
                <label>Religion</label>
                <select id="religion" class="form-select" name="religion">
                    <option value="">-- Select --</option>
                    <option>Hindu</option>
                    <option>Muslim</option>
                    <option>Christian</option>
                    <option>Jain</option>
                </select>
            </div>

            <div class="col-md-6">
                <label>Marital Status</label>
                <select id="maritalStatus" class="form-select" name="maritalStatus">
                    <option value="">-- Select --</option>
                    <option>Never Married</option>
                    <option>Divorced</option>
                    <option>Widowed</option>
                </select>
            </div>

            <div class="col-md-6">
                <label>Height (feet)</label>
                <input type="number" id="height" min="1" max="7" name="height" class="form-control" placeholder="1-7">
            </div>

            <div class="col-12 text-center">
                <button type="submit" class="btn btn-primary mt-3">Submit</button>
            </div>
        </div>
    </div>
</form>
</div>

<!-- JS LOAD FROM CORRECT PATH -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="script.js"></script>
</body>
</html>
