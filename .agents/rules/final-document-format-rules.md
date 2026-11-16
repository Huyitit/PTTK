---
description: Formatting, structural, heading, table, prose, and diagram-embedding rules for writing and updating final-document/17D23DCCE043.md so that all content strictly matches the current final-document format.
---

# Final Document Formatting & Style Rules (`final-document/17D23DCCE043.md`)

> **Purpose**: Every addition, revision, or completion in `final-document/17D23DCCE043.md` MUST preserve and follow the exact Markdown structure, Vietnamese phrasing patterns, heading anchor conventions, table layouts, and diagram embedding style established in the current `final-document/17D23DCCE043.md`.

---

## 1. Document Outline & Heading Conventions

### 1.1 Table of Contents (`# **Mục lục** {#mục-lục}`)
- Keep the Table of Contents at the top of the document using linked entries with tab-separated page numbers:
  - Top-level parts in bold: `[**I. Đề bài\t2**](#i.-đề-bài)`, `[**II. Câu trả lời\t5**](#ii.-câu-trả-lời)`
  - Numbered subsections with escaped dots where applicable: `[1\. Thu thập yêu cầu\t5](#thu-thập-yêu-cầu)`, `[1.2.1. Mục đích của hệ thống\t16](#1.2.1.-mục-đích-của-hệ-thống)`
- Place a blank `# ` heading line before major top-level parts (`# **I. Đề bài**` and `# **II. Câu trả lời**`).

### 1.2 Heading Hierarchy & Explicit `{#anchor}` IDs
Every heading must include bold formatting (where used in the template) and an explicit `{#...}` anchor slug at the end of the line:
- **Part Headings (`#`)**:
  - `# **I. Đề bài** {#i.-đề-bài}`
  - `# **II. Câu trả lời** {#ii.-câu-trả-lời}`
- **Major Phase Headings (`1. ##`)**:
  - `1. ## **Thu thập yêu cầu** {#thu-thập-yêu-cầu}`
  - `2. ## **Phân tích yêu cầu** {#phân-tích-yêu-cầu}`
  - `3. ## **Thiết kế** {#thiết-kế}`
- **Section Headings (`###`)**:
  - Indented numbered list + H3: `   1. ### **Tìm hiểu lĩnh vực chuyên môn** {#tìm-hiểu-lĩnh-vực-chuyên-môn}` or `2. ### **Mô tả hệ thống bằng ngôn ngữ tự nhiên (5 bước)** {#mô-tả-hệ-thống-bằng-ngôn-ngữ-tự-nhiên-(5-bước)}`
- **Sub-section Headings (`####`)**:
  - Bold numbered H4 (in Phase 1): `#### **1.2.1. Mục đích của hệ thống** {#1.2.1.-mục-đích-của-hệ-thống}`
  - Bold-italic step H4 (in Section 2.2): `#### ***Bước 1: Mô tả hệ thống trong một đoạn văn*** {#bước-1:-mô-tả-hệ-thống-trong-một-đoạn-văn}`
  - Plain numbered H4 (in Sections 2.3, 2.4, 3.3): `#### 2.3.1. Phân tích module tìm kiếm thông tin phim {#2.3.1.-phân-tích-module-tìm-kiếm-thông-tin-phim}`
- **Module Sub-headings in Design (`#####`)**:
  - `##### a. Thiết kế tĩnh module tìm kiếm thông tin phim {#a.-thiết-kế-tĩnh-module-tìm-kiếm-thông-tin-phim}`
  - `##### b. Thiết kế tĩnh module xem thống kê khách hàng theo doanh thu {#b.-thiết-kế-tĩnh-module-xem-thống-kê-khách-hàng-theo-doanh-thu}`

---

## 2. Diagram & Image Embedding Format

All UML diagrams (Use Case, Entity Class, Module Analysis Class, State, Communication, Design Class, Database Schema, Activity, Sequence, Package, Deployment) MUST be embedded using a **single-cell left-aligned Markdown table** referencing a bottom-of-file `[imageN]` definition:

```markdown
| ![][imageN] |
| :---- |
```

