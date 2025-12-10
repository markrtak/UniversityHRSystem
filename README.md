# 🌐 University HR Management System

A full-stack Human Resources Management System built with **ASP.NET**, **C#**, and **Microsoft SQL Server**.  
The platform supports multi-role authentication, structured approval workflows, automated payroll generation, and complete attendance/leave lifecycle management.

This project demonstrates production-level backend engineering, enterprise SQL logic, and full-system architecture from data modeling → implementation → UI.

---

## 🏷️ Technology Badges

<p>
  <img src="https://img.shields.io/badge/C%23-239120?style=for-the-badge&logo=c-sharp&logoColor=white"/>
  <img src="https://img.shields.io/badge/.NET-512BD4?style=for-the-badge&logo=dotnet&logoColor=white"/>
  <img src="https://img.shields.io/badge/ASP.NET-5C2D91?style=for-the-badge&logo=dotnet&logoColor=white"/>
  <img src="https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white"/>
  <img src="https://img.shields.io/badge/HTML-E34F26?style=for-the-badge&logo=html5&logoColor=white"/>
  <img src="https://img.shields.io/badge/CSS-1572B6?style=for-the-badge&logo=css3&logoColor=white"/>
  <img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black"/>
</p>

---

## 🎥 Project Demo

### 🎬 **Full-Length Walkthrough Video**  
👉 **[Watch the complete demo](https://drive.google.com/file/d/1tqF-SIhw13IES8K-ktR7nazSod6abxl_/view)**

---


## 🚀 Key Features

### 🔐 **Multi-Role Authentication**
- **Admin:** system configuration, attendance handling, holidays, replacements  
- **HR Employee:** leave approvals, deduction management, payroll generation  
- **Academic Employee:** leave requests, performance access, attendance & payroll review  

---

### 🧠 **Enterprise Workflow Automation**
- Hierarchical approval chain  
  *Dean → Vice-Dean → Upper Board → HR*  
- Automatic employment status updates  
- Attendance initialization + holiday/day off logic  
- Deduction engine (missing hours, missing days, unpaid leave)  
- Overtime bonus calculation  
- Replacement validation system  

---

### 🗄️ **Database-Driven Business Logic**
This system implements:

- **40+ Stored Procedures**  
- **15+ Table-Valued Functions & Views**  
- **Full Payroll Engine**  
- **Medical, Unpaid, Accidental, Compensation, Annual Leave Logic**  
- **Document Handling System** (status, expiration, storage)  

All implemented using **Microsoft SQL Server** with enforced constraints and integrity.

---

## 🧱 Tech Stack

**Backend:**  
- C#, ASP.NET, MVC-style architecture  

**Database:**  
- Microsoft SQL Server  
- Stored Procedures  
- Views  
- Table-Valued Functions  

**Frontend:**  
- HTML  
- CSS  
- JavaScript  

---

## 🧬 System Architecture

### Documentation Included:
- 📘 **EERD.pdf** – complete data modeling  
- 📘 **Relational Schema** – table structures, relations, constraints  
- 📘 **Business Logic** – SQL-driven workflows for payroll, attendance, leaves  
- 📘 **Hierarchy Engine** – rank-based approval architecture  

This system mirrors real HR enterprise environments.

---

## 🛠️ Setup & Installation

1. Open the project in **Visual Studio**.
2. Import the database schema into **Microsoft SQL Server**.
3. Create all tables by running:
   ```sql
   EXEC createAllTables;
4. Insert sample data as needed.
5. Run the project through Visual Studio.

## Test Credentials

- **Admin:** Username: "aly", Password: "aly123"  
- **HR Employee:** Username: "4", Password: "908"    
- **Academic Employee:** Username: "1", Password: "123"   
