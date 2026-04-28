vertical: construction
default_applied: true
written_by: orchestrator
written_at: 2026-04-28
rationale: |
  Per AUDIT_2026-04-28.md §3.2 (default wedge) and §0 spec — when WU-VERTICAL-01
  is unfulfilled by Justin at the time downstream WUs need to dispatch, the
  orchestrator writes `construction` as the default. Construction (general
  contractors + subs in Clark County, WA) is the §3.2-recommended default wedge
  because: (a) jobsite-Wi-Fi + Procore + Sage are the canonical pain stack;
  (b) ransomware risk is concrete and recent in PNW construction; (c) office
  managers are reachable via direct outreach; (d) no HIPAA gate (vs. dental).
  Justin can override at any time by editing this file — downstream WUs already
  merged are reverted via standard PR workflow.

prospects:
  - "[REPLACE] Local Vancouver-area GC #1 (10–25 employees) — name TBD by Justin"
  - "[REPLACE] Local Vancouver-area GC #2 (10–25 employees) — name TBD by Justin"
  - "[REPLACE] Local Vancouver-area GC #3 (10–25 employees) — name TBD by Justin"

note: |
  The 3 named local prospects above are placeholders — the spec requires
  ≥3 named prospects. Justin should replace these with real Clark County
  GC names (or override the vertical) before WU-OUTBOUND-02 dispatches,
  since that WU depends on this list.