- **Reference Definitions**: Place all `[imageN]: <data:image/png;base64,...>` definitions at the very bottom of `final-document/17D23DCCE043.md` in sequential order (`[image1]`, `[image2]`, ...).
- Never inline raw base64 strings directly inside the body paragraphs or tables.

---

## 3. Section-by-Section Content & Formatting Templates

### 3.1 Section `1.1. Tìm hiểu lĩnh vực chuyên môn`
1. **Keyword Table (`Bảng từ khóa:`)**:
   - Label: `Bảng từ khóa:`
   - 3-column table with italic headers:
     ```markdown
     | *Con người* | *Hoạt động của con người* | *Vật, đối tượng* |
     | ----- | ----- | ----- |
     ```
2. **Semantic Glossary Table (`Bảng giải thích ngữ nghĩa:`)**:
   - Label: `Bảng giải thích ngữ nghĩa:`
   - 4-column table with centered `TT` column and italic headers:
     ```markdown
     | *TT* | *Tên tiếng Việt* | *Tên tiếng Anh* | *Giải thích* |
     | :---: | ----- | ----- | ----- |
     ```
   - Group rows using full-row italic category dividers:
     - `| *Nhóm các khái niệm liên quan đến con người* |  |  |  |`
     - `| *Nhóm các khái niệm liên quan đến hoạt động của con người* |  |  |  |`
     - `| *Nhóm các khái niệm liên quan đến vật, đối tượng xử lí* |  |  |  |`

### 3.2 Section `1.2. Mô tả hệ thống bằng ngôn ngữ tự nhiên (5 bước)`
- **`1.2.1. Mục đích của hệ thống`**: 1 concise paragraph starting with `Hệ thống là trang web phục vụ công tác quản lý rạp chiếu phim...`
- **`1.2.2. Phạm vi hệ thống`**:
  - Lead-in line: `Những người được vào hệ thống và chức năng mỗi người được thực hiện khi vào hệ thống:`
  - Bulleted actors (`* **Người dùng:**`, `* **Khách hàng:**`, `* **Nhân viên bán vé:**`, `* **Nhân viên quản lý:**`) with numbered sub-items (`1.`, `2.`, ...).
  - First sub-item of specialized actors: `1. Được thực hiện các chức năng như người dùng`.
  - Bold the two target modules (`**Tìm kiếm thông tin phim**`, `**Xem các loại báo cáo thống kê**`).
  - End with italicized closing line: `*Những chức năng không đề cập đến thì mặc định là không thuộc phạm vi của hệ thống.*`
- **`1.2.3. Hoạt động nghiệp vụ của các chức năng`**:
  - Include the movie lifecycle summary line (`** Chu kì của một bộ phim: **... → ...**`).
  - Format each workflow as a bullet starting with `* **<Tên chức năng>:** <Bước 1> → <Bước 2> → ...`
  - For the two target modules, explicitly enumerate displayed output fields with bilingual labels and numbers `(1)`, `(2)`, ..., e.g.:
    `mã phim \- movie code (1), tên phim \- movie name (2), ...`
- **`1.2.4. Thông tin các đối tượng cần xử lý, quản lý`**:
  - Group into 4 bold top-level bullets:
    - `* **Nhóm các thông tin liên quan đến con người:**`
    - `* **Nhóm các thông tin liên quan đến cơ sở vật chất:**`
    - `* **Nhóm các thông tin liên quan đến tác nghiệp, vận hành:**`
    - `* **Nhóm thông tin liên quan đến thống kê:**`
  - Sub-bullets format: `* **<Tên đối tượng>:** <thuộc tính 1>, <thuộc tính 2>, ...` (using `giống <lớp cha>, có thêm: ...` for inherited entities).
- **`1.2.5. Quan hệ giữa các đối tượng, thông tin`**:
  - Bullet list of natural-language multiplicity statements (`* Một ... có nhiều ...`, `* Một ... chỉ thuộc một ...`).

### 3.3 Section `1.3. Mô tả hệ thống bằng ngôn ngữ UML`
- **Suffix Convention**: Append ` 3` to Use Case names (e.g., `Login 3`, `Logout 3`, `Search Movies 3`, `View Statistics 3`) when required by the classwork convention in the document.
- **`1.3.1. Use case tổng quan`**:
  1. Actor proposal paragraph (`Đề xuất các actor của hệ thống: ...`).
  2. Bullet list of actors and their Use Cases (`Các chức năng ứng với từng tác nhân:`).
  3. Embedded diagram (`Biểu đồ Use case tổng quan ...:` + `| ![][image1] |`).
  4. Use Case description table (`Mô tả Use case:`) with columns `| Tác nhân | Use Case | Mô tả |`.
