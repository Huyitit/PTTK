---
name: diagram-workflow
description: >-
  Use this skill whenever generating, updating, importing, or syncing UML and Database diagrams
  (via PlantUML or Visual Paradigm) and embedding them into final-document/17D23DCCE043.md.
---

# Diagram Generation & Sync Workflow (`diagram-workflow`)

This skill defines how the Agent generates diagram source files for **PlantUML** and **Visual Paradigm**, how exported diagram images are stored in [project-diagram/](../../../project-diagram), and how they are synced into [17D23DCCE043.md](../../../final-document/17D23DCCE043.md).

---

## 1. Directory Structure in `project-diagram/`

```text
project-diagram/
├── puml/                  # PlantUML source files (image1.puml .. image20.puml)
├── vp-import/
│   ├── xmi/               # Standard UML 2.x XMI files for Visual Paradigm import (e.g., image1.xmi .. image3.xmi)
│   ├── sql/               # SQL DDL scripts for Visual Paradigm DB Reverse (e.g., image12-schema.sql)
│   ├── java/              # Java skeleton classes per diagram for VP Instant Reverse (e.g., image11/)
│   └── specs/             # Step-by-step VP quick-editor tables / layout blueprints
├── exported/              # Rendered/exported diagram images (image1.png .. image20.png)
└── sync_diagrams.py       # Script to extract, inspect, and sync exported images into 17D23DCCE043.md
```

---

## 2. Diagram Slot Mapping (`image1` – `image20`)

| Slot | Section | Diagram Type | Recommended Tool & Agent Output |
| :--- | :--- | :--- | :--- |
| `image1` | `1.3.1` | General Use Case Diagram | PlantUML (`puml/image1.puml`) + VP XMI (`vp-import/xmi/image1.xmi`) / VP |
| `image2` | `1.3.2` | Detailed Use Case — Search Movie Info | PlantUML (`puml/image2.puml`) + VP XMI (`vp-import/xmi/image2.xmi`) / VP |
| `image3` | `1.3.3` | Detailed Use Case — View Customer Statistics | PlantUML (`puml/image3.puml`) + VP XMI (`vp-import/xmi/image3.xmi`) / VP |
| `image4` | `2.2` | General Analysis Entity Class Diagram | PlantUML (`puml/image4.puml`) + VP Java (`vp-import/java/image4/`) |
| `image5` | `2.3.1` | Module Analysis Class Diagram — Module 1 | PlantUML (`puml/image5.puml`) + VP Java (`vp-import/java/image5/`) |
| `image6` | `2.3.2` | Module Analysis Class Diagram — Module 2 | PlantUML (`puml/image6.puml`) + VP Java (`vp-import/java/image6/`) |
| `image7` | `2.4.1` | State Diagram — Module 1 | PlantUML (`puml/image7.puml`) |
| `image8` | `2.4.1` | Communication Diagram — Module 1 | PlantUML (`puml/image8.puml`) + VP Spec (`vp-import/specs/image8.md`) |
| `image9` | `2.4.2` | State Diagram — Module 2 | PlantUML (`puml/image9.puml`) |
| `image10` | `2.4.2` | Communication Diagram — Module 2 | PlantUML (`puml/image10.puml`) + VP Spec (`vp-import/specs/image10.md`) |
| `image11` | `3.1` | General Design Entity Class Diagram | PlantUML (`puml/image11.puml`) + VP Java (`vp-import/java/image11/`) |
| `image12` | `3.2` | Relational Database Schema Diagram | VP SQL DDL (`vp-import/sql/image12-schema.sql`) + PlantUML (`puml/image12.puml`) |
| `image13` | `3.3.1.a` | Module Static Design Class Diagram — Module 1 | PlantUML (`puml/image13.puml`) + VP Java (`vp-import/java/image13/`) |
| `image14` | `3.3.1.b` | Module Static Design Class Diagram — Module 2 | PlantUML (`puml/image14.puml`) + VP Java (`vp-import/java/image14/`) |
| `image15` | `3.3.2.a` | Activity Diagram (Swimlanes) — Module 1 | PlantUML (`puml/image15.puml`) |
| `image16` | `3.3.2.a` | Sequence Diagram v3 — Module 1 | PlantUML (`puml/image16.puml`) |
| `image17` | `3.3.2.b` | Activity Diagram (Swimlanes) — Module 2 | PlantUML (`puml/image17.puml`) |
| `image18` | `3.3.2.b` | Sequence Diagram v3 — Module 2 | PlantUML (`puml/image18.puml`) |
| `image19` | `3.3.3` | Package Diagram | PlantUML (`puml/image19.puml`) |
| `image20` | `3.3.3` | Deployment Diagram | PlantUML (`puml/image20.puml`) |

