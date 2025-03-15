<%@ page import="java.sql.*, com.xp.dbConnection.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
<%@ include file="navbar.jsp" %>


<script>

	window.onload = function() {
		
	
	function applyFilter() {
		
		alert("Apply Button was clicked on!");
		let search = document.getElementById("search").value;
		let search = document.getElementById("category").value;
		let sort = document.getElementById("sort").value;
		
        let params = new URLSearchParams(window.location.search);
//
		
        
  if (search) {
            params.set("search", search); // Add or update the search parameter
        } else {
            params.delete("search"); // Remove if empty
        }

        if (category) {
            params.set("category", category);
        } else {
            params.delete("category");
        }

        if (sort) {
            params.set("sort", sort);
        } else {
            params.delete("sort");
        }
        
        
        window.location.search = params.toString();
	}
	};
	
</script>


<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">


    <title>Available Products</title>
    <style>
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            text-align: center;
            border: 1px solid black;	
        }
        th {
            background-color: #f2f2f2;
        }
        form {
            display: inline;
        }
    </style>
</head>
<body>
<div class="search-filter-bar">

<input type="text" id="search" placeholder="Search for products" value ="<%= request.getParameter("search") == null ? "" : request.getParameter("search") %>">

<select id ="category" name ="select">
<option value="Electronics" <%= "Electronics".equals(request.getParameter("category")) ? "selected" : "" %>>Electronics</option>
<option value="Mobiles" <%= "Electronics".equals(request.getParameter("category")) ? "selected" : "" %>>Mobiles</option>
<option value="Laptops" <%= "Electronics".equals(request.getParameter("category")) ? "selected" : "" %>>Laptops</option>
<option value="Books" <%= "Electronics".equals(request.getParameter("category")) ? "selected" : "" %>>Books</option>
</select>

<select id="sort" name = "sort">
	<option value=""> Sort By </option>
	<option value="price_asc" <%= "price_asc".equals(request.getParameter("sort")) ? "selected" : "" %>>Price: Low to High</option>
        <option value="price_desc" <%= "price_desc".equals(request.getParameter("sort")) ? "selected" : "" %>>Price: High to Low</option>
        <option value="name_asc" <%= "name_asc".equals(request.getParameter("sort")) ? "selected" : "" %>>Name: A-Z</option>
</select>

<button id="myButton" onclick="myFunc()">My Button</button>


<button type="button" id="applyBtn" onclick="applyFilter()">Apply</button>
</div>



<%

	String search = request.getParameter("search");
	String category = request.getParameter("category");
	String sort = request.getParameter("sort");
	
	String query1 = "Select * from products where 1=1";
	if(search!=null && !search.trim().isEmpty()) {
		query1 += " AND LOWER(name) LIKE LOWER('%" + search +"%')" ;
	}
	if(category != null && category.trim().isEmpty()) {
		query1 += " AND category= '" + category + "'";

	}
	
	if(sort!=null) {
		
		if(sort.equals("price_asc")) query1 += " ORDER BY price ASC";
		if(sort.equals("price_desc")) query1 += " ORDER BY price DESC";
		if(sort.equals("name_asc")) query1 += " ORDER BY name ASC";
		
		
	}
	
	dbConnection cc = new dbConnection();
	
	Connection conn1 = cc.createConnection();
	Statement stmt1 = conn1.createStatement();
	ResultSet rs1 = stmt1.executeQuery(query1);
		
%>

    <h2 style="text-align: center;">Available Products</h2>

<div class = "row">

        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            dbConnection dbcon = null;

            try {
                // Establish connection to the database
                dbcon = new dbConnection();
                conn = dbcon.createConnection();
                stmt = conn.createStatement();
                String query = "SELECT * FROM products";
                rs = stmt.executeQuery(query);
                

                // Display all available products
                while (rs1.next()) {
                	int productId = rs1.getInt("id");
                    String name = rs1.getString("name");
                    double price = rs1.getDouble("price");
                    String description = rs1.getString("description");
                    int stock = rs1.getInt("stock"); 
                    String categoryP = rs1.getString("category");
                	
                	
        %>
        
        <div class="col-md-4 col-sm-6 mb-4">
            <div class="card h-100 shadow-lg">

                <div class="card-body text-center">
                    <h5 class="card-title"><%= name %></h5>
                    <p class="card-text text-muted"><%= description %></p>
                    <p class="card-text text-muted"><%= categoryP %></p>
                    <h6 class="text-success">$<%= price %></h6>
                    <h6 class="text-success">ID: <%= productId %></h6>
                    
                    <a href="product_details.jsp?id=<%= productId %>" class="btn btn-primary">
            		View Details
        			</a>
                    <form action="AddToCartServlet" method="post">
                        <input type="hidden" name="productId" value="<%= productId %>">
                        <button type="submit" class="btn btn-primary">Add to Cart</button>
                    </form>
                </div>
            </div>
        </div>
       
       <%


            }
            } catch(Exception e) {
            	e.printStackTrace();
            }
             finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>

</div>






</body>
</html>