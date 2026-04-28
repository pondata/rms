# WU-COPY-02 — Sitewide forbidden-phrase sweep report

**Date:** 2026-04-28
**Branch:** `swarm/wu-copy-02` (off `swarm/wu-vertical-01-default`)
**Owner:** A
**Replacement canonical phrase:** `30-day fixed-scope paid pilot · non-refundable onboarding · exit at day 30 with no renewal obligation`

---

## 1. Pre-edit grep (before snapshot)

Command (per spec):

```
grep -rEn '(money-back|satisfaction guarantee|risk-free|100% guarantee|60-day|60 day)' \
  --include="*.html" --include="*.md" /Users/ltlai/rms \
  | grep -v '/AUDIT' | grep -v '/PLAN.md' | grep -v '/.swarm/' | grep -v '/CLAUDE.md'
```

Raw hits:

```
/Users/ltlai/rms/industries/events-festivals.html:138:    <p>We require advance notice — typically 60 days minimum, ideally 90 — because hardware needs to be sourced, networks need to be designed and tested in your venue, and your registration platform needs to be configured before your marketing fires. Last-minute event tech is how things go wrong.</p>
/Users/ltlai/rms/tools/it-health-check.html:343:      summary.textContent = "Your IT setup has serious vulnerabilities. The good news: most of these are fixable in 30–60 days with the right plan.";
/Users/ltlai/rms/blog/event-tech-checklist.html:85:  <p>Cover sheet to use 60 days, 30 days, 7 days, and event day. Print it. Hand it to your tech lead. Don't try to remember any of this in your head.</p>
/Users/ltlai/rms/blog/event-tech-checklist.html:87:  <h2>60 days out: Strategy &amp; sourcing</h2>
```

Hits for `money-back`, `satisfaction guarantee`, `risk-free`, `100% guarantee`: **0** (zero).

Broad sanity grep for the bare token `guarantee` across `*.html` / `*.md` (excluding docs): **0 hits.**

---

## 2. Per-hit context judgement (60-day / 60 day rule)

Spec rule: replace `60-day` / `60 day` ONLY when in a guarantee context. Other usage (notice periods, prep timelines, MSA terms, fix windows) is fine — leave alone.

| File | Line | Phrase | Context | Decision |
|------|------|--------|---------|----------|
| `industries/events-festivals.html` | 138 | "60 days minimum" | Advance-notice lead time for event onboarding (sourcing hardware, testing networks). NOT a guarantee. | LEAVE |
| `tools/it-health-check.html` | 343 | "30–60 days" | Time-to-fix estimate for IT vulnerabilities surfaced by the health-check tool. NOT a guarantee. | LEAVE |
| `blog/event-tech-checklist.html` | 85 | "60 days, 30 days, 7 days, and event day" | Cover-sheet checklist cadence for event prep. NOT a guarantee. | LEAVE |
| `blog/event-tech-checklist.html` | 87 | "60 days out: Strategy & sourcing" | Section heading for event-prep timeline. NOT a guarantee. | LEAVE |

No guarantee-context occurrences exist. **No replacements were performed.**

---

## 3. Diff summary (file:line — before → after)

| File | Line | Before | After |
|------|------|--------|-------|
| — | — | (no edits) | (no edits) |

Net change: 0 files, 0 lines.

---

## 4. Post-edit grep (acceptance test)

Strict acceptance command:

```
grep -rEn '(money-back|satisfaction guarantee|risk-free|100% guarantee)' \
  --include="*.html" --include="*.md" . \
  | grep -v '^./AUDIT' | grep -v '^./PLAN.md' | grep -v '^./.swarm/'
```

Result: **empty** (passes).

Extended grep (incl. `60-day` / `60 day`) returns the same 4 non-guarantee-context lines documented above, which the spec explicitly permits.

---

## 5. Why the site was already clean

`AUDIT_2026-04-28.md` §3.2 records that the 60-day money-back guarantee was removed during the v2 post-adversarial-review rewrite. The site copy was rebuilt under the 30-day-paid-pilot framing from the start; no money-back / satisfaction-guarantee / risk-free / 100%-guarantee strings ever shipped to `*.html`. WU-COPY-02 confirms the absence and locks in the grep gate that WU-INFRA-02 will enforce on deploy.

---

## 6. Files claimed in `.swarm/claims.jsonl`

None — no HTML files were edited. Per §0.6, claims are appended only when a file is touched. A meta claim/release pair is recorded for log-trail.
