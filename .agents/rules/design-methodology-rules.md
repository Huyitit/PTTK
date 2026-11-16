---
description: Software Analysis, Design & SQA Methodology Rules derived strictly from case-study/BG HP TTTN 2 CNPM 2020 final.pdf (Chapters 3, 4, 5, 6). Enforce across every phase when reviewing and updating the project document.
---

# Analysis, Design & SQA Methodology Rules (`BG HP TTTN 2 CNPM 2020`)

> **Source of Truth**: This rule file is derived strictly from the textbook `case-study/BG HP TTTN 2 CNPM 2020 final.pdf` (Chapters 3, 4, 5, and 6). Do **not** assume any existing content in the target document is correct until verified against these rules and `business-rules.md`.

---

## Core Cross-Phase Principle: Traceability & Continuity (Ch. 6)
1. **Strict Phase Chaining**: The output of step/phase $k$ is the direct, mandatory input to step/phase $k+1$.
   - No actor, use case, screen, entity class, attribute, or method may appear in phase $k+1$ without being justified and traced from phase $k$.
   - No element identified in phase $k$ may disappear in phase $k+1$ unless explicitly eliminated by a documented methodology step (such as eliminating non-entity nouns in Section 2.2 Step 3, or eliminating derived/statistical tables in Section 3.2 Step 5).
   - **Downstream Untrusted Principle (Chỉ tin cậy mục trước - Cấm dựa vào mục sau)**: When reviewing, analyzing, or designing section/phase $k$, the Agent **MUST ONLY** rely on authoritative external sources (`DESCRIPTION.md`, `BG HP TTTN 2 CNPM 2020 final.pdf`), project rules, and verified upstream sections ($1 \dots k-1$). Downstream sections ($k+1 \dots$) in the target document are unverified, untrusted drafts that may contain errors and will be revised in later phases; they must **NEVER** be cited or used as justification, evidence, or ground truth for decisions in section $k$.
   - **Retroactive Upstream Impact & Synchronization Rule (Đánh giá Tác động Ngược & Đồng bộ các Mục Phía Trước)**: Whenever a design decision, scoping constraint, attribute reduction, or entity refinement is established in phase/section $k$ (e.g., user instructs to eliminate certain attributes like `ngày sinh`, `địa chỉ`, `ca làm việc`, `ngày vào làm`), the Agent **MUST** evaluate whether this change impacts any previously verified upstream sections ($1 \dots k-1$). If an upstream section (such as Section 1.1 Semantic Glossary or Section 1.2.3 Business Workflows) contains conflicting or obsolete references to those eliminated/modified elements, the Agent **MUST** report the retroactive impact.
2. **Naming Conventions & Mandatory Instructor Suffix `3`**:
   - **Instructor Suffix `3` Rule (Mandatory)**: By instructor requirement for this student submission (`17D23DCCE043` — last digit `3`), Use Case names (e.g., `Login 3`, `Search Movie 3`), Class names (Entity, DAO/Control, etc., e.g., `User3`, `Customer3`, `Movie3`, `CustomerStats3`, `DAO3`, `MovieDAO3`), and Database Table names (e.g., `tblUser3`, `tblMovie3`, `tblInvoice3`) **MUST include the suffix `3`**. Do NOT flag the suffix `3` as an error; instead, enforce that the suffix `3` is applied consistently across text, tables, and diagrams where required.
   - **Class Names**: `PascalCase` singular English nouns + suffix `3` (e.g., `User3`, `Customer3`, `Movie3`, `Showtime3`, `Ticket3`, `Invoice3`, `CustomerStats3`).
   - **Attribute & Variable Names**: `camelCase` English nouns (e.g., `startDate`, `endDate`, `totalRevenue`).
   - **Method Names**: `camelCase` starting with a verb (e.g., `searchMovie()`, `getMovieDetail()`, `getCustomerStat()`, `getCustomerInvoices()`).
   - **Boundary / View Names**: Must follow a uniform convention across phases (e.g., `...Screen` / `...Frm` / `GD...` in Analysis $\to$ `...Screen.jsp` / `gd...jsp` in Design).
   - **Database Table Names**: `tbl` prefix + `PascalCase` entity name + suffix `3` (`tblUser3`, `tblMovie3`, `tblShowtime3`, `tblTicket3`, `tblInvoice3`, etc.).

