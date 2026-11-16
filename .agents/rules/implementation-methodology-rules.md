---
description: Software Implementation & Unit Testing Methodology Rules derived strictly from case-study/BG HP TTTN 2 CNPM 2020 final.pdf (Chapter 5) and Section 3 of final-document/17D23DCCE043.md. Enforce across the implementation and testing phases.
---

# Implementation & Unit Testing Methodology Rules (`BG HP TTTN 2 CNPM 2020` - Chapter 5)

> **Source of Truth**: Quy tắc này được trích xuất và chuẩn hóa bắt buộc dựa trên:
> 1. Giáo trình môn học: `case-study/BG HP TTTN 2 CNPM 2020 final.pdf` (Chương 5: Cài đặt hệ thống, trang 115–168).
> 2. Hồ sơ thiết kế hệ thống đã được kiểm chứng tại Mục 3 của `final-document/17D23DCCE043.md` (3.1 Biểu đồ lớp thực thể, 3.2 Cơ sở dữ liệu quan hệ, 3.3 Thiết kế tĩnh & động 2 module tìm kiếm phim và xem thống kê khách hàng theo doanh thu, 3.3.3 Thiết kế triển khai và biểu đồ gói).
> 3. Bản vẽ thiết kế giao diện thực tế tại `final-document/UI/` (`module-search-movie-information/` và `module-view-customer-statistic/`).

---

## 1. Nguyên tắc cốt lõi: Tính kế thừa & Tính nhất quán tuyệt đối (Traceability)

1. **Ràng buộc đầu vào bất biến từ Pha Thiết kế (Phase 3 Contract)**:
   - Toàn bộ mã nguồn cài đặt của hệ thống (Model, DAO, CSDL, Giao diện JSP, Kiểm thử) phải bám sát 100% hợp đồng thiết kế đã chốt tại Mục 3 của tài liệu tổng kết:
     - **Tên lớp, tên thuộc tính, kiểu dữ liệu**: Phải khớp chính xác với Mục 3.1. Tuyệt đối không tự ý thêm, bớt hoặc đổi tên các thuộc tính/phương thức đã được đặc tả trong thiết kế tĩnh (Mục 3.3.1).
     - **Cơ sở dữ liệu (Tables, Columns, Foreign Keys)**: Phải khớp chính xác với 18 bảng quan hệ tại Mục 3.2. Không tạo bảng CSDL cho các thực thể thống kê (`tblCustomerStats3`, `tblMovieStats3`, `tblRevenueStats3`) vì đây là dữ liệu dẫn xuất được tính toán động tại thời điểm truy vấn.
     - **Chữ ký phương thức DAO**: Phải khớp chính xác với các phương thức DAO đã được khai báo ở Mục 3.3.1 và biểu đồ tuần tự Mục 3.3.2.
2. **Quy tắc bắt buộc hậu tố `3` (Mandatory Instructor Suffix `3`)**:
   - Theo yêu cầu của giảng viên hướng dẫn cho đề tài sinh viên `17D23DCCE043` (chữ số cuối là `3`), tất cả các lớp thực thể (`User3`, `Customer3`, `Staff3`, `Manager3`, `Saler3`, `CustomerStats3`, `Movie3`, `Genre3`, `Actor3`, `MovieGenre3`, `MovieActor3`, `Cinema3`, `ScreeningRoom3`, `Seat3`, `Showtime3`, `Ticket3`, `Invoice3`, `RevenueStats3`, `MembershipCard3`), các lớp DAO (`DAO3`, `MovieDAO3`, `CustomerStatDAO3`, `InvoiceDAO3`), và các bảng CSDL (`tblUser3`, `tblMovie3`, `tblInvoice3`, ...) **bắt buộc phải có hậu tố `3`**.
