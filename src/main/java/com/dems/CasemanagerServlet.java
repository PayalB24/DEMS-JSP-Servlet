package com.dems;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@MultipartConfig
public class CasemanagerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String caseName = request.getParameter("case_name");
        String caseStatus = request.getParameter("case_status");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dems", "root", "Payal@2005");

            System.out.println("Database connected!");

            String sql = "INSERT INTO case_table (case_name, case_status, created_at) VALUES (?, ?, NOW())";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, caseName);
            stmt.setString(2, caseStatus);

            System.out.println("Executing SQL: " + sql);
            System.out.println("Case Name: " + caseName);
            System.out.println("Case Status: " + caseStatus);

            int rowsInserted = stmt.executeUpdate();
            System.out.println("✔ Rows Inserted: " + rowsInserted);
            con.commit();
            con.close();

            response.sendRedirect("casemanager-dashboard.jsp?message=Evidence Uploaded Successfully");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("casemanager-dashboard.jsp?error=" + e.getMessage());
        }
    }
}
