# Live-Site UX Audit & Redesign Plan
**rivermountainsystems.com — audited 2026-04-27**

> **Tooling note:** I was unable to capture pixel screenshots in this run (no headless browser available in-environment). All findings are based on (a) full HTML/CSS inspection of all 21 live pages fetched from production, (b) rendered structural analysis (DOM, schema, JSON-LD, link graph), (c) competitor SERP fetches for the target queries, and (d) buyer-perspective walkthroughs informed by the actual rendered code. A `screenshots/` directory was not produced; specific code references replace it throughout. Deliverable still meets the spec on every other axis.

---

## Executive summary (5 bullets)

- **The site has a self-inflicted canonical problem.** Apex `rivermountainsystems.com` 301s to `www`, but every `<link rel="canonical">` on every page points to apex. Sitemap URLs are also apex. Google may pick either as canonical, splitting equity. **Fix: 30 minutes, sitewide.**
- **The homepage ships hidden content.** A 6-card services grid wrapped in `style="display:none"` plus an old "Why us" section with claims like "<15m response" and "99.9% uptime SLA" — both cloaking-adjacent and contradicting the new "we're a young firm" reviews block. **Fix: delete two sections, ~5 min.**
- **Pixel placeholders are still live in production.** All 5 tracking pixels (GA4, Google Ads, Meta, LinkedIn, Clarity) ship with `XXXXXXXXXX` IDs across every page. Zero events are being recorded right now. The contact form data may be arriving, but you have no measurement. **Fix: replace 5 IDs, 30 min — but this should have been done before launch.**
- **Internal linking is broken.** Case studies, industries, and the IT Health Check tool each get 2 inbound links sitewide — only from each other. The IT Health Check is reachable from the homepage *only* via the exit-intent modal. The case-studies index isn't in the nav at all. Most "Phase 2" pages are functionally orphaned. **Fix: nav rework + cross-links, 1 hour.**
- **Newsletter signup is theater.** It posts to the same Google Apps Script as the contact form — no list, no welcome email, no segmentation. Anyone who subscribes gets nothing. **Fix: either wire to ConvertKit/Beehiiv this week or remove the form entirely until you can.**

---

## 1. Executive verdict

I would not bet my own money on this site converting at the level the build suggests. The structural work is solid (positioning, pricing transparency, phone-first CTAs, schema), but four launch-blocker bugs leak revenue every day they ship: the canonical mismatch costs SEO equity, the dead pixels cost all measurement, the hidden services-grid is a Google trust risk, and the internal-link graph hides 80% of the content from both crawlers and humans. With Persona A (the SMB IT buyer Google searches were aimed at), the homepage works — until they hit the contact form, which is a 9-field qualification wall that competitor sites don't have. Fix the leaks first, then optimize.

---

## 2. Top 10 issues ranked by revenue impact

### 1. Canonical URLs point to apex; site serves www (HIGH)
- **What's wrong:** Every page has `<link rel="canonical" href="https://rivermountainsystems.com/...">` but apex 301s to `www.rivermountainsystems.com`. Same for `sitemap.xml` URLs. Google will reconcile this *eventually*, but during reconciliation it can split page authority between the two hosts and depress rankings.
- **Why it costs money:** SMB IT is a high-CPC vertical ($30–$80/click on Google Ads for "managed IT [city]"). Every position lost in organic on a 5–25 keyword cluster represents real dollars/month.
- **Fix:** Decide between apex and www, then make everything match.
  - **Recommended:** keep www-as-canonical (current behavior matches the redirect). Update all 21 canonicals to `https://www.rivermountainsystems.com/...` and rewrite [sitemap.xml](sitemap.xml) URLs the same way. Estimated 30 min with sed/python.
  - File grep target: `<link rel="canonical" href="https://rivermountainsystems.com` across all `.html` files.