3. **Quy chuẩn đặt tên mã nguồn (Java Naming Conventions)**:
   - **Tên gói (Package Names)**: Chữ thường hoàn toàn (`model`, `dao`, `view.customer`, `view.manager`, `view.user`, `test.dao`).
   - **Tên lớp (Class Names)**: `PascalCase` kèm hậu tố `3` (ví dụ: `MovieDAO3`, `CustomerStats3`).
   - **Tên thuộc tính & biến (Field & Variable Names)**: `camelCase` chuẩn Java (ví dụ: `startDate`, `totalRevenue`, `listMovies`).
   - **Tên phương thức (Method Names)**: `camelCase` bắt đầu bằng động từ (ví dụ: `getMovies()`, `getMovieDetail()`, `getCustomerStat()`, `getInvoicesOfCustomer()`).
   - **Tên hằng số (Constants)**: `UPPER_SNAKE_CASE`.

---

## 2. Quy chuẩn tổ chức dự án Eclipse Dynamic Web (`5.1 Tổ chức dự án`)

Dự án mã nguồn được tổ chức theo chuẩn **Eclipse Dynamic Web Project** thuần truyền thống đặt trong thư mục `cinema-management-system/` tại gốc workspace, tuân thủ nghiêm ngặt theo Hình 5.1 giáo trình (trang 115):

```
cinema-management-system/
├── src/                                   # Thư mục chứa mã nguồn Java (Java Resources)
│   ├── model/                             # Tầng thực thể (Model Package)
│   │   ├── User3.java
│   │   ├── Customer3.java
│   │   ├── Staff3.java
│   │   ├── Manager3.java
│   │   ├── Saler3.java
│   │   ├── CustomerStats3.java
│   │   ├── MembershipCard3.java
│   │   ├── Cinema3.java
│   │   ├── ScreeningRoom3.java
│   │   ├── Seat3.java
│   │   ├── Movie3.java
│   │   ├── Genre3.java
│   │   ├── Actor3.java
│   │   ├── MovieGenre3.java
│   │   ├── MovieActor3.java
│   │   ├── MovieStats3.java
│   │   ├── Showtime3.java
│   │   ├── Ticket3.java
│   │   ├── Invoice3.java
│   │   └── RevenueStats3.java
│   └── dao/                               # Tầng truy cập dữ liệu (DAO Package)
│       ├── DAO3.java                      # Lớp kết nối CSDL cơ sở
│       ├── MovieDAO3.java                 # DAO Module 1: Tìm kiếm phim
│       ├── CustomerStatDAO3.java          # DAO Module 2: Thống kê khách hàng theo doanh thu
│       └── InvoiceDAO3.java               # DAO Module 2: Lịch sử hóa đơn giao dịch của khách hàng
├── WebContent/                            # Thư mục gốc ứng dụng Web (Web content)
│   ├── index.jsp                          # Trang điều hướng chính
│   ├── LoginScreen.jsp                    # Trang đăng nhập dùng chung
│   ├── view/
│   │   ├── customer/                      # Các trang JSP phục vụ Khách hàng (Module 1)
│   │   │   ├── CustomerScreen.jsp         # Trang chủ khách hàng
│   │   │   ├── SearchMovieScreen.jsp      # Giao diện tìm kiếm và danh sách kết quả phim
│   │   │   └── MovieDetailScreen.jsp      # Giao diện thông tin chi tiết phim
│   │   └── manager/                       # Các trang JSP phục vụ Quản lý (Module 2)
│   │       ├── ManagerScreen.jsp          # Trang chủ quản lý
│   │       ├── ReportScreen.jsp           # Giao diện bộ lọc & bảng thống kê khách hàng
│   │       └── CustomerTransactionScreen.jsp # Giao diện chi tiết các giao dịch của khách hàng
│   └── WEB-INF/
│       ├── web.xml                        # File cấu hình triển khai Servlet/JSP
│       └── lib/                           # Chứa các thư viện .jar phụ thuộc
│           ├── mysql-connector-j-8.0.33.jar
│           ├── junit-4.13.2.jar
│           ├── hamcrest-core-1.3.jar
│           └── javax.servlet-api-4.0.1.jar
├── test/                                  # Thư mục mã nguồn kiểm thử đơn vị
│   └── dao/
│       ├── TestMovieDAO3.java             # JUnit 4 Test cho MovieDAO3
│       ├── TestCustomerStatDAO3.java      # JUnit 4 Test cho CustomerStatDAO3
│       └── TestInvoiceDAO3.java           # JUnit 4 Test cho InvoiceDAO3
└── sql/                                   # Kịch bản cơ sở dữ liệu MySQL 8.0
    ├── schema.sql                         # Khởi tạo CSDL cinema_db3 và 18 bảng tbl...3
    ├── procedures.sql                     # Các Stored Procedures phục vụ 2 module
    └── sample_data.sql                    # Dữ liệu mẫu phục vụ chạy thử và kiểm thử
```

