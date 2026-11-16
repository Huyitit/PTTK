# Hướng Dẫn Khởi Chạy Hệ Thống Bằng Docker (`cinema-management-system`)

Tài liệu này hướng dẫn chi tiết cách khởi chạy toàn bộ **Hệ thống Quản lý Rạp chiếu phim (Subject No. 17 - `cinema_db3`)** bằng Docker Compose theo **Phương án 1 (Multi-Container: Apache Tomcat 9 + MySQL 8.0)**.

---

## 1. Yêu cầu Tiền đề (Prerequisites)

- Đã cài đặt **Docker** (>= 20.10) và **Docker Compose** (>= v2.0).
- Máy tính không bị chiếm dụng các cổng:
  - Cổng **`8080`** (dành cho Web Server Tomcat).
  - Cổng **`3306`** (dành cho CSDL MySQL).

---

## 2. Hướng dẫn Khởi chạy 1 Lệnh Duy Nhất

Mở terminal tại thư mục chứa dự án:

```bash
cd cinema-management-system
docker compose up -d --build
```

### Quá trình tự động diễn ra:
1. **Container `cinema_mysql`**: Khởi chạy MySQL 8.0, tự động nạp toàn bộ cấu trúc và dữ liệu:
   - `01_schema.sql`: 17 bảng quan hệ chuẩn hóa.
   - `02_procedures.sql`: 7 Stored Procedures của cả 2 phân hệ.
   - `03_sample_data.sql`: Nạp sẵn dữ liệu mẫu (30 users, 25 phim, 45 hóa đơn).
2. **Container `cinema_web`**: Multi-stage build tự động biên dịch toàn bộ mã nguồn Model & DAO bằng Java 17, triển khai lên Apache Tomcat 9 và kết nối tự động tới container `cinema_mysql`.

---

## 3. Địa chỉ Truy cập Các Phân hệ

Sau khi container khởi động hoàn tất (khoảng 15–20 giây), truy cập vào trình duyệt:

| Phân hệ / Màn hình | Địa chỉ URL truy cập | Ghi chú |
| :--- | :--- | :--- |
| **Cổng Đăng nhập chung** | [http://localhost:8080/](http://localhost:8080/) hoặc [http://localhost:8080/LoginScreen.jsp](http://localhost:8080/LoginScreen.jsp) | Có sẵn nút đăng nhập nhanh minh họa cho 2 vai trò. |
| **Đường dẫn ứng dụng đầy đủ** | [http://localhost:8080/cinema-management-system/](http://localhost:8080/cinema-management-system/) | Triển khai song song cả context ROOT và context tên dự án. |
| **Module 1 (Khách hàng)** | [http://localhost:8080/view/customer/CustomerScreen.jsp](http://localhost:8080/view/customer/CustomerScreen.jsp) | Tìm kiếm phim, xem chi tiết phim (Avatar 1, Avatar 2...). |
| **Module 2 (Quản lý)** | [http://localhost:8080/view/manager/ManagerScreen.jsp](http://localhost:8080/view/manager/ManagerScreen.jsp) | Xem báo cáo thống kê khách hàng theo doanh thu (01/01/2026 - 31/01/2026). |

---

## 4. Tài khoản Đăng nhập Kiểm thử

Hệ thống có sẵn dữ liệu tài khoản trong CSDL để đăng nhập:

- **Nhân viên Quản lý**:
  - Tên đăng nhập: `manager_an`
  - Mật khẩu: `123456`
  - Vai trò: `Nhân viên Quản lý (Manager)`
- **Khách hàng**:
  - Tên đăng nhập: `vana` (hoặc `customer_a`)
  - Mật khẩu: `123456`
  - Vai trò: `Khách hàng (Customer)`

*(Lưu ý: Tại màn hình `LoginScreen.jsp` có sẵn 2 nút bấm nhanh **"Khách hàng"** và **"Quản lý"** để chuyển thẳng tới giao diện chức năng mà không cần gõ phím).*

---

## 5. Các Lệnh Quản trị Hữu ích

### 5.1 Xem trạng thái các container
```bash
docker compose ps
```

### 5.2 Xem log thời gian thực
```bash
# Xem log toàn bộ hệ thống
docker compose logs -f

# Chỉ xem log của Web Server Tomcat
docker compose logs -f web

# Chỉ xem log của MySQL
docker compose logs -f db
```

### 5.3 Dừng hệ thống (giữ nguyên dữ liệu CSDL)
```bash
docker compose stop
```

Khởi động lại:
```bash
docker compose start
```

### 5.4 Tắt hệ thống và Reset lại toàn bộ dữ liệu CSDL về ban đầu
```bash
docker compose down -v
```
*(Cờ `-v` sẽ xóa volume lưu trữ `cinema_mysql_data`, lần sau khởi chạy `docker compose up -d` sẽ nạp lại CSDL sạch từ file SQL ban đầu).*

---

## 6. Kết nối CSDL MySQL từ Công cụ Ngoài (DBeaver / DataGrip / Workbench)

Container MySQL đã mở cổng `5000` ra ngoài máy host (tránh xung đột với MySQL cục bộ trên cổng 3306 nếu có), bạn có thể kết nối trực tiếp với thông số:
- **Host**: `localhost` (hoặc `127.0.0.1`)
- **Port**: `5000` (được forward vào port 3306 của container)
- **Database**: `cinema_db3`
- **Username**: `root`
- **Password**: `root`
