> **DEPRECATED — superseded by `AUDIT_2026-04-28.md` (2026-04-28).** Do not follow this doc; it is retained for history only.

# River Mountain Systems — Site 2.0 Revenue Plan (v3)

**Date:** 2026-04-22
**Operator:** Justin Oberg (solo, founder-led)
**Goal:** Maximize **leads-per-dollar-of-effort** in months 1–6. Build for the actual SMB IT buyer searching "managed IT Vancouver WA," not for an imagined enterprise sale or future agency.

**v3 changes from v2:** Cut to 2 public pillars. Phone-first CTA. GBP + Google Ads as Phase 1. Pixels installed week 1. Hub pages capped at 2,000 words. Blog deferred. Live demo dashboard relabeled. Capacity ceiling math made explicit. Honest revenue projection added.

---

## 1. Positioning — TWO public pillars (not four)

Buyers don't trust generalists. Solo operators can't deliver four pillars. RMS publicly sells **two things**:

### A. IT Operations (recurring revenue base)
Managed IT, cloud (M365 / Google Workspace / Azure / AWS), networks, backup, endpoint protection, help desk, cybersecurity. **The hero pillar.** Lead with this everywhere.

### B. Logistics & Event Systems (high-ticket project differentiator)
WMS / TMS / ERP integrations, EDI, ShipStation/Shopify sync, plus event operations tech (credentialing, check-in, parking flow, on-site connectivity, radio/dispatch). Justin's logistics background is real differentiation against generic MSPs.

### Sold on calls, NOT merchandised on homepage
- **Data & Marketing Analytics** (GA4, GTM, Google Ads, Looker Studio) — offered when relevant on a discovery call. Listed only on `/services/` index, not the homepage.
- **AI Integration** (Codex Vivus showcase) — same. Available, not advertised. Will scope-creep to death if put on homepage.
- VoIP, AV, POS, document management — "We also handle…" footer-only.

### Compliance posture
RMS does **not** sell HIPAA / SOC 2 / PCI auditing or attestation. Pages may reference "HIPAA-aware setups" or "PCI-scoped network design" but never "HIPAA compliance" or "we'll get you SOC 2." Refer real audit work out.

### "Security" wording
Avoid the word **only** in event-ops contexts (implies licensed security guards / armed personnel — triggers WA state regulation). Cybersecurity stays "cybersecurity."

---

## 2. Two funnels (third one stays internal)

| Funnel | Audience | Price | Cycle | Public on site? |
|---|---|---|---|---|
| **A. Retainer** | SMB owners, 10–50 users | from **$99/user/mo, 10-user min (~$990/mo)** | 30–90 day cycle | **YES — primary** |
| **B. Project** | Ops leads, marketing managers | $2,500 – $50,000 one-shot | 1–4 week cycle | YES — secondary |
| **C. Event** | Event producers | $5,000 – $25,000 per event | 2–8 week cycle | Limited — by referral |

Per-user pricing replaces "$2,500/mo" anchor — reads as cheaper to SMB buyers and matches MSP industry standard.

---

## 3. Site architecture (lean — 2 hubs, not 4)

```
/                          ← homepage (rewritten — see §5)
/services/
  /it-operations/          ← HUB (1,500–2,000 words, conversion-optimized)
  /logistics-events/       ← HUB (1,500–2,000 words)
  /index.html              ← lists ALL services including the unmerchandised ones
/pricing/                  ← Funnel A + B prices
/about/                    ← Justin's story (real proof, certifications)
/contact/                  ← phone-first, Cal.com secondary, qualifying form
/blog/                     ← existing posts stay, no new cadence committed
```

Existing service sub-pages (managed-it.html, cloud-solutions.html, etc.) stay live for SEO continuity, internally link to the IT Operations hub.

**Cut from build:** AI Integration hub, Data & Marketing hub, all industries pages, all lead magnets, exit-intent modals, live chat. Defer until base funnel produces measurable leads.

---

