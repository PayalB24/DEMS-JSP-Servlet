package com.dems;

import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;

public class DashboardServlet extends HttpServlet {  
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/dems";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Payal@2005";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("id"));
            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String query = "DELETE FROM users WHERE user_id = ?";
                try (PreparedStatement ps = con.prepareStatement(query)) {
                    ps.setInt(1, userId);
                    int rowsAffected = ps.executeUpdate();
                    if (rowsAffected > 0) {
                        response.sendRedirect("dashboard.jsp");
                    } else {
                        response.getWriter().write("Error: Unable to delete user.");
                    }
                }
            } catch (SQLException e) {
                response.getWriter().write("Error: " + e.getMessage());
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String query = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)";
            try (PreparedStatement ps = con.prepareStatement(query)) {
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, password);
                ps.setString(4, role);

                int rowsAffected = ps.executeUpdate();
                if (rowsAffected > 0) {
                    response.sendRedirect("dashboard.jsp");
                } else {
                    response.getWriter().write("Error: Unable to add user.");
                }
            }
        } catch (SQLException e) {
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
}
