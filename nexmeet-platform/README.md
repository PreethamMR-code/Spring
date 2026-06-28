# NexMeet — Conference Management Platform

> A production-grade conference management platform built with **traditional Spring MVC 5.3 + Hibernate 5.6 — deliberately without Spring Boot** — to demonstrate deep understanding of the underlying framework rather than relying on auto-configuration.

---

## What is NexMeet?

NexMeet is a full-featured conference management system that handles the complete lifecycle of a conference — from creation and approval to registration, payment, attendance, certification, and post-event analytics.

It supports **four distinct roles** across a multi-tenant architecture:

| Role | Responsibility |
|------|---------------|
| **Super Admin** | Platform oversight, conference approval, organizer verification, commission management |
| **Organizer** | Create and manage conferences, speakers, sessions, bulk uploads, analytics |
| **Delegate** | Browse conferences, register, pay, attend, download tickets and certificates |
| **Institutional Admin** | Bulk-register students from their college or company |

---

## Tech Stack

| Layer | Technology | Version |
|-------|-----------|---------|
| Web Framework | Spring MVC | 5.3.32 |
| ORM | Hibernate | 5.6.15 |
| Database | MySQL | 8.0 |
| Connection Pool | HikariCP | 4.0.3 |
| Security | Spring Security | 5.8.9 |
| PDF Generation | iText | 5.5.13 |
| QR Codes | ZXing | 3.5.2 |
| Excel Export | Apache POI | 5.2.3 |
| CSV Parsing | Apache Commons CSV | 1.10.0 |
| Email | JavaMail + Mailtrap sandbox | 1.6.2 |
| Payment Gateway | Razorpay Test Mode | REST via HttpURLConnection |
| Frontend | Bootstrap | 5.3.0 |
| Charts | Chart.js | 4.4.0 |
| Logging | SLF4J + Logback | 1.7.36 / 1.2.12 |
| Build Tool | Maven + Cargo Plugin | — |
| Server | Embedded Tomcat 9 | — |
| Java Version | Java 8 | — |

**No Spring Boot. No Spring Data JPA. Pure XML bean configuration.**

---

## Architecture

```
nexmeet-platform/
├── src/main/java/com/nexmeet/platform/
│   ├── config/          # AuthSuccessHandler, NotificationInterceptor
│   ├── controller/
│   │   ├── admin/       # AdminController
│   │   ├── delegate/    # DelegateController, RegistrationController
│   │   ├── organizer/   # OrganizerController
│   │   ├── institution/ # InstitutionController
│   │   └── pub/         # HomeController, ConferenceController,
│   │                    # PaymentController, RegisterController, etc.
│   ├── dao/             # DAO interfaces
│   │   └── impl/        # Hibernate SessionFactory implementations
│   ├── dto/             # Form-binding DTOs
│   ├── entity/          # 22 JPA entities
│   ├── enums/           # ConferenceType (29 values), ConferenceStatus,
│   │                    # ConferenceMode, RegistrationStatus, etc.
│   ├── scheduler/       # ConferenceAutoCompletionScheduler
│   └── service/         # Service interfaces
│       └── impl/        # Business logic implementations
└── src/main/webapp/
    └── WEB-INF/
        ├── spring-mvc-config.xml    # DispatcherServlet, ViewResolver,
        │                           # Interceptors, Validators
        ├── spring-db-config.xml    # HikariCP, SessionFactory,
        │                           # TransactionManager, MailSender,
        │                           # property-placeholder for secrets
        ├── spring-security.xml     # URL rules, BCrypt, AuthHandler
        ├── web.xml                 # Filters, Listeners, Error pages
        └── views/                  # JSP files under WEB-INF
            ├── admin/
            ├── delegate/
            ├── organizer/
            ├── institution/
            ├── pub/
            └── common/
```

### Why traditional Spring MVC instead of Spring Boot?

Spring Boot is excellent for production use — but understanding what it hides is what separates developers who can debug framework issues from those who can't. This project was built without Boot to demonstrate:

- Manual `DispatcherServlet` configuration via `web.xml`
- XML-based bean definitions (`spring-db-config.xml`, `spring-mvc-config.xml`)
- Explicit `SessionFactory` and `HibernateTransactionManager` setup
- `<context:property-placeholder>` for secrets management without `@ConfigurationProperties`
- `<task:annotation-driven/>` for scheduling without `@EnableScheduling`
- Spring Security XML configuration with ordered `intercept-url` rules

### Why `hbm2ddl.auto=validate` instead of `update`?

