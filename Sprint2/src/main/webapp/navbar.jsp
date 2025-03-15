   <!-- Bootstrap & FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">


<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="btn btn-outline-success" href="index.jsp">EazyDeals</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"> 
            <span class="navbar-toggler-icon"></span> This is a button
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="btn btn-outline-success" href="products.jsp">Products</a></li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="categoryDropdown" role="button" data-bs-toggle="dropdown">Category</a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#">Mobiles</a></li>
                        <li><a class="dropdown-item" href="#">Laptops</a></li>
                        <li><a class="dropdown-item" href="#">Appliances</a></li>
                        <li><a class="dropdown-item" href="#">Books</a></li>

                        <li><a class="dropdown-item" href="#">Clothes</a></li>
                    </ul>
                </li>
            </ul>
            <form class="d-flex">
                <input class="form-control me-2 search-bar" type="search" placeholder="Search for products">
                <button class="btn btn-light" type="submit">Search</button>
            </form>
            <a class="btn btn-light ms-3" href="signup.jsp">Register</a>
            <a class="btn btn-light ms-2" href="login.jsp">Login</a>
            <a class="btn btn-light ms-2" href="#">Admin</a>
            <form  action="logoutServlet" method = "post"> <input class="btn btn-light ms-2" type = "submit" value = "LogOut" ></form>
        </div>
    </div>
</nav>