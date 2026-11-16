---
description: Authoritative Domain & Business Rules for the Cinema Management System (focusing on Subject No. 17) derived strictly from Topic-description/DESCRIPTION.md and the modeling conventions of case-study/BG HP TTTN 2 CNPM 2020 final.pdf.
---

# Business Rules: Cinema Management System (Topic: CINEMA — Subject No. 17)

> **Source of Truth**: This rule file is derived strictly from `Topic-description/DESCRIPTION.md` and the domain modeling principles in `case-study/BG HP TTTN 2 CNPM 2020 final.pdf`. Do **not** treat the existing draft in `final-document/` as a source of truth; use these rules to audit, correct, and complete the target document.

---

## 1. System Overview & Actors (`Topic-description/DESCRIPTION.md`)

A **Cinema Management System** serves three primary business roles, plus a generalized base user role per the case-study methodology:

### 1.1 Business Roles & Permitted Functions
1. **Management Staff / Manager (`Nhân viên quản lý`)**:
   - View statistical reports (`Xem báo cáo thống kê`) across three dimensions:
     - Movie statistics (`Thống kê phim`)
     - Customer statistics (`Thống kê khách hàng`)
     - Revenue statistics (`Thống kê doanh thu`)
   - Schedule showtimes (`Lên lịch chiếu`).
   - Manage movie information (`Quản lý thông tin phim`: add, edit, delete).
   - Manage theater / screening room information (`Quản lý thông tin rạp / phòng chiếu`: add, edit, delete).
2. **Saler (`Nhân viên bán vé`)**:
   - Sell tickets at the counter to customers (`Bán vé tại quầy cho khách hàng`).
   - Issue membership / loyalty cards to customers (`Cấp / làm thẻ thành viên cho khách hàng`).
3. **Customer (`Khách hàng`)**:
   - Register for membership (`Đăng ký thành viên`).
   - Search movie information (`Tìm kiếm thông tin phim`).
   - Buy tickets online (`Mua vé trực tuyến`).
   - Buy tickets at the counter (`Mua vé tại quầy` — assisted by Saler).
4. **Common System User (`Người dùng` / `Thành viên` — per Case-Study Ch. 3.1)**:
   - Common authentication/account functions shared by actors interacting with the software (e.g., Login `Đăng nhập`, Logout `Đăng xuất`).
   - Actor generalization hierarchy:
     - `Management staff` and `Saler` generalize to `Staff` (`Nhân viên`) or directly inherit common authentication behavior from `User` (`Người dùng` / `Thành viên`).
     - `Customer` inherits common authentication behavior from `User` (for registered online customers) while also supporting walk-in counter interactions.

### 1.2 Closed-World Scope Rule
Per `case-study/BG HP TTTN 2 CNPM 2020 final.pdf` (Section 3.1.2, Step 2):
- Only the functions explicitly stated above belong to the system scope.
- Every system scope description must conclude with the explicit boundary statement: *"Những chức năng không đề cập đến thì mặc định là không thuộc phạm vi của hệ thống."*

---

## 2. System-Wide Business Workflows (Derived from `DESCRIPTION.md` Subjects 13–17)

Although **Subject No. 17** requires detailed analysis and design for **two specific modules** (Section 3 below), the **Phase 1 Natural Language Description (1.1, 1.2)**, **General Use Case Diagram (1.3.1)**, **Phase 2 General Analysis Entity Class Diagram (2.2)**, **Phase 3 General Design Entity Class Diagram (3.1)**, and **Database Design (3.2)** must model the **entire Cinema Management System** consistently across all workflows described in `DESCRIPTION.md`:

1. **Manage Movie Information (Subject 13)**:
   - Management staff selects the movie information management menu $\to$ selects add/edit/delete movie information $\to$ enters movie details and confirms $\to$ system saves to the database.
2. **Manage Theater / Screening Room Information (General Topic)**:
   - Management staff selects theater/room management $\to$ adds, edits, or deletes theater/screening room and seat configuration $\to$ system saves to the database.
3. **Schedule Showtimes (Subject 15)**:
   - Manager selects showtime management menu $\to$ selects add showtime $\to$ selects time slot (`khung giờ`) and showtime date (`ngày chiếu`) $\to$ searches and selects an available screening room (`phòng chiếu trống`) at that time slot $\to$ selects a movie from the showing list (or adds a new movie if not yet present) $\to$ confirms $\to$ system saves the showtime schedule.
4. **Customer Registers as a Member (Subjects 14 & 16)**:
   - Customer chooses to register as a member $\to$ enters personal information and clicks register $\to$ system saves member information to the database.
5. **Saler Issues Membership Card (General Topic)**:
   - Saler verifies customer registration/personal info at the counter and issues a membership/loyalty card (`thẻ thành viên`) to the customer.
6. **Customer Purchases Online Ticket (Subject 13)**:
   - Customer selects ticket purchase menu $\to$ selects a movie from the list $\to$ selects a viewing time (showtime) $\to$ selects a seat $\to$ enters loyalty/membership card code (if any) and confirms ticket purchase $\to$ pays online $\to$ system generates/prints tickets and invoice (bill/transaction).