`update` silently alters your schema in ways that can cause data loss in production. `validate` makes Hibernate fail fast at startup if the entity definitions don't match the actual table structure — forcing all schema changes to be deliberate DDL statements. Every column added in this project has a corresponding `ALTER TABLE` statement.

---

## Features

### Conference Lifecycle
- Organizer creates conference (DRAFT) → submits for approval (SUBMITTED)
- Admin reviews and approves or rejects with reason (APPROVED / REJECTED)
- Conference goes live — delegates can register
- Background `@Scheduled` job runs hourly to auto-complete expired conferences
- COMPLETED status triggers: certificate issuance + email delivery to all attended delegates

### Payment System
- **Free conferences**: no payment record created
- **OFFLINE / HYBRID paid**: simulated payment at registration; organizer manually confirms venue cash/UPI payment per delegate
- **ONLINE paid**: real Razorpay Test Mode integration
  - Server-side order creation via `HttpURLConnection` (Java 8, no SDK)
  - Razorpay Checkout.js popup in browser
  - HMAC-SHA256 signature verification server-side before registration is created
  - Separate `registerDelegatePostPayment()` to avoid duplicate payment rows on Razorpay callback

### Commission Invoice System
- Admin generates invoice per completed conference
- Invoice = base fee + (per-delegate fee × registered count) from `commission_settings` table
- Organizer submits UTR/UPI reference after paying offline
- Admin sees organizer's submitted reference pre-filled in the "Confirm Payment" modal
- Three invoice statuses: PENDING → PAID / WAIVED
- Both admin and organizer see commission history with totals

### Registration & Attendance
- Individual self-registration with delegate profile enforcement
- Bulk upload via CSV or Excel (organizer and institutional admin)
- QR code generated per registration (ZXing) — stored as Base64 in DB
- Organizer scans QR or enters registration number for attendance marking
- Certificate auto-issued to attended delegates on conference completion

### PDF Generation (iText)
- Ticket PDF with embedded QR code — emailed as attachment on registration
- Certificate PDF with conference name, delegate name, unique certificate number
- Certificate verification page at `/verify` (public, no login required)

### Email System (Mailtrap SMTP sandbox)
- Welcome email on account creation
- Ticket PDF attached on conference registration
- Conference approved / rejected with reason
- Conference cancelled with reason (broadcast to all confirmed delegates)
- Certificate PDF attached on completion
- Password reset with time-limited secure token

### Organizer Analytics
- Per-conference registrations, revenue, and attendance counts
- Chart.js bar and line charts for visual comparison
- Overall rating aggregated from delegate feedback

### Admin Capabilities
- Commission settings per conference type (29 types, configurable rates)
- Platform revenue tracking separate from commission invoice totals
- Organizer verification workflow with approval/rejection
- User activate/deactivate
- Institution management
- Audit log viewer with action filter (34+ tracked action types)
- Delegate overview per conference with attendance and certificate status

---

## Database Schema

22 tables. Key relationships:

```
users → user_roles → roles
users → delegates / organizers / institutional_admins
organizers → conferences → registrations → payments
                        → sessions ↔ speakers (session_speakers)
                        → qr_codes
registrations → attendance → certificates
conferences → feedback
conferences → commission_invoices
commission_settings (global, keyed by conference type)
audit_logs / notifications / bulk_uploads
outreach_contacts / password_reset_tokens
```

---

## Running Locally

### Prerequisites
- Java 8
- Maven 3.6+
- MySQL 8.0

### Step 1 — Clone the repository
```bash
git clone https://github.com/PreethamMR-code/nexmeet-platform.git
cd nexmeet-platform
```

### Step 2 — Create the database
```sql
CREATE DATABASE nexmeet_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
```

### Step 3 — Import the schema
```bash
mysql -u root -p nexmeet_db < DATABASE_export.sql
```

### Step 4 — Create `application.properties`

Create `src/main/resources/application.properties` (gitignored — never commit this):

```properties
# Database
db.url=jdbc:mysql://localhost:3306/nexmeet_db?useSSL=false&serverTimezone=Asia/Kolkata&allowPublicKeyRetrieval=true
db.username=root
db.password=YOUR_MYSQL_PASSWORD

# Mailtrap SMTP (dev email sandbox — sign up free at mailtrap.io)
mail.host=sandbox.smtp.mailtrap.io
mail.port=2525
mail.username=YOUR_MAILTRAP_USERNAME
mail.password=YOUR_MAILTRAP_PASSWORD

# Razorpay Test Mode (sign up at razorpay.com → Settings → API Keys)
razorpay.key.id=rzp_test_YOUR_KEY_ID
razorpay.key.secret=YOUR_KEY_SECRET
```

