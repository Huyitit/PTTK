# Hệ Thống Quản Lý Rạp Chiếu Phim (Cinema Management System)
### Học phần: Đảm bảo chất lượng phần mềm (Software Assurance) — PTIT
**Đề tài (Subject No. 17)**: Khách hàng tìm kiếm thông tin phim & Quản lý xem thống kê khách hàng theo doanh thu  
**Mã sinh viên**: `D23DCCE043`

---

## 📌 Giới thiệu Tổng quan (Project Overview)

Kho lưu trữ (repository) này chứa toàn bộ tài liệu nghiên cứu, phân tích, thiết kế, mã nguồn cài đặt và kiểm thử tự động của bài tập lớn học phần **Đảm bảo chất lượng phần mềm (Software Assurance)**. Đề tài tập trung xây dựng và đảm bảo chất lượng cho **Hệ thống Quản lý Rạp chiếu phim (Cinema Management System)** theo đúng quy trình phát triển phần mềm chuẩn mực:

```
[Thu thập yêu cầu] ➔ [Phân tích hệ thống] ➔ [Thiết kế kiến trúc & CSDL] ➔ [Cài đặt mã nguồn (MVC)] ➔ [Kiểm thử đơn vị (JUnit 4 - C2)]
```

### 🎯 2 Phân hệ / Module trọng tâm (Subject No. 17):
1. **Module 1 - Khách hàng tìm kiếm thông tin phim (*Customer searches for movie information*)**:
   - Khách hàng nhập từ khóa tên phim trên giao diện tìm kiếm.
   - Hệ thống truy vấn CSDL và hiển thị danh sách các phim phù hợp kèm thông tin tóm tắt (thể loại, thời lượng, đạo diễn, ngày khởi chiếu).
   - Khách hàng chọn một phim cụ thể để xem chi tiết đầy đủ nội dung, danh sách diễn viên và lịch chiếu.
2. **Module 2 - Quản lý xem thống kê khách hàng (*Management staff views customer statistics*)**:
   - Quản lý chọn khoảng thời gian cần thống kê (từ ngày... đến ngày...).
   - Hệ thống tổng hợp và xếp hạng doanh thu đóng góp của từng khách hàng qua Stored Procedure tối ưu.
   - Quản lý chọn một khách hàng cụ thể để xem chi tiết lịch sử tất cả các hóa đơn/giao dịch phát sinh trong khoảng thời gian đã chọn.

---

## 📂 Cấu trúc Thư mục Cấp 1 (Level-1 Directories)

```
Software_Assurance/
├── final-document/            # Tài liệu báo cáo chính thức (Markdown) và mockup giao diện UI
├── cinema-management-system/  # Mã nguồn ứng dụng web Java (MVC), CSDL MySQL, Unit Test & Docker
├── project-diagram/           # Mã nguồn 20 biểu đồ UML (PlantUML), tệp Visual Paradigm & Scripts đồng bộ
├── case-study/                # Giáo trình bài giảng học phần & tài liệu ca nghiên cứu mẫu
├── Topic-description/         # Bản mô tả đề tài chính thức từ giảng viên (Subjects 13 - 17)
├── Image/                     # Thư viện ảnh tư liệu, sơ đồ và tài nguyên đồ họa bổ trợ
├── chat-output/               # Bản ghi trao đổi và ghi chú tiến độ phát triển
├── .agents/                   # Cấu hình tự động hóa AI (Skills, Rules cho quy trình làm đồ án)
└── README.md                  # Hướng dẫn tổng quan kho mã nguồn (Tài liệu này)
```

### 🔍 Mục đích sử dụng chi tiết của từng thư mục:

