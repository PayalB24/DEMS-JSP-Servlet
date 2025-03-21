<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Case Manager Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <h2 class="text-center text-primary mb-4">Case Manager Dashboard</h2>

        <!-- Form to Add New Case -->
        <div class="card shadow-lg p-4 mb-4">
            <h4 class="text-dark mb-3">Add New Case</h4>
            <form action="CasemanagerServlet" method="post">
                <div class="mb-3">
                    <label class="form-label">Case Name:</label>
                    <input type="text" name="case_name" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Case Status:</label>
                    <input type="text" name="case_status" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-primary">Add Case</button>
            </form>
        </div>

        <!-- Table to Display Cases -->
        <div class="card shadow-lg p-4">
            <h4 class="text-dark mb-3">Case Records</h4>
            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>Case ID</th>
                        <th>Case Name</th>
                        <th>Status</th>
                        <th>Created At</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dems", "root", "Payal@2005");
                            String query = "SELECT * FROM case_table ORDER BY created_at DESC";
                            PreparedStatement ps = con.prepareStatement(query);
                            ResultSet rs = ps.executeQuery();

                            while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("case_id") %></td>
                        <td><%= rs.getString("case_name") %></td>
                        <td><%= rs.getString("case_status") %></td>
                        <td><%= rs.getTimestamp("created_at") %></td>
                    </tr>
                    <%
                            }
                            con.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Bootstrap JS (Optional for UI enhancements) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