### Step 5 — Run
```bash
mvn clean package cargo:run
```

### Step 6 — Open
```
http://localhost:8080/nexmeet/
```

---

## Default Credentials

| Role | Email | Password |
|------|-------|----------|
| Super Admin | admin@nexmeet.com | admin123 |
| Organizer | manoj@gmail.com | admin123 |
| Organizer | indira@gmail.com | admin123 |
| Delegate | preetham@gmail.com | admin123 |
| Institutional Admin | hod@bmsce.ac.in | admin123 |

---

## Key Technical Decisions

**Java 8 + `HttpURLConnection` for Razorpay** — The official Razorpay Java SDK requires Java 15+. Rather than upgrading the JVM, the Razorpay API is called directly via `java.net.HttpURLConnection` with Base64-encoded Basic Auth. Identical behaviour, zero extra dependencies, pure Java 8.

**`registerDelegatePostPayment()` vs `registerForConference()`** — After Razorpay payment verification, calling `registerForConference()` would internally call `createRegistrationPayment()`, creating a second SIMULATED payment row and violating the `UNIQUE` constraint on `transaction_ref`. A dedicated post-payment method performs the identical flow (QR generation, ticket email, notifications, audit log) but skips payment creation since the RAZORPAY row already exists as COMPLETED.

**HMAC-SHA256 signature verification** — Razorpay sends `razorpay_order_id`, `razorpay_payment_id`, and `razorpay_signature` to the browser after payment. Before creating any registration, the server recomputes `HMAC-SHA256(order_id + "|" + payment_id, key_secret)` and compares it to the received signature. A mismatch means the payload was tampered with — the registration is never created.

**Two separate revenue streams** — `payments.platform_commission` tracks the per-delegate cut taken at registration time (shown as "Platform Revenue" on admin dashboard). `commission_invoices` tracks a separate flat-fee invoice raised against the organizer after conference completion. These are intentionally separate tables representing different money flows.

**Lazy loading + `enable_lazy_load_no_trans=true`** — All `@ManyToOne` associations use `FetchType.LAZY`. The Hibernate property allows JSP rendering to access lazy associations without a wrapping transaction, which is correct for a read-only view layer in traditional Spring MVC.

**`@Scheduled` background scheduler** — `ConferenceAutoCompletionScheduler` fires every hour via `cron = "0 0 * * * *"`. Without this, conferences only auto-complete when someone loads a dashboard. The scheduler ensures certificates are issued and emails sent at conference end time regardless of user activity.

**Secrets in `application.properties` (gitignored)** — DB credentials, Mailtrap SMTP details, and Razorpay keys are loaded via `<context:property-placeholder>` from a gitignored file. `PaymentServiceImpl` reads keys via Spring `Environment` with null/placeholder guards that fail fast with a clear error message rather than sending bad requests to Razorpay.

---

## Screenshots

> Run the app locally with the default credentials above to see the full UI.

<!-- TODO: Add screenshots of:
  - Home page with conference listing
  - Conference detail page with Razorpay payment card
  - Organizer dashboard with commission-due banner
  - Admin conference detail with invoice section
  - Delegate dashboard with QR modal
  - Ticket PDF and Certificate PDF
-->

---

## Project Status

| Feature | Status |
|---------|--------|
| 4-role authentication with Spring Security | ✅ Complete |
| Conference lifecycle (DRAFT → COMPLETED) | ✅ Complete |
| Hourly background scheduler (auto-completion) | ✅ Complete |
| QR code generation and attendance | ✅ Complete |
| PDF ticket and certificate generation | ✅ Complete |
| Email system with PDF attachments | ✅ Complete |
| Bulk delegate upload (CSV/Excel) | ✅ Complete |
| Commission settings and invoice system | ✅ Complete |
| Organizer payment reference submission | ✅ Complete |
| Razorpay Test Mode payment integration | ✅ Complete |
| HMAC-SHA256 signature verification | ✅ Complete |
| Organizer analytics with Chart.js | ✅ Complete |
| Audit logging (34+ action types) | ✅ Complete |
| Forgot password with time-limited token | ✅ Complete |
| Secrets management via gitignored properties | ✅ Complete |
| SLF4J structured logging throughout | ✅ Complete |
| Razorpay refund on cancellation | 🔄 Planned |
| Pagination on admin list pages | 🔄 Planned |
| Live deployment | 🔄 Planned |

---

## Author

**Preetham M R**
Java Trainee at X-workZ, Bengaluru
GitHub: [@PreethamMR-code](https://github.com/PreethamMR-code)
