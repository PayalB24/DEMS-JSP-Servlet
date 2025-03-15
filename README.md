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
DEMS-HTML-Servlet/<br>
│── src/<br>
│   ├── com.dems.servlet/       # Java Servlet files<br>
│   ├── com.dems.dao/           # Database Access Layer<br>
│   ├── com.dems.model/         # Data Models<br>
│── webapp/<br>
│   ├── index.html              # Landing Page<br>
│   ├── styles.css              # Stylesheet<br>
│   ├── script.js               # Client-side JavaScript<br>
│   ├── WEB-INF/<br>
│       ├── web.xml             # Servlet Configuration<br>
│── database/<br>
│   ├── dem_schema.sql          # SQL Schema<br>
│── README.md<br>
🚀 <h3>Features</h3>
✔️ User authentication (Login & Signup)
✔️ Upload and store digital evidence
✔️ Secure access for authorized personnel
✔️ Audit trail for tracking modifications
