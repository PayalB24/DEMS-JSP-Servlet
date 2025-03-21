package com.dems;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;  // Add this import
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AddEvidenceMetaServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set character encoding to handle special characters
        request.setCharacterEncoding("UTF-8");

        // Retrieve form data
        String evidenceId = request.getParameter("evidence_id");
        String cameraMake = request.getParameter("camera_make");
        String cameraModel = request.getParameter("camera_model");
        String resolution = request.getParameter("resolution");
        String latitude = request.getParameter("latitude");
        String longitude = request.getParameter("longitude");

        if (evidenceId == null || cameraMake == null || cameraModel == null || resolution == null || latitude == null || longitude == null) {
            response.sendRedirect("investigator-dashboard.jsp?error=Missing required fields");
            return;  
        }
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dems", "root", "Payal@2005");

            String sql = "INSERT INTO evidence_meta (evidence_id, camera_make, camera_model, resolution, latitude, longitude) VALUES (?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, Integer.parseInt(evidenceId)); 
            pstmt.setString(2, cameraMake);
            pstmt.setString(3, cameraModel);
            pstmt.setString(4, resolution);
            pstmt.setString(5, latitude);
            pstmt.setString(6, longitude);
            
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                System.out.println("Data inserted successfully");
                response.sendRedirect("investigator-dashboard.jsp?message=Evidence Uploaded Successfully");
            } else {
                System.out.println("Error inserting data");
                response.sendRedirect("investigator-dashboard.jsp?error=Error uploading evidence");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("investigator-dashboard.jsp?error=Error uploading evidence");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