7. **Saler Sells Ticket at the Counter (Subject 14)**:
   - Saler selects ticketing menu $\to$ asks for movie name and searches for the movie $\to$ selects movie from results $\to$ selects viewing time (showtime) $\to$ selects seat $\to$ enters customer's loyalty/membership card code (if any) and confirms ticket purchase $\to$ processes payment $\to$ prints tickets and invoice.
8. **Management Staff Views Movie Statistics (Subject 16)**:
   - Management staff selects statistical reports menu $\to$ selects movie statistics by revenue $\to$ selects start date and end date $\to$ views movie statistics list $\to$ clicks on a movie to view details $\to$ views statistics of showtimes for that movie $\to$ clicks on a showtime $\to$ views ticket sales statistics for that showtime.
9. **Customer Searches for Movie Information (Subjects 15 & 17 — Target Module 1)**:
   - Detailed in Section 3.1 below.
10. **Management Staff Views Customer Statistics (Subject 17 — Target Module 2)**:
    - Detailed in Section 3.2 below.

---

## 3. Target Modules for Subject No. 17 (Detailed Specification)

Subject No. 17 requires complete end-to-end modeling (Detailed Use Cases, Scenarios v1/v2/v3, Boundary/Control/Entity Extraction, State Diagrams, Communication Diagrams, UI Wireframes, Static MVC/DAO Class Diagrams, Activity Diagrams, Sequence Diagrams) for the following **two modules**:

### 3.1 Module 1: Customer Searches for Movie Information (`Khách hàng tìm kiếm thông tin phim`)
- **Exact Specification from `DESCRIPTION.md`**:
  > *"Customer searches for movie information: selects the menu to find movie information → enters the movie name to find it → the system displays a list of movies whose name contain the entered keywords → clicks on a movie to view details → the system displays information movie details."*
- **Required Business Rules & UI Flow**:
  1. **Entry Point**: Customer accesses the main/home interface and selects the menu option to search for movie information.
  2. **Search Input**: System presents a search interface where the customer enters a movie name keyword (`từ khóa tên phim`) and triggers the search.
  3. **Search Matching & Result List**:
     - System queries movies whose title/name contains the entered keyword (partial/substring match).
     - System displays a summary table of matching movies (key summary fields such as Movie ID/STT, Movie Name, Genre, Duration, Director/Release Date).
     - *Exception Path*: If no movie name contains the keyword, the system informs the customer that no matching movies were found.
  4. **Drill-Down to Movie Details**:
     - Customer clicks on a specific movie item/row from the search result list (optional extension step `<<extend>>` in Use Case modeling, since the customer may stop after viewing the list or only click when results exist).
     - System displays the full detail screen for that selected movie (all movie attributes).

### 3.2 Module 2: Management Staff Views Customer Statistics (`Nhân viên quản lý xem thống kê khách hàng`)
- **Exact Specification from `DESCRIPTION.md`**:
  > *"Management staff views customer statistics: selects the menu to view statistical reports → selects view customer statistics by revenue → selects start date, end date → Views customer statistics → clicks on a customer to view details → views statistics of transactions of the selected customer."*
- **Required Business Rules & UI Flow**:
  1. **Entry Point**: Logged-in Management Staff selects the menu to view statistical reports (`Xem báo cáo thống kê`).
  2. **Report Type Selection**: Management Staff selects the option to view **Customer Statistics by Revenue** (`Thống kê khách hàng theo doanh thu`).
  3. **Date Range Input**:
     - System displays the customer statistics filter interface requiring a **Start Date** (`ngày bắt đầu`) and **End Date** (`ngày kết thúc`).
     - Management Staff selects/enters `startDate` and `endDate` and submits.
     - *Business Validation*: `startDate <= endDate`.
  4. **Customer Statistics Display**:
     - System calculates and displays the list of customers along with their aggregated revenue (and ticket/transaction metrics) generated within `[startDate, endDate]` (typically ordered by revenue descending).
     - *Exception Path*: If no customer transactions occurred within `[startDate, endDate]`, the system displays an empty result message.
  5. **Drill-Down to Customer Transactions**:
     - Management Staff clicks on a specific customer row in the statistics table (optional extension step `<<extend>>` in Use Case modeling).
     - System displays the **statistics of transactions (invoices/bills)** belonging to that selected customer within the selected `[startDate, endDate]` period (showing transaction/invoice details such as Invoice/Transaction ID, transaction date/time, tickets/quantity, discount/loyalty card usage if any, and total amount paid).

---

## 4. Core Domain Entities & Relationship Rules

Derived strictly from the workflows in `Topic-description/DESCRIPTION.md` and the entity extraction rules in `case-study/BG HP TTTN 2 CNPM 2020 final.pdf`:

### 4.1 Required Domain Entities
1. **Actors / People Entities**:
   - Base `User` / `Member` (`Thành viên` / `Người dùng`) — holds common personal & login info (`username`, `password`, `fullName`, `email`, `phone`, `address`, `dob`, `role`).
   - `Staff` (`Nhân viên`) $\to$ `Manager` / `ManagementStaff` (`Nhân viên quản lý`) and `Saler` (`Nhân viên bán vé`).
   - `Customer` (`Khách hàng`) — holds customer/member info.
   - `MembershipCard` / `LoyaltyCard` (`Thẻ thành viên`) — issued by Saler / associated with Customer to apply discounts/points when buying tickets.
