<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Real Estate Update Form</title>

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body class="bg-light">

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg bg-dark navbar-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="index.jsp">RealEstate</a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <div class="navbar-nav">
                <a class="nav-link" href="index.jsp">Home</a>
                <a class="nav-link" href="Registration.jsp">Register</a>
                <a class="nav-link" href="Search.jsp">Search by Email</a>
                <a class="nav-link active" href="RealEstateSearch.jsp">Search by Property Type</a>
            </div>
        </div>
    </div>
</nav>

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-6">

                <div class="card shadow-lg">
                    <div class="card-header text-center bg-primary text-white">
                        <h3>Property Update Form</h3>
                    </div>

                    <div class="card-body">

                        <form action="Update" method="POST">

                            <div class="mb-3">
                                <label class="form-label">Full Name</label>
                                <input type="text" id="fullName" name="fullName" class="form-control" placeholder="Enter your name" value="${sessionScope.editDTO.fullName}" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Email Address</label>
                                <input type="email" id="email" name="email" class="form-control" value="${sessionScope.editDTO.email}" placeholder="example@gmail.com" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Preferred Property Type</label>
                                 <select name="propertyType" id="propertyType" class="form-select" required>
                                    <option value="">-- Select Type --</option>
                                     <option ${sessionScope.editDTO.propertyType == 'Apartment' ? 'selected' : ''}>Apartment</option>
                                     <option ${sessionScope.editDTO.propertyType == 'Villa' ? 'selected' : ''}>Villa</option>
                                     <option ${sessionScope.editDTO.propertyType == 'Commercial Space' ? 'selected' : ''}>Commercial Space</option>
                                     <option ${sessionScope.editDTO.propertyType == 'Plot' ? 'selected' : ''}>Plot</option>
                                 </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Budget in La</label>
                                <input type="number" id="budget" name="budget" class="form-control" value="${sessionScope.editDTO.budget}" placeholder="Enter budget" required>
                            </div>

                            <div class="mb-3">

                                <label class="form-label">Message / Requirements</label>
                                <textarea name="message" id="message" class="form-control" rows="3"   placeholder="Describe your requirements...">${sessionScope.editDTO.message}</textarea>
                            </div>

                            <button type="submit" class="btn btn-primary w-100">Update</button>

                        </form>

                        <div class="text-center mt-3">
                            <a href="index.jsp" class="text-decoration-none"> Back to Home</a>
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="validation.js"></script>


</body>
</html>
