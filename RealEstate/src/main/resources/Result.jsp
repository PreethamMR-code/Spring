<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>registered Details Result</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
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

    <div class="container col-md-6 mt-5">

      <h3 class="text-center mb-4 text-primary">registration Details Submitted</h3>

      <div class="border p-4 rounded shadow-sm bg-white">

        <!-- Success / Failure Messages -->
        <h1>
            <p style="color: green"><strong>${success}</strong></p>
            <p style="color: red"><strong>${fail}</strong></p>
        </h1>

        <!-- Display Data -->
        <p><strong>Full Name :</strong> ${fullName}</p>
        <p><strong>Email :</strong> ${email}</p>
        <p><strong>Property Type:</strong> ${propertyType}</p>
        <p><strong>Budget:</strong> ${budget}</p>
        <p><strong>Message:</strong> ${message}</p>


        <!-- Button -->
        <div class="mt-4 text-center">
            <a href="Registration.jsp" class="btn btn-primary">Go Back</a>
        </div>

      </div>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
