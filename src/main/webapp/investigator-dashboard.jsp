<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Investigator Dashboard</title>
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
        .content {
            margin-left: 260px;
            padding: 20px;
            width: 100%;
            background-color: #f8f9fa;
        }
        .card-header {
            background-color: #2c3e50;
            color: white;
        }
        .softred {
        	background-color: #e67e22;
        	border-radius : 4px;
        }
    </style>
</head>
<body>

    <div class="sidebar">
        <h4 class="text-center text-white">Investigator Dashboard</h4>
        <a href="#addEvidence" class="nav-link">Add Evidence</a>
        <a href="#addEvidenceMetadata" class="nav-link">Add Evidence Metadata</a>
        <a href="#generateReport" class="nav-link">Generate Report</a>
        <a href="view_cases.jsp" class="nav-link">View Cases</a>
        <a href="view_evidence.jsp" class="nav-link">View Evidence</a>
        <a href="view_reports.jsp" class="nav-link">View Reports</a>
    </div>

    <!-- Main Content -->
    <div class="content">
        <div id="addEvidence" class="card mt-4">
            <div class="card-header">
                <h4>Add New Evidence</h4>
            </div>
            <div class="card-body">
                <form action="/Digital_Evidence_Management_System/AddEvidenceServlet" method="post" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label class="form-label">Evidence ID:</label>
                        <input type="text" name="evidence_id" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Case ID:</label>
                        <input type="text" name="case_id" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Evidence Type:</label>
                        <input type="text" name="evidence_type" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Uploaded By:</label>
                        <input type="text" name="uploaded_by" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">File Name:</label>
                        <input type="text" name="file_name" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Upload Evidence File:</label>
                        <input type="file" name="evidence_file" class="form-control" required>
                    </div>
                    <button type="submit" class="softred">Upload Evidence</button>
                </form>
            </div>
        </div>

        <!-- Add Evidence Metadata Section -->
        <div id="addEvidenceMetadata" class="card mt-4" style="display:none;">
            <div class="card-header">
                <h4>Add Evidence Metadata</h4>
            </div>
            <div class="card-body">
                <form action="AddEvidenceMetaServlet" method="post">
                    <div class="mb-3">
                        <label class="form-label">Evidence ID:</label>
                        <input type="text" name="evidence_id" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Camera Make:</label>
                        <input type="text" name="camera_make" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Camera Model:</label>
                        <input type="text" name="camera_model" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Resolution:</label>
                        <input type="text" name="resolution" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Latitude:</label>
                        <input type="text" name="latitude" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Longitude:</label>
                        <input type="text" name="longitude" class="form-control">
                    </div>
                    <button type="submit" class="softred">Add Metadata</button>
                </form>
            </div>
        </div>

       <!-- Generate Report Section -->
<div id="generateReport" class="card mt-4" style="display:none;">
    <div class="card-header">
        <h4>Generate Report</h4>
    </div>
    <div class="card-body">
        <form action="GenerateReportServlet" method="post">
            <input type="hidden" name="generated_by" value="<%= session.getAttribute("user_id") %>" />
            <div class="mb-3">
                <label class="form-label">Report Type:</label>
                <input type="text" name="report_type" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Generated By</label>
                <input type="text" name="report_type" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">File Path:</label>
                <input type="text" name="file_path" class="form-control" required>
            </div>
            <button type="submit" class="softred">Generate Report</button>
        </form>
    </div>
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
