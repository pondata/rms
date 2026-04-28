# WU-FAQ-SLA-01 — Sitewide SLA-leak cleanup report

**Date:** 2026-04-28
**Branch:** `swarm/wu-faq-sla-01` (off `swarm/wu-vertical-01-default`)
**Reason:** `.swarm/phone-routing-live.md` does NOT exist → WU-PHONE-01 incomplete → 15-min SLA claims must NOT appear on the site. Replaced with fallback **"Same-day response, business hours."**

## Before snapshot (leak grep)

Pattern: `15[-\s]?min(ute)?s?\s+(first\s+)?response|15[-\s]?min(ute)?s?\s+SLA|15[-\s]?min(ute)?s?\s+first` against `--include="*.html"` under `/Users/ltlai/rms`.

```
/Users/ltlai/rms/pricing.html:385:          <li>Sub-15-min response on critical issues</li>
```

Broader sweep (any `15-min` mention) also surfaced indirect SLA-shaped claims that the strict regex missed but the spec covers ("under 15 minutes", "&lt;15 min critical", "under-15-minute average response"):

```
/Users/ltlai/rms/index.html:152          [JSON-LD]   "...response time is under 15 minutes for critical issues..."
/Users/ltlai/rms/index.html:1012         [FAQ body]  "Our average response time is under 15 minutes for critical issues..."
/Users/ltlai/rms/services/it-operations.html:91   [JSON-LD]   "...under 15 minutes during business hours..."
/Users/ltlai/rms/services/it-operations.html:329  [compare]   "&lt;15 min critical"
/Users/ltlai/rms/services/it-operations.html:422  [FAQ body]  "...under 15 minutes during business hours..."
/Users/ltlai/rms/services/managed-it.html:242     [list]      "...under-15-minute average response"
```

## Edits (file:line — before → after)

### 1. `/Users/ltlai/rms/index.html:152` — FAQ JSON-LD `acceptedAnswer.text`
- **Before:** `"text": "Our average response time is under 15 minutes for critical issues. We provide 24/7 monitoring and tiered response times based on severity — critical outages get immediate attention, while routine requests are handled within a few hours."`
- **After:** `"text": "Same-day response, business hours. We provide 24/7 monitoring and tiered response times based on severity — critical outages get immediate attention, while routine requests are handled within a few hours."`

### 2. `/Users/ltlai/rms/index.html:1012` — FAQ body `<p>`
- **Before:** `<p>Our average response time is under 15 minutes for critical issues. We provide 24/7 monitoring and tiered response times based on severity — critical outages get immediate attention, while routine requests are handled within a few hours.</p>`
- **After:** `<p>Same-day response, business hours. We provide 24/7 monitoring and tiered response times based on severity — critical outages get immediate attention, while routine requests are handled within a few hours.</p>`

### 3. `/Users/ltlai/rms/pricing.html:385` — Operations tier feature list
- **Before:** `<li>Sub-15-min response on critical issues</li>`
- **After:** `<li>Same-day response, business hours</li>`

### 4. `/Users/ltlai/rms/services/it-operations.html:91` — FAQ JSON-LD `acceptedAnswer.text`
- **Before:** `"acceptedAnswer": {"@type": "Answer", "text": "Critical issues (server down, ransomware, can't work): under 15 minutes during business hours. Standard requests: within 2 hours. Tier 3 plans include 24/7 critical response with after-hours pager."}`
- **After:** `"acceptedAnswer": {"@type": "Answer", "text": "Same-day response, business hours. Standard requests: within 2 hours. Tier 3 plans include 24/7 critical response with after-hours pager."}`

### 5. `/Users/ltlai/rms/services/it-operations.html:329` — break-fix vs managed compare row
- **Before:** `<div ... class="compare-yes">&lt;15 min critical</div>`
- **After:** `<div ... class="compare-yes">Same-day, business hours</div>`

### 6. `/Users/ltlai/rms/services/it-operations.html:422` — FAQ body `<p>`
- **Before:** `<p>Critical issues (server down, ransomware, can't work): under 15 minutes during business hours. Standard requests: within 2 hours. Tier 3 plans include 24/7 critical response with after-hours pager.</p>`
- **After:** `<p>Same-day response, business hours. Standard requests: within 2 hours. Tier 3 plans include 24/7 critical response with after-hours pager.</p>`

### 7. `/Users/ltlai/rms/services/managed-it.html:242` — help desk feature list
- **Before:** `<li>Phone, email, and remote desktop support with under-15-minute average response</li>`
- **After:** `<li>Phone, email, and remote desktop support — same-day response, business hours</li>`

## Intentionally NOT changed

- `/Users/ltlai/rms/index.html:540-550` — `WU:HERO-COPY` anchor. HERO-01 owns this. Already uses fallback ("Justin answers Mon–Fri 8a–6p PT").
- `/Users/ltlai/rms/blog/small-business-cybersecurity-checklist.html:234` — "15 minutes per service. Start with email and banking." This is a *task duration estimate*, not an SLA claim. Out of scope.
- `AUDIT_2026-04-28.md`, `AUDIT.md`, `marketing/*.md` — non-HTML / planning docs. The audit doc is explicitly allowed to mention 15-min as a target spec.

## Acceptance tests

| Test | Result | Evidence |
|------|--------|----------|
| Strict SLA regex returns zero matches outside `.swarm/`/AUDIT | PASS | `grep -rEn "15[-\s]?min(ute)?s?\s+(first\s+)?response\|15[-\s]?min(ute)?s?\s+SLA\|15[-\s]?min(ute)?s?\s+first" --include="*.html" /Users/ltlai/rms` returns empty |
| "Same-day response, business hours" appears in each formerly-leaking spot | PASS | 7/7 confirmed via grep |
| JSON-LD parses cleanly | PASS | `python3 json.loads()` over 4 ld+json blocks (2 in `index.html`, 2 in `services/it-operations.html`): all OK |
| Hero anchor untouched | PASS | `WU:HERO-COPY:START/END` lines 540/550 unmodified |

## Followup

Once `.swarm/phone-routing-live.md` exists (= WU-PHONE-01 acceptance test passes), **WU-FAQ-SLA-02** should revert this fallback back to the proper 15-min SLA wording per `AUDIT_2026-04-28.md:271`:

> *"15-minute first response, business hours (Mon–Fri 8a–6p PT). After-hours P1 callback within 30 minutes via answering-service triage."*

Each of the 7 edits above is a candidate revert point.
