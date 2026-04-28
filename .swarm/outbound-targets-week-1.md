# Outbound Targets — Week 1

**WU:** WU-OUTBOUND-02
**Vertical:** Construction (Clark County, WA — Vancouver / Battle Ground / Camas / Washougal / Ridgefield, plus near-side Portland metro)
**Wedge profile:** General contractors and specialty subs, 10–25 employees
**Roles to target (in order of preference):** Office Manager → Operations Manager → Bookkeeper / Controller → Owner-operator (only if firm <10 employees)
**Generated:** 2026-04-28
**Rotates:** weekly (next file: `.swarm/outbound-targets-week-2.md`)

---

## Data-gap notice

This file ships as a **25-row research scaffold**, not a finished prospect list.
The agent does not have authenticated access to LinkedIn Sales Navigator, paid
data brokers, or Hunter.io credits in this run, and the WU spec explicitly
prefers a CAN-SPAM-correct template + verifiable scaffolding over fabricated
contact names.

**Justin's job before sending:**
1. Walk down the source list below (all free, public).
2. For each row, fill `firm`, `contact_name`, `title`, `email`, and verify
   `source_url`. Confirm the email exists (Hunter.io free tier = 25 verifications/mo,
   or `https://www.linkedin.com/in/...` cross-check).
3. Skip + replace any row that can't be verified — never invent an address.
4. Once 25 rows are filled and verified, send Email 1 in a batch of no more
   than 10/day to protect domain reputation.

## Research sources (all free, public, no scraping ToS issues)

| Source | URL | Notes |
| --- | --- | --- |
| WA L&I Contractor Verify | https://secure.lni.wa.gov/verify/ | Filter by city = Vancouver, license type = General. Returns firm name + bond + license. |
| Clark County Building Permits | https://www.clark.wa.gov/community-development/permits | Active permits → contractor of record. Surfaces actively-working firms (not dormant LLCs). |
| AGC of Washington — Members | https://www.agcwa.com/membership/find-a-member | Member directory of WA general contractors; many list office staff. |
| BBB — Vancouver, WA Contractors | https://www.bbb.org/us/wa/vancouver | Filter by category. Cross-reference with L&I to drop unverified firms. |
| Google Maps "general contractor Vancouver WA" | maps query | Pulls website + phone; visit Contact / About page for office-manager name. |
| LinkedIn (public profile pages, no login) | https://www.linkedin.com/search/results/people/ | Public search: `"office manager" "Vancouver, WA" construction`. Use the public surface only — no scraping logged-in pages. |
| Hunter.io free tier | https://hunter.io | 25 email verifications/mo on free plan. Use after you have firm domain + contact name. |

---

## Targets — 25 rows

Columns:
- `#` — row index (do not change)
- `firm` — legal or DBA name
- `domain` — primary website (used for email pattern guess)
- `contact_name` — first + last
- `title` — Office Manager / Ops Manager / Bookkeeper / Controller
- `email` — `[research-needed]` until verified
- `source_url` — the public URL where Justin verified the contact
- `size_est` — employees (target 10–25)
- `notes` — anything from the public footprint that becomes `{{specific_observation}}` in Email 1
- `email_1_sent_at` / `email_2_sent_at` / `email_3_sent_at` — ISO date when Justin sends
- `status` — `queued` | `sent-1` | `sent-2` | `sent-3` | `replied` | `unsubscribed` | `bounced` | `dropped`