| Thư mục | Mục đích sử dụng & Nội dung cốt lõi |
| :--- | :--- |
| [`final-document/`](file:///home/huycao/Documents/Year4-S1/Software_Assurance/final-document/) | **Tài liệu Báo cáo đồ án chính thức**: <br>• File báo cáo hoàn chỉnh [`17D23DCCE043.md`](file:///home/huycao/Documents/Year4-S1/Software_Assurance/final-document/17D23DCCE043.md) theo mẫu đề cương môn học (Đặc tả 5 bước, Phân tích kịch bản & trích lớp, Thiết kế lớp & CSDL, Thiết kế động & Kiến trúc triển khai).<br>• Thư mục con [`UI/`](file:///home/huycao/Documents/Year4-S1/Software_Assurance/final-document/UI/) chứa hình ảnh thiết kế giao diện màn hình mô phỏng cho cả 2 module. |
| [`cinema-management-system/`](file:///home/huycao/Documents/Year4-S1/Software_Assurance/cinema-management-system/) | **Mã nguồn phần mềm thực thi & Kiểm thử**: <br>• Ứng dụng Web Java theo chuẩn **Eclipse Dynamic Web Project** (Hình 5.1 Giáo trình).<br>• Tầng Model (20 POJO classes) và tầng DAO (JDBC, kết nối CSDL).<br>• Tầng View gồm các màn hình JSP trực quan.<br>• Bộ kịch bản SQL MySQL 8.0 (`schema.sql`, `procedures.sql`, `sample_data.sql`).<br>• Bộ kiểm thử tự động JUnit 4 bao phủ nhánh C2 (`test/dao/`).<br>• Cấu hình Docker & Docker Compose sẵn sàng chạy chỉ với 1 lệnh. |
| [`project-diagram/`](file:///home/huycao/Documents/Year4-S1/Software_Assurance/project-diagram/) | **Hệ thống Biểu đồ Thiết kế (UML & Database)**: <br>• Chứa mã nguồn 20 biểu đồ PlantUML (`.puml`) tương ứng từ `image1` đến `image20` trong báo cáo.<br>• Thư mục `vp-import/`: Định dạng XMI/XML/SQL phục vụ nhập vào công cụ **Visual Paradigm**.<br>• Thư mục `exported/`: Chứa ảnh PNG đã kết xuất của các biểu đồ.<br>• Script Python tự động hóa: `sync_diagrams.py` (đồng bộ ảnh vào tài liệu) và `encode_puml.py` (tạo link PlantUML server). |
| [`case-study/`](file:///home/huycao/Documents/Year4-S1/Software_Assurance/case-study/) | **Tài liệu Tham khảo & Chuẩn mực**: <br>• Chứa giáo trình gốc: `BG HP TTTN 2 CNPM 2020 final.pdf` (Bài giảng Thực tập tốt nghiệp 2 / Đảm bảo chất lượng phần mềm - PTIT).<br>• Các ảnh tham chiếu tiêu chuẩn (tổ chức thư mục chương 5, biểu đồ hoạt động mẫu, biểu đồ tuần tự mẫu). |
| [`Topic-description/`](file:///home/huycao/Documents/Year4-S1/Software_Assurance/Topic-description/) | **Đặc tả Đề tài Môn học**: <br>• File [`DESCRIPTION.md`](file:///home/huycao/Documents/Year4-S1/Software_Assurance/Topic-description/DESCRIPTION.md) mô tả nghiệp vụ chung của hệ thống rạp phim và phân công module từ Đề tài số 13 đến Đề tài số 17. |
| [`Image/`](file:///home/huycao/Documents/Year4-S1/Software_Assurance/Image/) | **Tài nguyên Hình ảnh Bổ trợ**: <br>• Lưu trữ ảnh sơ đồ cơ sở dữ liệu gốc, biểu đồ tổng quan và các tài sản đồ họa tĩnh được nhúng trong tài liệu. |
| [`chat-output/`](file:///home/huycao/Documents/Year4-S1/Software_Assurance/chat-output/) | **Ghi chú & Nhật ký Phát triển**: <br>• Lưu trữ các output, bản ghi thảo luận trung gian trong quá trình hoàn thiện các phần của đồ án. |
| [`.agents/`](file:///home/huycao/Documents/Year4-S1/Software_Assurance/.agents/) | **Hệ thống AI Agent Workflows**: <br>• Cấu hình bộ kỹ năng (Skills) và quy tắc (Rules) tự động hóa dành cho Antigravity Assistant: biên soạn tài liệu, vẽ biểu đồ PUML, sinh mã nguồn DAO/JSP và thiết kế bộ test case JUnit 4 chuẩn độ bao phủ nhánh. |

---

## 🧭 Hướng dẫn Dành cho Khách Thăm quan (Visitor Guide)

Tùy theo mục đích ghé thăm repo, bạn có thể lựa chọn lộ trình phù hợp bên dưới:

### 📖 Lộ trình 1: Đọc Báo cáo Đồ án & Tài liệu Kỹ thuật
Nếu bạn là giảng viên, sinh viên hoặc người muốn nghiên cứu quy trình phân tích thiết kế phần mềm chuẩn:
1. Mở xem trực tiếp báo cáo toàn diện tại: [`final-document/17D23DCCE043.md`](file:///home/huycao/Documents/Year4-S1/Software_Assurance/final-document/17D23DCCE043.md).
2. Tài liệu được biên soạn kỹ lưỡng với đầy đủ các phần:
   - **Mục I. Đề bài**: Yêu cầu học phần và đề bài Subject 17.
   - **Mục II.1. Thu thập yêu cầu**: Lập bảng thuật ngữ chuyên môn, mô tả hệ thống theo 5 bước tự nhiên, biểu đồ Use Case tổng quan & chi tiết.
   - **Mục II.2. Phân tích yêu cầu**: Kịch bản nghiệp vụ (Scenarios), quy trình 5 bước trích xuất 20 lớp thực thể, biểu đồ lớp biên/điều khiển, biểu đồ tuần tự và biểu đồ hoạt động pha phân tích.
   - **Mục II.3. Thiết kế**: Thiết kế lớp thực thể, thiết kế CSDL quan hệ chuẩn 3NF, thiết kế tĩnh (Class diagram chi tiết), thiết kế động (Sequence diagram tương tác DAO/Servlet/JSP), biểu đồ gói (Package) và biểu đồ triển khai vật lý (Deployment diagram).
3. Xem ảnh chụp mockup giao diện web tại thư mục: [`final-document/UI/`](file:///home/huycao/Documents/Year4-S1/Software_Assurance/final-document/UI/).

---

### 🚀 Lộ trình 2: Trải nghiệm & Chạy Thử Ứng dụng (Quickstart Demo)
Dự án đã được đóng gói hoàn chỉnh bằng **Docker Compose** (chạy đồng thời Tomcat 9 + MySQL 8.0 với dữ liệu mẫu nạp sẵn).

#### Cách khởi chạy nhanh với Docker:
```bash
# 1. Di chuyển vào thư mục ứng dụng
cd cinema-management-system

# 2. Khởi chạy toàn bộ hệ thống bằng Docker Compose (chỉ 1 lệnh)
docker compose up -d --build
```

#### Truy cập các màn hình ứng dụng:
Sau khi các container báo trạng thái `healthy` (khoảng 15-20 giây):
- **Cổng Đăng nhập dùng chung**: [http://localhost:8080/](http://localhost:8080/) hoặc [http://localhost:8080/LoginScreen.jsp](http://localhost:8080/LoginScreen.jsp)
- **Module 1 (Khách hàng)**: Nhấp *"Đăng nhập Khách hàng"* hoặc truy cập trực tiếp [http://localhost:8080/view/customer/CustomerScreen.jsp](http://localhost:8080/view/customer/CustomerScreen.jsp). Bạn có thể tìm kiếm phim với các từ khóa mẫu như: `Avatar`, `Đất`, `Mai`, `Dune`...
- **Module 2 (Quản lý)**: Nhấp *"Đăng nhập Quản lý"* hoặc truy cập trực tiếp [http://localhost:8080/view/manager/ManagerScreen.jsp](http://localhost:8080/view/manager/ManagerScreen.jsp). Chọn báo cáo thống kê khách hàng theo doanh thu, nhập khoảng thời gian (ví dụ: từ `2024-01-01` đến `2024-12-31`) để xem bảng xếp hạng và bấm chi tiết để xem giao dịch.

#### Dừng ứng dụng:
```bash
docker compose down
```

> 💡 *Chi tiết về các biến môi trường, tài khoản kiểm thử và cấu hình nâng cao xem tại: [`cinema-management-system/DOCKER_GUIDE.md`](file:///home/huycao/Documents/Year4-S1/Software_Assurance/cinema-management-system/DOCKER_GUIDE.md).*

---

### 🧪 Lộ trình 3: Kiểm tra Mã nguồn & Chạy Kiểm thử Đơn vị (Unit Testing)
Dành cho người quan tâm đến chất lượng mã nguồn (Code Quality) và Đảm bảo chất lượng phần mềm (Software Assurance):
1. **Kiến trúc mã nguồn**: Nằm trong thư mục [`cinema-management-system/src/`](file:///home/huycao/Documents/Year4-S1/Software_Assurance/cinema-management-system/src/):
   - `model/`: Chứa đầy đủ 20 POJO entity classes mapping với cơ sở dữ liệu.
   - `dao/`: Tầng truy cập dữ liệu JDBC thuần, sử dụng Stored Procedures và PreparedStatement phòng chống SQL Injection.
2. **Kiểm thử đơn vị JUnit 4 (Branch Coverage Level 2 - C2)**: Nằm trong thư mục [`cinema-management-system/test/dao/`](file:///home/huycao/Documents/Year4-S1/Software_Assurance/cinema-management-system/test/dao/):
   - Thiết kế ma trận kiểm thử bao phủ toàn bộ các nhánh điều kiện (tìm thấy phim, không tìm thấy, từ khóa rỗng, ngày bắt đầu > ngày kết thúc, dữ liệu biên, lỗi SQL ngoại lệ).
   - Tự động thiết lập cơ chế **Transaction Rollback (`connection.rollback()`)** trong các bài kiểm thử để tuyệt đối không làm sai lệch hay rác CSDL thực tế.
3. **Thực thi Unit Test từ dòng lệnh**:
   ```bash
   cd cinema-management-system
   # Biên dịch và chạy test runner JUnit 4
   javac -cp "WebContent/WEB-INF/lib/*:build" -d build test/dao/*.java
   java -cp "WebContent/WEB-INF/lib/*:build" org.junit.runner.JUnitCore dao.MovieDAOTest dao.CustomerStatDAOTest
   ```

---

### 📊 Lộ trình 4: Xem và Tùy biến Sơ đồ UML (PlantUML & Visual Paradigm)
1. Toàn bộ 20 sơ đồ UML từ pha Phân tích đến pha Thiết kế được lưu tại: [`project-diagram/puml/`](file:///home/huycao/Documents/Year4-S1/Software_Assurance/project-diagram/puml/).
2. **Xem / Chỉnh sửa nhanh**: Bạn có thể copy nội dung tệp `.puml` và dán trực tiếp vào [PlantText](https://www.planttext.com/) hoặc [PlantUML Online Server](https://www.plantuml.com/plantuml/uml/).
3. **Sinh URL xem sơ đồ trực tiếp**: Chạy script:
   ```bash
   python3 project-diagram/encode_puml.py project-diagram/puml/image14.puml
   ```
4. **Đồng bộ hóa với Visual Paradigm**: Các đặc tả cấu trúc và mô hình dữ liệu sẵn sàng import vào Visual Paradigm nằm trong thư mục [`project-diagram/vp-import/`](file:///home/huycao/Documents/Year4-S1/Software_Assurance/project-diagram/vp-import/).

---

## 🛠️ Công nghệ Sử dụng (Tech Stack)

| Hạng mục | Công nghệ / Công cụ áp dụng |
| :--- | :--- |
| **Ngôn ngữ lập trình** | Java (JDK 11 / 17) |
| **Mô hình kiến trúc** | MVC (Model - View - Controller), DAO Pattern |
| **Web & Template Engine** | Servlet API, JSP (JavaServer Pages), JSTL, HTML5, CSS3, JavaScript |
| **Cơ sở dữ liệu** | MySQL 8.0 (17 quan hệ chuẩn hóa 3NF, Stored Procedures, Transactions) |
| **Kiểm thử tự động** | JUnit 4.13.2, Hamcrest Core 1.3 (Đạt chuẩn bao phủ nhánh C2) |
| **Mô hình hóa (UML/DB)** | PlantUML, Visual Paradigm, PlantText |
| **Môi trường Container** | Docker, Docker Compose (Multi-container Tomcat 9 + MySQL 8.0) |
| **IDE & Môi trường làm việc** | Eclipse IDE (Dynamic Web Project), Linux (Ubuntu) |

---

## 👥 Thông tin Tác giả & Đóng góp (Author & Acknowledgements)

- **Sinh viên thực hiện**: `D23DCCE043`
- **Học viện**: Học viện Công nghệ Bưu chính Viễn thông (PTIT)
- **Học phần**: Đảm bảo chất lượng phần mềm (Software Assurance)
- Dự án được phát triển tuân thủ nghiêm ngặt theo các tiêu chuẩn kỹ thuật phần mềm và mục tiêu học tập của học phần. Mọi ý kiến đóng góp, phản hồi hoặc câu hỏi vui lòng mở Issue trên repository.

---
*Cập nhật lần cuối: Tháng 11/2026*