---

## Phase 1: Requirements Gathering (`1. Thu thập yêu cầu` — Ch. 3.1, pp. 56–67)

### 1.1 Domain Understanding (`1.1 Tìm hiểu lĩnh vực chuyên môn`)
Must contain **3 explicit steps**:
1. **Bước 1 & Bước 2 — Brainstorm & Categorize Domain Keywords**:
   - Present a 3-column table grouping all domain concepts into:
     - Column 1: `Con người` (People / Actors)
     - Column 2: `Hoạt động của con người` (Human / Business Activities)
     - Column 3: `Vật, đối tượng` (Physical & Information Objects)
2. **Bước 3 — Semantic Glossary (`Bảng giải thích ngữ nghĩa`)**:
   - Present a 4-column table: `TT | Tên Tiếng Việt | Tiếng Anh | Giải thích`, divided into the 3 categories (`I. Con người`, `II. Hoạt động của con người`, `III. Vật, đối tượng`).
   - **Rule**: The `Tiếng Anh` column establishes the canonical vocabulary that must be used consistently in all subsequent UML diagrams.

### 1.2 Natural Language System Description (`1.2 Mô tả hệ thống bằng ngôn ngữ tự nhiên`)
Must contain **5 explicit steps**:
1. **Bước 1 — Mục đích hệ thống**: 1 concise paragraph summarizing why the system is built and its primary goals.
2. **Bước 2 — Phạm vi hệ thống**:
   - List all actors and their permitted functions, explicitly noting actor inheritance (e.g., `Management staff` and `Saler` inherit common functions from `Staff`/`User`; `Customer` inherits common functions from `User`).
   - **Mandatory Closing Statement**: *"Những chức năng không đề cập đến thì mặc định là không thuộc phạm vi của hệ thống."*
3. **Bước 3 — Hoạt động nghiệp vụ của các chức năng**:
   - Describe the step-by-step operational flow (`->` sequence) for each core function/module, specifying user inputs, search/filter criteria, displayed information, sorting order, and drill-down interactions.
4. **Bước 4 — Thông tin các đối tượng cần xử lý, quản lý**:
   - Group domain objects logically (People, Physical/Facility objects, Transaction/Schedule objects, Statistical objects) and list the natural-language attributes of each object.
5. **Bước 5 — Quan hệ giữa các đối tượng, thông tin**:
   - State the multiplicity/cardinality between pairs of domain objects in natural language (`Một A có nhiều B; một B thuộc về một A...`).

### 1.3 UML Use Case Modeling (`1.3 Mô tả hệ thống bằng ngôn ngữ UML (use case)`)
- **1.3.1 General Use Case Diagram (`Sơ đồ use case tổng quát`)**:
  - **Bước 1**: Identify Actors and their generalization hierarchy (`Saler` & `Manager` $\to$ `Staff` $\to$ `User`; `Customer` $\to$ `User`).
  - **Bước 2**: Propose initial Use Cases directly from Section 1.2 Step 2.
  - **Bước 3**: Refine/group Use Cases (e.g., grouping sub-functions under management or statistical reporting UCs using `<<include>>` or `<<extend>>`).
  - **Bước 4**: Describe each Use Case and draw the General Use Case Diagram inside a system boundary box.
  - **Visual Paradigm Interoperability (XMI Export)**: For every Use Case diagram (`image1`, `image2`, `image3`), generate an OMG UML 2.x XMI file at `project-diagram/vp-import/xmi/imageN.xmi` so the user can import model elements directly into Visual Paradigm via **Project $\to$ Export / Import $\to$ UML 2.x XMI...**.
- **1.3.2 & 1.3.3 Detailed Module Use Case Diagrams (`Sơ đồ use case chi tiết cho từng mô-đun`)**:
  - **Screen-to-Sub-UC Rule**: Decompose the module Use Case into sub-Use Cases where **each UI screen that interacts with the actor corresponds to one sub-Use Case**.
  - **Stereotype & Arrow Direction Rules**:
    - `<<include>>`: Mandatory sub-step or a step that always requires a preceding step. Dashed arrow points from **Base UC $\to$ Included UC**.
    - `<<extend>>`: Optional / conditional follow-up step (e.g., clicking a movie from the search result list to view movie details, or clicking a customer from the statistics table to view their transactions). Dashed arrow points from **Extending UC $\to$ Base UC**.
  - **SQA Check**: Every Use Case name must be an active verb phrase. Every Use Case must have a valid path from at least one Actor.