- **`1.3.2` & `1.3.3` (Detailed Module Use Cases)**:
  1. Lead-in sentence: `Module/Chức năng <tên module> có các giao diện tương tác với <tác nhân>:`
  2. Bullet list mapping each screen interaction to a proposed Use Case (`* <Thao tác> → đề xuất use case <UC Name> 3`) plus a bullet explaining `bao gồm (include)` and `mở rộng (extend)` relationships.
  3. `Biểu đồ use case:` + `| ![][imageN] |`.
  4. Bảng mô tả chi tiết các Use case trong phân hệ với cấu trúc 4 cột chuẩn:
     `| STT | Tác nhân | Tên Use Case | Mô tả chức năng |`
     *(Cột "Mô tả chức năng" tuân thủ chuẩn văn phong Case study: bắt đầu bằng "UC này cho phép...", đồng thời nêu đúng chiều logic quan hệ: ví dụ nếu A include B thì A được thực hiện khi B đã được thực hiện).*

### 3.4 Section `2.1. Viết kịch bản`
- Plain numbered sub-headers:
  - `2.1.1. Kịch bản cho module Khách hàng tìm kiếm thông tin phim`
  - `2.1.2. Kịch bản cho module Nhân viên quản lý xem thống kê khách hàng theo doanh thu`
- Format each scenario as a 2-column Markdown table with exact row keys:
  ```markdown
  | Use case | <Tên tiếng Việt> (<English UC Name> 3\) |
  | :---- | ----- |
  | **Actor** | <Tên Actor> |
  | **Tiền điều kiện** | <Điều kiện đăng nhập> |
  | **Hậu điều kiện** | <Kết quả sau khi hoàn tất> |
  | **Kịch bản chính** | <Các bước tương tác kèm dữ liệu mẫu và bảng kết quả minh họa> |
  | **Ngoại lệ** | **4\.** <Mô tả nhánh ngoại lệ và câu thông báo của hệ thống> |
  ```

### 3.5 Section `2.2. Trích lớp thực thể`
Use the exact 5 bold-italic step headings (`#### ***Bước 1: ...***` through `#### ***Bước 5: ...***`) followed by `#### **Biểu đồ lớp thực thể pha phân tích**`:
- **Bước 1**: 1 cohesive paragraph describing the system.
- **Bước 2**: 3 bullets (`* **Các danh từ liên quan đến người**:`, `* **Các danh từ liên quan đến vật / cơ sở vật chất**:`, `* **Các danh từ liên quan đến thông tin**:`).
- **Bước 3**: Bullets classifying nouns using `\-\>` arrows:
  - `* **Các danh từ trừu tượng / loại bỏ**: ... \-\> *Loại bỏ*.`
  - `* **Danh từ chỉ người**:` (`... \-\> Lớp thực thể <ClassName>: attr1, attr2.`)
  - `* **Danh từ chỉ vật / cơ sở vật chất**:`
  - `* **Danh từ thông tin**:` (explicitly noting intermediate/split entities like `Genre`, `Actor`).
- **Bước 4**: Bullets explaining cardinalities (`1-1`, `1-n`, `n-n \-\> đề xuất lớp trung gian ...`).
- **Bước 5**: Concise relationship summary bullets (`A chứa B`, `A liên kết B tạo ra C duy nhất`, `A kế thừa bởi B`, `A \-\> AStats`).
- **Diagram**: `#### **Biểu đồ lớp thực thể pha phân tích**` + `| ![][image4] |`.

