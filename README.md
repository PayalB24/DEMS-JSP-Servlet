<h1>Digital Evidence Management System (DEMS) - JSP & Servlet Implementation</h1>
📌 Project Overview
The Digital Evidence Management System (DEMS) is designed to securely store, manage, and retrieve digital evidence for law enforcement agencies. This implementation uses JSP and Java Servlets to build a dynamic web application.

🛠️ <h3>Technology Stack</h3>
Frontend: JSP
Backend: Java Servlets, JDBC
Database: MySQL
Server: Apache Tomcat
📁 <h3>Project Structure</h3>
pgsql
Copy
Edit
DEMS-HTML-Servlet/
│── src/
│   ├── com.dems.servlet/       # Java Servlet files
│   ├── com.dems.dao/           # Database Access Layer
│   ├── com.dems.model/         # Data Models
│── webapp/
│   ├── index.html              # Landing Page
│   ├── styles.css              # Stylesheet
│   ├── script.js               # Client-side JavaScript
│   ├── WEB-INF/
│       ├── web.xml             # Servlet Configuration
│── database/
│   ├── dem_schema.sql          # SQL Schema
│── README.md
🚀 <h3>Features</h3>
✔️ User authentication (Login & Signup)
✔️ Upload and store digital evidence
✔️ Secure access for authorized personnel
✔️ Audit trail for tracking modifications
