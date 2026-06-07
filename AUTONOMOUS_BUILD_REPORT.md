# Sarf Autonomous Build Experiment

**Date:** June 7, 2026
**Classification:** Internal Engineering Document

---

## Executive Summary

This document records a controlled experiment in autonomous software development: building a production-grade Flutter application — **Sarf**, a local-first subscription tracker — using AI agents as the primary development and quality assurance actors.

The experiment used **Cursor** as the autonomous builder and **Claude Code** as the independent auditor. The workflow proceeded through two full audit cycles before reaching a verified pass. All critical and high-priority issues identified during audit were resolved. The final build passed static analysis, the full test suite, and an independent code-level verification with zero outstanding blockers.

**Outcome: PASS**

---

## Project Context

**Sarf** (صرف) is a personal finance application focused on subscription and recurring commitment tracking. The name is Arabic for "spending."

### Product Philosophy

| Principle | Meaning |
|-----------|---------|
| **Local First** | All data lives on the user's device. No cloud sync, no backend. |
| **Offline First** | The application is fully functional without a network connection. |
| **Privacy First** | No data leaves the device. No analytics, no telemetry. |
| **Arabic First** | RTL layout and Arabic localization are first-class, not an afterthought. |
| **Minimal & Calm UX** | Material Design 3, a single seed color, no visual noise. |

### Technical Stack

- **Frontend:** Flutter (Dart 3.12+)
- **State Management:** Riverpod 2.x
- **Routing:** GoRouter
- **Database:** Drift ORM + SQLite (schema v3)
- **Notifications:** flutter\_local\_notifications + timezone
- **Localization:** ARB-based, English + Arabic

---

## Experiment Objective

The experiment was designed to answer a specific question:

> *Can AI agents autonomously build a real Flutter application that meets a written specification — and can a separate AI agent independently verify that it does?*

More specifically, the experiment measured AI capability across four dimensions:

1. **Build fidelity** — Does the generated code match the specification?
2. **Architectural soundness** — Is the code maintainable and correctly layered?
3. **Self-correction under audit** — Can the builder fix issues identified by an independent reviewer?
4. **Audit integrity** — Can a separate AI agent catch what the builder missed without access to the builder's reasoning?

---

## Autonomous Development Workflow

The experiment followed a six-stage pipeline:

```
Build → Audit → Fix → Re-Audit → Surgical Fix → Final Verification
```

### Stage 1: Build
Cursor autonomously generated the full application from a written specification. This included database schema, repositories, Riverpod providers, feature screens, localization files, notification service, and a test suite.

### Stage 2: Audit
Claude Code performed a read-only audit of the entire codebase. No claims from the builder were trusted. Every assertion was verified against the actual source files. The audit produced a scored report with Critical, High, Medium, and Low priority findings.

### Stage 3: Fix
Cursor addressed all Critical and High priority findings from the audit report, producing a revised build.

### Stage 4: Re-Audit
Claude Code performed a second full audit of the revised codebase, verifying each fix independently and identifying any new issues introduced during the fix cycle.

### Stage 5: Surgical Fix
One new critical issue was identified in the re-audit: the Weekly Digest notification used `matchDateTimeComponents` for recurring scheduling — a technique explicitly prohibited by the specification. Cursor removed this and replaced the implementation with one-shot scheduling.

### Stage 6: Final Verification
Claude Code performed a targeted two-point verification: (1) confirming `matchDateTimeComponents` was absent from all production code, and (2) confirming Weekly Digest was implemented as a true one-shot notification. Both checks passed.

---

## Tools Used

### Builder — Cursor

Cursor acted as the autonomous development agent throughout the experiment. Its responsibilities included:

- Generating the initial project structure from specification
- Implementing all features across the full stack (database, state, UI, notifications, localization)
- Executing the fix cycle against audit findings
- Performing the surgical correction in Stage 5

### Independent Auditor — Claude Code

Claude Code acted as the independent quality gate. Its responsibilities included:

- Reading source files directly — not relying on summaries, READMEs, or commit messages
- Verifying specification compliance claim by claim
- Scoring the build across six dimensions (overall, release readiness, architecture, code quality, testing, security)
- Performing the re-audit after fixes and the final targeted verification

The auditor operated under an explicit constraint: **trust nothing, verify everything from the code.**

---

## Major Findings During Audit

The initial audit (Stage 2) identified the following Critical and High priority issues:

| Finding | Detail |
|---------|--------|
| **Template count** | 15 templates present; specification required 115 |
| **Category schema mismatch** | Categories were `subscription/utility/rent/finance/other`; specification required `entertainment/work/education/telecom/utilities/storage/other` |
| **Missing Details Screen** | Tapping a commitment opened the edit form directly; no dedicated detail view existed |
| **Missing Top 3 Expensive** | `InsightsService` did not calculate or expose the three most expensive subscriptions |
| **Upcoming window incorrect** | Upcoming payments filtered to 30 days; specification required 7 days |
| **Trial Reminder absent** | `LocalNotificationService` had no `syncTrialReminder` implementation |
| **Weekly Digest absent** | No weekly summary notification of any kind |
| **`watchSettings` bug** | The stream returned hardcoded defaults regardless of database content |
| **Notification locale bug** | System locale preference fell through to English unconditionally |
| **Migration tests insufficient** | The migration test opened a fresh database; it did not simulate a real v1→v2 upgrade |
| **BOOT_COMPLETED unwired** | Permission declared in the manifest but no `BroadcastReceiver` registered |
| **Notification ID collision risk** | IDs derived from `hashCode % 100000` with meaningful collision probability |

