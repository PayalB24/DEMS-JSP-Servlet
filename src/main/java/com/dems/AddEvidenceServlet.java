package com.dems;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@MultipartConfig
public class AddEvidenceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String evidenceId = request.getParameter("evidence_id");
        String caseId = request.getParameter("case_id");
        String evidenceType = request.getParameter("evidence_type");
        String uploadedBy = request.getParameter("uploaded_by");
        String fileName = request.getParameter("file_name");
        Part filePart = request.getPart("evidence_file");

        String filePath = "uploads" + File.separator + fileName; 
        File uploadDir = new File(getServletContext().getRealPath("/") + "uploads");
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        try {
            filePart.write(getServletContext().getRealPath("/") + filePath);

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dems", "root", "Payal@2005");
            if (con != null) {
                System.out.println("Database connected!");
            } else {
                System.out.println("Failed to connect to the database.");
            }

            String sql = "INSERT INTO evidence (evidence_id, case_id, evidence_type, uploaded_by, file_name, collected_at) VALUES (?, ?, ?, ?, ?, NOW())";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, evidenceId);
            stmt.setString(2, caseId);
            stmt.setString(3, evidenceType);
            stmt.setString(4, uploadedBy);
            stmt.setString(5, filePath); 
            stmt.executeUpdate();
            
            con.close();
            response.sendRedirect("investigator-dashboard.jsp?message=Evidence Uploaded Successfully");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("investigator-dashboard.jsp?error=Error uploading evidence");
        }
    }
}