---

## 3. Quy chuẩn lập trình tầng Model (`src/model/`)

1. **Nguyên tắc đóng gói (Encapsulation)**:
   - Toàn bộ 20 lớp thực thể Model phải tuân thủ chuẩn Java Bean / POJO.
   - Tất cả các thuộc tính phải khai báo tầm nhìn `private`.
   - Cung cấp Constructor không tham số (mặc định) và Constructor đầy đủ tham số.
   - Cung cấp đầy đủ các phương thức Getter và Setter cho từng thuộc tính.
2. **Kế thừa & Quan hệ đối tượng**:
   - Khai báo chính xác quan hệ kế thừa `extends`:
     - `Customer3 extends User3`, `Staff3 extends User3`.
     - `Manager3 extends Staff3`, `Saler3 extends Staff3`.
     - `CustomerStats3 extends Customer3` (bổ sung: `startDate`, `endDate`, `totalTransactions`, `totalRevenue`).
     - `MovieStats3 extends Movie3` (bổ sung: `startDate`, `endDate`, `totalTickets`, `totalRevenue`).
   - Khai báo các thuộc tính tham chiếu đối tượng và mảng đối tượng theo đúng Bước 4 Mục 3.1:
     - `Movie3`: Chứa `MovieGenre3[] genres` (hoặc `ArrayList<MovieGenre3>`) và `MovieActor3[] actors`.
     - `Invoice3`: Chứa `Ticket3[] tickets`, `Customer3 customer`, `Saler3 saler`.
     - `Showtime3`: Chứa `Movie3 movie`, `ScreeningRoom3 room`.
     - `Ticket3`: Chứa `Showtime3 showtime`, `Seat3 seat`.

---

## 4. Quy chuẩn lập trình tầng DAO & Stored Procedures (`src/dao/` & `sql/`)

### 4.1 Lớp cơ sở `DAO3.java`
- Khai báo biến kết nối dùng chung: `public static Connection con;`
- Constructor `public DAO3()`:
  - Nạp Driver JDBC: `Class.forName("com.mysql.cj.jdbc.Driver");`
  - Khởi tạo kết nối với CSDL MySQL `cinema_db3`:
    ```java
    String dbUrl = "jdbc:mysql://localhost:3306/cinema_db3?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    con = DriverManager.getConnection(dbUrl, "root", "root");
    ```

### 4.2 Các lớp DAO nghiệp vụ
1. **Lớp `MovieDAO3.java`** (kế thừa `DAO3`):
   - `public ArrayList<Movie3> getMovies(String name)`:
     - Gọi Stored Procedure `sp_searchMovies(?)` truyền vào từ khóa `name`.
     - Duyệt `ResultSet`, khởi tạo và đóng gói danh sách đối tượng `Movie3` trả về.
     - Xử lý chuỗi rỗng: Nếu `name` rỗng hoặc `null`, trả về toàn bộ phim hoặc danh sách rỗng theo nghiệp vụ.
   - `public Movie3 getMovieDetail(Movie3 movie)`:
     - Gọi Stored Procedure `sp_getMovieDetail(?)` để lấy thông tin chi tiết đầy đủ của phim theo `movie.getId()`.
     - Gọi tiếp `sp_getMovieGenres(?)` để đóng gói danh sách thể loại `MovieGenre3`.
     - Gọi tiếp `sp_getMovieActors(?)` để đóng gói danh sách diễn viên `MovieActor3`.
     - Trả về đối tượng `Movie3` hoàn chỉnh.
