# Đặc tả Biểu đồ gói hệ thống (Package Diagram - `image19`)

Biểu đồ gói mô hình hóa cách tổ chức phân tầng cấu trúc mã nguồn của hệ thống quản lý rạp chiếu phim theo mô hình 3 tầng MVC / DAO.

---

## 1. Cấu trúc phân cấp các gói (Package Hierarchy)

| STT | Tên gói (Package) | Gói cha (Parent) | Loại thành phần | Diễn giải chức năng & Danh sách lớp |
| :---: | :--- | :--- | :--- | :--- |
| **1** | `view` | System Root | Folder Package | Tầng giao diện người dùng (chứa toàn bộ các trang giao diện Web JSP) |
| **1.1** | `view.user` | `view` | Sub-package | Các màn hình dùng chung cho mọi tác nhân: `LoginScreen.jsp`, `LogoutScreen.jsp` |
| **1.2** | `view.customer` | `view` | Sub-package | Các màn hình phục vụ khách hàng: `CustomerScreen.jsp`, `SearchMovieScreen.jsp`, `MovieDetailScreen.jsp`, `BookingTicketScreen.jsp` |
| **1.3** | `view.manager` | `view` | Sub-package | Các màn hình phục vụ quản lý: `ManagerScreen.jsp`, `ReportScreen.jsp`, `CustomerTransactionScreen.jsp`, `MovieManageScreen.jsp`, `ShowtimeManageScreen.jsp` |
| **1.4** | `view.saler` | `view` | Sub-package | Các màn hình phục vụ nhân viên bán vé: `SalerScreen.jsp`, `SellTicketScreen.jsp`, `IssueCardScreen.jsp` |
| **2** | `dao` | System Root | Folder Package | Tầng truy xuất CSDL (Data Access Objects):<br>- Lớp cơ sở: `DAO3`<br>- Lớp nghiệp vụ: `MovieDAO3`, `CustomerStatDAO3`, `InvoiceDAO3`, `UserDAO3`, `ShowtimeDAO3`, `TicketDAO3` |
| **3** | `model` | System Root | Folder Package | Tầng thực thể nghiệp vụ (Entity Beans / DTO - 20 lớp):<br>- *Người dùng*: `User3`, `Staff3`, `Customer3`, `Manager3`, `Saler3`, `CustomerStats3`, `MembershipCard3`<br>- *Cơ sở vật chất*: `Cinema3`, `ScreeningRoom3`, `Seat3`<br>- *Phim & Thể loại*: `Movie3`, `Genre3`, `Actor3`, `MovieGenre3`, `MovieActor3`, `MovieStats3`<br>- *Tác nghiệp*: `Showtime3`, `Ticket3`, `Invoice3`, `RevenueStats3` |

---

## 2. Bảng quan hệ phụ thuộc giữa các gói (Package Dependencies)

| STT | Gói nguồn (Source) | Gói đích (Target) | Loại quan hệ | Stereotype | Diễn giải ngữ nghĩa |
| :---: | :--- | :--- | :---: | :---: | :--- |
| **1** | `view` | `dao` | Dependency (`..>`) | `<<use>>` | Các màn hình JSP gọi phương thức nghiệp vụ của DAO để truy vấn/thao tác dữ liệu |
| **2** | `view` | `model` | Dependency (`..>`) | `<<use>>` | Các màn hình JSP sử dụng các đối tượng thực thể model để binding và hiển thị dữ liệu |
| **3** | `dao` | `model` | Dependency (`..>`) | `<<use>>` | Các lớp DAO khởi tạo, ánh xạ từ bảng CSDL và trả về các thực thể model |
| **4** | `view.customer` | `dao` | Dependency (`..>`) | `<<use>>` | Phân hệ khách hàng gọi `MovieDAO3`, `ShowtimeDAO3`, `TicketDAO3` |
| **5** | `view.manager` | `dao` | Dependency (`..>`) | `<<use>>` | Phân hệ quản lý gọi `CustomerStatDAO3`, `InvoiceDAO3`, `MovieDAO3`, ... |
| **6** | `view.saler` | `dao` | Dependency (`..>`) | `<<use>>` | Phân hệ bán vé gọi `TicketDAO3`, `InvoiceDAO3`, ... |
| **7** | `view.user` | `dao` | Dependency (`..>`) | `<<use>>` | Phân hệ người dùng chung gọi `UserDAO3` |
