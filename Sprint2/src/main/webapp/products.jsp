<%@ page import="java.sql.*, com.xp.dbConnection.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>


<html>
<head>
<%@ include file="navbar.jsp" %>

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
    <h2 style="text-align: center;">Available Products</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Price</th>
            <th>Description</th>
            <th>Stock</th>
            <th>Action</th>
        </tr>

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
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td>$<%= rs.getDouble("price") %></td>
            <td><%= rs.getString("description") %></td>
            <td><%= rs.getInt("stock") %></td>
            <td>
                <% if (rs.getInt("stock") > 0) { %>
                <form action="AddToCartServlet" method="post">
                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                    <input type="hidden" name="name" value="<%= rs.getString("name") %>">
                    <input type="hidden" name="price" value="<%= rs.getDouble("price") %>">
                    <input type="submit" value="Add to Cart">
                </form>
                <% } else { %>
                <span style="color: red;">Out of Stock</span>
                <% } %>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
        %>
        <tr>
            <td colspan="6" style="color: red; text-align: center;">Error fetching products. Check console for details.</td>
        </tr>
        <%
            } 

        %>
    </table>

<div class="text-center">
 <h2>Begin this div now</h2>

		<div class="row">
		 
		 <%
		  Connection conn1 = null;
         Statement stmt1 = null;
         ResultSet rs1 = null;
         dbConnection dbcon1 = null;
		 
		 dbcon1 = new dbConnection();
         conn1 = dbcon1.createConnection();
         stmt1 = conn1.createStatement();
         String query1 = "SELECT * FROM products";
         rs1 = stmt1.executeQuery(query1);


            while (rs.next()) {
                int productIdi = rs1.getInt("id");
                String name1 = rs1.getString("name");
                double price1 = rs1.getDouble("price");
                String description1 = rs1.getString("description");
                int stock1 = rs1.getInt("stock"); 
                
         %>
		
		<div class="col-md-4 col-sm-6 mb-4">
            <div class="card h-100 shadow-lg">

                <div class="card-body text-center">
                    <h5 class="card-title"><%= name1 %></h5>
                    <p class="card-text text-muted"><%= description1 %></p>
                    <h6 class="text-success">$<%= price1 %></h6>
                    <form action="AddToCartServlet" method="post">
                        <input type="hidden" name="id" value="<%= productIdi %>">
	                    <input type="hidden" name="name" value="<%= name1 %>">
	                    <input type="hidden" name="price" value="<%= price1 %>">
	                    <input type="submit" value="Add to Cart">
                        
                        
                        
                     </form>
                </div>
            </div>
        </div>
          <% 
          }
            rs1.close();
            conn1.close();
            stmt1.close();
          
          
          %>		
		</div>

</div>




</body>
</html>