---

## Fix Cycle

All twelve issues were addressed in Stage 3. The following summarizes what was verified in the code:

**115 Service Templates** — A new file (`template_seed_entries.dart`) was created containing exactly 115 entries across the seven required categories, verified by manual count: Entertainment (25), Work (15), Education (15), Telecom (20), Utilities (15), Storage (10), Other (15).

**Category Migration** — `CommitmentCategory` enum was updated to the seven new values. A schema v3 migration was added to `app_database.dart` running `UPDATE` statements to remap legacy category values in both the `commitments` and `service_templates` tables. `fromStorage()` also includes a normalization fallback for any edge case.

**Details Screen** — `CommitmentDetailScreen` was created as a standalone screen. The list now navigates to `/commitments/:id` on tap rather than opening the edit form directly.

**Top 3 Most Expensive** — `InsightsService.calculate()` now sorts active commitments by monthly equivalent and takes the top three. The result is exposed via `InsightsSummary.mostExpensive` and rendered in `InsightsScreen`.

**Upcoming 7 Days** — Filter threshold corrected from `<= 30` to `<= 7`. A dedicated test case (`upcoming window is 7 days`) was added to the insights test suite.

**Trial Reminder** — `syncTrialReminder()` implemented using `ensureFirstLaunchAt()` to anchor the trial period. Schedules a one-shot notification at 9:00 AM three days before the 14-day trial end.

**Weekly Digest** — `syncWeeklyDigest()` implemented as a one-shot notification scheduled for the next Monday at 9:00 AM, without `matchDateTimeComponents`.

**BOOT_COMPLETED Rescheduling** — `ScheduledNotificationBootReceiver` from `flutter_local_notifications` registered in `AndroidManifest.xml`, wiring the existing permission to actual rescheduling behavior.

**Stable Notification IDs** — `notification_ids.dart` introduced using FNV-1a hashing over a range of 800,000, replacing the `hashCode % 100000` approach.

**Migration Tests** — `migration_test.dart` rewritten to construct a v1 schema using raw SQLite, insert a legacy row, set `PRAGMA user_version = 1`, then open the Drift database and verify both the schema upgrade and data preservation.

---

## Final Verification

| Check | Result |
|-------|--------|
| `flutter analyze` | PASS |
| `flutter test` | PASS |
| `matchDateTimeComponents` in production code | **Not found** (grep across all of `lib/`) |
| Weekly Digest implementation | **One-shot** — `zonedSchedule` without recurrence parameter |
| Git working tree | Clean |
| Release tag | `v1.0-autonomous-pass` |

---

## Lessons Learned

**1. AI agents are highly capable builders.**
The initial autonomous build produced a working, architecturally sound Flutter application with correct Riverpod wiring, Drift migrations, GoRouter configuration, and localization — with no human intervention. The quality of the generated code was sufficient to serve as a real foundation.

**2. Specification fidelity requires an independent check.**
The builder passed its own internal consistency checks but missed twelve specification requirements. Many of these were not bugs — they were correct code that did not match the spec. A builder cannot audit itself against requirements it has already internalized.

**3. The audit must read code, not documentation.**
Both audit cycles operated exclusively from source files. This discipline caught the `watchSettings` bug (a method that appeared correct but returned hardcoded defaults), the miscounted template list, and the `matchDateTimeComponents` violation — none of which would have been caught from README or commit message review.

**4. Build alone is not a release gate.**
The build completing without errors is necessary but not sufficient. The audit cycle added the quality signal that the build phase cannot provide: specification alignment, behavioral correctness, and security posture.

**5. Audit gates compound in value.**
The re-audit caught one new issue introduced during the fix cycle (`matchDateTimeComponents`). This demonstrates that fixes themselves require verification — the correction loop must close with an independent check, not the author's own review.

---

## Final Assessment

| Category | Score |
|----------|-------|
| Autonomous Build | 9 / 10 |
| Architecture | 8 / 10 |
| Specification Compliance | 9 / 10 |
| Testing | 8 / 10 |
| Audit Process | 10 / 10 |

**Final Verdict: PASS**

---

## Future Recommendation

This repository constitutes a **Proof of Capability** for AI-assisted software development at production quality.

**As an architectural reference:** The codebase demonstrates a clean Flutter feature architecture with Riverpod, Drift, GoRouter, and local notifications — correctly layered, testable, and specification-compliant. It can serve as a reference implementation for future projects adopting the same stack.

**As a process template:** The Build → Audit → Fix → Verify pipeline is repeatable and tool-agnostic. Any sufficiently capable builder and any sufficiently rigorous auditor can execute this workflow. The key invariant is auditor independence: the auditor must have no access to the builder's reasoning and must derive all findings from the source alone.

**For future engagements:** Teams considering AI-assisted development should plan for at least one independent audit cycle as a non-negotiable gate before any release milestone. The cost of the audit is low relative to the risk it mitigates, and the findings from this experiment suggest that even high-quality autonomous builds will have specification gaps that only independent review can surface.
