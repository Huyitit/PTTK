---
name: implementation-workflow
description: >-
  Use this skill to guide the end-to-end coding workflow for the Cinema Management System (Subject No. 17) in the Implementation Phase (Chapter 5 case study). Covers Eclipse Dynamic Web project directory scaffolding, MySQL schema/stored procedures, Model POJO generation, DAO implementation, and JSP views matching final-document/UI/ mockups.
---

# System Implementation Workflow (`implementation-workflow`)

Kỹ năng này điều phối toàn bộ quy trình lập trình mã nguồn cho Hệ thống quản lý rạp chiếu phim (Cinema Management System - Subject No. 17), tuân thủ nghiêm ngặt phương pháp luận tại Chương 5 giáo trình `case-study/BG HP TTTN 2 CNPM 2020 final.pdf`, các quy tắc tại `.agents/rules/implementation-methodology-rules.md`, mô hình thiết kế tại Mục 3 của `final-document/17D23DCCE043.md`, và bản vẽ UI thực tế tại `final-document/UI/`.

---

## Tổng quan quy trình 5 bước cài đặt

```
[Bước 1: Khởi tạo cấu trúc dự án Eclipse Web]
                     ↓
[Bước 2: Cài đặt CSDL & Stored Procedures (MySQL 8.0)]
                     ↓
[Bước 3: Lập trình 20 lớp thực thể Model (POJOs)]
                     ↓
[Bước 4: Lập trình tầng truy cập dữ liệu DAO]
                     ↓
[Bước 5: Lập trình các trang giao diện JSP (Khớp 100% UI)]
```

---

## Bước 1: Khởi tạo cấu trúc dự án Eclipse Dynamic Web

1. **Khởi tạo thư mục dự án `cinema-management-system/`**:
   - Tạo toàn bộ cây thư mục bám sát Hình 5.1 giáo trình:
     - `src/model/`
     - `src/dao/`
     - `WebContent/WEB-INF/lib/`
     - `WebContent/view/customer/`
     - `WebContent/view/manager/`
     - `test/dao/`
     - `sql/`
2. **Cấu hình `web.xml` (`WebContent/WEB-INF/web.xml`)**:
   - Thiết lập chuẩn Web App 3.1/4.0:
     ```xml
     <?xml version="1.0" encoding="UTF-8"?>
     <web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
              xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
              xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee
                                  http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
              version="4.0">
       <display-name>cinema-management-system</display-name>
       <welcome-file-list>
         <welcome-file>index.jsp</welcome-file>
       </welcome-file-list>
     </web-app>
     ```
3. **Thư viện phụ thuộc (`WebContent/WEB-INF/lib/`)**:
   - Đảm bảo có sẵn các file thư viện `.jar` chuẩn:
     - `mysql-connector-j-8.x.jar` (hoặc JDBC driver tương đương).
     - `junit-4.13.2.jar` và `hamcrest-core-1.3.jar` phục vụ kiểm thử.
     - `javax.servlet-api-4.0.1.jar` phục vụ biên dịch JSP/Servlet.

---

## Bước 2: Cài đặt CSDL & Stored Procedures (MySQL 8.0)

1. **Sinh script tạo bảng `sql/schema.sql`**:
   - Tạo cơ sở dữ liệu: `CREATE DATABASE IF NOT EXISTS cinema_db3 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; USE cinema_db3;`
   - Dựa vào Mục 3.2 để sinh đầy đủ 18 bảng quan hệ với khóa chính `id` và các khóa ngoại `tbl...Id`:
     - `tblUser3`, `tblStaff3`, `tblManager3`, `tblSaler3`, `tblCustomer3`, `tblMembershipCard3`.
     - `tblCinema3`, `tblScreeningRoom3`, `tblSeat3`.
     - `tblMovie3`, `tblGenre3`, `tblActor3`, `tblMovieGenre3`, `tblMovieActor3`.
     - `tblShowtime3`, `tblTicket3`, `tblInvoice3`, `tblRevenueStats3`.
   - Lưu ý: Không tạo bảng CSDL cho `tblCustomerStats3` và `tblMovieStats3` vì là thực thể thống kê dẫn xuất.
