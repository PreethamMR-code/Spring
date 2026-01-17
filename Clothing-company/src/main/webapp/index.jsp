<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Clothing Company | Cloth Management System</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<!-- HEADER -->
<nav class="navbar navbar-expand-lg bg-dark navbar-dark px-4">
    <a class="navbar-brand fw-bold" href="index.jsp">
        👕 Clothing Company
    </a>
</nav>

<!-- MAIN CONTENT -->
<div class="container text-center my-5">

    <h1 class="mb-3 fw-bold">Cloth Inventory Management System</h1>
    <p class="mb-5 text-muted">
        Manage cloth details, stock, brands and pricing using Hibernate & JSP.
    </p>

    <div class="row justify-content-center">

        <!-- REGISTER CLOTH -->
        <div class="col-md-4 mb-4">
            <div class="card shadow-sm h-100 border-primary">
                <div class="card-body">
                    <h4 class="card-title fw-bold">Register Cloth</h4>
                    <p class="card-text">
                        Add new clothing items to the inventory.
                    </p>

                    <a href="registration.jsp" class="btn btn-primary w-100">
                        ➕ Add Cloth
                    </a>
                </div>
            </div>
        </div>

        <!-- SEARCH CLOTH -->
        <div class="col-md-4 mb-4">
            <div class="card shadow-sm h-100 border-success">
                <div class="card-body">
                    <h4 class="card-title fw-bold">Search Cloth</h4>
                    <p class="card-text">
                        Find clothes by name, brand, or type.
                    </p>

                    <a href="search.jsp" class="btn btn-success w-100">
                        🔍 Search Cloth
                    </a>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- FOOTER -->
<footer class="text-center border-top py-3 bg-white">
    <span class="fw-bold">Clothing Company Inventory System</span> |
    Powered by Hibernate + JSP
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