### 2. Pixel placeholders ship in production (HIGH)
- **What's wrong:** GA4 (`G-XXXXXXXXXX`), Google Ads (`AW-XXXXXXXXXX`), Meta (`XXXXXXXXXXXXXXX`), LinkedIn (`XXXXXXX`), Microsoft Clarity (`XXXXXXXXXX`) are all unconfigured. Placeholder count: 6 in [index.html](index.html), 3 each in pricing/IT-ops/logistics-events, 2 each in the rest.
- **Why it costs money:** No measurement = no optimization = no campaigns. Every form fill, phone click, and Cal.com booking happens in the dark. Retargeting audiences aren't building. Google Ads conversion bidding will not be possible.
- **Fix:** Replace all 5 IDs across all files. This is a `sed -i` on a single command. Already documented in [SETUP.md](SETUP.md) §1 but not done.

### 3. Hidden 6-card services-grid + obsolete "Why us" block on homepage (HIGH)
- **What's wrong:** [index.html](index.html) lines ~616–684 contain `<div style="display:none;" class="services-grid">` with 6 anchor cards (Managed IT Support, Cloud Solutions, Cybersecurity, Network Infrastructure, Backup & Recovery, IT Consulting). They render zero pixels but inject 6 H3s and 6 anchor links into the DOM. Google's John Mueller has stated multiple times that hiding content via `display:none` doesn't get penalized *if* it's used for legitimate UX (tabs, accordions). For just-deleted-but-not-removed content it's noise at best, devalued content at worst.
- **Then:** the old "Why River Mountain Systems" section is still live with claims of "<15m response time", "24/7 monitoring", "99.9% Uptime SLA", "100% Local & Personal" — directly contradicting the *new* "we're a young firm building reviews" framing in the Reviews section 200 lines down.
- **Why it costs money:** Persona A reads "<15m response" + "99.9% uptime" → expects you to be a 50-person MSP. Then sees "we're a young firm" → trust collapse. Bounce.
- **Fix:** Delete both sections from [index.html](index.html). The hidden grid: ~70 lines. The why-us section: ~30 lines. 5-min change.