2. **Sinh script Stored Procedures `sql/procedures.sql`**:
   - **Module 1: Tìm kiếm phim**:
     - `sp_searchMovies(IN kw VARCHAR(255))`: Truy vấn các phim có `title LIKE CONCAT('%', kw, '%')`.
     - `sp_getMovieDetail(IN mId INT)`: Truy vấn toàn bộ thông tin cơ bản của phim theo `mId`.
     - `sp_getMovieGenres(IN mId INT)`: Truy vấn danh sách thể loại của phim kết hợp giữa `tblGenre3` và `tblMovieGenre3`.
     - `sp_getMovieActors(IN mId INT)`: Truy vấn danh sách diễn viên của phim kết hợp giữa `tblActor3` và `tblMovieActor3`.
   - **Module 2: Thống kê khách hàng theo doanh thu**:
     - `sp_getCustomerRevenueStat(IN sDate DATE, IN eDate DATE)`: Kết hợp `tblCustomer3`, `tblUser3`, `tblInvoice3` trong khoảng `createdDate BETWEEN sDate AND eDate`. Nhóm theo khách hàng, tính `COUNT(DISTINCT tblInvoice3.id)` thành `totalTransactions`, tính `SUM(tblInvoice3.totalAmount)` thành `totalRevenue`, sắp xếp theo `totalRevenue DESC`.
     - `sp_getInvoicesOfCustomer(IN cId INT, IN sDate DATE, IN eDate DATE)`: Truy vấn danh sách các hóa đơn của khách hàng `cId` phát sinh trong kỳ `[sDate, eDate]`.
     - `sp_getTicketsOfInvoice(IN invId INT)`: Truy vấn danh sách vé thuộc hóa đơn `invId`.
3. **Sinh dữ liệu mẫu `sql/sample_data.sql`**:
   - Chèn ít nhất 5 bộ phim mẫu (có thể loại, diễn viên đa dạng).
   - Chèn ít nhất 5 người dùng (khách hàng, quản lý, nhân viên bán vé).
   - Chèn dữ liệu phòng chiếu, ghế ngồi, suất chiếu, vé xem phim và hóa đơn mẫu với nhiều mốc thời gian khác nhau để phục vụ kiểm thử đơn vị và chạy thử nghiệm.

---

## Bước 3: Lập trình toàn bộ 20 lớp thực thể Model (`src/model/`)

Lập trình chuẩn POJO Java Bean cho đầy đủ 20 lớp thực thể theo đúng Mục 3.1:

1. **Nhóm người dùng & vai trò**:
   - `User3`: `- id: int`, `- username: String`, `- password: String`, `- fullName: String`, `- email: String`, `- phone: String`.
   - `Staff3 extends User3`: `- role: String`.
   - `Manager3 extends Staff3`.
   - `Saler3 extends Staff3`.
   - `Customer3 extends User3`: `- code: String`, `- card: MembershipCard3`.
   - `MembershipCard3`: `- id: int`, `- issueDate: Date`, `- points: int`.
   - `CustomerStats3 extends Customer3`: `- startDate: Date`, `- endDate: Date`, `- totalTransactions: int`, `- totalRevenue: float`.
2. **Nhóm cơ sở vật chất**:
   - `Cinema3`: `- id: int`, `- name: String`, `- address: String`, `- phone: String`, `- rooms: ScreeningRoom3[]`.
   - `ScreeningRoom3`: `- id: int`, `- name: String`, `- capacity: int`, `- type: String`, `- seats: Seat3[]`.
   - `Seat3`: `- id: int`, `- row: String`, `- number: int`, `- type: String`.
3. **Nhóm phim & nghệ thuật**:
   - `Movie3`: `- id: int`, `- title: String`, `- director: String`, `- duration: int`, `- releaseDate: Date`, `- ageRestriction: int`, `- description: String`, `- genres: ArrayList<MovieGenre3>`, `- actors: ArrayList<MovieActor3>`.
   - `Genre3`: `- id: int`, `- name: String`.
   - `Actor3`: `- id: int`, `- name: String`.
   - `MovieGenre3`: `- id: int`, `- rate: float`, `- genre: Genre3`.
   - `MovieActor3`: `- id: int`, `- characterName: String`, `- actor: Actor3`.
   - `MovieStats3 extends Movie3`: `- startDate: Date`, `- endDate: Date`, `- totalTickets: int`, `- totalRevenue: float`.
4. **Nhóm giao dịch tác nghiệp**:
   - `Showtime3`: `- id: int`, `- showDate: Date`, `- startTime: String`, `- endTime: String`, `- format: String`, `- basePrice: float`, `- movie: Movie3`, `- room: ScreeningRoom3`.
   - `Ticket3`: `- id: int`, `- price: float`, `- issueTime: Date`, `- status: String`, `- type: String`, `- showtime: Showtime3`, `- seat: Seat3`.
   - `Invoice3`: `- id: int`, `- createdDate: Date`, `- totalAmount: float`, `- paymentMethod: String`, `- customer: Customer3`, `- saler: Saler3`, `- tickets: ArrayList<Ticket3>`.
   - `RevenueStats3`: `- id: int`, `- startDate: Date`, `- endDate: Date`, `- totalTickets: int`, `- totalRevenue: float`, `- invoices: ArrayList<Invoice3>`.

---

## Bước 4: Lập trình tầng truy cập dữ liệu DAO (`src/dao/`)

1. **Lớp cơ sở `DAO3.java`**:
   - Nạp driver `com.mysql.cj.jdbc.Driver` và khởi tạo kết nối tĩnh `public static Connection con`.
