---
name: unit-test-workflow
description: >-
  Use this skill to design, implement, and run automated JUnit 4 unit tests for DAO classes in the Cinema Management System (Subject No. 17). Covers branch coverage level 2 test matrix specification, test case implementation with transaction rollback, compilation, and command-line test execution.
---

# Unit Testing & SQA Workflow (`unit-test-workflow`)

Kỹ năng này điều phối toàn bộ quy trình thiết kế, cài đặt mã nguồn và thực thi kiểm thử đơn vị tự động (Unit Testing) bằng **JUnit 4** cho các lớp DAO trong Hệ thống quản lý rạp chiếu phim (Cinema Management System - Subject No. 17), tuân thủ nghiêm ngặt phương pháp luận tại Mục 5.3 giáo trình `case-study/BG HP TTTN 2 CNPM 2020 final.pdf` và quy tắc `.agents/rules/implementation-methodology-rules.md`.

---

## Tổng quan quy trình 4 bước kiểm thử đơn vị

```
[Bước 1: Thiết kế ma trận Test Cases (Độ phủ cấp 2)]
                         ↓
[Bước 2: Cài đặt mã nguồn JUnit 4 (Rollback CSDL)]
                         ↓
[Bước 3: Biên dịch mã nguồn & kiểm thử (javac)]
                         ↓
[Bước 4: Thực thi kiểm thử & Báo cáo kết quả (JUnitCore)]
```

---

## Bước 1: Thiết kế ma trận Test Cases (Độ phủ cấp 2 - Branch Coverage)

Theo Mục 5.3.1 giáo trình (trang 157–158), với mỗi phương thức DAO cần kiểm thử, lập bảng ma trận test case đảm bảo bao phủ hết các nhánh trong source code (nhánh rỗng, nhánh 1 kết quả, nhánh nhiều kết quả, nhánh ngoại lệ).

Bảng đặc tả test case chuẩn hóa theo mẫu sau:

| TT | Chức năng / Use case | Lớp điều khiển | Phương thức | Trường hợp test (Chuẩn / Ngoại lệ) | Dữ liệu đầu vào (Input) | Kết quả mong đợi (Expected Output) |
| :---: | :--- | :--- | :--- | :--- | :--- | :--- |
| **1** | **Tìm kiếm thông tin phim** | `MovieDAO3` | `getMovies` | Chuẩn 1: Từ khóa khớp 1 phim duy nhất | `name = "Avatar"` | Trả về `ArrayList<Movie3>` có kích thước = 1, `title` chứa "Avatar" |
| | | | | Chuẩn 2: Từ khóa khớp nhiều phim | `name = "a"` | Trả về `ArrayList<Movie3>` có kích thước > 1 |
| | | | | Ngoại lệ 1: Từ khóa không tồn tại | `name = "PhimKhongCoThuc123"` | Trả về danh sách rỗng (size = 0) |
| | | | | Ngoại lệ 2: Từ khóa là chuỗi rỗng | `name = ""` | Trả về toàn bộ phim hiện có hoặc danh sách rỗng |
| | | | | Ngoại lệ 3: Từ khóa là `null` | `name = null` | Trả về danh sách rỗng hoặc xử lý an toàn không quăng ngoại lệ |
| **2** | **Xem chi tiết phim** | `MovieDAO3` | `getMovieDetail` | Chuẩn 1: Phim tồn tại đầy đủ thể loại và diễn viên | `movie.id = 1` | Trả về đối tượng `Movie3` có đầy đủ thông tin, `genres.size() > 0`, `actors.size() > 0` |
| | | | | Ngoại lệ 1: ID phim không tồn tại trong CSDL | `movie.id = 99999` | Trả về `null` hoặc đối tượng không có chi tiết |
| **3** | **Thống kê khách hàng theo doanh thu** | `CustomerStatDAO3` | `getCustomerStat` | Chuẩn 1: Khoảng ngày hợp lệ có nhiều KH phát sinh doanh thu | `startDate = 2026-01-01`, `endDate = 2026-12-31` | Trả về `ArrayList<CustomerStats3>` có kích thước > 0, sắp xếp giảm dần theo `totalRevenue` (`item[0].revenue >= item[1].revenue`) |
| | | | | Chuẩn 2: Khoảng ngày chỉ có đúng 1 KH có doanh thu | `startDate = 2026-11-01`, `endDate = 2026-11-02` | Trả về `ArrayList<CustomerStats3>` có kích thước = 1 |
| | | | | Ngoại lệ 1: Khoảng ngày không có giao dịch nào | `startDate = 2020-01-01`, `endDate = 2020-01-02` | Trả về danh sách rỗng (size = 0) |
| | | | | Ngoại lệ 2: Ngày bắt đầu lớn hơn ngày kết thúc | `startDate = 2026-12-31`, `endDate = 2026-01-01` | Trả về danh sách rỗng hoặc `null` |
| **4** | **Xem lịch sử giao dịch của khách hàng** | `InvoiceDAO3` | `getInvoicesOfCustomer` | Chuẩn 1: Khách hàng có nhiều hóa đơn trong kỳ | `customerId = 1`, `startDate = 2026-01-01`, `endDate = 2026-12-31` | Trả về danh sách `Invoice3` có kích thước > 0, mỗi hóa đơn chứa danh sách vé `tickets.size() > 0` |
| | | | | Ngoại lệ 1: Khách hàng tồn tại nhưng không có hóa đơn trong kỳ | `customerId = 1`, `startDate = 2020-01-01`, `endDate = 2020-01-02` | Trả về danh sách rỗng (size = 0) |
| | | | | Ngoại lệ 2: Mã khách hàng không tồn tại | `customerId = 99999`, `startDate = 2026-01-01`, `endDate = 2026-12-31` | Trả về danh sách rỗng (size = 0) |

