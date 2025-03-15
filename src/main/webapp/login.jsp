<%@ page import="java.sql.*" %>
<%
String message = "";
String email = request.getParameter("email");
String password = request.getParameter("password");

String url = "jdbc:mysql://localhost:3306/dems";
String user = "root";
String pass = "Payal@2005";

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
    if (email != null && password != null) {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url, user, pass);

        String query = "SELECT name, password, role FROM users WHERE email=?";
        ps = con.prepareStatement(query);
        ps.setString(1, email);
        rs = ps.executeQuery();

        if (rs.next()) {
            String storedPassword = rs.getString("password");
            String role = rs.getString("role");

            if (password.equals(storedPassword)) { 
                session.setAttribute("user", rs.getString("name"));
                session.setAttribute("role", role);

                if ("prosecutor".equalsIgnoreCase(role)) {
                    response.sendRedirect("prosecutor-dashboard.jsp");
                } else if ("dl".equalsIgnoreCase(role)) {
                    response.sendRedirect("prosecutor-dashboard.jsp"); 
                } else if ("admin".equalsIgnoreCase(role)) {
                    response.sendRedirect("dashboard.jsp");
                } else if ("investigator".equalsIgnoreCase(role)) {
                    response.sendRedirect("investigator-dashboard.jsp");
                } else if ("lem".equalsIgnoreCase(role)) {
                    response.sendRedirect("investigator-dashboard.jsp");
                } else if ("cm".equalsIgnoreCase(role)) {
                    response.sendRedirect("casemanager-dashboard.jsp");
                } else if ("fa".equalsIgnoreCase(role)) {
                    response.sendRedirect("forensic-dashboard.jsp");
                } else if ("detective".equalsIgnoreCase(role)) {
                    response.sendRedirect("detective-dashboard.jsp");
                } else if ("ao".equalsIgnoreCase(role)) {
                    response.sendRedirect("audit-dashboard.jsp");
                } else {
                    response.sendRedirect("index.html");
                }
                return;
            } else {
                message = "<div class='alert alert-danger text-center'>Invalid password.</div>";
            }
        } else {
            message = "<div class='alert alert-danger text-center'>User not found.</div>";
        }
    }
} catch (Exception e) {
    message = "<div class='alert alert-danger text-center'>Error: " + e.getMessage() + "</div>";
} finally {
    try {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    } catch (SQLException e) {
        message = "<div class='alert alert-danger text-center'>Error closing connection: " + e.getMessage() + "</div>";
    }
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="CSS/register.css" rel="stylesheet">
</head>
<body>
    <img src="Images/logo.jpg" alt="Logo" class="">

    <div class="card col-md-4">
        <form method="POST">
            <h2 class="text-center">Login</h2>
            <%= message %>
            <div class="mb-3">
                <input type="email" name="email" class="form-control" placeholder="Email" required>
            </div>
            <div class="mb-3">
                <input type="password" name="password" class="form-control" placeholder="Password" required>
            </div>
            <button type="submit" class="btn w-100">Login</button>
            <p>Don't have an account? <a href="register.jsp">Register</a></p>
            <div class="text-center mt-3">
        <a href="index.html" class="btn btn-secondary w-100">Back to Home</a>
    </div>
        </form>
    </div>

</body>
</html>