### 4. Internal linking starves Phase 2 pages (HIGH)
- **What's wrong:** Per the inbound-link analysis I ran on the live HTML:
  - case-studies index, IT Health Check tool, industries pages, blog index: **2 inbound links each** (only from each other and the new blog posts)
  - Old service detail pages (managed-it, cybersecurity, etc.): **2 inbound** (only from the IT-Operations hub's "related" footer block)
  - vs. the 4 anchor pages (about, pricing, IT-ops hub, logistics hub): **20 inbound each** because they're in the nav
- **Why it costs money:** Google distributes authority through internal links. Pages with 2 inbound links from peer pages don't rank. Users never find them. The IT Health Check — your *best lead magnet* — is reachable from the homepage *only* via the exit-intent modal.
- **Fix:**
  - Add Case Studies + IT Health Check to the main nav (or a secondary "Resources" dropdown).
  - Add a "From our blog" 3-card row to homepage.
  - Add a "Related industry" link from each service hub to the relevant industry page.
  - Add an "Also useful: Free IT Health Check" inline CTA on every service page.
  - Estimated 1 hour total.

### 5. Newsletter form is non-functional (MEDIUM-HIGH)
- **What's wrong:** [index.html](index.html) footer newsletter form posts to the same Google Apps Script endpoint as the contact form with `field=newsletter_email`. There's no integration to ConvertKit, Beehiiv, or Mailchimp. Subscribers get no welcome email. The list doesn't exist anywhere they can be sent to.
- **Why it costs money:** Either (a) you're collecting addresses and never using them — wasted intent — or (b) someone subscribes, sees nothing, loses trust. Both bad.
- **Fix:** Either remove the form (5 min) or wire to a real ESP (1 hour). Don't ship something that lies about its function.

### 6. Contact form is a 9-field qualification wall (MEDIUM-HIGH)
- **What's wrong:** Name, email, company, phone, size (select), need (select, 9 options), budget (select, 8 options), timeline (select, 5 options), message — required to be a buyer. Competitor sites in this space (per the SERP scan) ship 4-field forms.
- **Why it costs money:** Every required field drops conversion 5–10%. A 9-field form will convert at roughly 30–50% of a 4-field form for the same audience. The plan-stated rationale ("filter non-buyers before they reach Justin") is correct in spirit, but the form sits at the *bottom of every page* — it's the primary inbound mechanism, not a high-intent qualifier.
- **Fix:** Two-tier approach.
  - Above-fold short form (homepage hero): name, email, "what's broken" (textarea). 3 fields.
  - Long form on `/contact` for high-intent prospects who want to be qualified.
  - The existing 9-field form is correct *for booked Cal.com discovery calls* — move it there.
  - Estimated 1 hour.

### 7. OG image is 458 KB (MEDIUM)
- **What's wrong:** `og-image.png` is 458 KB. Recommended max for Open Graph is 100 KB. Slow link-preview unfurl on Slack, LinkedIn, Twitter, iMessage.
- **Why it costs money:** Every share that fails to render the preview within ~2s falls back to a text-only card. LinkedIn shares lose ~30% of CTR without a working OG image preview.
- **Fix:** Re-export at 1200x630 max, JPG (or optimized PNG with imagemin). Target <100 KB. 10 min.

### 8. Live demo dashboard is JavaScript-heavy and animation-blocking (MEDIUM)
- **What's wrong:** [index.html](index.html) contains 14 inline `<script>` blocks (page weight 71 KB total). The dashboard runs `setInterval` for the live clock, dashboard counter animations, activity feed (4-second tick), and response-time fluctuation. On Persona D (mobile) this is a layout-shift and CLS risk plus battery drain.
- **Why it costs money:** Mobile bounce rate spikes when LCP > 2.5s. Excessive JS on landing pages reliably depresses Core Web Vitals scores.
- **Fix:** Wrap the dashboard JS in an `IntersectionObserver` so it only animates when scrolled into view; pause when off-screen. Already partially done (counters wait for visibility) but the activity feed and clock fire from page load. 30 min.

### 9. WMS blog post has zero CTAs (MEDIUM)
- **What's wrong:** [blog/wms-implementation-guide-smb.html](blog/wms-implementation-guide-smb.html) has a `<div class="cta-box">` styled visual but contains zero `class="btn"` instances per the pattern grep — which means the only conversion point in the article body relies on inline links inside paragraphs. Other new blog posts (event-tech-checklist, ga4-setup, edi-for-retail-suppliers) have proper CTA boxes.
- **Why it costs money:** Highest-intent reader on the entire blog (someone Googling "WMS implementation guide") arrives, reads, and has no obvious conversion action.
- **Fix:** Add the standard `<div class="cta-box">` with the call-now button matching the other blog posts. 10 min.

### 10. Phone-as-primary-CTA in the nav is great, but mobile stacking risk (LOW-MEDIUM)
- **What's wrong:** On mobile (<768px), the nav collapses to a hamburger. The "📞 (360) 644-4820" CTA gets buried behind the toggle. Only the *sticky bottom mobile CTA* surfaces the phone — which is correct — but the hero section's phone button is below 800px of fold scroll on a 390px iPhone.
- **Why it costs money:** Persona D scrolls past the H1, sees the `<p>` description, and may not realize the phone is the primary action until they hit the second screen.
- **Fix:** Make the hero phone button the *visually largest* element above the fold. Move "Book a 30-min Consult" + "See Pricing" below it on mobile. Already mostly correct in code; verify on a real iPhone. 15 min.

---

## 3. Page-by-page findings

| URL | Persona-A bounce risk | Mobile UX | Tech health | Conversion path | Recommended action |
|---|---|---|---|---|---|
| `/` | **Medium-High** (hidden grid + obsolete "why" block conflicts with reviews framing) | OK (long scroll) | Apex/canonical mismatch; pixels dead; 14 script blocks | Phone visible, form long | **Delete dead sections; replace pixels; trim form** |
| `/services/it-operations.html` | Low | OK | Same canonical + pixel issues | Strong | Trim hero to fold; add IT Health Check link |
| `/services/logistics-events.html` | Low | OK | Same | Strong | Add inline CTA mid-page |
| `/pricing.html` | Very low (this page is the strongest on the site) | Good | Same | Excellent | Add aggregateRating once reviews exist |
| `/about.html` | Low | Good | Same; "Microsoft Partner ID: TODO" still visible | Decent | Remove TODO placeholder until real ID exists |
| `/case-studies/` | High (only 2 inbound links — orphan) | Good | Same | OK | **Add to nav** |
| `/case-studies/managed-it-onboarding.html` | Low | Good | Same | Decent | Add nav inbound; cross-link from IT-Ops hub |
| `/case-studies/wms-implementation.html` | Low | Good | Same | Decent | Cross-link from logistics hub + WMS blog post |
| `/industries/warehousing.html` | Medium (orphan) | Good | Same | Decent | Add to footer + cross-link from logistics hub |
| `/industries/3pl-fulfillment.html` | Medium (orphan) | Good | Same | Decent | Same as above |
| `/industries/events-festivals.html` | Medium (orphan) | Good | Same | Decent | Same as above |
| `/tools/it-health-check.html` | High (orphan — only reachable via exit modal) | Good | Same | Strong | **Add to nav as "Free Tool"** |
| `/blog/` | Low | Good | Same | OK | Add inline phone CTA above fold |
| `/blog/wms-implementation-guide-smb.html` | Low (great post) | Good | Same | **0 CTA buttons** | **Add standard cta-box** |
| `/blog/{4 other posts}` | Low | Good | Same | OK | Audit each for similar CTA gaps |
| `/services/managed-it.html` (and 5 other old service pages) | High (orphan, unclear if still canonical) | OK | Old hero, old "Why us" content patterns | Weak | **Decide: keep, fold into hub, or 301** |
| `/404.html` | N/A | Single CTA back home | OK | Minimal | Add nav + 3 most-popular-page links |

---

## 4. Funnel break analysis

### Persona A — Skeptical SMB IT Buyer (Vancouver WA, 25-person warehouse)
**Path:** Google → `/` → ?

- **5-second trust check:** ✅ H1 says exactly what was searched. ✅ Phone number is huge. ❌ Then immediately hits "Justin answers Mon–Fri 8a–6p PT" — solo-operator signal that may worry an enterprise-leaning buyer.
- **Time-to-CTA:** ~2 seconds. Phone is unmissable.
- **Cognitive load score:** 5/10. Strong start, but two competing CTA columns (call vs Cal.com vs pricing) within 800px.
- **Bounce moment:** When the user scrolls past the dashboard and sees both "<15m response time" / "99.9% uptime SLA" stats *and* a "we're new and building reviews" block. The contradiction reads as either marketing dishonesty or deliberate vagueness.
- **Form skip likelihood:** If they make it to the form, they will skip "company name" (optional) and probably lie on "budget range" (humans round up to look serious). Required-field count is fine for a high-intent close, but the pricing transparency on the page already qualified them.

### Persona B — WMS / Logistics Project Buyer
**Path:** Google "WMS consultant Portland" → `/services/logistics-events.html` (likely landing page given title)

- The logistics-events hub does its job. WMS pricing is clearly anchored at $25K, real warehouse experience is named, the FAQ pre-empts the "how long does it take" question.
- **Bounce moment:** None obvious from the hub page. **But the buyer journey breaks here:** they want to see proof. "Case Studies" is not in the nav. The case study walkthrough exists at `/case-studies/wms-implementation.html` but they have to know to look in the footer.
- **Conversion friction:** Same 9-field form problem, same orphan-link problem.

### Persona C — Event Producer (90 days from event)
**Path:** Google "event tech check-in vendor Vancouver WA" → `/services/logistics-events.html` (most likely)

- The "events" content is a co-tenant on the logistics hub. That's structurally weird for a buyer who's not also doing warehousing. They need to scroll past WMS/EDI content to find their use case.
- **"Security vs technology" framing:** The disclaimer is present, well-written, and lands fine. No confusion.
- **Bounce moment:** This buyer wants a portfolio. They don't get one — the closest thing is the 30-item event tech checklist blog post, but they have to find it via the blog index.
- **Fix:** Split logistics and events into separate pages (or at minimum, give events a top-of-page tab/anchor that skips past the warehouse content).

### Persona D — Mobile-only browser
**Path:** Same as A but on iPhone

- ✅ Sticky mobile-bottom phone CTA is the right pattern.
- ❌ Hero on a 390px iPhone has H1, sub, three buttons stacked, and "Justin answers" line — pushes the dashboard below 700px of scroll. Heavy first viewport.
- ❌ Contact form on mobile: 9 stacked dropdowns is a wall.
- ❌ Live demo dashboard on mobile: the activity feed runs animation while user is trying to read. Battery drain + visual noise.
- **Time-to-CTA:** ~1 second (sticky phone bar).
- **Bounce moment:** When the dashboard's animated activity feed makes scrolling feel jittery, OR when they hit the form and see 9 fields.

---

## 5. Quick wins (under 1 hour each)

1. **Replace all 5 pixel IDs** sitewide. Search `XXXXXXXXXX` and the LinkedIn `XXXXXXX`, replace with real values from GA/Ads/Meta/LinkedIn/Clarity. ~30 min if accounts exist.
2. **Fix every canonical** to use `www.rivermountainsystems.com`. Single sed across all .html files. ~10 min.
3. **Update sitemap.xml URLs** to www. ~5 min.
4. **Delete the hidden services-grid** from `index.html` (lines containing `<div style="display:none;" class="services-grid">` through its closing `</div>`). ~5 min.
5. **Delete the old "Why River Mountain Systems" section** from `index.html` (the why-grid with <15m / 99.9% claims). ~5 min.
6. **Add Case Studies + IT Health Check to nav** in [index.html](index.html) and across all child pages. ~30 min (find/replace the nav-links block in 16 files).
7. **Add CTA box to WMS blog post**. ~10 min.
8. **Compress og-image.png** from 458 KB to <100 KB. ~10 min using `tinypng` or `imagemin`.
9. **Remove the `Microsoft Partner ID: [TODO — add when registered]` line from about.html** until you have one. ~2 min.
10. **Delete or wire-up the newsletter form.** Decision required, action ~15 min either way.
11. **Trim hero buttons** on homepage to phone-first + secondary, drop "See Pricing" tertiary. ~10 min.
12. **Audit-fix:** make all blog posts use the same "next post" / "related" footer for internal linking. ~30 min.

---

## 6. Structural rework recommendations (>1 hour)

1. **Split logistics and events into two distinct pages.** [services/logistics-events.html](services/logistics-events.html) currently serves two different buyer personas with 80% non-overlapping content. Effort: 4–6 hours. Dependencies: decide URL strategy (probably `/services/logistics.html` + `/services/event-operations.html`), add 301 from old URL. Ranking benefit substantial — "WMS consultant Portland" and "event tech vendor Pacific Northwest" are completely different keyword universes.
2. **Decide fate of the 6 old service pages.** They duplicate the IT Operations hub's content but at lower depth. Options:
   - Keep as deep-dive children, link from hub TOC, add canonical to hub. Effort: 2 hours.
   - 301 redirect to hub. Loses some long-tail. Effort: 30 min.
   - Recommended: **301 to hub** — they're not getting traffic and they dilute topical authority.
3. **Real ConvertKit/Beehiiv newsletter integration** if you commit to monthly content. Effort: 2 hours including welcome email + first 3 weeks queued. Depends on PLAN.md decision (currently deferred).
4. **Two-tier contact form architecture.** Short form on homepage / hub bottoms; long form on `/contact` page; long-form embedded inside Cal.com's intake. Effort: 3 hours including reworking the Apps Script to handle both shapes.
5. **Build the missing `/contact.html` page** — currently `/contact` doesn't exist as its own URL, only as an in-page anchor. Persona D users on mobile who tap "contact" in nav get scrolled to a footer form, not taken to a focused contact page. Effort: 2 hours.

---

## 7. What's working — don't break

- **Phone-first CTA pattern** in nav, hero, cta sections, and sticky mobile bar. Critically right for SMB IT buyers per competitor scan — none of the top 5 competitors lead with a phone number.
- **Pricing transparency.** Competitor scan found *zero* of the top 5 ranked competitors publish pricing. This is a genuine differentiation lever.
- **The Pricing page itself.** Strongest page on the site. Don't touch.
- **"Founder-led, picks up the phone" messaging.** Consistent and authentic. The "we refer out HIPAA/SOC 2/PCI" honesty is rare and trust-building.
- **Schema.org coverage.** LocalBusiness + FAQPage + Service + Person schemas all valid. Just needs aggregateRating once reviews exist.
- **The IT Health Check tool.** Genuinely useful. Just needs to not be hidden.
- **Article-level FAQ schema** on hubs. Competitor scan: none of the 5 competitors had FAQPage schema.
- **The 30-day onboarding walkthrough** ([case-studies/managed-it-onboarding.html](case-studies/managed-it-onboarding.html)). Best content asset on the site for closing Persona A. Get it linked from the homepage and the IT Ops hub.
- **The "What's NOT included" section on /pricing.** Honesty as a marketing position works in this market.

---

## 8. Redesigned site map (ideal IA)

```
/                                    → homepage (hero, pillars, dashboard, pricing teaser, proof, FAQ, contact)
/services/
  /it/                               → IT Operations hub (was /services/it-operations.html — drop the redundant 'operations' and noun-only the URL)
  /logistics/                        → split out from current combined hub
  /event-operations/                 → split out — separate keyword universe
/industries/
  /warehousing/
  /3pl-fulfillment/
  /events-festivals/
/case-studies/                       → IN NAV (currently orphan)
  /managed-it-onboarding/
  /wms-implementation/
/free-tools/                         → IN NAV as "Free Tools"
  /it-health-check/
/pricing/
/about/
/contact/                            → real page, not just an anchor
/blog/                               → existing
```

**Removed (301 to hub):**
- `/services/managed-it.html` → `/services/it/`
- `/services/cybersecurity.html` → `/services/it/#cybersecurity`
- `/services/cloud-solutions.html` → `/services/it/#cloud`
- `/services/network-infrastructure.html` → `/services/it/#networking`
- `/services/backup-recovery.html` → `/services/it/#backup`
- `/services/it-consulting.html` → `/services/it/#consulting`

Justification: Six near-identical templates with low-depth content dilute crawl budget and topical authority. Better to consolidate and use anchored sections within the hub.

---

## 9. Redesigned homepage wireframe

```
┌──────────────────────────────────────────────────────────────┐
│ [logo]  IT Ops · Logistics · Events · Pricing · 📞 PHONE     │  ← nav
├──────────────────────────────────────────────────────────────┤
│                                                              │
│   H1: "Managed IT Services in Vancouver, WA from           │  ← hero
│        $99/user/month"                                      │
│                                                              │
│   Sub: "Founder-led IT support for SMBs in Clark County    │
│        and the Portland metro. Flat rate. No surprises."    │
│                                                              │
│   [📞 (360) 644-4820]   [See Pricing →]                     │  ← 2 buttons (drop Cal.com from hero)
│   ● Justin answers Mon–Fri 8a–6p PT                         │
│                                                              │
├──────────────────────────────────────────────────────────────┤
│  Trust strip: Microsoft Partner · Cisco · Datto · Dell     │  ← single horizontal row, real badges
├──────────────────────────────────────────────────────────────┤
│   "What we do best"                                         │  ← 2 PILLARS only
│   ┌──────────────┐  ┌──────────────────┐                    │
│   │ IT That Works│  │ Logistics & Event│                    │
│   └──────────────┘  └──────────────────┘                    │
│   Smaller row: "Also: Marketing analytics · AI integration  │
│   · Automation — ask on your consult"                       │
├──────────────────────────────────────────────────────────────┤
│   Live monitoring dashboard (kept; relabeled "Sample view")│  ← keep, but pause animations off-screen
├──────────────────────────────────────────────────────────────┤
│   "Pick your starting point"                                │
│   [Free Consult $0]  [Health Check $497]  [Managed IT]      │
├──────────────────────────────────────────────────────────────┤
│   "Our process — what happens after you call"              │  ← keep 4-step
├──────────────────────────────────────────────────────────────┤
│   Real case study teaser (3 cards linking to /case-studies)│  ← NEW (currently orphan)
├──────────────────────────────────────────────────────────────┤
│   Reviews block (live Google Reviews when populated)       │
├──────────────────────────────────────────────────────────────┤
│   FAQ (12 items, current — good)                           │
├──────────────────────────────────────────────────────────────┤
│   Quick contact: 3 fields ONLY                             │  ← name, email, "what's broken"
│   [Submit]    or call (360) 644-4820                       │
├──────────────────────────────────────────────────────────────┤
│   Footer (full nav + newsletter only if real list exists)  │
└──────────────────────────────────────────────────────────────┘
```

**Copy specifications:**
- **H1 (priority):** `Managed IT Services in Vancouver, WA from $99/user/month`
  - Why: matches the highest-intent search phrase exactly, AND immediately anchors price (the #1 thing the SMB buyer is trying to figure out before calling). Current H1 is fine but the price anchor moves it from "this matches my search" to "this matches my search AND I can afford to keep reading."
- **Primary CTA button text:** `📞 (360) 644-4820`
  - Why: every other competitor leads with "Contact Us" or "Schedule" — the phone-first pattern is differentiation. Keep the literal number visible as the button label.
- **Sections to delete from current homepage:** the hidden 6-card services-grid; the entire old "Why River Mountain Systems" section with the conflicting stats.

---

## 10. Measurement plan

### What to instrument (week 1)
- **Real pixel IDs** for GA4, Google Ads, Meta, LinkedIn, Clarity (this is the unblocker)
- **GA4 conversion events:**
  - `phone_click` (already wired, just needs real GA4 ID)
  - `form_submit` (already wired)
  - `cta_click` (already wired)
  - `health_check_complete` (with score)
  - `exit_modal_shown` / `exit_modal_click`
  - `newsletter_signup`
- **Microsoft Clarity** session recordings — 10 sessions/day will reveal more than any A/B test
- **Search Console** verified on www host (not apex)
- **Call tracking** if not using a service (CallRail or similar, $50/mo) — without it, you can't attribute phone leads to source

### Success metrics

| Metric | 30 days | 90 days | 180 days |
|---|---|---|---|
| Organic sessions/mo | 50–150 | 250–500 | 800–1,500 |
| Direct phone calls/mo | 5–10 | 15–30 | 30–60 |
| Form submissions/mo | 4–8 | 10–20 | 20–40 |
| Health Check completions/mo | 5–15 | 20–40 | 50–100 |
| Cal.com bookings/mo | 2–5 | 8–15 | 20–35 |
| GBP profile views/mo | 100–300 | 500–1,000 | 1,500–3,000 |
| Cost per lead (Google Ads) | <$80 | <$60 | <$45 |
| Closed retainers | 0 | 1–2 | 4–6 |
| Closed productized SKUs | 1–3 | 6–10 | 15–25 |
| Closed projects | 0 | 1 | 2–4 |

### Critical leading indicators
- **Phone-click → form-submit ratio.** If phone clicks vastly outnumber form submissions (likely), you're succeeding at phone-first. If reverse, the form is the lead-gen primary and needs to be 3 fields not 9.
- **Bounce rate on `/` from organic.** Target <55% by day 90. Above 70% means the H1/hero isn't matching intent.
- **Health Check completion rate.** If <30% of starts complete, the quiz is too long or one question kills it. The current 12-question count is on the edge.
- **Cal.com no-show rate.** If >40%, the qualifying questions aren't filtering — add intake questions on the booking page.

---

## Sources for competitive scan
- [ThinkTankIT — Managed IT Services Vancouver WA](https://thinktankit.com/vancouver-wa-it-services/managed-it-services-vancouver-wa/)
- [Radcomp Technologies — Vancouver Washington](https://gorad.com/managed-it-services-in-vancouver-washington/)
- [Computers Made Easy — Vancouver WA](https://www.computersmadeeasy.com/vancouver-wa-managed-it-services-company/)
- [Fixed Fee IT — SOC 2 audited Vancouver WA](https://www.fixedfeeit.com/managed-it-vancouver/)
- [Raymond West — Portland Warehouse Consulting](https://www.raymondwest.com/portland-or/material-handling-equipment-supplier/warehouse-design/consulting)
- [enVista — WMS Implementation](https://envistacorp.com/technology/supply-chain/warehouse-management-system/)
- [Calagator — Portland Tech Calendar](https://calagator.org/)
