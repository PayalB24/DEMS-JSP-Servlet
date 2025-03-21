<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Forensic Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <h2 class="text-center text-danger mb-4">Forensic Dashboard</h2>

        <!-- Form to Add Forensic Report -->
        <div class="card shadow-lg p-4 mb-4">
            <h4 class="text-dark mb-3">Add Forensic Report</h4>
            <form action="GenerateReport" method="post">
                <div class="mb-3">
                    <label class="form-label">Case ID:</label>
                    <input type="number" name="case_id" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Report Details:</label>
                    <textarea name="report_details" class="form-control" rows="4" required></textarea>
                </div>
                <button type="submit" class="btn btn-danger">Add Report</button>
            </form>
        </div>

        <!-- Table to Display Forensic Reports -->
        <div class="card shadow-lg p-4">
            <h4 class="text-dark mb-3">Forensic Reports</h4>
            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>Report ID</th>
                        <th>Case ID</th>
                        <th>Details</th>
                        <th>Created At</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dems", "root", "Payal@2005");
                            String query = "SELECT * FROM forensic_reports ORDER BY created_at DESC";
                            PreparedStatement ps = con.prepareStatement(query);
                            ResultSet rs = ps.executeQuery();

                            while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("report_id") %></td>
                        <td><%= rs.getInt("case_id") %></td>
                        <td><%= rs.getString("report_details") %></td>
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

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
