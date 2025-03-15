<%@ page import="java.sql.*" %>
<%
    String userId = request.getParameter("id");
    String name = "";
    String email = "";
    String role = "";

    if (userId != null) {
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dems", "root", "Payal@2005");
            PreparedStatement pst = conn.prepareStatement("SELECT * FROM users WHERE user_id = ?");
            pst.setInt(1, Integer.parseInt(userId));
            ResultSet rs = pst.executeQuery();
            
            if (rs.next()) {
                name = rs.getString("name");
                email = rs.getString("email");
                role = rs.getString("role");
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String newName = request.getParameter("name");
        String newEmail = request.getParameter("email");
        String newRole = request.getParameter("role");

        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dems", "root", "Payal@2005");
            PreparedStatement pst = conn.prepareStatement("UPDATE users SET name = ?, email = ?, role = ? WHERE user_id = ?");
            pst.setString(1, newName);
            pst.setString(2, newEmail);
            pst.setString(3, newRole);
            pst.setInt(4, Integer.parseInt(userId));
            pst.executeUpdate();
            conn.close();
            response.sendRedirect("dashboard.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update User</title>
</head>
<body>
    <h2>Update User</h2>
    <form method="post">
        <div class="mb-3">
            <input type="text" name="name" class="form-control" placeholder="Name" required>
        </div>
        <div class="mb-3">
            <input type="email" name="email" class="form-control" placeholder="Email" required>
        </div>
        <div class="mb-3">
            <input type="password" name="password" class="form-control" placeholder="Password" required>
        </div>
        <div class="mb-3">
            <select name="role" class="form-select" required>
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
            </select>
        </div>
        <button type="submit" class="btn  w-100">Register</button>

    </form>
    
</body>
</html>
