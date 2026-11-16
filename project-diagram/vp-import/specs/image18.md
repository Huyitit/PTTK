# Đặc tả Biểu đồ tuần tự v3: Module Xem thống kê khách hàng theo doanh thu (`image18`)

## 1. Danh sách đối tượng tham gia (Lifelines / Objects)

| STT | Tên đối tượng (Lifeline) | Tầng kiến trúc / Stereotype | Diễn giải vai trò |
| :---: | :--- | :--- | :--- |
| **1** | `Nhân viên quản lý` | `Actor` | Người dùng trực tiếp thao tác lọc và xem thống kê doanh thu |
| **2** | `ManagerScreen.jsp` | `Boundary` (View) | Giao diện trang chủ quản lý |
| **3** | `ReportScreen.jsp` | `Boundary` (View) | Giao diện chọn bộ lọc và hiển thị bảng xếp hạng doanh thu khách hàng |
| **4** | `CustomerTransactionScreen.jsp` | `Boundary` (View) | Giao diện hiển thị chi tiết các hóa đơn của khách hàng được chọn |
| **5** | `CustomerStatDAO3` | `Control` (DAO) | Lớp truy xuất CSDL tổng hợp số liệu thống kê khách hàng |
| **6** | `InvoiceDAO3` | `Control` (DAO) | Lớp truy xuất CSDL chi tiết các hóa đơn của khách hàng |
| **7** | `CustomerStats3` | `Entity` (Model) | Lớp thực thể thống kê khách hàng (kế thừa `Customer3`) |
| **8** | `Invoice3` | `Entity` (Model) | Lớp thực thể hóa đơn thanh toán |
| **9** | `Ticket3` | `Entity` (Model) | Lớp thực thể vé xem phim trong hóa đơn |

---

## 2. Bảng thông điệp tuần tự (Numbered Sequence Messages)

| STT | Người gửi (Source) | Người nhận (Target) | Chiều / Loại gọi | Tên thông điệp / Lời gọi / Trả về |
| :---: | :--- | :--- | :---: | :--- |
| **1** | `Nhân viên quản lý` | `ManagerScreen.jsp` | `->` | `1: Chọn chức năng "Xem thống kê khách hàng theo doanh thu"` |
| **2** | `ManagerScreen.jsp` | `ReportScreen.jsp` | `->` | `2: gọi trang` |
| **3** | `ReportScreen.jsp` | `Nhân viên quản lý` | `-->` | `3: hiển thị giao diện báo cáo thống kê (loại TK, startDate, endDate, nút "Xem thống kê")` |
| **4** | `Nhân viên quản lý` | `ReportScreen.jsp` | `->` | `4: chọn loại thống kê, nhập khoảng thời gian (startDate, endDate) và click "Xem thống kê"` |
| **5** | `ReportScreen.jsp` | `CustomerStatDAO3` | `->` | `5: yêu cầu lấy danh sách thống kê khách hàng theo doanh thu` |
| **6** | `CustomerStatDAO3` | `CustomerStatDAO3` | `->` (self) | `6: getCustomerStat(startDate: Date, endDate: Date)` |
| **7** | `CustomerStatDAO3` | `CustomerStats3` | `->` | `7: kết nối CSDL, tổng hợp doanh thu từng khách hàng và gọi đóng gói dữ liệu` |
| **8** | `CustomerStats3` | `CustomerStats3` | `->` (self) | `8: CustomerStats3() [đóng gói]` |
| **9** | `CustomerStats3` | `CustomerStatDAO3` | `-->` | `9: trả kết quả đối tượng CustomerStats3 đã đóng gói` |
| **10** | `CustomerStatDAO3` | `ReportScreen.jsp` | `-->` | `10: trả kết quả danh sách mảng đối tượng CustomerStats3[]` |
| **11** | `ReportScreen.jsp` | `Nhân viên quản lý` | `-->` | `11: hiển thị bảng danh sách thống kê khách hàng (sắp xếp theo doanh thu giảm dần)` |
| **12** | `Nhân viên quản lý` | `ReportScreen.jsp` | `->` | `12: click nút "Xem chi tiết" của một khách hàng cụ thể trên bảng thống kê` |
| **13** | `ReportScreen.jsp` | `CustomerTransactionScreen.jsp` | `->` | `13: gọi trang (truyền mã khách hàng customerId, startDate, endDate)` |
| **14** | `CustomerTransactionScreen.jsp` | `InvoiceDAO3` | `->` | `14: yêu cầu lấy danh sách chi tiết các hóa đơn của khách hàng` |
| **15** | `InvoiceDAO3` | `InvoiceDAO3` | `->` (self) | `15: getInvoicesOfCustomer(customerId: int, startDate: Date, endDate: Date)` |
| **16** | `InvoiceDAO3` | `Invoice3` | `->` | `16: kết nối CSDL, truy vấn các hóa đơn và gọi đóng gói dữ liệu` |
| **17** | `Invoice3` | `Invoice3` | `->` (self) | `17: Invoice3() [đóng gói]` |
| **18** | `Invoice3` | `Ticket3` | `->` | `18: gọi đóng gói danh sách các vé thuộc từng hóa đơn` |
| **19** | `Ticket3` | `Ticket3` | `->` (self) | `19: Ticket3() [đóng gói]` |
| **20** | `Ticket3` | `Invoice3` | `-->` | `20: trả kết quả danh sách vé` |
| **21** | `Invoice3` | `InvoiceDAO3` | `-->` | `21: trả về đối tượng Invoice3 hoàn chỉnh (chứa thông tin hóa đơn và mảng Ticket3[])` |
| **22** | `InvoiceDAO3` | `CustomerTransactionScreen.jsp` | `-->` | `22: trả kết quả danh sách mảng đối tượng Invoice3[]` |
| **23** | `CustomerTransactionScreen.jsp` | `Nhân viên quản lý` | `-->` | `23: hiển thị danh sách chi tiết các giao dịch/hóa đơn của khách hàng kèm tổng doanh thu` |
