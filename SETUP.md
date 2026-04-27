# RMS Site 2.0 — Setup Checklist

**Status:** Site rebuild is shipped. The items below are user-required actions to actually turn it into a lead engine. None of these can be done from code — they need accounts, billing, and verification only Justin can do.

Total time: **~6 hours** spread across the items below. Do them in this order.

---

## Phase 0 — Critical (this week, ~2 hours)

### 1. Replace pixel placeholders (~30 min)
Every page has placeholder pixel IDs. Until replaced, nothing tracks.

**Files to update:**
- `index.html`
- `pricing.html`
- `about.html`
- `services/it-operations.html`
- `services/logistics-events.html`

**What to replace:**

| Placeholder | Where to get the real ID | Cost |
|---|---|---|
| `G-XXXXXXXXXX` | analytics.google.com → Admin → Create Property → Web stream → Measurement ID | Free |
| `AW-XXXXXXXXXX` | ads.google.com → Tools → Conversions → Create | Free (no campaign required to install) |
| `XXXXXXXXXXXXXXX` (Meta Pixel) | business.facebook.com → Events Manager → Connect data sources → Web → Create Pixel | Free |
| `XXXXXXX` (LinkedIn) | linkedin.com/campaignmanager → Account Assets → Insight Tag | Free |
| `XXXXXXXXXX` (Clarity) | clarity.microsoft.com → Add new project | Free |

**Quickest way:** open each HTML file, search for `XXXXXXXXXX`, replace with real IDs.

### 2. Set up Cal.com (~20 min)
Currently the "Book a Consult" links go to `https://cal.com/joberg/30min` — placeholder.

- Create free Cal.com account at cal.com
- Set up a 30-min event type
- Restrict availability to Tue/Thu 10am–12pm PT (protects deep-work time per PLAN.md §8)
- Add intake questions: company name, company size, biggest pain
- Update the URL in:
  - `index.html` (search for `cal.com/joberg/30min`)
  - `pricing.html` (if added later)

### 3. Verify Google Business Profile (~30 min)
This is the highest-ROI digital asset for local IT search. If you only do one thing this week, do this.

- Go to business.google.com
- Claim or create profile for "River Mountain Systems"
- Address: Vancouver, WA (use service-area business if no public office)
- Phone: (360) 644-4820
- Categories (pick up to 10): IT support and services, Computer support and services, Computer consultant, Computer security service, Computer networking service, Internet marketing service, Software company, Business management consultant
- Add 10 photos (logo, headshot, equipment, service-truck-style photos)
- Service area: Vancouver WA + Clark County + Portland metro 30-mile radius
- Add 5 services with pricing:
  - Managed IT — from $99/user/mo
  - IT Health Check — $497
  - Network Assessment — $797
  - Cloud Migration — from $3,000
  - WMS Implementation — from $25,000

**Verification** can take 1–7 days (postcard or video).

---

## Phase 1 — Lead generation (week 2, ~2 hours)

### 4. Launch Google Ads test campaign (~1 hour, $500 budget)
- Single campaign, exact-match + phrase-match
- Keywords:
  - `managed IT Vancouver WA`
  - `IT support Vancouver WA`
  - `IT services Portland Oregon`
  - `WMS consultant Portland`
  - `business IT support Clark County`
- Daily budget: $20
- Send traffic to `/services/it-operations.html`
- Conversion goals: phone call (already wired up in pixel), form submit (already wired up)
- Run for 2 weeks. Goal: 10–20 clicks/day, 1–3 form fills or calls per week.

### 5. Review acquisition push (~30 min setup, ongoing)
Target: 25 reviews on Google Business Profile in 90 days.

- Email every past client / contact who's used your services historically
- Email template:
  > "Hey [name] — I just (re)launched River Mountain Systems and I'd really appreciate a quick Google review. Would mean the world. Here's the link: [GBP review link]. Thanks!"
- Set up automated review request: any time you complete an engagement, send the same template within 7 days.

### 6. Quick technical SEO audit (~30 min)
Run Lighthouse on:
- `/` (homepage)
- `/services/it-operations.html`
- `/services/logistics-events.html`
- `/pricing.html`

Fix any Critical/Major issues before they impact rankings. Common issues: image sizing, missing alt text, slow LCP.

---

## Phase 2 — Polish (weeks 3–4, ~2 hours)

### 7. Add real Google Reviews widget
Once you have 5+ reviews, replace the placeholder block in `index.html` (search for `REVIEWS PLACEHOLDER`) with a live widget. Options:
- ElfSight Google Reviews (free tier, easiest)
- Trustmary
- Embedsocial

### 8. Add Microsoft Partner ID
Once you've registered as a Microsoft Partner, add the Partner ID to:
- `about.html` (search for `Microsoft Partner ID:`)

### 9. Add aggregateRating schema
Once you have 5+ Google reviews, add to homepage LocalBusiness schema (in `index.html`):
```json
"aggregateRating": {
  "@type": "AggregateRating",
  "ratingValue": "5.0",
  "reviewCount": "5"
}
```

### 10. Set up newsletter (Beehiiv or ConvertKit free tier)
Currently no list-building capture. Add footer opt-in once you commit to at least monthly content.

---

## Phase 3 — Growth (Month 2+)

Per PLAN.md §9 Phase 3:
- First real case study (after first closed engagement permits it)
- Industries pages (only if hubs are ranking)
- Retargeting campaigns ($150/mo across Google/Meta/LinkedIn)
- Blog revisit (only if base funnel converting)
- Lead magnet (only if base funnel converting)

---

## Files shipped this build

### New
- `index.html` — full rewrite (phone-first H1, 2 pillars, qualifying form, dashboard relabeled, expanded FAQ)
- `pricing.html` — productized offers + 9 project starting prices + 3 retainer tiers + honest exclusions + 6 pricing FAQs
- `about.html` — Justin's story + operating principles + capabilities
- `services/it-operations.html` — IT Operations hub (~1,800 words, conversion-optimized)
- `services/logistics-events.html` — Logistics &amp; Events hub (~1,800 words)
- `SETUP.md` — this file

### Updated
- `sitemap.xml` — new pages + updated lastmod
- All 6 existing service pages — nav + footer updated
- All 6 blog pages (index + 5 posts) — nav + footer updated

### Pixels installed (placeholder IDs)
- Google Analytics 4
- Google Ads conversion tag
- Meta Pixel
- LinkedIn Insight Tag
- Microsoft Clarity (session replay)

### Conversion events wired up
- `phone_click` — fires on every tel: link click (10+ locations)
- `email_click` — fires on email links
- `cta_click` — fires on button clicks with location label
- `form_submit` — fires on contact form submission with need/budget/timeline params

---

## Quick sanity checks before going live

- [ ] Replace all `XXXXXXXXXX` pixel IDs (search the codebase)
- [ ] Replace `cal.com/joberg/30min` with real Cal.com URL
- [ ] Test phone link on a real mobile device
- [ ] Test contact form end-to-end (does it actually submit?)
- [ ] Check the Google Apps Script form endpoint is still valid
- [ ] Run Lighthouse on at least homepage + 1 hub
- [ ] Verify Google Business Profile is claimed
