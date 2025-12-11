<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search User</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .form-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background: #fff;
        }
        .error { color: red; }
        .result-box {
            margin-top: 20px;
            padding: 15px;
            background: #f9f9f9;
            border-radius: 8px;
            border: 1px solid #ccc;
        }
    </style>
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

    <div class="form-container">
        <h2 class="text-center mb-3">Search User</h2>

        <form action="RealEstateServlet" method="get">

            <div class="mb-3">
                <label class="form-label">Email:</label>
                <input type="text" class="form-control" name="email" id="email"
                       placeholder="Enter email to search">
            </div>

            <div class="row">
                <div class="col">
                    <button type="submit" name="submit" value="search" class="btn btn-primary w-100">
                        Search
                    </button>
                </div>
                <div class="col">
                    <button type="reset"  value="Clear" class="btn btn-secondary w-100">
                        Clear
                    </button>
                </div>
            </div>

            <!-- Display Search Result -->
            <c:if test="${realEstateDTO != null}">
                <div class="result-box mt-3">
                    <h5>Search Result</h5>
                    <p><strong>Full Name:</strong> ${sessionScope.realEstateDTO.fullName}</p>
                    <p><strong>Email :</strong> ${sessionScope.realEstateDTO.email}</p>
                    <p><strong>Property Type:</strong> ${sessionScope.realEstateDTO.propertyType}</p>
                    <p><strong>Budget:</strong> ${sessionScope.realEstateDTO.budget}</p>
                    <p><strong>Message:</strong> ${sessionScope.realEstateDTO.message}</p>


                    <a href="Update?emailId=${realEstateDTO.email}"
                       class="btn btn-warning btn-sm mt-2">Edit</a>
                </div>
            </c:if>

            <!-- Error Message -->
            <c:if test="${message != null}">
                <p class="error mt-2">${message}</p>
            </c:if>

        </form>
    </div>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