2. **Lớp `CustomerStatDAO3.java`** (kế thừa `DAO3`):
   - `public ArrayList<CustomerStats3> getCustomerStat(Date startDate, Date endDate)`:
     - Kiểm tra logic: Nếu `startDate.after(endDate)`, trả về `null` hoặc danh sách rỗng.
     - Gọi Stored Procedure `sp_getCustomerRevenueStat(?, ?)` với 2 tham số `startDate` và `endDate`.
     - Stored Procedure thực hiện phép kết hợp (JOIN) các bảng `tblCustomer3`, `tblUser3`, `tblInvoice3` và tổng hợp `COUNT(DISTINCT tblInvoice3.id)` thành `totalTransactions`, `SUM(tblInvoice3.totalAmount)` thành `totalRevenue`, sắp xếp giảm dần theo `totalRevenue DESC`.
     - Ánh xạ từng dòng `ResultSet` thành đối tượng `CustomerStats3` và trả về danh sách.
3. **Lớp `InvoiceDAO3.java`** (kế thừa `DAO3`):
   - `public ArrayList<Invoice3> getInvoicesOfCustomer(int customerId, Date startDate, Date endDate)`:
     - Gọi Stored Procedure `sp_getInvoicesOfCustomer(?, ?, ?)` để lấy danh sách các hóa đơn của khách hàng `customerId` trong kỳ `[startDate, endDate]`.
     - Với mỗi hóa đơn, gọi `sp_getTicketsOfInvoice(?)` để nạp danh sách các vé `Ticket3` thuộc hóa đơn đó.
     - Trả về danh sách `ArrayList<Invoice3>`.

### 4.3 Quy chuẩn Stored Procedures (`sql/procedures.sql`)
- Sử dụng cú pháp chuẩn MySQL 8.0 với `DELIMITER //`.
- Tách biệt rõ ràng tham số đầu vào (`IN`) và kiểu dữ liệu tương thích với CSDL.
- Bắt buộc kiểm tra điều kiện dữ liệu và đảm bảo hiệu năng truy vấn thông qua các khóa chính và khóa ngoại đã thiết lập.

---

## 5. Quy chuẩn lập trình tầng giao diện JSP (`WebContent/`)

1. **Bám sát bản vẽ UI chi tiết (`final-document/UI/`)**:
   - Toàn bộ các trang JSP bắt buộc phải đối chiếu và hiện thực chính xác 100% các thành phần điều khiển, bảng biểu, liên kết từ các file ảnh UI trong thư mục `final-document/UI/`:
     - **Module Tìm kiếm phim** (`final-document/UI/module-search-movie-information/`):
       - `customer-screen.png`: Hiển thị thanh menu có chức năng tìm kiếm phim (`CustomerScreen.jsp`).
       - `SearchMovie-screen-before-clicking-search.png`: Khung tìm kiếm gồm ô input nhập từ khóa tên phim, nút "Search", nút "Back" (`SearchMovieScreen.jsp`).
       - `SearchMovie-screen-after-clicking-search.png`: Hiển thị bảng kết quả danh sách phim gồm các cột: `TT`, `Title`, `Action` (nút/link "View") (`SearchMovieScreen.jsp`).
       - `MovieDetail-screen.png`: Hiển thị bảng chi tiết gồm các trường: `Code`, `Title`, `Director`, `Main actors`, `Genres`, `Duration`, `Release Date`, `Age Restriction`, `Description`, và nút "Close" (`MovieDetailScreen.jsp`).
     - **Module Xem thống kê khách hàng** (`final-document/UI/module-view-customer-statistic/`):
       - `ManagerScreen.png`: Trang chủ quản lý có nút chọn chức năng "View reports" (`ManagerScreen.jsp`).
       - `reportScreen-before-select-report.png`: Bộ lọc gồm hộp chọn loại báo cáo `Type`, ô chọn `Start Date`, `End Date`, nút "View report" (`ReportScreen.jsp`).
       - `reportScreen-after-select-report.png`: Hiển thị bảng báo cáo gồm các cột: `TT`, `Customer code`, `Customer name`, `Total transactions`, `Total revenue (VNĐ)`, liên kết "View", nút "Back" (`ReportScreen.jsp`).
       - `Customer-transaction_screen.png`: Hiển thị bảng hóa đơn chi tiết của khách hàng gồm: `TT`, `Invoice code`, `Time`, `Total tickets`, `Total price`, dòng tổng kết `Total`, nút "Close" (`CustomerTransactionScreen.jsp`).
