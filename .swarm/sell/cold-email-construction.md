# Cold email — Clark County construction firms

**Target list:** in `.swarm/outbound-targets-week-1.md` (25 named contacts).
**From address:** justin@pondata.com (or joberg@rivermountainsystems.com — the second is more on-brand)
**Send cadence:** 5/day, spaced through the morning. Not 25 in one batch — your domain reputation matters.
**Subject-line A/B:** test 2 subjects. The winner becomes the default for the rest of the list.

---

## Email 1 (intro — sent on day 1)

**Subject A (named pain):** *Procore + Sage + jobsite Wi-Fi — quick question for [BUSINESS NAME]*
**Subject B (curiosity):** *Vancouver IT for contractors — would 5 minutes be useful?*

**Body:**

> Hey [FIRST_NAME],
>
> Quick note from another local — I run **River Mountain Systems**, a managed IT shop in Vancouver focused on construction firms in Clark County and the Portland metro. I'm reaching out because [BUSINESS NAME] showed up in a list of GCs in our service area, and I wanted to introduce myself directly rather than ad-spam you.
>
> I won't pitch in this email — I just want to ask one question: **how is your team handling IT today?** Most contractors I talk to are running through one of three patterns — a part-time consultant, the office manager doing it on top of payroll, or the [vendor] that takes 3+ days to respond. None of them are great when Procore goes sideways during a draw deadline.
>
> If your setup is actually good, ignore this. If you'd like a free 30-minute IT health check (no commitment, no pitch — just a written priority list of what we'd fix in the first 30 days), here's how:
>
> - **5-min self-check tool:** rivermountainsystems.com/tools/it-health-check.html (no email required, gives you an honest score)
> - **Sample of what a real audit looks like:** rivermountainsystems.com/samples/it-health-check-sample.html (redacted, fake client, but the format is real)
> - **Or just call me:** (360) 644-4820. Mon–Fri 8a–6p PT.
>
> Either way — best of luck on the season. The Vancouver permit office is reportedly running ~3 weeks behind right now; everyone seems to be feeling that.
>
> Justin Oberg
> Founder, River Mountain Systems
> rivermountainsystems.com · (360) 644-4820

**Why this works:**
- Local-to-local opener (Vancouver to Vancouver) lowers the cold-email barrier
- The "permit office 3 weeks behind" line is a real local-specific signal that reads as "I actually live here, I'm not in a Bangalore call center"
- No ask for a meeting. The CTA is a free self-serve tool first, the meeting second.
- Three CTAs, ranked by friction: the quiz (lowest), the sample report (medium), the phone call (highest)

---

## Email 2 — value-add follow-up (day 5 if no reply)

**Subject:** *Quick construction-IT thing I should've sent first*

> Hey [FIRST_NAME],
>
> Following up on my note from earlier this week. Wanted to send one concrete tip instead of another "checking in" email:
>
> **The single biggest IT exposure I see at construction firms in this size band is shared Procore + Sage credentials.** When 4 people log in as "office@business.com" with the same password, you lose audit trail per user, your offboarding is broken (former employees keep access), and a single credential leak unlocks everything. The fix is 30 minutes per user — set them up with their own login, MFA, and remove the shared one. Costs nothing if you're already paying per-seat.
>
> If you want me to walk through your specific setup — free, 30 min on the phone, no ongoing — (360) 644-4820 or grab time at cal.com/rivermountainsystems.
>
> If shared logins aren't your situation, ignore this and tell me to stop emailing.
>
> Justin
> rivermountainsystems.com

**Why this works:**
- Demonstrates expertise without pitching
- The "tell me to stop emailing" close is the most respect-signaling reply ask in cold email — it actually increases reply rate
- The tip is real and applies to ~70% of construction firms in this size band

---

## Email 3 — breakup (day 10 if still no reply)

**Subject:** *Last one — promise*

> Hey [FIRST_NAME],
>
> Going to stop emailing after this one. I don't want to be the IT guy who's already a nuisance before he's an MSP.
>
> If [BUSINESS NAME] ever does want a second opinion on the IT side, the door's open: (360) 644-4820 or rivermountainsystems.com. Otherwise — no further follow-up from me.
>
> Best on the season.
>
> Justin

**Why this works:** breakup emails get the highest reply rate of any cold sequence (~7–12% in B2B SMB benchmarks). Self-imposed scarcity ("I'll stop emailing") creates a tiny urgency.

---

## What to NOT do

- **Don't BCC.** Send each email individually with the recipient's name. Email tools like Mailmerge, Lemlist, Apollo, or Streak send personalized one-at-a-time. Free tier of any is fine for 25/wk.
- **Don't attach PDFs.** Spam filters hate them on first contact. Link to web pages instead.
- **Don't include images or HTML signatures.** Plain text gets through filters at 2–3x the rate of styled HTML.
- **Don't follow up more than 3x.** After the breakup email, stop.
- **Don't email outside business hours their time.** 9am–11am Pacific lands in their inbox at the start of their workday.
- **Don't email Friday afternoons.** Weekend dies, gets buried Monday.

---

## CAN-SPAM compliance

Every email needs:
- A real physical mailing address in the footer (your home or PO box is fine; required by law)
- An unsubscribe option ("Reply STOP and I'll remove you" is a valid mechanism for personal one-to-one cold email; for bulk you'd need a real unsubscribe link)
- Truthful subject and from line (don't fake who you are or where the email is from)

A simple compliant footer:

> Justin Oberg · River Mountain Systems · [your physical address], Vancouver, WA 98685
> Reply STOP and I'll remove you from all future contact.

---

## Tracking

If you use a sender like Apollo or Lemlist, you can see opens/clicks. For now, the simplest tracking is:
- The Cal.com booking attribution we built will tell you if any of them book a call
- The IT Health Check page logs `quiz_completed` events in GA4
- Any inbound call to (360) 644-4820 from a number in your target list — match it back manually
