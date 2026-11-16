---
name: phase-review-workflow
description: >-
  Use this skill to drive the agent's 6-step execution workflow in every working phase of reviewing, designing, or completing the Software Assurance project document (Requirements Gathering, Requirements Analysis, System Design, Implementation/SQA). Always activate this skill before starting or transitioning to any phase or section task.
---

# Phase-Driven Review & Design Workflow (`phase-review-workflow`)

This skill defines the mandatory **6-step workflow** that the Agent must follow in every working phase when reviewing, designing, or updating the Software Assurance final document.

---

## Workflow Overview

```
[Step 1: Context Analysis]
       ↓
[Step 2: Impact & Task Planning]
       ↓
[Step 3: User Plan Review Gate] ──(Feedback)──┐
       ↓ (Approved)                           │
[Step 4: Step-by-Step Implementation] <───────┘
       ↓
[Step 5: Post-Implementation SQA Review]
       ↓
[Step 6: Rule Persistence / State Update]
```

---

## Step 1: Analyze Problems / Task with Context

Before proposing changes or writing content for the current phase $k$, gather and cross-check all authoritative context sources:

1. **Project Rules (`.agents/rules/`)**:
   - Read [business-rules.md](../../rules/business-rules.md) to verify actor permissions, cinema domain workflows, entity relationships, and Subject No. 17 module specifications.
   - Read [design-methodology-rules.md](../../rules/design-methodology-rules.md) to verify the required textbook sub-steps (`Bước 1`, `Bước 2`, ...), UML conventions, and SQA constraints for phase $k$.
   - Read [implementation-methodology-rules.md](../../rules/implementation-methodology-rules.md) (and use the `implementation-workflow` and `unit-test-workflow` skills) for Phase 4 to verify Eclipse dynamic web project scaffolding, POJO/DAO/JSP coding, MySQL Stored Procedures, and JUnit 4 unit testing with rollback constraints.
   - Read [final-document-format-rules.md](../../rules/final-document-format-rules.md) (and use the `write-final-document` skill) to preserve the exact Markdown layout, heading `{#anchor}` convention, table schemas, prose patterns, and `[imageN]` diagram embedding format of [17D23DCCE043.md](../../../final-document/17D23DCCE043.md).
2. **Primary Reference Sources**:
   - Cross-reference [DESCRIPTION.md](../../../Topic-description/DESCRIPTION.md) for domain ground truth.
   - Cross-reference [BG HP TTTN 2 CNPM 2020 final.pdf](../../../case-study/BG%20HP%20TTTN%202%20CNPM%202020%20final.pdf) when deeper examples or formatting conventions are needed for phase $k$.
3. **Completed Previous Phase Outputs ($1 \dots k-1$) & Downstream Untrusted Principle**:
   - Inspect the already-verified sections of the final document from phase $k-1$ (and earlier completed sections).
   - Treat the verified output of upstream sections as the **immutable input contract** for phase $k$ (e.g., canonical English terms and definitions from Section 1.1 Glossary).
   - **CRITICAL RESTRICTION (Downstream Untrusted Principle)**: Downstream sections ($k+1 \dots$) of the final document are unverified, untrusted drafts that may contain serious errors and will be revised in later phases. The Agent **MUST NOT** cite, inspect, or use downstream sections (e.g., Use cases, Scenarios, Class diagrams, Sequence diagrams, Database design) as evidence, justification, or ground truth for the current phase/section $k$.
4. **Current Draft Gap Analysis**:
   - Compare the current draft of phase $k$ in [17D23DCCE043.md](../../../final-document/17D23DCCE043.md) (both Markdown text/tables and embedded diagrams) against the rules and upstream phase $k-1$ outputs.
   - List every defect, missing step, naming mismatch, relationship inconsistency, or diagram error found.

---

## Step 2: Plan Based on Analysis

Based on the findings from Step 1, produce a structured **Phase Action Plan** containing:

