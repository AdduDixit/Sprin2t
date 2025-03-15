<!DOCTYPE html>
<html lang="en">
<head>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>

<script>
    window.onload = function() {
        if (performance.navigation.type === 2) {  
            fetch('InvalidateSessionServlet', { method: 'POST' })  
                .then(response => {
                    window.location.href = 'login.jsp'; // Redirect to login
                });
        }
    };
</script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - EazyDeals</title>
    
    <!-- Bootstrap & FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <style>
        body {
            background: linear-gradient(B3D8A8, B3D8A8, #A3D1C6, #3D8D7A);
            font-family: 'Poppins', sans-serif;
            color: black;
        }
        .navbar { background-color: #A3D1C6; }
        .navbar-brand, .nav-link, .dropdown-item { color: black !important; }
        .search-bar { width: 300px; }
        .category-section {
            background-color: B3D8A8;
            padding: 10px 0;
            text-align: center;
        }
        .category-section img {
            width: 80px;
            height: 80px;
        }
        .carousel-item img { height: 350px; object-fit: cover; }
        .featured-product { transition: transform 0.3s ease-in-out; }
        .featured-product:hover { transform: scale(1.05); }
        .featured-product img { height: 200px; object-fit: cover; }
        .footer { background-color: #222; color: white; text-align: center; padding: 3px; font-size: 0.7em; margin-top: 15px; }
    </style>
</head>
<body>
<%
		HttpSession sess = request.getSession(false);
        String name = (String)sess.getAttribute("username");
        Integer userId = (Integer)sess.getAttribute("userId");
%>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand fw-bold" href="#">EazyDeals</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="products.jsp">Products</a></li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="categoryDropdown" role="button" data-bs-toggle="dropdown">Category</a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#">Mobiles</a></li>
                        <li><a class="dropdown-item" href="#">Laptops</a></li>
                        <li><a class="dropdown-item" href="#">Appliances</a></li>
                        <li><a class="dropdown-item" href="#">Books</a></li>
                        <li><a class="dropdown-item" href="#">Furniture</a></li>
                        <li><a class="dropdown-item" href="#">Clothes</a></li>
                    </ul>
                </li>
            </ul>
     
			
			<ul>
			<% if (name == null) { %>
			<li><a class="btn btn-light ms-3" href="signup.jsp">Register</a></li>
            <li><a class="btn btn-light ms-2" href="login.jsp">Login</a></li>
            <li><a class="btn btn-light ms-2" href="#">Admin</a></li>
			</ul>
            <%} else { %>
            <li> <a class="btn btn-light ms-2" href = "userprofile.jsp">My Profile</a> </li>
            <li><form action="logoutServlet" method = "post"> <input class="btn btn-light ms-2" type = "submit" value = "LogOut" ></form></li>
            <%} %>
            </ul>
        </div>
    </div>
</nav>


<div> Showing user data here
	
	

	<%= name %>
	<%= userId %>
		
</div>


<!-- Category Section -->
<div class="category-section">
    <div class="container d-flex justify-content-around">
        <div><img src="img/mobiles.png" alt="Mobiles"><p>Mobiles</p></div>
        <div><img src="img/laptops.png" alt="Laptops"><p>Laptops</p></div>
        <div><img src="img/appliances.png" alt="Appliances"><p>Appliances</p></div>
        <div><img src="img/books.png" alt="Books"><p>Books</p></div>
        <div><img src="img/furniture.png" alt="Furniture"><p>Furniture</p></div>
        <div><img src="img/clothes.png" alt="Clothes"><p>Clothes</p></div>
        <div><img src="img/electronics.png" alt="Electronics"><p>Electronics</p></div>
    </div>
</div>

<!-- Carousel -->
<div id="productCarousel" class="carousel slide" data-bs-ride="carousel">
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="img/banner1.jpg" class="d-block w-100" alt="Banner 1">
        </div>
        <div class="carousel-item">
            <img src="img/banner2.jpg" class="d-block w-100" alt="Banner 2">
        </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#productCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon"></span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#productCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon"></span>
    </button>
</div>

<!-- Latest Products -->
<div class="container mt-4">
    <h2 class="text-center mb-4">Latest Products</h2>
    <div class="row">
        <div class="col-md-4">
            <div class="card featured-product">
                <img src="img/earbuds.jpg" class="card-img-top" alt="Earbuds">
                <div class="card-body text-center">
                    <h5 class="card-title">Wireless Earbuds</h5>
                    <button class="btn btn-primary">View</button>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card featured-product">
                <img src="img/hoodie.jpg" class="card-img-top" alt="Hoodie">
                <div class="card-body text-center">
                    <h5 class="card-title">Black Hoodie</h5>
                    <button class="btn btn-primary">View</button>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card featured-product">
                <img src="img/laptop.jpg" class="card-img-top" alt="Gaming Laptop">
                <div class="card-body text-center">
                    <h5 class="card-title">Gaming Laptop</h5>
                    <button class="btn btn-primary">View</button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<div class="footer">
    <p>Follow us:</p>
    <p>Contact: support@eazydeals.com</p>
    <p>&copy; 2025 EazyDeals. All rights reserved.</p>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>