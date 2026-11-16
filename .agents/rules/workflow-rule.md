---
description: Mandatory 6-step execution workflow for every working phase of the Software Assurance project. Always follow the phase-review-workflow skill.
---

# Mandatory Phase Execution Workflow Rule

In every working phase of reviewing, designing, or completing the project document, the Agent **MUST** activate and follow the [`phase-review-workflow`](../skills/phase-review-workflow/SKILL.md) skill strictly through these **6 sequential stages**:

1. **Analyze Problem / Task with Context**:
   - Inspect `.agents/rules/business-rules.md`, `.agents/rules/design-methodology-rules.md`, `.agents/rules/implementation-methodology-rules.md` (for Phase 4 Implementation & SQA), `Topic-description/DESCRIPTION.md`, `case-study/BG HP TTTN 2 CNPM 2020 final.pdf`, and any completed/verified sections of the final document from previous phases ($1 \dots k-1$).
   - For Phase 4 (Implementation & Unit Testing): Additionally activate and follow [`implementation-workflow`](../skills/implementation-workflow/SKILL.md) and [`unit-test-workflow`](../skills/unit-test-workflow/SKILL.md) to govern project scaffolding, POJO/DAO/JSP coding, and JUnit test automation in `cinema-management-system/`.
   - **CRITICAL RESTRICTION (Downstream Untrusted Principle)**: The Agent **MUST ONLY** rely on verified upstream sections ($1 \dots k-1$) and external authoritative sources. All downstream sections ($k+1 \dots$) in the target document are unverified, untrusted drafts that may contain errors and will be revised in later phases. The Agent **MUST NOT** cite, inspect, or use downstream sections (e.g., Use cases, Scenarios, Class diagrams, Sequence diagrams, Database design) as evidence, justification, or ground truth for the current phase/section $k$.
   - Identify all gaps, inconsistencies, and defects in the current phase draft.
2. **Plan Based on Analysis**:
   - Identify all **affected system design components** (text steps, tables, actors, use cases, boundary/control/entity classes, database tables, UML diagrams, downstream dependencies, **and retroactive upstream impacts on sections $1 \dots k-1$**) and define the **expected output**.
   - If a decision or scope adjustment in phase $k$ modifies or eliminates elements defined in earlier sections (e.g., attributes in Section 1.1 or workflows in Section 1.2.3), explicitly include tasks to synchronize those upstream sections.
   - Produce a **detailed To-Do task list** with concrete, verifiable steps.
3. **Ask Review for Plan (Approval Gate)**:
   - Present the analysis and detailed plan to the user and **wait for user review/approval** before executing changes on the final document.
4. **Implement Plan Step by Step**:
   - After user approval, execute the planned To-Do tasks step by step.
5. **Review Implemented Output**:
   - Audit the updated output against project rules (`business-rules.md`, `design-methodology-rules.md`, `implementation-methodology-rules.md`), completed upstream phases, and the initial analysis to verify 100% accuracy and consistency.
6. **Update Rules (If Needed) or Skip**:
   - If the review passes and canonical decisions from the completed phase (e.g., locked-in class names, attributes, screens, or method signatures) should be persisted for subsequent phases, update the rules in `.agents/rules/`; otherwise, explicitly skip and move to the next phase.
