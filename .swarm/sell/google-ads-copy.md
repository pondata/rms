# Google Ads copy — for the $1.50/day → $15/day bump

You already approved the bump in the audit (WU-ADS-01). When you push the slider in the Ads dashboard, also update the ad copy with these — far stronger than the current generic version.

---

## Campaign structure

**Recommended:** one Search campaign + one Performance Max for the geo. Don't overcomplicate.

- **Search campaign budget:** $15/day cap, max-clicks bidding
- **Performance Max campaign budget:** $5/day, geo-targeted to Clark County WA + Multnomah/Washington counties OR
- **Single keyword group inside Search:** start narrow

### Keywords (priority order, exact match where possible)

```
"managed IT Vancouver WA"          [exact]
"managed IT services Vancouver"    [exact]
"IT support Vancouver WA"          [exact]
"small business IT Vancouver"      [phrase]
"IT services Clark County"         [phrase]
"managed service provider Vancouver WA"  [phrase]
"small business IT Portland"       [phrase] — only if budget allows
```

**Negative keywords (add immediately):** `free`, `tutorial`, `course`, `jobs`, `salary`, `internship`, `kaiser`, `permanente`, `microsoft`. These eat budget on irrelevant searches.

---

## Ad headlines (15-character max each — use as many as Google lets you)

Pick 8–10 of these for a Responsive Search Ad. Google rotates and picks winners:

```
Managed IT Vancouver WA
Posted Price: $99/User
30-Day Paid Pilot
Same-Day Response IT
Founder-Led IT Support
No Long-Term Contracts
Free 30-Min IT Consult
Vancouver WA SMB IT
$99/User. No Surprises.
Construction IT Vancouver
Justin Picks Up Phone
Real SLA, Posted Online
Stop Firefighting IT
Clark County IT Pro
Built For 10–100 Person
```

---

## Ad descriptions (90-character max each — use 4)

```
Founder-led IT for Vancouver, WA. $99/user/mo. 30-day pilot. Same-day response.
Posted price, signed SLA, no long-term lock-in. Justin answers the phone himself.
For 10–100 person businesses tired of MSPs that hide pricing and dodge SLA promises.
Free 30-min consult. Free IT Health Check tool. No email required to see results.
```

---

## Sitelinks (4 — use these exact URLs + descriptions)

1. **30-day pilot terms** → `/pilot-terms.html` — *"Public exit clause. Read before you sign."*
2. **Response-time SLA** → `/sla.html` — *"P1/P2/P3 targets. Public, plain English."*
3. **Free IT Health Check** → `/tools/it-health-check.html` — *"5-min scorecard. No email needed."*
4. **Pricing** → `/pricing.html` — *"$99/user. $497 audit. $25K project floor."*

Sitelinks roughly double CTR — never run an ad without them.

---

## Callouts (each 25 chars)

```
$99/user/month
10-user minimum
30-day paid pilot
Posted SLA online
Founder-led
Same-day response
Vancouver, WA based
No long-term contracts
$1M E&O insured
12+ years IT operations
```

---

## Conversion actions to track

In Google Ads → Tools → Conversions, set up these as conversion events:

1. **Cal.com booking** — set up via Cal.com → Apps → Google Analytics integration (forwards `cal_book` event to GA4 → Ads imports it)
2. **Phone call** — Ads has a built-in call-tracking feature; enable for `(360) 644-4820`
3. **Form submit** — already firing as `form_submit` in GA4
4. **Health Check completed** — already firing as `health_check_complete` in GA4

Until conversion tracking is live, optimize for clicks. Once you have ~30 conversions, switch to Maximize Conversions bidding (Google's algorithm needs ~30 events to learn).

---

## What to watch in the first 7 days

- **CTR ≥ 4%** is the bar. Below that, the ad copy is wrong.
- **CPC $4–$12** is normal for Vancouver "IT support." Above $20, you're competing with national MSPs willing to pay more.
- **Bounce rate from ads ≤ 60%.** Above that, the landing page doesn't match the search intent.
- **Search-terms report** (Tools → Search terms): every 3 days, look at what people actually typed. Add irrelevant matches as negative keywords.

---

## After 30 days of data

- Pause anything with CTR < 2%
- Pause anything with CPC > $25
- Double the budget on the single keyword group with the lowest CPL (cost per lead)
- Add 2 new ad variations testing a different value-prop (e.g., "Stop firefighting" vs "Posted price")

---

## What NOT to do

- **Don't use display network** for a 1-tech MSP. It burns budget on impressions that never convert.
- **Don't enable Smart Bidding** until 30+ conversions in the account. Smart bidding without data spends money randomly.
- **Don't run ads to the homepage** if you have a vertical landing page (`/industries/construction-vancouver-wa.html` outperforms the homepage for contractor-keyword traffic by 30–50%). Set the final URL per ad to the most-relevant page.
- **Don't bid on competitor names** until you've talked to a lawyer about Washington trademark law. Some competitors will sue.
