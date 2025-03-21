<%@ page import="java.sql.*, java.util.*, jakarta.servlet.*, jakarta.servlet.http.*" %>
<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String message = "";

    try {
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dems", "root", "Payal@2005"); 
        String query = "SELECT * FROM case_table";
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

    <h1>List of Cases</h1>

    <p><%= message %></p>

    <button class="show-btn" onclick="showRecords()">Show Records</button>

    <table id="userTable">
        <thead>
            <tr>
                <th>Case Id</th>
                <th>Case Name</th>
                <th>Case Status</th>
                <th>Created at</th>
            </tr>
        </thead>
        <tbody>
            <%
                while (rs.next()) {
                    int case_id = rs.getInt("case_id");
                    String case_name = rs.getString("case_name");
                    String case_status = rs.getString("case_status");
                    Timestamp createdAt = rs.getTimestamp("created_at");
            %>
            <tr>
                <td><%= case_id %></td>
                <td><%= case_name %></td>
                <td><%= case_status %></td>
                <td><%= createdAt %></td>
            </tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>
