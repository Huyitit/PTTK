# Đặc tả Biểu đồ giao tiếp: Module Tìm kiếm thông tin phim (`image8`)

## 1. Danh sách đối tượng tham gia (Objects / Lifelines)
- `Customer`: Actor (Tác nhân Khách hàng)
- `CustomerScreen`: Boundary (Lớp biên - Giao diện chính của khách hàng)
- `SearchMovieScreen`: Boundary (Lớp biên - Giao diện tìm kiếm phim)
- `MovieDetailScreen`: Boundary (Lớp biên - Giao diện chi tiết phim)
- `Movie`: Entity (Lớp thực thể - Phim)

---

## 2. Bảng thông điệp giao tiếp (Numbered Messages)

| STT | Người gửi (Source) | Người nhận (Target) | Chiều thông điệp | Tên thông điệp / Lời gọi |
| :---: | :--- | :--- | :---: | :--- |
| **1** | `Customer` | `CustomerScreen` | `>` | `1: select search movie feature` |
| **2** | `CustomerScreen` | `SearchMovieScreen` | `>` | `2: call` |
| **3** | `SearchMovieScreen` | `Customer` | `<` | `3: display` |
| **4** | `Customer` | `SearchMovieScreen` | `>` | `4: insert keyword + click search` |
| **5** | `SearchMovieScreen` | `Movie` | `>` | `5: call` |
| **6** | `Movie` | `Movie` | `>` (self) | `6: getMovies()` |
| **7** | `Movie` | `SearchMovieScreen` | `<` | `7: return` |
| **8** | `SearchMovieScreen` | `Customer` | `<` | `8: display` |
| **9** | `Customer` | `SearchMovieScreen` | `>` | `9: select a movie` |
| **10** | `SearchMovieScreen` | `MovieDetailScreen` | `>` | `10: call` |
| **11** | `MovieDetailScreen` | `Movie` | `>` | `11: call` |
| **12** | `Movie` | `Movie` | `>` (self) | `12: getMovieDetail()` |
| **13** | `Movie` | `MovieDetailScreen` | `<` | `13: return` |
| **14** | `MovieDetailScreen` | `Customer` | `<` | `14: display` |