---

## 3. Agent Rules for Generating Diagram Source Files

### 3.1 PlantUML (`.puml`) Generation Rules
Whenever a diagram is planned or modified, write a complete, self-contained `.puml` file to `project-diagram/puml/imageN.puml`:
- Include `skinparam classAttributeIconSize 0` on all Class Diagrams so visibility symbols (`-`, `+`, `#`) are rendered explicitly.
- Keep styling clean and readable (high contrast, explicit multiplicities `"1"`, `"*"`, `"0..1"`, and stereotypes `<<include>>`, `<<extend>>`).
- Ensure 100% of class names, attribute names, method signatures, and numbered messages (`1:`, `2:`, ...) match the corresponding Markdown section in `17D23DCCE043.md`.
- **Module Static Design Class Diagrams (`image13`, `image14`) Standard**:
  - View classes (JSP) use alias and solid association lines (`--`) for inter-screen navigation and for JSP $\leftrightarrow$ DAO links (no constructors).
  - Module DAO inherits `DAO3` (`DAO3 <|-- ...DAO3`) and connects to the primary module entity via solid line (`MovieDAO3 -- Movie3`, `CustomerStatDAO3 -- CustomerStats3`, `InvoiceDAO3 -- Invoice3`).
  - **MANDATORY**: Embed the **entire system Design Entity model from Section 3.1 (`image11`)** underneath the DAO, maintaining all 20 classes and relationships (`<|--`, `*--`, `o--`), exactly as established in `image11.puml`.

### 3.2 Visual Paradigm (`vp-import/`) Generation Rules
When the user prefers drawing or refining a diagram in **Visual Paradigm**:
1. **Database ERD (`image12`)**:
   - Generate a standard MySQL DDL file at `project-diagram/vp-import/sql/image12-schema.sql` containing `CREATE TABLE tbl...`, `PRIMARY KEY`, and `FOREIGN KEY` constraints so the user can import via **Visual Paradigm $\to$ Tools $\to$ DB $\to$ Reverse DDL...**.
2. **Class Diagrams (`image4`, `image5`, `image6`, `image11`, `image13`, `image14`)**:
   - In addition to `.puml`, optionally generate Java skeleton files in `project-diagram/vp-import/java/imageN/` so the user can import via **Visual Paradigm $\to$ Tools $\to$ Code $\to$ Instant Reverse...**.
3. **Communication / Sequence Diagrams**:
   - Provide the `.puml` file plus a concise step table in `project-diagram/vp-import/specs/imageN.md` listing Lifelines/Objects, Links, and exact numbered messages (`1: method()`).
4. **Use Case Diagrams (`image1`, `image2`, `image3`)**:
   - **Định dạng Native XML**: Sinh file XML theo chuẩn của Visual Paradigm tại `project-diagram/vp-import/xml/imageN.xml` chứa sẵn cả Model Elements lẫn Layout tọa độ hình vẽ (import qua **Project $\to$ Export / Import $\to$ XML...**).
   - **Định dạng chuẩn XMI**: Sinh file OMG UML 2.x XMI tại `project-diagram/vp-import/xmi/imageN.xmi` chứa toàn bộ cấu trúc Actor, Use Case, Generalization, Association (import qua **Project $\to$ Export / Import $\to$ UML 2.x XMI...**).

---

## 4. Returning & Syncing Diagrams into `final-document/17D23DCCE043.md`

### Step 1: User Exports Diagram Image
After rendering in PlantUML or exporting from Visual Paradigm, save the image file into:
`project-diagram/exported/imageN.png` (or `imageN.jpg`)

### Step 2: Agent Syncs Image into `17D23DCCE043.md`
Run the sync script from the workspace root:
```bash
# Check status of all diagram slots
python3 project-diagram/sync_diagrams.py --status

# Sync specific updated diagram(s) into final-document/17D23DCCE043.md
python3 project-diagram/sync_diagrams.py --sync image12

# Or sync all images in project-diagram/exported/
python3 project-diagram/sync_diagrams.py --sync
```
- The script automatically base64-encodes `project-diagram/exported/imageN.png` and updates (or appends) `[imageN]: <data:image/png;base64,...>` at the bottom of [17D23DCCE043.md](../../../final-document/17D23DCCE043.md), while also copying the image to `final-document-html/images/`.
- In the Markdown body of `17D23DCCE043.md`, always reference the diagram using the single-cell table format:
  ```markdown
  | ![][imageN] |
  | :---- |
  ```