## 4. Pricing page

Phase 1 must-have. Forces qualification.

### Productized fixed-price offers (first-touch revenue)
- **Free 30-min consult** — $0
- **IT Health Check + report** — $497 flat
- **Network Assessment** — $797 flat

### Project starting prices
- M365 / Google Workspace migration — from **$3,000 + per-seat**
- Network design + deployment — from **$5,000**
- WMS implementation / integration — from **$25,000** (raised from $10K — these are 200-hour engagements)
- Event tech package (single event) — from **$5,000**
- Custom engagements (AI, data, integrations) — **"Contact for scope"** (no public price)

### Retainers
- Managed IT — **$99/user/mo**, 10-user minimum (~$990/mo starting)
- Higher tiers (24/7 monitoring, advanced security): $149/user/mo, $199/user/mo

Removed from public pricing per Critic 2: Fractional CTO ($3K/mo retainer trap), undefined AI projects, sub-$25K WMS work.

---

## 5. Homepage rewrite

### Above the fold

**H1 (matches search intent verbatim):**
**"Managed IT Services in Vancouver, WA — Without the Big-Company Price Tag"**

**Sub:**
"Local, founder-led IT support for businesses in Vancouver, WA and the Portland metro area. From $99/user/month — flat rate, no surprise invoices."

**Primary CTA (phone, big):**
**📞 Call (360) 644-4820** — *Justin answers Mon–Fri 8a–6p PT*

**Secondary CTA:**
`Book a 30-min Consult` (Cal.com) + `See Pricing`

**Trust strip (real elements only):**
- Microsoft Partner badge (with Partner ID)
- Google Reviews aggregate (live widget — even 1 star with 3 real reviews beats fake claims)
- "Serving Vancouver, WA & Portland metro since [year]"

### Live demo dashboard — KEEP, but label
Add small label above dashboard: **"Sample monitoring view — this is what your dashboard would look like as a managed client."** One sentence kills the bait-and-switch risk and the fake-data trust risk simultaneously.

### "What we do" — TWO pillars (not four)
1. **IT That Works** → `/services/it-operations/`
2. **Logistics & Event Systems That Scale** → `/services/logistics-events/`

Below those, smaller row: *"Also: data analytics, AI integration, automation — ask on your consult."*

### "Pick your starting point" section
Mirrors `/pricing` productized offers — three cards:
- Free 30-min consult
- IT Health Check ($497)
- Managed IT (from $99/user/mo)

### Proof section
- Embedded Google Reviews (live)
- Microsoft Partner badge with verifiable Partner ID
- Real testimonials with full first names + roles (or none — no fakes)
- Replace any fictional metrics with **"Our process"** walkthroughs

### Expanded FAQ
6 Q&As: pricing, response time, what break-fix businesses can expect when switching, project scope, where Justin works (geography), what happens after consult.

---

## 6. Lead capture (phone-first, calendar-second)

**Primary:**
- **Phone number** — clickable in nav (mobile), giant in hero, in footer
- **Cal.com booking embed** — secondary CTA, used for non-urgent or prospect-preferred scheduling
- **Qualifying contact form** — name, company, size, current setup, biggest pain, budget range, timeline

**Pixel install (Week 1, ~30 min total):**
- Google Ads conversion tag
- Meta Pixel
- LinkedIn Insight Tag
- GA4 with conversion events on: phone click, Cal.com book, form submit
- Microsoft Clarity (free session replay)

