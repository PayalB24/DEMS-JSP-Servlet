<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Posecutor Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            display: flex;
            min-height: 100vh;
        }
        .sidebar {
            width: 250px;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            background-color: #212529;
            color: white;
            padding-top: 20px;
        }
        .sidebar a {
            color: white;
            text-decoration: none;
            display: block;
            padding: 10px;
            margin: 5px 0;
            border-radius: 4px;
        }
        .sidebar a:hover {
            background-color: #e67e22;
        }
        
    </style>
</head>
<body>
    <div class="sidebar">
        <a href="view_cases.jsp" class="nav-link">View Cases</a>
        <a href="view_evidence.jsp" class="nav-link">View Evidence</a>
        <a href="view_reports.jsp" class="nav-link">View Reports</a>
    </div>


    <script>
        const sections = document.querySelectorAll('.nav-link');
        sections.forEach(section => {
            section.addEventListener('click', function() {
                const target = document.querySelector(this.getAttribute('href'));
                document.querySelectorAll('.card').forEach(card => card.style.display = 'none');
                target.style.display = 'block';
            });
        });
    </script>
</body>
</html>