---

## Phase 2: Requirements Analysis (`2. Phân tích yêu cầu` — Ch. 3.2, pp. 68–91)

### 2.1 Use Case Scenarios v1.0 (`2.1 Viết kịch bản`)
For each of the two target modules (`2.1.1` and `2.1.2`), construct a scenario specification table with:
- `Use case`: Name of the module Use Case.
- `Actor`: Primary actor.
- `Tiền điều kiện (Pre-condition)`: Required authentication/role state.
- `Hậu điều kiện (Post-condition)`: Expected system state after completion.
- `Kịch bản chính (Main flow)`: Numbered steps (`1, 2, 3, ...`) alternating between Actor action and System response.
  - **Mock UI Table Rule**: Whenever the system displays a screen with a form or result table, include a mock table layout inside the step showing exact input fields, buttons, table column headers, and sample rows.
- `Ngoại lệ (Exceptions)`: Numbered according to the main flow step where the exception branches (e.g., step `4.1` when no movies match the keyword; step `6.1` when no customer revenue exists in `[startDate, endDate]`).

### 2.2 Analysis Entity Class Extraction (`2.2 Trích lớp thực thể`)
Must follow **5 explicit steps**:
1. **Bước 1**: Write a single comprehensive paragraph summarizing the entire system's actors, objects, and workflows.
2. **Bước 2**: Extract all candidate nouns from Step 1, grouped into: (a) People (`Con người`), (b) Physical Objects (`Vật`), and (c) Information/Conceptual Objects (`Đối tượng thông tin`).
3. **Bước 3**: Evaluate each candidate noun and classify it into one of three outcomes:
   - **Entity Class (`Lớp thực thể`)**: Has attributes and domain identity.
   - **Attribute (`Thuộc tính của lớp`)**: Single property belonging to an Entity Class.
   - **Eliminated (`Loại bỏ`)**: Out of scope, duplicate synonym, or meta-term (`hệ thống`, `menu`).
   - **Statistical Entity Rule**: Statistical concepts (`CustomerStat`/`CustomerStats`, `MovieStat`/`MovieStats`, `RevenueStats`) are modeled as **Entity Classes**:
     - `CustomerStats` inherits from `Customer`; `MovieStats` inherits from `Movie`. Both hold statistical attributes (`startDate`, `endDate`, `totalTickets`, `totalRevenue`).
     - `RevenueStats` is an independent summary entity class aggregating data across multiple `Invoice` instances ($n-1$), holding attributes (`startDate`, `endDate`, `totalRevenue`, `totalTickets`, `totalInvoices`). It does **not** inherit from `Invoice`.
4. **Bước 4**: Identify relationships and multiplicities (`1-1`, `1-n`, `n-n`) between entity classes.
   - **Mandatory `n-n` Elimination Rule**: Every `n-n` relationship MUST be resolved into two `1-n` relationships by introducing an intermediate associative entity class (e.g., `Showtime` between `Movie` and `ScreeningRoom`; `Ticket` between `Showtime` and `Seat`). No `n-n` relationship may remain.
5. **Bước 5**: Determine Object-Oriented relationship types:
   - **Generalization / Inheritance (`Kế thừa`)**: Hollow triangle arrow pointing to parent class.
   - **Composition (`Quan hệ hợp thành` — filled diamond $\blacklozenge$)**: Strong whole-part lifecycle dependency.
   - **Aggregation (`Quan hệ tụ hợp` — hollow diamond $\lozenge$)** or **Association (`Quan hệ kết hợp`)**.
   - **Analysis Diagram Notation Rule (Hình 3.5 giáo trình)**:
     - Association lines are undirected solid lines **without arrows** (`--`).
     - Intermediate classes (e.g., `Showtime`, `Ticket`, `MovieGenre`, `MovieActor`) are represented as **Association Classes** attached via a dashed line (`..`) to the solid association line between the two base entities. They are **not** decomposed into separate $1-n$ relationships in Phase 2 (decomposition happens in Phase 3 Design).
   - Draw the **General Analysis Entity Class Diagram** (attributes are listed by name in `camelCase`; no `id` keys or programming data types are added yet in Section 2.2).