**Skip:**
- Live chat (solo can't staff)
- Exit-intent modals (premature)
- Newsletter opt-in (no list strategy yet)

**Capacity messaging:**
Do NOT publish "Accepting N clients/month" — reads desperate. Use scarcity-by-implication only ("Now booking June engagements") if needed.

---

## 7. SEO + paid + GBP strategy (rebalanced)

**Reality check on timeline:**
- **Months 1–3:** Organic traffic = ~zero. **Google Ads + Google Business Profile do 90% of digital lead-gen.**
- **Months 4–6:** Organic starts contributing.
- **Months 6–12:** Organic becomes primary channel.

### Phase 1 priorities (in order):

1. **Google Business Profile optimization** (highest-ROI digital activity for local IT)
   - Complete profile, 10 service categories, 10 photos
   - 5 services with pricing
   - Weekly posts
   - Respond to every review within 24 hours
   - **Target: 25 reviews in 90 days** (ask every past client + every contact who's ever used Justin's services)
   - Implement Review schema (aggregateRating) on homepage

2. **Google Ads test** — $500 budget, single campaign, "managed IT Vancouver WA" + 5 close-variant keywords, traffic to homepage. Goal: 10–20 clicks, 1–3 form fills/calls. Learn cost-per-lead.

3. **Two hub pages, 1,500–2,000 words each** (NOT 3,000)
   - H1 with `[service category] Vancouver WA`
   - LocalBusiness + Service + FAQPage schema
   - CTA above fold + mid-page + bottom
   - Internal links to relevant existing sub-pages

4. **Technical SEO audit** before adding pages — Lighthouse + Screaming Frog. Fix Critical/Major issues first. ~2 hours, can move rankings 5–15 positions.

### Blog cadence
**Deferred.** Existing posts stay live, no new posts committed in Phase 1. Revisit Phase 3 if hub pages and GBP are producing leads. If revisited: 2/month or "Field Notes" 300-word weekly format — never the 1/week treadmill that dies in month 4.

---

## 8. Fulfillment plan + capacity ceiling

### Capacity math (named explicitly)
- **Solo retainer ceiling: 5 clients** (each = ~80 tickets/wk + 20hrs maintenance + on-call risk)
- **Max solo MRR from retainers: ~$5K–$12.5K/mo**
- **At 5 clients:** Either (a) raise prices to $5K+/mo per client, or (b) hire Tier-1 tech. **Decide before signing client #6.**

### Inbound flow
- Phone rings → Justin answers if available, voicemail otherwise (auto-text response: "Got your call, ringing back within 2 hours")
- Form submits → single inbox, auto-acknowledge with "within 1 business day" + Cal.com link
- Cal.com books → fixed window Tue/Thu 10a–12p (protects deep-work time)
- Qualifying form filters non-buyers before any call

### Overflow plan
If pipeline exceeds capacity → **raise prices first**, hire second.

### What gets sold on intro calls (not advertised)
- Marketing analytics work
- AI integration projects
- Sub-$25K WMS scoping
- Fractional CTO
- Anything outside the two public pillars

---

## 9. Build sequence

### Phase 1 — Week 1 (highest leads-per-effort)
1. **Pixels installed** on existing site (GA4, Google Ads tag, Meta, LinkedIn, Clarity) — 30 min
2. **Technical SEO audit** + fix critical issues — 2 hrs
3. **GBP optimization** complete + review request push — 4 hrs
4. **Homepage rewrite** (new H1, phone-first, 2 pillars, dashboard relabeled, real proof) — 4 hrs
5. **`/pricing` page** with productized offers + project starting prices — 2 hrs
6. **Cal.com setup** (Tue/Thu window, intake questions) — 1 hr
7. **Qualifying contact form** (budget, timeline, setup fields) — 1 hr
8. **Google Ads $500 test campaign** launched — 2 hrs

**Total Week 1: ~16 hrs of work. Drives lead pipeline same week.**

### Phase 2 — Weeks 2–4
9. `/services/it-operations/` hub page (1,500–2,000 words)
10. `/services/logistics-events/` hub page (1,500–2,000 words)
11. `/about/` page with Justin's story + verifiable certifications
12. Review acquisition push — target 10 new reviews
13. Iterate Google Ads based on Week 1 data
14. First "Our process" walkthrough on homepage (replaces fake metrics)

### Phase 3 — Month 2+
15. First real case study (after first closed engagement permits it)
16. Industries pages (only if 2 hubs are ranking)
17. Retargeting campaigns ($150/mo split across Google/Meta/LinkedIn)
18. Blog revisit decision (only if base funnel converting)
19. Lead magnet (only if base funnel converting)

**Cut from build entirely:**
- AI Integration hub page
- Data & Marketing hub page
- 18 sub-service pages
- 30 blog posts
- Live chat
- Exit-intent modals (until Phase 3)
- Newsletter opt-in (until list strategy exists)
- "Eat-own-cooking" GA4 portfolio setup beyond default config
- Fractional CTO public offering
- Sub-$25K WMS work as advertised SKU

---

## 10. Honest revenue projection

| Month | New leads (est.) | Closes | Productized revenue | New MRR | Cumulative cash |
|---|---|---|---|---|---|
| Month 1 | 4–8 | 0 | $0 | $0 | $0 |
| Month 2 | 6–12 | 1 | $497–$1,294 | $1K | $2K |
| Month 3 | 8–15 | 1–2 | $1K–$2K | $2.5K | $5K |
| Month 6 | 15–25 | 4–6 total | $5K | $5–$7.5K MRR | $25K–$50K |
| Month 12 | 25–40 | 10–15 total | $10K | $10–$15K MRR | $80K–$150K |

**If Month 3 cash is < $5K, the plan needs revisiting — not the operator.**

Bottlenecks to watch:
- Lead-to-consult conversion (target: 30%+)
- Consult-to-close conversion (target: 25%+)
- Cost per lead from Google Ads (target: <$50)
- Time-to-respond on inbound (target: <2 hours during business hours)

---

## 11. What got cut from v2 (and why)

| Cut | Reason |
|---|---|
| 4 public pillars → 2 | Critic 1: confuses IT buyer. Critic 2: solo can't deliver 4. |
| Cal.com as primary CTA | Critic 1: SMB IT buyer wants phone. Calendar reads as enterprise sale. |
| 3,000-word hub pages | Critic 3: outdated SEO advice; 1,500–2,000 converts better. |
| 4 hub pages → 2 | Critic 3: page count is vanity; concentrate effort. |
| Blog cadence (1/week) | Critic 2: dies by month 4. Critic 3: vanity metric. |
| "Eat-own-cooking" GA4 setup | Critic 2: 8 hrs unbilled work, zero buying-window influence. |
| Fractional CTO public SKU | Critic 2: locks Justin into recurring meetings forever. |
| Sub-$25K WMS work | Critic 2: 200-hr engagements; raise floor or cut. |
| AI Integration as pillar | Critic 2: scope-creep death. Sell on calls only. |
| Data & Marketing as pillar | Critic 1: dilutes IT positioning. Critic 2: capacity. |
| "Accepting N clients/mo" | Critic 1: reads desperate, not scarce. |
| Industries Phase 1 | Critic 3: build only after hubs rank. |
| Live chat | Solo can't staff. |
| Newsletter opt-in Phase 1 | No list strategy yet. |

---

## 12. What stays unchanged from v2 (the plan got these right)

1. Three-funnel revenue framing (even if only 2 are publicly visible)
2. Productized fixed-price first-touch offers
3. Compliance refer-out posture
4. Industries deferred until case studies exist
5. Exit-intent / lead magnets / live chat all deferred
6. No fictional case study metrics — ever
7. Fulfillment plan section exists at all
8. Live demo dashboard kept (now properly labeled)

---

## 13. Day-one starting order

1. Install pixels (GA4, Google Ads, Meta, LinkedIn, Clarity) — 30 min
2. Technical SEO audit + fixes — 2 hrs
3. GBP optimization + review push setup — 4 hrs
4. Homepage rewrite (H1, phone CTA, 2 pillars, dashboard label, real proof) — 4 hrs
5. `/pricing` page — 2 hrs
6. Launch $500 Google Ads test — 2 hrs

**Total: ~15 hours. Drives leads same week. Everything else waits for data.**
