<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search by Property Type</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-image: url('');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }
        .form-container {
            background: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 15px;
            max-width: 700px;
            margin: 50px auto;
            box-shadow: 0 8px 16px rgba(0,0,0,0.3);
        }
        h2 {
            text-align: center;
            margin-bottom: 25px;
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

<!-- MAIN FORM -->
<div class="form-container">
    <h2>Search by Property Type</h2>

    <form action="property" method="get">
        <div class="mb-3">
            <label class="form-label">Property Type:</label>
            <input type="text" class="form-control"
                   name="propertyType"
                   placeholder="Enter property type (Apartment, Villa, Plot...)">
        </div>

        <div class="row">
            <div class="col">
                <button type="submit" name="submit" value="search"
                        class="btn btn-primary w-100">Search</button>
            </div>
            <div class="col">
                <button type="reset" class="btn btn-secondary w-100">Clear</button>
            </div>
        </div>

        <!-- ERROR MESSAGE -->
        <c:if test="${message != null}">
            <p class="text-danger mt-3">${message}</p>
        </c:if>

        <!-- TABLE RESULT -->
        <c:if test="${realEstateList != null}">
            <table class="table table-striped table-hover mt-4">
                <thead class="table-dark">
                    <tr>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Property Type</th>
                        <th>Budget</th>
                        <th>Message</th>
                        <th>Edit</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach items="${realEstateList}" var="item">
                        <tr>
                            <td>${item.fullName}</td>
                            <td>${item.email}</td>
                            <td>${item.propertyType}</td>
                            <td>${item.budget}</td>
                            <td>${item.message}</td>

                            <td>
                                <a href="Update?emailId=${item.email}"
                                   class="btn btn-sm btn-warning">
                                    Edit
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
