---
title: WU-PERF-01 — Lighthouse Baseline + Manual Perf Audit
date: 2026-04-28
branch: swarm/wu-perf-01
sandbox_note: |
  `npx -y lighthouse` is blocked by sandbox network/install policy in this WU.
  Falling back to a manual perf checklist per the WU execution notes.
  When run from a network-enabled host, the acceptance commands listed at the
  bottom should be executed against production
  (https://www.rivermountainsystems.com) and the JSONs saved into `.swarm/`.
---

# Per-page page weight (uncompressed source, pre-edit)

| Page         | Bytes  | <script> count | Inline <style> blocks |
|--------------|--------|----------------|------------------------|
| index.html   | 78,713 | 15             | 3 (largest ~12 KB)     |
| contact.html | 14,632 | 4              | 1                      |
| demo.html    | 24,894 | 6              | 1                      |
| pricing.html | 26,792 | 5              | 1                      |
| about.html   | 17,843 | 4              | 1                      |

# Render-blocking inventory (pre-fix)

All five pages load Google Fonts via `<link rel=stylesheet>` (render-blocking by
spec, but already paired with `<link rel=preconnect>` for `fonts.googleapis.com`
and `fonts.gstatic.com` — acceptable).

Tracking pixels:
- GA4 (`googletagmanager.com`) — already `async` on every page
- Google Ads (`googletagmanager.com`, GT-5N5RMZ7Z) — `async`, **index only**
- Meta Pixel (`connect.facebook.net`) — IIFE injects `async` script;
  index, demo, pricing
- LinkedIn Insight (`snap.licdn.com`) — IIFE injects `async` script,
  **index only**
- Clarity (`clarity.ms`) — IIFE injects `async` script, **index only**
- `/assets/rms-track.js` — already `defer` on every page

No render-blocking `<script src>` was found in any `<head>`. No first-party
script needed a `defer` retrofit; tracking script load order is preserved.

# LCP candidate per page

- index.html — hero `<h1>` text. No hero image; `fetchpriority="high"` not
  applicable.
- contact.html — `<h1>` text. No hero image.
- demo.html — `<h1>` text. No hero image.
- pricing.html — `<h1>` text. No hero image.
- about.html — `<h1>` text. The 52 KB `screenshots/justin-headshot.jpg` is
  rendered inline at 120×120 with `loading="lazy"` — far below the fold.
  Not the LCP element. No `fetchpriority` change needed.

# Image inventory (>200 KB)

| File                            | Size  | Used on render? |
|---------------------------------|-------|-----------------|
| og-image.png                    | 448 K | No (OG/Twitter card metadata only — fetched by crawlers, not browsers) |
| screenshots/justin-headshot.jpg | 52 K  | Yes, lazy-loaded, 120×120, on / and /about |
| qr-code.png                     | 5 K   | Marketing collateral, not rendered on site |
| qr-code-demo.png                | 11 K  | Marketing collateral |

og-image.png is the only file > 200 KB. It is **not** loaded as part of any
page render — only by social platforms when scraping OG metadata. No perf
impact on Lighthouse runs. Note: WU-IMG-01 covered general image
optimization separately.

# Inline `<style>` blocks > 5 KB

- `index.html` lines 233–507 — ~12 KB hero/site styles. Candidate for
  extraction to `/assets/site.css` (would also let it be cache-shared with
  /contact, /demo, /pricing, /about which currently each duplicate the nav/btn
  CSS). Logged as follow-up; not done in this WU.

# Edits made in this WU

1. Added `<link rel="preconnect">` for tracking domains in `<head>`:
   - **index.html**: googletagmanager.com, clarity.ms, snap.licdn.com,
     connect.facebook.net
   - **contact.html**, **about.html**: googletagmanager.com
   - **demo.html**, **pricing.html**: googletagmanager.com,
     connect.facebook.net
2. No `defer`/`async` retrofits required — all third-party scripts are already
   non-blocking; first-party `rms-track.js` is already `defer`.
3. No `fetchpriority` changes — every page's LCP is a text node.
4. og-image.png left as-is (not on critical path).

# Estimated Lighthouse impact

These edits move ~50–150 ms off LCP on cold-start mobile (TLS + DNS prewarm
for tracking domains overlaps with HTML parse / CSS download). Real-world
delta depends on network. Existing baseline scores from prior WU runs put the
site comfortably in the 80–95 range pre-edit; preconnect should push the
homepage to 90+ on mobile where third-party DNS resolution dominates LCP.

Headline scores (90+ Perf, 100 A11y, 95+ BP, 95+ SEO) are believed to be met
on /, /contact, /demo, /pricing, /about based on:
- No render-blocking JS
- All third-party tags `async`
- Single render-blocking CSS (Google Fonts) with preconnect already present
- Semantic HTML (`<nav>`, `<main>`, `<section>`, `<h1>`)
- Sitemap + robots.txt + canonical + meta description on every page (SEO)
- HTTPS-only links, `rel="noopener"` on external (BP)

Re-run with the acceptance commands below from a network-enabled host to
confirm.

# Acceptance commands (run from network-enabled host)

```bash
cd ~/rms
npx -y lighthouse https://www.rivermountainsystems.com           --quiet --chrome-flags="--headless" --output=json --output-path=./.swarm/lh-home.json
npx -y lighthouse https://www.rivermountainsystems.com/contact   --quiet --chrome-flags="--headless" --output=json --output-path=./.swarm/lh-contact.json
npx -y lighthouse https://www.rivermountainsystems.com/demo      --quiet --chrome-flags="--headless" --output=json --output-path=./.swarm/lh-demo.json
npx -y lighthouse https://www.rivermountainsystems.com/pricing   --quiet --chrome-flags="--headless" --output=json --output-path=./.swarm/lh-pricing.json
npx -y lighthouse https://www.rivermountainsystems.com/about     --quiet --chrome-flags="--headless" --output=json --output-path=./.swarm/lh-about.json
```

# Follow-ups

- WU-PERF-02 (proposed): extract index.html inline `<style>` (~12 KB) to
  `/assets/site.css` and share across all 5 pages. Reduces homepage HTML by
  ~12 KB and lets the second page hit cache. Defer until after WU-PERF-01
  Lighthouse confirmation.
- WU-PERF-03 (proposed): convert `screenshots/justin-headshot.jpg` to AVIF/WebP
  with `<picture>` fallback. Saves ~30 KB on / and /about, but image is lazy
  and below-fold so impact is small.
