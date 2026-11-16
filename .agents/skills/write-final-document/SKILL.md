---
name: write-final-document
description: >-
  Use this skill whenever writing, formatting, completing, or updating any section of
  final-document/17D23DCCE043.md so that the output strictly follows the exact structure,
  Vietnamese phrasing conventions, heading anchors, table layouts, and diagram embedding
  format of the current final-document.
---

# Write Final Document Skill (`write-final-document`)

Use this skill whenever drafting, editing, or completing content in [17D23DCCE043.md](../../../final-document/17D23DCCE043.md).

---

## 1. Mandatory Pre-Write Checklist

Before writing or editing any section in [17D23DCCE043.md](../../../final-document/17D23DCCE043.md):
1. Read [final-document-format-rules.md](../../rules/final-document-format-rules.md) to verify the exact heading level, `{#anchor}` format, table schema, bullet syntax, and numbering style for the target section.
2. Read [business-rules.md](../../rules/business-rules.md) and [design-methodology-rules.md](../../rules/design-methodology-rules.md) to ensure domain accuracy and cross-phase traceability.
3. Read the surrounding lines in [17D23DCCE043.md](../../../final-document/17D23DCCE043.md) (avoiding reading the base64 `[imageN]:` block at the bottom of the file unless inspecting or appending image references).

---

## 2. Structural & Formatting Rules to Enforce

### 2.1 Headings & Table of Contents
- Every heading must preserve the document's numbering, bold/italic styling, and `{#anchor-id}` suffix:
  - `# **I. Đề bài** {#i.-đề-bài}` / `# **II. Câu trả lời** {#ii.-câu-trả-lời}`
  - `1. ## **Thu thập yêu cầu** {#thu-thập-yêu-cầu}`
  - `   1. ### **Tìm hiểu lĩnh vực chuyên môn** {#tìm-hiểu-lĩnh-vực-chuyên-môn}`
  - `#### **1.2.1. Mục đích của hệ thống** {#1.2.1.-mục-đích-của-hệ-thống}`
  - `#### ***Bước 1: Mô tả hệ thống trong một đoạn văn*** {#bước-1:-mô-tả-hệ-thống-trong-một-đoạn-văn}`
  - `#### 2.3.1. Phân tích module tìm kiếm thông tin phim {#2.3.1.-phân-tích-module-tìm-kiếm-thông-tin-phim}`
  - `##### a. Thiết kế tĩnh module tìm kiếm thông tin phim {#a.-thiết-kế-tĩnh-module-tìm-kiếm-thông-tin-phim}`
- If adding or renaming any heading, update the `# **Mục lục** {#mục-lục}` block at lines 1–92 to match.

### 2.2 Tables & Wireframes
- **Section 1.1 Tables**:
  - `Bảng từ khóa:`: 3 columns (`| *Con người* | *Hoạt động của con người* | *Vật, đối tượng* |`).
  - `Bảng giải thích ngữ nghĩa:`: 4 columns (`| *TT* | *Tên tiếng Việt* | *Tên tiếng Anh* | *Giải thích* |`) with italic group header rows (`| *Nhóm các khái niệm liên quan đến ...* |  |  |  |`).
- **Section 1.3.1 Table**:
  - `Mô tả Use case:`: 3 columns (`| Tác nhân | Use Case | Mô tả |`).
- **Section 2.1 Scenario v1 Tables**:
  - 2-column table with rows: `Use case`, `**Actor**`, `**Tiền điều kiện**`, `**Hậu điều kiện**`, `**Kịch bản chính**`, `**Ngoại lệ**`.
- **Section 3.3.1 Text UI Wireframes (`* Giao diện`)**:
  - 1-column table where each row `(1)`, `(2)`, `(3)` depicts a screen state in compact inline text/table format.

### 2.3 Prose & Step Patterns
- **Section 1.2.3**: Use `→` arrows between workflow steps (`Quản lí chọn ... → Hệ thống hiện ... → ...`) and numbered bilingual field tags `(1)..(N)` for the target modules.
- **Section 2.2**: Keep the 5 bold-italic steps (`Bước 1`..`Bước 5`) using `\-\>` arrows for noun classification and cardinality resolution (`n-n \-\> đề xuất lớp trung gian ...`).
- **Section 2.3**: Alternate between screen component bullets (`* Bước k, giao diện ... \-\> đề xuất lớp ...Screen, cần các thành phần:`) and backend method derivation bullets (`* Để có ..., cần xử lí dưới hệ thống:` with `input:`, `output:`, `đề xuất phương thức ...(), gán cho lớp ...`).
- **Section 2.4 (`Kịch bản v.2`)**: Numbered list (`1..N`) of concise object interactions (`Lớp <ScreenA> gọi lớp <ScreenB>`, `Lớp <ScreenB> gọi lớp <Entity>, yêu cầu ...`, `Lớp <Entity> tìm kiếm thông tin`, `Lớp <Entity> trả về kết quả cho <ScreenB>`, `Lớp <ScreenB> hiển thị`).
- **Section 3.3.2 (`Biểu đồ tuần tự v3:`)**: Numbered list (`1..N`) tracing `.jsp` pages, `DAO` classes, typed DAO methods, and entity constructor packaging (`gọi hàm khởi tạo <Entity>3() \[dong goi\] để đóng gói thông tin ...`).

### 2.4 Diagram Embedding (`[imageN]`)
- Use the `diagram-workflow` skill ([SKILL.md](../diagram-workflow/SKILL.md)) to generate PlantUML (`.puml`) and Visual Paradigm (`vp-import/`) files in `project-diagram/` and to sync exported images from `project-diagram/exported/imageN.png` via `python3 project-diagram/sync_diagrams.py --sync`.
- Always wrap diagram references in a 1-column Markdown table:
  ```markdown
  | ![][imageN] |
  | :---- |
  ```
- Keep all `[imageN]: <data:image/png;base64,...>` definitions at the bottom of the file (after Section `3.3.3`).

---

## 3. Post-Write Verification
After editing [17D23DCCE043.md](../../../final-document/17D23DCCE043.md):
1. Verify that no heading anchors `{#...}` or Table of Contents links were broken.
2. Verify that all Markdown tables render cleanly without unescaped pipe characters or broken line wraps.
3. Verify that all `[imageN]` placeholders still match their reference definitions at the end of the file.