| # | firm | domain | contact_name | title | email | source_url | size_est | notes | email_1_sent_at | email_2_sent_at | email_3_sent_at | status |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | [research-needed] | [research-needed] | [research-needed] | [research-needed] | [research-needed] | https://secure.lni.wa.gov/verify/ | 10–25 | | | | | queued |
| 2 | [research-needed] | [research-needed] | [research-needed] | [research-needed] | [research-needed] | https://secure.lni.wa.gov/verify/ | 10–25 | | | | | queued |
| 3 | [research-needed] | [research-needed] | [research-needed] | [research-needed] | [research-needed] | https://secure.lni.wa.gov/verify/ | 10–25 | | | | | queued |
| 4 | [research-needed] | [research-needed] | [research-needed] | [research-needed] | [research-needed] | https://secure.lni.wa.gov/verify/ | 10–25 | | | | | queued |
| 5 | [research-needed] | [research-needed] | [research-needed] | [research-needed] | [research-needed] | https://secure.lni.wa.gov/verify/ | 10–25 | | | | | queued |
| 6 | [research-needed] | [research-needed] | [research-needed] | [research-needed] | [research-needed] | https://www.clark.wa.gov/community-development/permits | 10–25 | | | | | queued |
| 7 | [research-needed] | [research-needed] | [research-needed] | [research-needed] | [research-needed] | https://www.clark.wa.gov/community-development/permits | 10–25 | | | | | queued |
| 8 | [research-needed] | [research-needed] | [research-needed] | [research-needed] | [research-needed] | https://www.clark.wa.gov/community-development/permits | 10–25 | | | | | queued |
| 9 | [research-needed] | [research-needed] | [research-needed] | [research-needed] | [research-needed] | https://www.clark.wa.gov/community-development/permits | 10–25 | | | | | queued |
| 10 | [research-needed] | [research-needed] | [research-needed] | [research-needed] | [research-needed] | https://www.clark.wa.gov/community-development/permits | 10–25 | | | | | queued |
| 11 | [research-needed] | [research-needed] | [research-needed] | [research-needed] | [research-needed] | https://www.agcwa.com/membership/find-a-member | 10–25 | | | | | queued |
| 12 | [research-needed] | [research-needed] | [research-needed] | [research-needed] | [research-needed] | https://www.agcwa.com/membership/find-a-member | 10–25 | | | | | queued |
| 13 | [research-needed] | [research-needed] | [research-needed] | [research-needed] | [research-needed] | https://www.agcwa.com/membership/find-a-member | 10–25 | | | | | queued |
| 14 | [research-needed] | [research-needed] | [research-needed] | [research-needed] | [research-needed] | https://www.agcwa.com/membership/find-a-member | 10–25 | | | | | queued |
| 15 | [research-needed] | [research-needed] | [research-needed] | [research-needed] | [research-needed] | https://www.agcwa.com/membership/find-a-member | 10–25 | | | | | queued |
| 16 | [research-needed] | [research-needed] | [research-needed] | [research-needed] | [research-needed] | https://www.bbb.org/us/wa/vancouver | 10–25 | | | | | queued |
| 17 | [research-needed] | [research-needed] | [research-needed] | [research-needed] | [research-needed] | https://www.bbb.org/us/wa/vancouver | 10–25 | | | | | queued |
| 18 | [research-needed] | [research-needed] | [research-needed] | [research-needed] | [research-needed] | https://www.bbb.org/us/wa/vancouver | 10–25 | | | | | queued |
| 19 | [research-needed] | [research-needed] | [research-needed] | [research-needed] | [research-needed] | https://www.bbb.org/us/wa/vancouver | 10–25 | | | | | queued |
| 20 | [research-needed] | [research-needed] | [research-needed] | [research-needed] | [research-needed] | https://www.bbb.org/us/wa/vancouver | 10–25 | | | | | queued |
| 21 | [research-needed] | [research-needed] | [research-needed] | [research-needed] | [research-needed] | google maps: "general contractor Vancouver WA" | 10–25 | | | | | queued |
| 22 | [research-needed] | [research-needed] | [research-needed] | [research-needed] | [research-needed] | google maps: "general contractor Battle Ground WA" | 10–25 | | | | | queued |
| 23 | [research-needed] | [research-needed] | [research-needed] | [research-needed] | [research-needed] | google maps: "general contractor Camas WA" | 10–25 | | | | | queued |
| 24 | [research-needed] | [research-needed] | [research-needed] | [research-needed] | [research-needed] | google maps: "general contractor Washougal WA" | 10–25 | | | | | queued |
| 25 | [research-needed] | [research-needed] | [research-needed] | [research-needed] | [research-needed] | google maps: "general contractor Ridgefield WA" | 10–25 | | | | | queued |

---

## Pre-flight checks before Justin sends Email 1

- [ ] All 25 rows have a real `firm`, `contact_name`, `title`, and `email`.
- [ ] Every email passed Hunter.io (or equivalent) verification, OR was found
      directly on the firm's public website / state filing.
- [ ] None of the 25 emails appears on the unsubscribe list in
      `.swarm/secrets.local.md`.
- [ ] CAN-SPAM footer in `.swarm/outbound-email-templates.md` has the real
      physical address — not the placeholder.
- [ ] First batch is ≤10 sends/day for the first 3 days (warm-up).

## Human gate

The agent does **not** send. Justin sends from his own domain mailbox. This
file + `outbound-email-templates.md` are the entire artifact set the agent
produces; the send action is `sending-pending-justin`.
