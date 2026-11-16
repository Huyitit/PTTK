#!/usr/bin/env python3
"""
Sync diagram images between project-diagram/exported/ and final-document/17D23DCCE043.md.

Usage:
  python3 project-diagram/sync_diagrams.py --status
  python3 project-diagram/sync_diagrams.py --extract
  python3 project-diagram/sync_diagrams.py --sync [image1 image12 ...]
"""
#`python3 project-diagram/sync_diagrams.py --sync image1`
import argparse
import base64
import re
import shutil
from pathlib import Path

ROOT_DIR = Path(__file__).resolve().parent.parent
DIAGRAM_DIR = ROOT_DIR / "project-diagram"
PUML_DIR = DIAGRAM_DIR / "puml"
VP_SQL_DIR = DIAGRAM_DIR / "vp-import" / "sql"
VP_JAVA_DIR = DIAGRAM_DIR / "vp-import" / "java"
VP_SPEC_DIR = DIAGRAM_DIR / "vp-import" / "specs"
VP_XMI_DIR = DIAGRAM_DIR / "vp-import" / "xmi"
VP_XML_DIR = DIAGRAM_DIR / "vp-import" / "xml"
EXPORTED_DIR = DIAGRAM_DIR / "exported"

FINAL_DOC_PATH = ROOT_DIR / "final-document" / "17D23DCCE043.md"
HTML_IMAGES_DIR = ROOT_DIR / "final-document-html" / "images"

# Mapping of imageN slots to their section and diagram purpose in 17D23DCCE043.md
DIAGRAM_CATALOG = {
    "image1": ("1.3.1", "General Use Case Diagram"),
    "image2": ("1.3.2", "Detailed Use Case Diagram — Search Movie Info"),
    "image3": ("1.3.3", "Detailed Use Case Diagram — View Customer Statistics"),
    "image4": ("2.2", "General Analysis Entity Class Diagram"),
    "image5": ("2.3.1", "Module Analysis Class Diagram — Search Movie Info"),
    "image6": ("2.3.2", "Module Analysis Class Diagram — View Customer Statistics"),
    "image7": ("2.4.1", "State Diagram — Search Movie Info"),
    "image8": ("2.4.1", "Communication Diagram — Search Movie Info"),
    "image9": ("2.4.2", "State Diagram — View Customer Statistics"),
    "image10": ("2.4.2", "Communication Diagram — View Customer Statistics"),
    "image11": ("3.1", "General Design Entity Class Diagram"),
    "image12": ("3.2", "Relational Database Schema Diagram"),
    "image13": ("3.3.1.a", "Module Static Design Class Diagram — Search Movie Info"),
    "image14": ("3.3.1.b", "Module Static Design Class Diagram — View Customer Statistics"),
    "image15": ("3.3.2.a", "Activity Diagram — Search Movie Info"),
    "image16": ("3.3.2.a", "Sequence Diagram — Search Movie Info"),
    "image17": ("3.3.2.b", "Activity Diagram — View Customer Statistics"),
    "image18": ("3.3.2.b", "Sequence Diagram — View Customer Statistics"),
    "image19": ("3.3.3", "Package Diagram"),
    "image20": ("3.3.3", "Deployment Diagram"),
}

BASE64_LINE_RE = re.compile(
    r"^\[(image\d+)\]:\s*<data:(image/[a-zA-Z0-9.+-]+);base64,([A-Za-z0-9+/=\s]+)>\s*$"
)


def ensure_dirs() -> None:
    for d in (PUML_DIR, VP_SQL_DIR, VP_JAVA_DIR, VP_SPEC_DIR, VP_XMI_DIR, VP_XML_DIR, EXPORTED_DIR):
        d.mkdir(parents=True, exist_ok=True)


def mime_to_ext(mime: str) -> str:
    mime = mime.lower()
    if "png" in mime:
        return ".png"
    if "jpeg" in mime or "jpg" in mime:
        return ".jpg"
    if "svg" in mime:
        return ".svg"
    return ".png"


def ext_to_mime(ext: str) -> str:
    ext = ext.lower()
    if ext in (".jpg", ".jpeg"):
        return "image/jpeg"
    if ext == ".svg":
        return "image/svg+xml"
    return "image/png"


def find_exported_file(image_id: str) -> Path | None:
    """Find exported image file matching image_id (e.g. image1.png, image1.jpg)."""
    for ext in (".png", ".jpg", ".jpeg"):
        candidate = EXPORTED_DIR / f"{image_id}{ext}"
        if candidate.exists():
            return candidate
    return None


def extract_from_markdown() -> None:
    """Extract existing base64 [imageN] definitions from 17D23DCCE043.md into exported/."""
    ensure_dirs()
    lines = FINAL_DOC_PATH.read_text(encoding="utf-8").splitlines()
    extracted = 0
    for line in lines:
        m = BASE64_LINE_RE.match(line)
        if not m:
            continue
        image_id, mime, b64_data = m.group(1), m.group(2), m.group(3)
        ext = mime_to_ext(mime)
        raw_bytes = base64.b64decode(b64_data)
        out_path = EXPORTED_DIR / f"{image_id}{ext}"
        out_path.write_bytes(raw_bytes)
        extracted += 1
        print(f"Extracted {image_id} -> {out_path.relative_to(ROOT_DIR)} ({len(raw_bytes):,} bytes)")
    print(f"Done. Extracted {extracted} diagram(s) into {EXPORTED_DIR.relative_to(ROOT_DIR)}/")