### 2.3 Boundary & Control/Entity Method Extraction (`2.3 Trích các lớp biên và điều khiển`)
For each target module (`2.3.1` and `2.3.2`), follow **4 explicit steps**:
1. **Bước 1 — Identify Boundary Classes (`Lớp biên`)**:
   - Each UI screen interacting with the actor in the module becomes one Boundary class (matching the sub-UCs from Section 1.3.2 / 1.3.3 and screens in Scenario v1.0).
2. **Bước 2 — Identify Boundary Attributes (`Thuộc tính lớp biên`)**:
   - List UI controls on each Boundary class using the textbook's mandatory prefix convention:
     - `in...`: Input field (e.g., `inKeyword`, `inStartDate`, `inEndDate`).
     - `out...`: Output/display component or table (e.g., `outMovieList`, `outMovieDetail`, `outCustomerStatList`, `outTransactionList`).
     - `sub...`: Submit button, menu link, or row selection trigger (e.g., `subSearchMovie`, `subSelectMovie`, `subViewStat`, `subSelectCustomer`, `subBack`).
     - Combined prefixes (`inout...`, `outsub...`) when an element serves both roles.
3. **Bước 3 — Identify Data Processing Methods & Assign to Entity Classes**:
   - For each data processing action in the module, define `Method Name`, `Input`, and `Output`.
   - **Textbook Method Assignment Priority Rule (Ch. 3.2.3, p. 84)**:
     - In the Analysis phase (Boundary + Entity pattern), assign each method to an Entity class as follows:
       1. **Check Output first**: If the method's output is an instance or list of an entity class $E$, assign the method to class $E$ (e.g., `searchMovie()` and `getMovieDetail()` return `Movie` $\to$ assign to `Movie`; `getCustomerStat()` returns `CustomerStat` $\to$ assign to `CustomerStat`; `getTransactionsByCustomer()` returns `Invoice`/`Transaction` $\to$ assign to `Invoice`).
       2. **Check Input second** (if output does not map to an entity): If input relates to a single entity class, assign to it; if input relates to multiple entity classes, assign to the smallest container/associative entity class that links the most input entities.
4. **Bước 4 — Module Analysis Class Diagram**:
   - Draw the diagram containing the Actor, all Boundary classes of the module, and all participating Entity classes (including supporting entities traversed during query calculation).
   - **Consistency Rule**: All relationships and multiplicities among Entity classes in Section 2.3 must be 100% identical to Section 2.2.

### 2.4 Activity / Behavioral Analysis (`2.4 Phân tích hoạt động`)
For each target module (`2.4.1` and `2.4.2`), provide **3 synchronized artifacts**:
1. **State Diagram (`Biểu đồ trạng thái`)**:
   - Each state represents displaying one UI screen waiting for user action (`Hien thi GD ...`).
   - Each transition arrow is labeled with the user trigger (`[chon ...]`, `[nhap ... va bam ...]`).
2. **Scenario v2.0 (`Kịch bản v.2`)**:
   - Refine Scenario v1.0 into numbered object-interaction steps (`1, 2, 3, ...`) explicitly naming the Actor, Boundary objects, and Entity objects from Section 2.3 (including internal entity-to-entity data retrieval steps when aggregating statistics).
3. **Communication Diagram (`Biểu đồ giao tiếp`)**:
   - Show the Actor, Boundary objects, and Entity objects linked exactly as in Section 2.3 Step 4.
   - Place numbered messages (`1:`, `2:`, `3:`, ...) along the object links in **strict 1-to-1 correspondence** with Scenario v2.0.

---

## Phase 3: System Design (`3. Thiết kế` — Ch. 4, pp. 92–114)

