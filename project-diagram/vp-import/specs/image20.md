# Đặc tả Biểu đồ triển khai hệ thống (Deployment Diagram - `image20`)

Biểu đồ triển khai mô hình hóa cấu trúc mạng phần cứng và môi trường thực thi vật lý của hệ thống quản lý rạp chiếu phim, trong đó Máy chủ ứng dụng (Web/App Server) và Máy chủ cơ sở dữ liệu (Database Server) được tích hợp trên cùng một thiết bị máy chủ vật lý.

---

## 1. Danh sách các Nút thiết bị & Môi trường thực thi (Nodes & Execution Environments)

| STT | Nút thiết bị (Device Node) | Môi trường thực thi (Execution Environment) | Thành phần triển khai (Artifacts / Databases) | Diễn giải chức năng |
| :---: | :--- | :--- | :--- | :--- |
| **1** | `Client Node (PC / Workstation)` | `Web Browser`<br>(Chrome, Edge, Firefox) | `Web Interface (HTML / CSS / JS)` | Thiết bị trạm của người dùng (Khách hàng từ xa qua Internet, Nhân viên bán vé và Quản lý tại rạp qua LAN) |
| **2** | `Server (Linux Ubuntu Server)` | **1. Apache Tomcat Server 9.x/10.x**<br>(vận hành trên `JRE 11+`)<br><br>**2. MySQL 8.0 DBMS** | - `cinema_system.war` (Ứng dụng web đóng gói)<br>- `mysql-connector-java.jar` (JDBC Driver 8.0)<br><br>- Cơ sở dữ liệu quan hệ `cinema_db3` | Thiết bị máy chủ duy nhất đảm nhiệm đồng thời xử lý logic ứng dụng web và quản trị cơ sở dữ liệu hệ thống |

---

## 2. Bảng kết nối & Giao thức truyền thông (Communication Links)

| STT | Nút / Môi trường nguồn | Nút / Môi trường đích | Giao thức (Protocol) | Cổng mạng (Port) | Môi trường kết nối | Diễn giải ngữ nghĩa |
| :---: | :--- | :--- | :---: | :---: | :---: | :--- |
| **1** | `Client Node` | `Server` (Device) | `HTTP` | `80` | `Internet / LAN` | Trình duyệt web máy khách gửi yêu cầu HTTP và nhận kết quả phản hồi giao diện web từ máy chủ |
| **2** | `Apache Tomcat Server`<br>(Web/App Server) | `MySQL 8.0 DBMS`<br>(Database Server) | `TCP/IP (Local JDBC)` | `localhost:3306` | `Nội bộ máy chủ (Localhost)` | Ứng dụng web truy xuất cơ sở dữ liệu MySQL trực tiếp qua giao tiếp nội bộ localhost bằng kết nối JDBC |