---

## Bước 2: Cài đặt mã nguồn JUnit 4 (`test/dao/`)

Theo Mục 5.3.2 giáo trình (trang 158–168), các lớp test JUnit 4 được đặt trong thư mục `test/dao/`:
- `test/dao/TestMovieDAO3.java`
- `test/dao/TestCustomerStatDAO3.java`
- `test/dao/TestInvoiceDAO3.java`

### Quy chuẩn cấu trúc lớp Test chuẩn:
1. **Import thư viện**:
   ```java
   package test.dao;

   import java.sql.Date;
   import java.util.ArrayList;
   import org.junit.Assert;
   import org.junit.BeforeClass;
   import org.junit.Test;
   import dao.DAO3;
   import dao.MovieDAO3;
   import model.Movie3;
   ```
2. **Khởi tạo đối tượng DAO**:
   ```java
   public class TestMovieDAO3 {
       private static MovieDAO3 movieDAO;

       @BeforeClass
       public static void setUp() {
           movieDAO = new MovieDAO3();
       }
   ```
3. **Mẫu test chuẩn (`_testChuan<k>`)**:
   ```java
   @Test
   public void getMovies_testChuan1() {
       String keyword = "Avatar";
       ArrayList<Movie3> list = movieDAO.getMovies(keyword);
       Assert.assertNotNull(list);
       Assert.assertEquals(1, list.size());
       Assert.assertTrue(list.get(0).getTitle().contains("Avatar"));
   }
   ```
4. **Mẫu test ngoại lệ (`_testNgoaile<k>`)**:
   ```java
   @Test
   public void getMovies_testNgoaile1() {
       String keyword = "PhimKhongCoThuc123";
       ArrayList<Movie3> list = movieDAO.getMovies(keyword);
       Assert.assertNotNull(list);
       Assert.assertEquals(0, list.size());
   }
   ```
5. **Mẫu kiểm thử có Rollback giao dịch CSDL (Bắt buộc với thao tác ghi hoặc dữ liệu thay đổi)**:
   ```java
   @Test
   public void testWithDatabaseRollback() {
       try {
           DAO3.con.setAutoCommit(false);
           
           // Thực hiện thao tác gọi DAO và kiểm tra kết quả
           // ...
           
       } catch (Exception e) {
           e.printStackTrace();
           Assert.fail("Exception xảy ra trong quá trình test: " + e.getMessage());
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

---

## Bước 3: Biên dịch mã nguồn & bộ kiểm thử (Compile)

Sử dụng lệnh `javac` trong môi trường Linux để biên dịch toàn bộ các lớp `model`, `dao` và các lớp kiểm thử trong `test/`:

1. **Tạo thư mục chứa class biên dịch**:
   ```bash
   mkdir -p cinema-management-system/build/classes
   mkdir -p cinema-management-system/build/test-classes
   ```
2. **Biên dịch mã nguồn chính (`src/`)**:
   ```bash
   javac -encoding UTF-8 \
     -cp "cinema-management-system/WebContent/WEB-INF/lib/*" \
     -d cinema-management-system/build/classes \
     cinema-management-system/src/model/*.java \
     cinema-management-system/src/dao/*.java
   ```
3. **Biên dịch mã nguồn kiểm thử (`test/`)**:
   ```bash
   javac -encoding UTF-8 \
     -cp "cinema-management-system/build/classes:cinema-management-system/WebContent/WEB-INF/lib/*" \
     -d cinema-management-system/build/test-classes \
     cinema-management-system/test/dao/*.java
   ```

---

## Bước 4: Thực thi kiểm thử & Báo cáo kết quả (Test Runner & Reporting)

1. **Chạy kiểm thử bằng trình chạy chuẩn `org.junit.runner.JUnitCore`**:
   ```bash
   java -cp "cinema-management-system/build/classes:cinema-management-system/build/test-classes:cinema-management-system/WebContent/WEB-INF/lib/*" \
     org.junit.runner.JUnitCore \
     test.dao.TestMovieDAO3 \
     test.dao.TestCustomerStatDAO3 \
     test.dao.TestInvoiceDAO3
   ```
2. **Đánh giá và phân tích báo cáo kết quả**:
   - Nếu kết quả trả về `OK (N tests)`: Tất cả các ca kiểm thử đạt 100%.
   - Nếu có `Failures` hoặc `Errors`:
     - Trích xuất chi tiết StackTrace, tên phương thức test bị fail.
     - Đối chiếu lại giữa câu lệnh Stored Procedure, ánh xạ CSDL trong DAO và dữ liệu mẫu trong `sql/sample_data.sql`.
     - Tiến hành sửa lỗi (Fix Defect) trong mã nguồn DAO hoặc Stored Procedure và chạy lại kiểm thử đến khi đạt 100% Pass.
