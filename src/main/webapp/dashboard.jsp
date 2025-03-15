<%@ page import="java.sql.*, java.util.*, jakarta.servlet.*, jakarta.servlet.http.*" %>
<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String message = "";

    try {
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dems", "root", "Payal@2005"); 
        String query = "SELECT * FROM users";
        ps = con.prepareStatement(query);
        rs = ps.executeQuery();
    } catch (Exception e) {
        message = "Error: " + e.getMessage();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management Dashboard</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            display: none; 
        }
        th, td {
            padding: 8px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .btn {
            padding: 5px 10px;
            margin: 5px;
            text-decoration: none;
            background-color: #4CAF50;
            color: white;
            border-radius: 5px;
        }
        .btn-danger {
            background-color: #f44336;
        }
        .show-btn {
            padding: 10px 15px;
            background-color: #008CBA;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
    <script>
        
        function showRecords() {
            var table = document.getElementById("userTable");
            if (table.style.display === "none") {
                table.style.display = "table";  
            } else {
                table.style.display = "none"; 
            }
        }
    </script>
</head>
<body>

    <h1>User Management Dashboard</h1>

    <p><%= message %></p>

    <button class="show-btn" onclick="showRecords()">Show Records</button>

    <table id="userTable">
        <thead>
            <tr>
                <th>User ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Role</th>
                <th>Created At</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                while (rs.next()) {
                    int userId = rs.getInt("user_id");
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String role = rs.getString("role");
                    Timestamp createdAt = rs.getTimestamp("created_at");
            %>
            <tr>
                <td><%= userId %></td>
                <td><%= name %></td>
                <td><%= email %></td>
                <td><%= role %></td>
                <td><%= createdAt %></td>
                <td>
                    <a href="update.jsp?id=<%= userId %>" class="btn">Update</a>
                    <a href="DashboardServlet?action=delete&id=<%= userId %>" class="btn btn-danger">Delete</a>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <hr>

    <h2>Add New User</h2>
    <form action="DashboardServlet" method="POST">
        <input type="text" name="name" placeholder="Enter Name" required><br><br>
        <input type="email" name="email" placeholder="Enter Email" required><br><br>
        <input type="password" name="password" placeholder="Enter Password" required><br><br>
        <select name="role" required>
            <option value="" disabled selected>Select Role</option>
                <option value="admin">Admin</option>
                <option value="investigator">Investigator</option>
                <option value="lem">Law Enforcement Officer</option>
                <option value="fa">Forensic Analyst</option>
                <option value="cm">Case Manager</option>
                <option value="detective">Detective</option>
                <option value="prosecutor">Prosecutor</option>
                <option value="dl">Defense Lawyer</option>
                <option value="ao">Audit Officer</option>
        </select><br><br>
        <input type="submit" value="Add User">
    </form>

</body>
</html>
