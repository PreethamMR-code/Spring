# NexMeet — Conference Management Platform

A full-stack conference management platform built with **Spring MVC**, **Hibernate ORM**, and **MySQL**. Supports the complete conference lifecycle — from creation and approval to registration, QR check-in, and certificate generation.

---

## Tech Stack

| Layer | Technology |
|---|---|
| Backend Framework | Spring MVC 5.3.31 |
| ORM | Hibernate 5.6.15 |
| Security | Spring Security 5.8 |
| Database | MySQL 8.0 |
| Connection Pool | HikariCP |
| View Layer | JSP + JSTL |
| PDF Generation | iText 5.5.13 |
| QR Code | ZXing 3.5.2 |
| Build Tool | Maven |
| Server | Tomcat 9 (embedded via Cargo) |

---

## Features by Role

### 👑 Admin (ROLE_SUPER_ADMIN)
- View all conferences with status filter (All / Pending / Approved / Rejected / Draft)
- Full conference detail review before approval
- Approve or Reject conferences with reason
- View all registered users with roles

### 🎯 Organizer (ROLE_ORGANIZER)
- Create conferences with full details (venue, dates, pricing, features)
- Submit for admin approval or save as draft
- Edit DRAFT and REJECTED conferences and resubmit
- View registered delegates list (name, email, status)
- QR-based attendance check-in at venue
- Real-time attendance stats (checked in / not yet arrived)

### 🎓 Delegate (ROLE_DELEGATE)
- Browse and register for approved conferences
- Download PDF admission ticket with large QR code and venue details
- Cancel registration (seat freed automatically)
- View QR code on dashboard (click for modal)
- Download participation certificate after attendance is marked

### 🏛️ Institution (ROLE_INSTITUTIONAL_ADMIN)
- Institutional admin dashboard (bulk upload — planned)

---

## Core Flows
```
Organizer Creates → Admin Approves → Delegate Registers
    → Gets Ticket PDF with QR → Attends Conference
    → Organizer Scans QR → Attendance Marked
    → Delegate Downloads Certificate
```

---

## Project Structure
```
nexmeet-platform/
├── src/main/java/com/nexmeet/platform/
│   ├── config/          # AuthSuccessHandler
│   ├── controller/      # Admin, Organizer, Delegate, Pub controllers
│   ├── dao/             # DAO interfaces + Hibernate implementations
│   ├── dto/             # ConferenceCreateDto, RegisterDto
│   ├── entity/          # 21 JPA entities
│   ├── enums/           # ConferenceStatus, RegistrationStatus, etc.
│   └── service/         # Service interfaces + implementations
├── src/main/webapp/
│   ├── WEB-INF/
│   │   ├── views/       # JSP pages by role
│   │   ├── spring-mvc-config.xml
│   │   ├── spring-db-config.xml
│   │   └── spring-security.xml
│   └── static/          # CSS, JS, images
└── pom.xml
```

---

## Database

- **Database:** `nexmeet_db`
- **Tables:** 22 tables
- Key tables: `users`, `roles`, `user_roles`, `conferences`, `organizers`,
  `registrations`, `attendance`, `qr_codes`, `certificates`

---

## How to Run Locally

### Prerequisites
- Java 8+
- Maven 3.6+
- MySQL 8.0
- IntelliJ IDEA (recommended)

### Step 1 — Clone the repository
```bash
git clone https://github.com/PreethamMR-code/Spring.git
cd Spring/nexmeet-platform
```

### Step 2 — Create the database
```sql
CREATE DATABASE nexmeet_db;
```
Then run the schema SQL file to create all 22 tables.

### Step 3 — Configure database credentials

Open `src/main/webapp/WEB-INF/spring-db-config.xml` and update:
```xml
<property name="jdbcUrl"
    value="jdbc:mysql://localhost:3306/nexmeet_db?useSSL=false&amp;serverTimezone=Asia/Kolkata"/>
<property name="username" value="root"/>
<property name="password" value="your_password"/>
```

### Step 4 — Insert default admin user
```sql
INSERT INTO users (full_name, email, password_hash, is_active, is_verified, created_at, updated_at)
VALUES ('Super Admin', 'admin@nexmeet.com',
'$2a$12$...bcrypt_hash...', true, true, NOW(), NOW());

INSERT INTO user_roles (user_id, role_id)
SELECT u.id, r.id FROM users u, roles r
WHERE u.email='admin@nexmeet.com' AND r.name='SUPER_ADMIN';
```

### Step 5 — Build and run
```bash
mvn clean package cargo:run
```

### Step 6 — Access the application
```
http://localhost:8080/nexmeet/
```

---

## Default Users (for testing)

| Role | Email | Password |
|---|---|---|
| Admin | admin@nexmeet.com | admin123 |
| Organizer | manoj@gmail.com | (registered via app) |
| Delegate | preetham@gmail.com | (registered via app) |

---

## Key Architectural Decisions

- **XML-based Spring configuration** — traditional enterprise style (no Spring Boot)
- **Hibernate SessionFactory** — explicit transaction management via `@Transactional`
- **Spring Security XML** — intercept-url with first-match-wins ordering
- **QR stored as Base64 LONGTEXT** — inline display without file system dependency
- **iText 5 PDF** — A5 ticket with embedded QR, A4 landscape certificate
- **No payment gateway** — fee collected at venue (Option 1 model)

---

## Screenshots

> *(Add screenshots of home page, delegate dashboard, ticket PDF, certificate PDF, attendance page)*

---

## Author

**Preetham M R**
- GitHub: [@PreethamMR-code](https://github.com/PreethamMR-code)

---

*Built as a portfolio project demonstrating enterprise Spring MVC patterns.*