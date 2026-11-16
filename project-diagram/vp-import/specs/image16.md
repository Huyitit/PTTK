# Đặc tả Biểu đồ tuần tự v3: Module Tìm kiếm thông tin phim (`image16`)

## 1. Danh sách đối tượng tham gia (Lifelines / Objects)

| STT | Tên đối tượng (Lifeline) | Tầng kiến trúc / Stereotype | Diễn giải vai trò |
| :---: | :--- | :--- | :--- |
| **1** | `Khách hàng` | `Actor` | Người dùng trực tiếp thao tác tìm kiếm và xem chi tiết phim |
| **2** | `CustomerScreen.jsp` | `Boundary` (View) | Giao diện trang chủ của khách hàng |
| **3** | `SearchMovieScreen.jsp` | `Boundary` (View) | Giao diện tìm kiếm phim và hiển thị danh sách kết quả |
| **4** | `MovieDetailScreen.jsp` | `Boundary` (View) | Giao diện hiển thị thông tin chi tiết toàn diện của bộ phim |
| **5** | `MovieDAO3` | `Control` (DAO) | Lớp truy xuất dữ liệu CSDL cho thực thể phim |
| **6** | `Movie3` | `Entity` (Model) | Lớp thực thể phim |
| **7** | `MovieGenre3` | `Entity` (Model) | Lớp thực thể thể loại của phim |
| **8** | `MovieActor3` | `Entity` (Model) | Lớp thực thể diễn viên của phim |

---

## 2. Bảng thông điệp tuần tự (Numbered Sequence Messages)

| STT | Người gửi (Source) | Người nhận (Target) | Chiều / Loại gọi | Tên thông điệp / Lời gọi / Trả về |
| :---: | :--- | :--- | :---: | :--- |
| **1** | `Khách hàng` | `CustomerScreen.jsp` | `->` | `1: Chọn chức năng "Tìm kiếm phim"` |
| **2** | `CustomerScreen.jsp` | `SearchMovieScreen.jsp` | `->` | `2: gọi trang` |
| **3** | `SearchMovieScreen.jsp` | `Khách hàng` | `-->` | `3: hiển thị giao diện tìm kiếm (ô keyword, nút Tìm kiếm)` |
| **4** | `Khách hàng` | `SearchMovieScreen.jsp` | `->` | `4: nhập từ khóa tên phim (ví dụ: "Avatar") và click nút "Tìm kiếm"` |
| **5** | `SearchMovieScreen.jsp` | `MovieDAO3` | `->` | `5: yêu cầu tìm kiếm phim theo từ khóa` |
| **6** | `MovieDAO3` | `MovieDAO3` | `->` (self) | `6: getMovies(name: String)` |
| **7** | `MovieDAO3` | `Movie3` | `->` | `7: gọi đóng gói thông tin thực thể phim` |
| **8** | `Movie3` | `Movie3` | `->` (self) | `8: Movie3() [đóng gói]` |
| **9** | `Movie3` | `MovieDAO3` | `-->` | `9: trả kết quả đối tượng Movie3 đã đóng gói` |
| **10** | `MovieDAO3` | `SearchMovieScreen.jsp` | `-->` | `10: trả kết quả danh sách mảng đối tượng Movie3[]` |
| **11** | `SearchMovieScreen.jsp` | `Khách hàng` | `-->` | `11: hiển thị bảng danh sách các phim tìm được` |
| **12** | `Khách hàng` | `SearchMovieScreen.jsp` | `->` | `12: click chọn tên / nút xem của một bộ phim cụ thể` |
| **13** | `SearchMovieScreen.jsp` | `MovieDetailScreen.jsp` | `->` | `13: gọi trang (truyền đối tượng phim đã chọn)` |
| **14** | `MovieDetailScreen.jsp` | `MovieDAO3` | `->` | `14: yêu cầu lấy thông tin chi tiết đầy đủ của bộ phim` |
| **15** | `MovieDAO3` | `MovieDAO3` | `->` (self) | `15: getMovieDetail(movie: Movie3)` |
| **16** | `MovieDAO3` | `Movie3` | `->` | `16: gọi đóng gói thông tin chi tiết phim` |
| **17** | `Movie3` | `Movie3` | `->` (self) | `17: Movie3() [đóng gói thông tin chung]` |
| **18** | `Movie3` | `MovieGenre3` | `->` | `18: gọi đóng gói danh sách thể loại của bộ phim` |
| **19** | `MovieGenre3` | `MovieGenre3` | `->` (self) | `19: MovieGenre3() [đóng gói]` |
| **20** | `MovieGenre3` | `Movie3` | `-->` | `20: trả kết quả danh sách thể loại` |
| **21** | `Movie3` | `MovieActor3` | `->` | `21: gọi đóng gói danh sách diễn viên tham gia bộ phim` |
| **22** | `MovieActor3` | `MovieActor3` | `->` (self) | `22: MovieActor3() [đóng gói]` |
| **23** | `MovieActor3` | `Movie3` | `-->` | `23: trả kết quả danh sách diễn viên` |
| **24** | `Movie3` | `MovieDAO3` | `-->` | `24: trả về đối tượng Movie3 hoàn chỉnh (chứa chi tiết, thể loại, diễn viên)` |
| **25** | `MovieDAO3` | `MovieDetailScreen.jsp` | `-->` | `25: trả kết quả đối tượng Movie3` |
| **26** | `MovieDetailScreen.jsp` | `Khách hàng` | `-->` | `26: hiển thị bảng thông tin chi tiết toàn diện của bộ phim` |