def sync_to_markdown(target_ids: list[str] | None = None) -> None:
    """Encode image files in exported/ into base64 and update final-document/17D23DCCE043.md."""
    ensure_dirs()
    content = FINAL_DOC_PATH.read_text(encoding="utf-8")
    lines = content.splitlines()

    # Discover all imageN files in exported/
    available_files: dict[str, Path] = {}
    for file_path in sorted(EXPORTED_DIR.iterdir()):
        if file_path.is_file() and file_path.suffix.lower() in (".png", ".jpg", ".jpeg"):
            stem = file_path.stem  # e.g., image1
            if re.match(r"^image\d+$", stem):
                # Prefer .png if both .png and .jpg exist
                if stem not in available_files or file_path.suffix.lower() == ".png":
                    available_files[stem] = file_path

    if target_ids:
        selected_ids = [i for i in target_ids if i in available_files]
        missing = [i for i in target_ids if i not in available_files]
        for m_id in missing:
            print(f"WARNING: No file found in {EXPORTED_DIR.relative_to(ROOT_DIR)}/ for '{m_id}'")
    else:
        selected_ids = list(available_files.keys())

    updated_in_place = set()
    new_lines = []
    for line in lines:
        m = BASE64_LINE_RE.match(line)
        if m and m.group(1) in selected_ids:
            img_id = m.group(1)
            img_path = available_files[img_id]
            mime = ext_to_mime(img_path.suffix)
            b64_str = base64.b64encode(img_path.read_bytes()).decode("ascii")
            new_lines.append(f"[{img_id}]: <data:{mime};base64,{b64_str}>")
            updated_in_place.add(img_id)
            print(f"Updated [{img_id}] in {FINAL_DOC_PATH.name} from {img_path.relative_to(ROOT_DIR)}")
        else:
            new_lines.append(line)

    # Append any new imageN definitions that were not previously in the markdown file
    for img_id in sorted(selected_ids, key=lambda x: int(x.replace("image", ""))):
        if img_id not in updated_in_place:
            img_path = available_files[img_id]
            mime = ext_to_mime(img_path.suffix)
            b64_str = base64.b64encode(img_path.read_bytes()).decode("ascii")
            new_lines.append(f"[{img_id}]: <data:{mime};base64,{b64_str}>")
            print(f"Appended new [{img_id}] to {FINAL_DOC_PATH.name} from {img_path.relative_to(ROOT_DIR)}")

    FINAL_DOC_PATH.write_text("\n".join(new_lines) + "\n", encoding="utf-8")

    # Also mirror to final-document-html/images/ if that directory exists
    if HTML_IMAGES_DIR.exists():
        for img_id in selected_ids:
            src_path = available_files[img_id]
            dst_path = HTML_IMAGES_DIR / src_path.name
            shutil.copy2(src_path, dst_path)


def show_status() -> None:
    """Print status table of all diagram slots."""
    ensure_dirs()
    lines = FINAL_DOC_PATH.read_text(encoding="utf-8").splitlines()
    md_defined = set()
    for line in lines:
        m = BASE64_LINE_RE.match(line)
        if m:
            md_defined.add(m.group(1))

    print(f"{'Slot':<9} | {'Sec':<7} | {'Exported Image':<22} | {'In MD':<5} | {'Description'}")
    print("-" * 95)
    all_keys = sorted(
        set(DIAGRAM_CATALOG.keys()) | md_defined,
        key=lambda x: int(re.sub(r"\D", "", x) or 0),
    )
    for img_id in all_keys:
        sec, desc = DIAGRAM_CATALOG.get(img_id, ("?", "Custom Diagram"))
        exp_file = find_exported_file(img_id)
        exp_str = exp_file.name if exp_file else "MISSING"
        in_md_str = "YES" if img_id in md_defined else "NO"
        print(f"{img_id:<9} | {sec:<7} | {exp_str:<22} | {in_md_str:<5} | {desc}")


def main() -> None:
    parser = argparse.ArgumentParser(description="Manage & sync diagrams for final-document.")
    parser.add_argument("--status", action="store_true", help="Show status of all diagram slots")
    parser.add_argument("--extract", action="store_true", help="Extract base64 images from MD to exported/")
    parser.add_argument("--sync", nargs="*", metavar="IMAGE_ID", help="Sync exported/ images into MD base64")
    args = parser.parse_args()

    if args.extract:
        extract_from_markdown()
    elif args.sync is not None:
        sync_to_markdown(args.sync if len(args.sync) > 0 else None)
    else:
        show_status()


if __name__ == "__main__":
    main()