2. **Cinema & Scheduling Entities**:
   - `Cinema` / `Theater` (`Rạp chiếu phim`) — contains multiple screening rooms.
   - `ScreeningRoom` (`Phòng chiếu`) — belongs to a cinema; contains multiple seats (`Seat`).
   - `Seat` (`Ghế ngồi`) — belongs to a screening room (`ScreeningRoom`).
   - `Movie` (`Phim`) — movie catalog entry managed by Manager and searched by Customer/Saler.
   - `TimeSlot` (`Khung giờ` — either an entity or time attributes on `Showtime` per Subject 15).
   - `Showtime` / `Schedule` (`Lịch chiếu` / `Suất chiếu`) — resolves the many-to-many relationship between `Movie`, `ScreeningRoom`, and date/time slot.
3. **Ticketing & Transaction Entities**:
   - `Ticket` (`Vé`) — links a specific `Showtime` and a specific `Seat` (resolving the many-to-many between `Showtime` and `Seat`), with ticket price.
   - `Invoice` / `Bill` / `Transaction` (`Hóa đơn` / `Giao dịch`) — represents a customer's ticket purchase transaction (online or at counter via `Saler`), grouping one or more `Ticket`s, recording transaction date/time, optional `MembershipCard`/discount, and total payment amount.
4. **Statistical Entities (Analysis & Object Design Only)**:
   - Per `case-study/BG HP TTTN 2 CNPM 2020 final.pdf` (Section 3.2.2 Step 3 & Section 4.2 Step 5):
     - `CustomerStat` / `CustomerStats` (`Thống kê khách hàng`): **Inherits from `Customer`**, adding statistical attributes (`startDate`, `endDate`, `totalTransactions`/`totalTickets`, `totalRevenue`).
     - `MovieStat` / `MovieStats` (`Thống kê phim`): **Inherits from `Movie`**, adding statistical attributes (`startDate`, `endDate`, `totalTickets`, `totalRevenue`).
     - `ShowtimeStat` / `RevenueStat` (`Thống kê suất chiếu / doanh thu`): Holds statistical attributes for showtime/revenue reporting.
     - **CRITICAL RULE**: Statistical classes (`CustomerStat`, `MovieStat`, `RevenueStat`) are used in the **Analysis Class Diagram (2.2, 2.3)** and **Design Class Diagram (3.1, 3.3)** to encapsulate aggregated report rows, but **MUST BE ELIMINATED in Database Design (3.2 Step 5)** because their attributes are derived (`thuộc tính dẫn xuất`) from `Invoice`/`Ticket`/`Showtime` tables.

### 4.2 Verified Relational Database Schema (`tbl...3` Tables — Locked Contract for Phase 3.3 DAOs)
1. `tblUser3(id PK, username UNIQUE, password, fullName, email, phone)`
2. `tblStaff3(tblUserId PK/FK -> tblUser3, role)`
3. `tblManager3(tblStaffId PK/FK -> tblStaff3)`
4. `tblSaler3(tblStaffId PK/FK -> tblStaff3)`
5. `tblCustomer3(tblUserId PK/FK -> tblUser3, code UNIQUE)`
6. `tblMembershipCard3(id PK, issueDate, points, tblCustomer3UserId FK UNIQUE -> tblCustomer3)`
7. `tblCinema3(id PK, name, address, phone)`
8. `tblScreeningRoom3(id PK, name, capacity, type, tblCinema3Id FK -> tblCinema3)`
9. `tblSeat3(id PK, row, number, type, tblScreeningRoom3Id FK -> tblScreeningRoom3)`
10. `tblMovie3(id PK, title, director, duration, releaseDate, ageRestriction, description)`
11. `tblGenre3(id PK, name)`
12. `tblActor3(id PK, name)`
13. `tblMovieGenre3(id PK, rate, tblMovie3Id FK -> tblMovie3, tblGenre3Id FK -> tblGenre3)`
14. `tblMovieActor3(id PK, characterName, tblMovie3Id FK -> tblMovie3, tblActor3Id FK -> tblActor3)`
15. `tblShowtime3(id PK, showDate, startTime, endTime, format, basePrice, tblMovie3Id FK -> tblMovie3, tblScreeningRoom3Id FK -> tblScreeningRoom3)`
16. `tblInvoice3(id PK, createdDate, totalAmount, paymentMethod, tblCustomer3UserId FK -> tblCustomer3, tblSaler3StaffId FK -> tblSaler3)`
17. `tblTicket3(id PK, price, issueTime, status, type, tblShowtime3Id FK -> tblShowtime3, tblSeat3Id FK -> tblSeat3, tblInvoice3Id FK -> tblInvoice3)`
- **Eliminated Statistical Tables**: `tblCustomerStats3`, `tblMovieStats3`, `tblRevenueStats3` are permanently eliminated from physical RDBMS storage per methodology.