2. **Lớp `MovieDAO3.java extends DAO3`**:
   - `public ArrayList<Movie3> getMovies(String name)`:
     - Thực thi `CallableStatement cs = con.prepareCall("{call sp_searchMovies(?)}");`
     - Thiết lập tham số, duyệt `ResultSet`, ánh xạ thành `ArrayList<Movie3>`.
   - `public Movie3 getMovieDetail(Movie3 movie)`:
     - Thực thi Stored Procedure lấy chi tiết thông tin phim, danh sách thể loại và diễn viên.
     - Đóng gói đầy đủ vào đối tượng `movie` và trả về kết quả.
3. **Lớp `CustomerStatDAO3.java extends DAO3`**:
   - `public ArrayList<CustomerStats3> getCustomerStat(Date startDate, Date endDate)`:
     - Kiểm tra điều kiện `startDate <= endDate`.
     - Thực thi `CallableStatement cs = con.prepareCall("{call sp_getCustomerRevenueStat(?, ?)}");`
     - Đóng gói từng dòng `ResultSet` thành đối tượng `CustomerStats3` (chứa `code`, `fullName`, `totalTransactions`, `totalRevenue`).
4. **Lớp `InvoiceDAO3.java extends DAO3`**:
   - `public ArrayList<Invoice3> getInvoicesOfCustomer(int customerId, Date startDate, Date endDate)`:
     - Thực thi `CallableStatement cs = con.prepareCall("{call sp_getInvoicesOfCustomer(?, ?, ?)}");`
     - Đóng gói danh sách hóa đơn `Invoice3` cùng danh sách vé tương ứng.

---

## Bước 5: Lập trình các trang giao diện JSP (`WebContent/`)

Đối chiếu trực tiếp với các bản vẽ giao diện tại `final-document/UI/` để dựng mã nguồn JSP:

1. **Module Tìm kiếm phim** (khớp với `final-document/UI/module-search-movie-information/`):
   - `WebContent/view/customer/CustomerScreen.jsp`:
     - Khớp `customer-screen.png`: Trang chủ khách hàng chứa nút/liên kết điều hướng tới `SearchMovieScreen.jsp`.
   - `WebContent/view/customer/SearchMovieScreen.jsp`:
     - Khớp `SearchMovie-screen-before-clicking-search.png`: Khung tìm kiếm có ô `keyword` nhập tên phim, nút "Search", nút "Back".
     - Khớp `SearchMovie-screen-after-clicking-search.png`: Khi có tham số `keyword`, gọi `MovieDAO3.getMovies(keyword)` và hiển thị bảng kết quả: `TT`, `Title`, `Action` (nút/liên kết "View" chuyển sang `MovieDetailScreen.jsp?id=...`).
   - `WebContent/view/customer/MovieDetailScreen.jsp`:
     - Khớp `MovieDetail-screen.png`: Nhận `id`, gọi `MovieDAO3.getMovieDetail()`, hiển thị bảng thông tin chi tiết: `Code`, `Title`, `Director`, `Main actors`, `Genres`, `Duration`, `Release Date`, `Age Restriction`, `Description`, và nút "Close".
2. **Module Xem thống kê khách hàng** (khớp với `final-document/UI/module-view-customer-statistic/`):
   - `WebContent/view/manager/ManagerScreen.jsp`:
     - Khớp `ManagerScreen.png`: Trang chủ quản lý chứa nút "View reports" dẫn tới `ReportScreen.jsp`.
   - `WebContent/view/manager/ReportScreen.jsp`:
     - Khớp `reportScreen-before-select-report.png`: Bộ lọc gồm hộp chọn `Type` (chọn "Customer - Revenue"), ô `Start Date`, `End Date`, và nút "View report".
     - Khớp `reportScreen-after-select-report.png`: Khi người dùng submit khoảng ngày, gọi `CustomerStatDAO3.getCustomerStat(startDate, endDate)` và hiển thị bảng kết quả: `TT`, `Customer code`, `Customer name`, `Total transactions`, `Total revenue (VNĐ)`, liên kết "View" dẫn tới `CustomerTransactionScreen.jsp`, và nút "Back".
   - `WebContent/view/manager/CustomerTransactionScreen.jsp`:
     - Khớp `Customer-transaction_screen.png`: Nhận `customerId`, `startDate`, `endDate`, gọi `InvoiceDAO3.getInvoicesOfCustomer()`, hiển thị bảng lịch sử giao dịch: `TT`, `Invoice code`, `Time`, `Total tickets`, `Total price`, dòng tổng kết `Total`, và nút "Close".
3. **Các trang dùng chung**:
   - `WebContent/index.jsp`: Trang điều hướng mặc định.
   - `WebContent/LoginScreen.jsp`: Trang đăng nhập giả lập thông tin tài khoản phiên làm việc.
