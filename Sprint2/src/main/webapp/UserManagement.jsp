<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - User Management</title>

    <!-- Bootstrap & FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <style>
        body {
            background: linear-gradient(135deg, #3D8D7A, #A3D1C6, #FBFFE4);
            font-family: 'Poppins', sans-serif;
            color: black;
        }
        .container {
            margin-top: 30px;
        }
        .btn-action {
            padding: 5px 10px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            text-decoration: none;
        }
        .btn-block {
            background-color: red;
            color: white;
        }
        .btn-activate {
            background-color: green;
            color: white;
        }
        .btn-delete {
            background-color: black;
            color: white;
        }
        .btn-remove {
            background-color: darkorange;
            color: white;
        }
        .footer {
            margin-top: 50px;
            background-color: #3D8D7A;
            color: white;
            text-align: center;
            padding: 10px 0;
        }
    </style>
</head>
<body>



<div class="container">
    <h2>User Management</h2>

    <!-- Search & Filter -->
    <form action="user-management.jsp" method="GET">
        <div class="row mb-3">
            <div class="col-md-4">
                <input type="text" class="form-control" name="search" placeholder="Search by Name or Email">
            </div>
            <div class="col-md-4">
                <select class="form-control" name="status">
                    <option value="">All Users</option>
                    <option value="Active">Active Users</option>
                    <option value="Blocked">Blocked Users</option>
                </select>
            </div>
            <div class="col-md-4">
                <button type="submit" class="btn btn-dark">Search</button>
            </div>
        </div>
    </form>

    <!-- User List -->
    <table class="table table-bordered table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>

        <%
            String search = request.getParameter("search");
            String statusFilter = request.getParameter("status");

            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/eazydeals", "root", "password");

                String sql = "SELECT * FROM users WHERE 1=1";
                if (search != null && !search.isEmpty()) {
                    sql += " AND (name LIKE ? OR email LIKE ?)";
                }
                if (statusFilter != null && !statusFilter.isEmpty()) {
                    sql += " AND status = ?";
                }

                stmt = conn.prepareStatement(sql);
                int paramIndex = 1;
                if (search != null && !search.isEmpty()) {
                    stmt.setString(paramIndex++, "%" + search + "%");
                    stmt.setString(paramIndex++, "%" + search + "%");
                }
                if (statusFilter != null && !statusFilter.isEmpty()) {
                    stmt.setString(paramIndex++, statusFilter);
                }

                rs = stmt.executeQuery();

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String status = rs.getString("status");
        %>
                    <tr>
                        <td><%= id %></td>
                        <td><%= name %></td>
                        <td><%= email %></td>
                        <td><%= phone %></td>
                        <td><%= status %></td>
                        <td>
                            <% if ("Active".equals(status)) { %>
                                <a href="UserActionServlet?action=block&id=<%= id %>" class="btn-action btn-block">Block</a>
                            <% } else { %>
                                <a href="UserActionServlet?action=activate&id=<%= id %>" class="btn-action btn-activate">Activate</a>
                            <% } %>
                            <a href="UserActionServlet?action=delete&id=<%= id %>" class="btn-action btn-delete">Delete</a>
                            <a href="UserActionServlet?action=remove&id=<%= id %>" class="btn-action btn-remove">Remove</a>
                        </td>
                    </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>

        </tbody>
    </table>
</div>

<!-- Footer -->
<div class="footer">
    <p>&copy; 2024 EazyDeals. All rights reserved.</p>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>