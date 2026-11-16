# Đặc tả Biểu đồ giao tiếp: Module Xem thống kê khách hàng theo doanh thu (`image10`)

## 1. Danh sách đối tượng tham gia (Objects / Lifelines)
- `Manager`: Actor (Tác nhân Nhân viên quản lý)
- `ManagerScreen`: Boundary (Lớp biên - Giao diện chính của quản lý)
- `ReportSelectionScreen`: Boundary (Lớp biên - Giao diện chọn loại báo cáo và thời gian)
- `CustomerReportByRevenueScreen`: Boundary (Lớp biên - Giao diện danh sách thống kê khách hàng theo doanh thu)
- `CustomerTransactionScreen`: Boundary (Lớp biên - Giao diện chi tiết các giao dịch của khách hàng)
- `CustomerStats`: Entity (Lớp thực thể - Thống kê khách hàng)
- `Invoice`: Entity (Lớp thực thể - Hóa đơn giao dịch)

---

## 2. Bảng thông điệp giao tiếp (Numbered Messages)

| STT | Người gửi (Source) | Người nhận (Target) | Chiều thông điệp | Tên thông điệp / Lời gọi |
| :---: | :--- | :--- | :---: | :--- |
| **1** | `Manager` | `ManagerScreen` | `>` | `1: select view report feature` |
| **2** | `ManagerScreen` | `ReportSelectionScreen` | `>` | `2: call` |
| **3** | `ReportSelectionScreen` | `Manager` | `>` | `3: display` |
| **4** | `Manager` | `ReportSelectionScreen` | `>` | `4: select report + date` |
| **5** | `ReportSelectionScreen` | `CustomerReportByRevenueScreen` | `>` | `5: call` |
| **6** | `CustomerReportByRevenueScreen` | `CustomerStats` | `>` | `6: call` |
| **7** | `CustomerStats` | `CustomerStats` | `>` (self) | `7: getCustomerStat()` |
| **8** | `CustomerStats` | `CustomerReportByRevenueScreen` | `<` | `8: return` |
| **9** | `CustomerReportByRevenueScreen` | `Manager` | `>` | `9: display` |
| **10** | `Manager` | `CustomerReportByRevenueScreen` | `>` | `10: select a customer` |
| **11** | `CustomerReportByRevenueScreen` | `CustomerTransactionScreen` | `>` | `11: call` |
| **12** | `CustomerTransactionScreen` | `Invoice` | `>` | `12: call` |
| **13** | `Invoice` | `Invoice` | `>` (self) | `13: getInvoicesOfCustomer()` |
| **14** | `Invoice` | `CustomerTransactionScreen` | `<` | `14: return` |
| **15** | `CustomerTransactionScreen` | `Manager` | `>` | `15: display` |
