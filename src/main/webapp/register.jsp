<%@ page import="java.sql.*, java.time.LocalDateTime" %>
<%
String message = "";
String name = request.getParameter("name");
String email = request.getParameter("email");
String password = request.getParameter("password");
String role = request.getParameter("role");

String url = "jdbc:mysql://localhost:3306/dems";
String user = "root";
String pass = "Payal@2005";

Connection con = null;
PreparedStatement ps = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection(url, user, pass);

    String query = "INSERT INTO users (name, email, password, role, created_at) VALUES (?, ?, ?, ?, ?)";
    ps = con.prepareStatement(query);
    ps.setString(1, name);
    ps.setString(2, email);
    ps.setString(3, password);
    ps.setString(4, role);
    ps.setTimestamp(5, new java.sql.Timestamp(new java.util.Date().getTime()));

    int result = ps.executeUpdate();
    if (result > 0) {
        message = "<div class='alert alert-success text-center'>Registration successful!</div>";
    } else {
        message = "<div class='alert alert-danger text-center'>Registration failed. Try again.</div>";
    }
} catch (Exception e) {
    message = "<div class='alert alert-danger text-center'>Error: " + e.getMessage() + "</div>";
} finally {
    try {
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
    <title>Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="CSS/register.css" rel="stylesheet">
</head>
<body>
	<img src="Images/logo.jpg" alt="Logo" class="">
    <div class="card col-md-4">
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
        <p>Already Registered? <a href="login.jsp">Login</a>
    </form>
    

</div>


</body>
</html>