### 3.1 Design Entity Class Diagram (`3.1 Thiết kế lớp thực thể`)
Transform the General Analysis Entity Class Diagram (Section 2.2) through **4 explicit steps**:
1. **Bước 1 — Add `id` Attributes**:
   - Add `- id: int` to every base/root entity class. Subclasses (`Staff`, `Customer`, `Manager`, `Saler`, `CustomerStat`, `MovieStat`) inherit `id` from their superclass and must **not** declare a duplicate `id`.
2. **Bước 2 — Add Programming Data Types & Visibility**:
   - Specify private visibility (`-`) and explicit programming language types (e.g., `int`, `String`, `Date`, `float`) for every attribute.
3. **Bước 3 — Refine Associations into Aggregation/Composition**:
   - Ensure all non-inheritance relationships are converted strictly into Aggregation ($\lozenge$, `o--`) or Composition ($\blacklozenge$, `*--`). Never use plain associations (`--`) or direct arrows (`-->`).
   - Intermediate associative classes (`Showtime3`, `Ticket3`, `MovieGenre3`, `MovieActor3`) use Aggregation to connect to their related entities.
   - Composition relationships (`Customer3 *-- MembershipCard3`, `Cinema3 *-- ScreeningRoom3`, `ScreeningRoom3 *-- Seat3`) are unidirectional from the container to the components.
4. **Bước 4 — Declare Object / Array Reference Attributes**:
   - For every Composition/Aggregation relationship where container class `A` holds part class `B`:
     - Multiplicity `1`: declare `- b: B` inside the referencing class.
     - Multiplicity `n` (`*`): declare array attribute `- b: B[]` using bracket syntax (e.g. `- rooms: ScreeningRoom3[]`, `- tickets: Ticket3[]`), not `List<B>`.
     - In unidirectional Composition, child classes (`ScreeningRoom3`, `Seat3`) do not declare back-reference attributes to their parent container.
     - Statistical subclasses (`CustomerStats3`, `MovieStats3`) only inherit attributes from their base entity and do not declare direct aggregation collections.
   - Draw the complete **General Design Entity Class Diagram**.

### 3.2 Database Design (`3.2 Thiết kế cơ sở dữ liệu`)
Transform the Design Entity Class Diagram (Section 3.1) into a Relational Database Schema through **5 explicit steps**:
1. **Bước 1 — Propose Candidate Tables**: Propose one table `tbl<EntityName>` per entity class.
2. **Bước 2 — Map Scalar Attributes to Columns**: Convert primitive attributes into SQL columns (`int(10)`, `varchar(255)`, `date`, `float(10)`, etc.). Omit all object/array reference attributes added in Section 3.1 Step 4.
3. **Bước 3 — Map Multiplicities**: Verify all relationships are `1-1` (e.g., inheritance or `Customer`–`MembershipCard`) or `1-n` (zero `n-n` relationships allowed).
4. **Bước 4 — Add Primary Keys (PK) & Foreign Keys (FK)**:
   - Add `id int(10) PRIMARY KEY` to each table (or shared PK/FK `tblUserId` for `1-1` inheritance sub-tables).
   - For every `1-n` relationship (`tblA` $1 \text{ --- } n$ `tblB`), add foreign key column `tblAId int(10)` to the `n`-side table (`tblB`).
5. **Bước 5 — Eliminate Redundant & Derived Data (`Loại bỏ dữ liệu dư thừa và thuộc tính dẫn xuất`)**:
   - **Remove Derived Columns**: Remove attributes that can be dynamically computed from child records (e.g., calculated invoice totals if derived from tickets/discounts, or clearly document any persisted historical snapshot).
   - **Remove All Statistical Tables**: Completely eliminate `tblCustomerStat`, `tblMovieStat`, and `tblRevenueStat` from the database schema because all their fields are derived at query time from `tblCustomer`, `tblInvoice`, `tblTicket`, `tblShowtime`, and `tblMovie`.
   - Draw the **Relational Database Schema Diagram** and provide detailed table/column description tables.

### 3.3 Module Detailed Design (`3.3 Thiết kế chi tiết các mô-đun`)

#### 3.3.1 Static Design (`3.3.1 Thiết kế tĩnh` — per module)
For each target module, follow **4 explicit steps**:
1. **Bước 1 — UI Wireframe Flow (`Thiết kế giao diện`)**:
   - Draw the sequence of UI screen wireframes connected by directional arrows from the clicked button/row to the target screen, including `Quay lại` / `Trở về` navigation buttons.