### 3.6 Section `2.3. Trích các lớp biên và điều khiển`
For each module (`#### 2.3.1` and `#### 2.3.2`):
- Use chronological bullets tracing each UI step to a proposed `*Screen` class and its UI components, interleaved with backend data-processing blocks:
  - Screen bullet pattern:
    ```markdown
    * Bước <k>, giao diện <mô tả> \-\> đề xuất lớp <ScreenName>, cần các thành phần:
      * <Tên thành phần>: <input / output / kiểu submit>
    ```
  - System processing bullet pattern:
    ```markdown
    * Để có <dữ liệu> hiện lên ở bước <k>, cần xử lí dưới hệ thống:
      * <Mô tả xử lý>
      * input: <tham số đầu vào>
      * output: <kết quả đầu ra>
      * đề xuất phương thức <methodName>(), gán cho lớp <EntityClass>
    ```
- End each subsection with the single-cell diagram table `| ![][imageN] |`.

### 3.7 Section `2.4. Phân tích hoạt động`
For each module (`#### 2.4.1` and `#### 2.4.2`):
1. **State Diagram Section**:
   - Line: `Biểu đồ trạng thái mô tả hoạt động của module`
   - Bullet list of transitions: `* Từ giao diện <A>, nếu <điều kiện> thì chuyển sang giao diện <B>`
   - Single-cell image table: `| ![][imageN] |`
2. **Scenario v2 Section**:
   - Line: `Kịch bản v.2 cho module <tên module>`
   - Numbered list (`1.` to `N.`) using concise object-call sentences:
     - `Tại giao diện chính của <actor>, sau khi đăng nhập, <actor> chọn chức năng ...`
     - `Lớp <ScreenA> gọi lớp <ScreenB>`
     - `Lớp <ScreenB> hiển thị`
     - `Lớp <ScreenB> gọi lớp <Entity>, yêu cầu ...`
     - `Lớp <Entity> tìm kiếm/lấy thông tin`
     - `Lớp <Entity> trả về kết quả cho <ScreenB>`
3. **Communication / Interaction Diagram Section**:
   - Label + single-cell image table `| ![][imageN] |`.

### 3.8 Section `3. Thiết kế`
- **`3.1. Thiết kế lớp thực thể`**:
  - Heading + explanation/step notes (if applicable) + `| ![][image11] |`.
- **`3.2. Thiết kế cơ sở dữ liệu`**:
  - Heading + explanation/table notes (if applicable) + `| ![][image12] |`.
- **`3.3.1. Thiết kế tĩnh` (`##### a.` & `##### b.`)**:
  1. `* Giao diện`:
     - Single-column Markdown table where each row `(1)`, `(2)`, `(3)` represents a screen mockup in text form (showing `Before searching:` / `After searching:` or filter/result states, bold headers/buttons, and sample rows).
  2. `* Sơ đồ lớp`:
     - Sub-bullets:
       - `* Các lớp giao diện có các trang jsp: <Screen1>, <Screen2>, ...`
       - `* Các lớp tầng truy cập dữ liệu: <DAO1>, <DAO2>, ...`
     - Single-cell image table `| ![][imageN] |`.
- **`3.3.2. Thiết kế hoạt động` (`##### a.` & `##### b.`)**:
  1. `Biểu đồ hoạt động:` + optional 1-sentence description + `| ![][imageN] |`.
  2. `Biểu đồ tuần tự v3:`:
     - Numbered list (`1.` to `N.`) explicitly naming `.jsp` pages, `DAO` classes, typed method calls, and `Entity3` constructor packaging steps:
       - `Trang <A>.jsp gọi trang <B>.jsp.`
       - `Trang <B>.jsp gọi lớp <DAO> yêu cầu ...`
       - `Lớp <DAO> gọi hàm <method>(<params>).`
       - `Hàm <method>(<params>) gọi lớp <Entity3> để đóng gói thông tin ...`
       - `Lớp <Entity3> gọi hàm khởi tạo <Entity3>() \[dong goi\] để đóng gói thông tin ...`
       - `Lớp <Entity3> trả kết quả đối tượng <Entity3> đã đóng gói về cho hàm <method>(...).`
       - `Hàm <method>(...) trả kết quả danh sách mảng đối tượng <Entity3>\[\] cho trang <B>.jsp.`
     - Single-cell image table `| ![][imageN] |`.
- **`3.3.3. Thiết kế triển khai`**:
  - Package diagram (`Biểu đồ gói`) and Deployment diagram (`Biểu đồ triển khai`) following the same label + single-cell image table (`| ![][imageN] |`) convention.
