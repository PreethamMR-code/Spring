<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Restaurant</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg bg-dark navbar-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="index.jsp">ZOMATO</a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <div class="navbar-nav">
                <a class="nav-link" href="index.jsp">Home</a>
                <a class="nav-link" href="Registration.jsp">Add Restaurant</a>
            </div>
        </div>
    </div>
</nav>


<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-6">

            <div class="card shadow-lg">
                <div class="card-header text-center bg-primary text-white">
                    <h3>Add Your Restaurant</h3>
                </div>

                <div class="card-body">

                    <form action="updateRestaurant" method="POST">

                        <div class="mb-3">
                            <label class="form-label">Owner Name</label>
                            <input type="text" id="ownerName" name="ownerName" class="form-control" placeholder="Enter your name"  value="${zomatoDTO.getOwnerName()}" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Email Address</label>
                            <input type="email" id="email" name="email" class="form-control" placeholder="example@gmail.com" value="${zomatoDTO.getEmail()}"required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Restaurant Name</label>
                            <input type="text" id="restaurantName" name="restaurantName" class="form-control" placeholder="Enter restaurant name"  value="${zomatoDTO.getRestaurantName()}" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Food Styles </label>
                            <select name="foodStyles" id="foodStyles" class="form-select"  required>
                                <option value="">-- Select Food Style --</option>
                                <option value="${zomatoDTO.getFoodStyles()}">Veg</option>
                                <option value="${zomatoDTO.getFoodStyles()}">Non-veg</option>
                                <option value="${zomatoDTO.getFoodStyles()}">North Indian</option>
                                <option value="${zomatoDTO.getFoodStyles()}">Chinese</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label"> City </label>
                            <input type="text" id="city" name="city" class="form-control" placeholder="Enter city" value="${zomatoDTO.getCity()}" required>
                        </div>


                        <div class="mb-3">
                            <label class="form-label">Contact Number</label>
                            <input type="number" name="number" id="number" class="form-control" placeholder="Enter your Number" value="${zomatoDTO.getNumber()}" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Number of Stars</label>
                            <input type="number" name="stars" id="stars" class="form-control" placeholder="Enter Stars" value="${zomatoDTO.getStars()}" required>
                        </div>




                        <button type="submit" class="btn btn-primary w-100"> update</button>

                    </form>

                    <div class="text-center mt-3">
                        <a href="index.jsp" class="text-decoration-none"> Back to Home</a>
                        <a href="search.jsp" class="text-decoration-none">Search</a>
                    </div>

                </div>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>