2. **Bước 2 — View Classes (`Lớp biên / Giao diện` — e.g., JSP)**:
   - Transform each Boundary class from Section 2.3 into platform-specific View classes (e.g., `gd...jsp` / `do...jsp`), specifying their typed variables and form/session parameters.
3. **Bước 3 — Control / DAO Classes (`Lớp điều khiển / DAO`)**:
   - Define base class `DAO` (`+ con: Connection`, `+ DAO()`).
   - Define module DAO classes inheriting from `DAO` (`MovieDAO`, `CustomerStatDAO`, `InvoiceDAO` / `TransactionDAO`).
   - Move the data-processing methods assigned to Entity classes in Section 2.3 Step 3 into the corresponding `...DAO` classes with full typed signatures.
4. **Bước 4 — Entity Classes & Module Design Class Diagram**:
   - **User Canonical Standard for Module Static Design Diagrams (`image13`, `image14`)**:
     - *View Tier (JSP)*: Declare View classes (`CustomerScreen.jsp`, `SearchMovieScreen.jsp`, `MovieDetailScreen.jsp` for Module 1; `ManagerScreen.jsp`, `ReportScreen.jsp`, `CustomerTransactionScreen.jsp` for Module 2) with control attributes (`keyword`, `search`, `listMovies`, `moviesTable`, `selectMovie`, `back`, etc.) and entity references. Do NOT declare constructors for View classes.
     - *Navigation & Associations*: Connections between JSP pages (`ScreenA -- ScreenB`) and between JSP and DAO (`Screen -- ...DAO3`) use simple solid association lines (`--`).
     - *DAO Tier*: Base class `DAO3` (`+ con: Connection`, `+ DAO3()`), module DAO inherits `DAO3` (`DAO3 <|-- ...DAO3`), and connects to the module's primary entity via solid association line (`MovieDAO3 -- Movie3`, `CustomerStatDAO3 -- CustomerStats3`, `InvoiceDAO3 -- Invoice3`).
     - *Entity Tier (Model)*: **MANDATORY**: Embed the **ENTIRE system Design Entity Class model from Section 3.1 (`image11`) directly beneath the DAO**, fully preserving all 20 entity classes, attributes, visibility (`-`), and OOP relationships (Generalization `<|--`, Composition `*--`, Aggregation `o--`), rather than drawing an isolated or trimmed subset of entities.

#### 3.3.2 Dynamic Design (`3.3.2 Thiết kế hoạt động` — per module)
For each target module, follow **2 explicit steps**:
1. **Bước 1 — Activity Diagram (`Biểu đồ hoạt động`)**:
   - Draw an Activity Diagram partitioned into **swimlanes** (one swimlane per `.jsp` view page plus one swimlane for `DAO` methods), showing control and data flow from start to end.
2. **Bước 2 — Scenario v3.0 & Sequence Diagram (`Biểu đồ tuần tự`)**:
   - Write **Scenario v3.0** detailing the exact numbered sequence of calls across `Actor`, `JSP Views`, `DAO` instances, and `Entity` objects (`new Entity()`, getters/setters).
   - Draw the **Sequence Diagram** matching Scenario v3.0 step-for-step (`1:`, `2:`, ...), with lifelines ordered `Actor` $\to$ `Views` $\to$ `DAOs` $\to$ `Entities`, proper activation bars, exact method signatures from Section 3.3.1, and dashed return arrows.

#### 3.3.3 Package & Deployment Design (`3.3.3 Thiết kế triển khai`)
1. **Package Diagram (`Biểu đồ gói`)**:
   - Group classes into architecture packages: `view` (sub-packages per actor: `user`, `customer`, `saler`, `manager`), `dao`, and `model`, connected by dependency arrows (`view` $\to$ `dao` $\to$ `model` and `view` $\to$ `model`).
2. **Deployment Diagram (`Biểu đồ triển khai`)**:
   - Model the physical runtime architecture: `Client Node` (Web Browser) $\leftrightarrow$ `Web/Application Server Node` (Tomcat / JSP + DAO + Model container) $\leftrightarrow$ `Database Server Node` (MySQL DBMS).