2. **Quy chuẩn mã lệnh JSP**:
   - Sử dụng Java Scriptlet cơ bản hoặc JSTL/EL đơn giản nhằm minh họa rõ nghiệp vụ và luồng gọi DAO theo đúng giáo trình (không sử dụng framework phức tạp).
   - Kiểm tra `null` an toàn khi duyệt danh sách dữ liệu để tránh `NullPointerException`.
   - Giữ mã HTML/CSS sạch sẽ, hiển thị rõ ràng các thẻ `<table>`, `<tr>`, `<th>`, `<td>`, `<form>`, `<input>`, `<button>`.

---

## 6. Quy chuẩn kiểm thử đơn vị JUnit 4 (`test/dao/` & `5.3 Kiểm thử đơn vị`)

### 6.1 Xây dựng bộ Test Cases (Độ phủ cấp 2 - Branch Coverage)
Theo Mục 5.3.1 giáo trình, bộ test case phải bao phủ toàn bộ các nhánh rẽ trong code:
- **Trường hợp chuẩn (`_testChuan<k>`)**:
  - Dữ liệu đầu vào hợp lệ, CSDL có sẵn dữ liệu thỏa mãn.
  - Kiểm tra trường hợp kết quả trả về đúng số lượng bản ghi, đúng thuộc tính chi tiết, đúng thứ tự sắp xếp giảm dần theo doanh thu.
- **Trường hợp ngoại lệ (`_testNgoaile<k>`)**:
  - Dữ liệu đầu vào biên hoặc không hợp lệ (từ khóa không tồn tại, ID khách hàng/phim không tồn tại, `startDate > endDate`, khoảng ngày không có giao dịch nào).
  - Kiểm tra hàm xử lý an toàn (trả về danh sách rỗng hoặc `null`, không làm crash hệ thống).

### 6.2 Cơ chế Transaction Rollback trong JUnit 4
Theo Mục 5.3.2 giáo trình (trang 159–168), đối với các phương thức có thao tác ghi dữ liệu hoặc để đảm bảo tính độc lập tuyệt đối giữa các test case, bắt buộc phải tắt chế độ `AutoCommit` trước khi test và thực hiện `Rollback` trong khối `finally` hoặc phương thức `@After`:

```java
@Test
public void testMethod_withRollback() {
    try {
        DAO3.con.setAutoCommit(false);
        
        // 1. Chuẩn bị dữ liệu test
        // 2. Thực thi phương thức cần test
        // 3. Assert kết quả thực tế với expected output
        Assert.assertNotNull(result);
        Assert.assertEquals(expectedSize, result.size());
        
    } catch (Exception e) {
        e.printStackTrace();
        Assert.fail(e.getMessage());
    } finally {
        try {
            DAO3.con.rollback();
            DAO3.con.setAutoCommit(true);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
```

### 6.3 Quy ước đặt tên phương thức kiểm thử
- Định dạng bắt buộc: `<tenPhuongThuc>_testChuan<SoThuTu>()` và `<tenPhuongThuc>_testNgoaile<SoThuTu>()`.
- Ví dụ:
  - `getMovies_testChuan1()`, `getMovies_testChuan2()`, `getMovies_testNgoaile1()`.
  - `getCustomerStat_testChuan1()`, `getCustomerStat_testNgoaile1()`, `getCustomerStat_testNgoaile2()`.
  - `getInvoicesOfCustomer_testChuan1()`, `getInvoicesOfCustomer_testNgoaile1()`.