1. **Affected System Design Components**:
   - Explicitly identify which artifacts are impacted in the current phase, downstream phases, **and upstream phases**:
     - *Text / Analytical Steps*: Which `Bước 1..N` descriptions or tables are affected.
     - *Domain / Model Components*: Which Actors, Use Cases, Boundary/View classes, Control/DAO classes, Entity classes, or Database tables (`tbl...`) are added, renamed, or modified.
     - *UML Diagrams*: Which embedded diagrams (`[imageN]`) must be inspected, relabeled, or regenerated.
     - *Downstream Impact*: How changes in this phase affect subsequent phases ($k+1 \dots$).
     - *Retroactive Upstream Impact*: If design decisions, scoping constraints, or attribute reductions established in phase $k$ modify or invalidate elements in earlier sections ($1 \dots k-1$), identify every impacted upstream section (e.g. Section 1.1 Semantic Glossary, Section 1.2.3 Business Workflows) and plan necessary synchronization to prevent internal document contradictions.
2. **Expected Output Specification**:
   - Define the exact structure, headings, tables, class/method signatures, and diagrams that the completed phase $k$ section will have when finished.
3. **Detailed To-Do Task List**:
   - Break the work into atomic, ordered, verifiable tasks (`[ ] Task 1`, `[ ] Task 2`, ...), specifying target line numbers and exact modifications.

---

## Step 3: Ask Review for Plan (Mandatory Approval Gate)

1. Present the **Step 1 Analysis Summary** and **Step 2 Detailed Plan** clearly to the user (updating the plan artifact in the brain directory if appropriate).
2. Highlight any design choices or ambiguities that require user confirmation.
3. **STOP and wait for user approval** before modifying [17D23DCCE043.md](../../../final-document/17D23DCCE043.md). Do not execute Step 4 until the user approves or provides adjustments to the plan.

---

## Step 4: Implement Plan Step by Step

Once the user approves the plan:
1. Execute each task from the approved To-Do list sequentially (`Task 1` $\to$ `Task 2` $\to$ ...).
2. Ensure all Markdown tables, numbered steps (`Bước 1`, `Bước 2`, ...), mock UI wireframes, and UML diagrams strictly follow the planned specifications.
3. For any created or updated UML / Database diagram (`[imageN]`), use the `diagram-workflow` skill ([SKILL.md](../diagram-workflow/SKILL.md)) to write the PlantUML (`project-diagram/puml/imageN.puml`) and/or Visual Paradigm import files (`project-diagram/vp-import/`), and run `python3 project-diagram/sync_diagrams.py --sync` once exported images are placed in `project-diagram/exported/`.
4. Maintain clean formatting and preserve valid links/image references throughout [17D23DCCE043.md](../../../final-document/17D23DCCE043.md).

---

## Step 5: Review Implemented Output (Post-Implementation SQA Audit)

After completing the implementation of phase $k$, perform a rigorous self-audit before reporting completion:

1. **Rule Compliance Check**:
   - Does the implemented section satisfy every requirement in [business-rules.md](../../rules/business-rules.md), [design-methodology-rules.md](../../rules/design-methodology-rules.md), and [final-document-format-rules.md](../../rules/final-document-format-rules.md)?
2. **Cross-Phase Traceability Check (Phase $k-1 \leftrightarrow$ Phase $k$)**:
   - Are 100% of actor names, use case names, screen/boundary names, entity class names, attributes, relationships, and method signatures consistent with phase $k-1$?
   - Are there any orphan classes, unresolved `n-n` relationships, or unnumbered scenario/diagram steps?
3. **Analysis & Plan Fulfillment Check**:
   - Has every gap identified in Step 1 and every task in Step 2 been completely resolved?
   - If any discrepancy remains, fix it immediately before moving to Step 6.

---

## Step 6: Update Rules with Verified Phase Information (or Skip)

Once Step 5 passes:
1. **Evaluate Rule Persistence Needs**:
   - Determine whether the newly completed phase $k$ established canonical design contracts that must be locked into `.agents/rules/` so future phases ($k+1 \dots$) cannot drift. Examples:
     - After **Phase 1**: Lock in the canonical Glossary English names, Actor names, and sub-Use Case screen breakdowns.
     - After **Phase 2**: Lock in the canonical Analysis Entity class list, attribute lists, Boundary class names (`in`/`out`/`sub` attributes), and assigned Entity method signatures.
     - After **Phase 3.1–3.2**: Lock in the exact Design Entity types and physical `tbl...` Database Schema columns/FKs.
2. **Update or Skip**:
   - **If needed**: Update [business-rules.md](../../rules/business-rules.md) or [design-methodology-rules.md](../../rules/design-methodology-rules.md) (or a canonical traceability section within them) with the verified phase $k$ artifacts.
   - **If not needed**: Explicitly state that no rule update is required and proceed to ask the user to transition to phase $k+1$.
