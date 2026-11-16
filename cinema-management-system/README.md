# Cinema Management System (Subject No. 17)

Dự án cài đặt mã nguồn cho **Hệ thống Quản lý Rạp chiếu phim (Cinema Management System)** phục vụ học phần **Đảm bảo chất lượng phần mềm (Software Assurance)**.

---

## 1. Cấu trúc thư mục dự án (Chuẩn Eclipse Dynamic Web Project - Hình 5.1 Giáo trình)

```
cinema-management-system/
├── .project                               # Cấu hình dự án Eclipse
├── .classpath                             # Cấu hình Classpath và thư viện Eclipse
├── src/                                   # Thư mục mã nguồn Java chính
│   ├── model/                             # 20 lớp thực thể Model POJO (Mục 3.1)
│   └── dao/                               # Các lớp truy cập dữ liệu DAO (Mục 3.3.1)
├── WebContent/                            # Thư mục ứng dụng Web
│   ├── index.jsp                          # Trang điều hướng chính
│   ├── LoginScreen.jsp                    # Trang đăng nhập dùng chung
│   ├── view/
│   │   ├── customer/                      # Module 1: Khách hàng tìm kiếm phim
│   │   │   ├── CustomerScreen.jsp
│   │   │   ├── SearchMovieScreen.jsp
│   │   │   └── MovieDetailScreen.jsp
│   │   └── manager/                       # Module 2: Quản lý xem thống kê doanh thu KH
│   │       ├── ManagerScreen.jsp
│   │       ├── ReportScreen.jsp
│   │       └── CustomerTransactionScreen.jsp
│   └── WEB-INF/
│       ├── web.xml                        # File cấu hình triển khai Web
│       └── lib/                           # Các thư viện .jar phụ thuộc
│           ├── mysql-connector-j-8.0.33.jar
│           ├── junit-4.13.2.jar
│           └── hamcrest-core-1.3.jar
├── test/                                  # Thư mục mã nguồn kiểm thử đơn vị
│   └── dao/                               # Các lớp kiểm thử JUnit 4 cho DAO
├── sql/                                   # Kịch bản cơ sở dữ liệu MySQL 8.0
│   ├── schema.sql                         # Script tạo 18 bảng CSDL quan hệ
│   ├── procedures.sql                     # Stored Procedures phục vụ các DAO
│   └── sample_data.sql                    # Dữ liệu mẫu kiểm thử
└── build/                                 # Thư mục chứa bytecode đã biên dịch (.class)
```

---

## 2. Thư viện phụ thuộc (Dependencies)
- **MySQL Connector/J 8.0.33**: Trình điều khiển kết nối CSDL MySQL qua giao thức JDBC (`com.mysql.cj.jdbc.Driver`).
- **JUnit 4.13.2**: Framework kiểm thử đơn vị (`org.junit.Test`, `Assert`).
- **Hamcrest Core 1.3**: Thư viện so sánh kết quả kiểm thử phụ trợ cho JUnit 4.

---

## 3. Hướng dẫn Khởi chạy bằng Docker (Khuyến nghị - 1 Lệnh Duy Nhất)
Hệ thống hỗ trợ chạy độc lập qua Docker Compose mà không cần cài đặt Apache Tomcat hoặc MySQL cục bộ:
```bash
docker compose up -d --build
```
- Truy cập ứng dụng: [http://localhost:8080/](http://localhost:8080/)
- Xem hướng dẫn chi tiết tại: [`DOCKER_GUIDE.md`](file:///home/huycao/Documents/Year4-S1/Software_Assurance/cinema-management-system/DOCKER_GUIDE.md)

---

## 4. Hướng dẫn Mở dự án trong Eclipse IDE
1. Mở Eclipse IDE (Eclipse IDE for Enterprise Java and Web Developers).
2. Chọn **File** $\to$ **Import...** $\to$ **General** $\to$ **Existing Projects into Workspace**.
3. Chọn đường dẫn tới thư mục `cinema-management-system/` và nhấn **Finish**.
4. Cấu hình Targeted Runtimes là **Apache Tomcat 9.0** (nếu triển khai trực tiếp từ IDE).
