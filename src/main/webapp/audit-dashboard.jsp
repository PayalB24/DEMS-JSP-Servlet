<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Audit Dashboard</title>
    <style>
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid black; padding: 10px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <h2>Audit Dashboard</h2>
    
    <!-- Search Cases -->
    <form action="audit-dashboard.jsp" method="get">
        <label>Search Case:</label>
        <input type="text" name="case_name">
        <button type="submit">Search</button>
    </form>
    
    <h3>Recent Case Activities</h3>
    <table>
        <tr>
            <th>Case ID</th>
            <th>Case Name</th>
            <th>Status</th>
            <th>Created At</th>
        </tr>
        <% 
            String caseNameFilter = request.getParameter("case_name");
            String query = "SELECT case_id, case_name, case_status, created_at FROM case_table";
            if (caseNameFilter != null && !caseNameFilter.trim().isEmpty()) {
                query += " WHERE case_name LIKE '%" + caseNameFilter + "%'";
            }
            query += " ORDER BY created_at DESC";
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dems", "root", "Payal@2005");
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery(query);
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
    </table>


    <h3>Open Cases</h3>
    <ul>
        <% 
            try {
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dems", "root", "Payal@2005");
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT case_id, case_name FROM case_table WHERE case_status != 'Closed'");
                while (rs.next()) {
        %>
        <li>Case <%= rs.getInt("case_id") %>: <%= rs.getString("case_name") %></li>
        <% 
                }
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </ul>

    <h3>Evidence Upload Logs</h3>
    <table>
        <tr>
            <th>Evidence ID</th>
            <th>Case ID</th>
            <th>Uploaded By</th>
            <th>Upload Time</th>
            <th>Upload Time</th>
            <th>Upload Time</th>
        </tr>
        <% 
            try {
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dems", "root", "Payal@2005");
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT evidence_id, case_id, evidence_type, uploaded_by, file_name, collected_at from evidence ORDER BY collected_at DESC");
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("evidence_id") %></td>
            <td><%= rs.getInt("case_id") %></td>
            <td><%= rs.getString("evidence_type") %></td>
            <td><%= rs.getString("uploaded_by") %></td>
            <td><%= rs.getString("file_name") %></td>
            <td><%= rs.getTimestamp("collected_at") %></td>
        </tr>
        <% 
                }
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </table>

</body>
</html>
