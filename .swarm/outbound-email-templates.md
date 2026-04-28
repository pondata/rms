# Outbound Email Templates — Construction Vertical

**WU:** WU-OUTBOUND-02
**Vertical:** Construction (Clark County, WA / Vancouver / Portland metro)
**Wedge profile:** GCs + specialty subs, 10–25 employees, office-manager / operations-manager / bookkeeper as primary contact
**Sender:** Justin Paul Åberg <justin@rivermountainsystems.com> (sends from his domain — agent drafts only)
**Cadence:** Email 1 → +5 days Email 2 → +10 days Email 3 (breakup). Total window: 2 weeks.
**Tone:** First-person, plain English, no buzzwords, no pitch in Email 1. CAN-SPAM compliant footer on every send.

---

## How to use

1. Pull a row from `.swarm/outbound-targets-week-1.md`.
2. Replace every `{{token}}` below.
3. Send from `justin@rivermountainsystems.com` (or whatever domain alias Justin uses).
4. Log the send timestamp in column `email_1_sent_at` of the targets sheet.
5. If they reply at any stage, drop them from the cadence. If they ask to be removed, add their email to the manual unsubscribe list (see Unsubscribe handling below) and never email again.
6. Do **not** send Emails 2 or 3 if Email 1 bounced. Mark the row `bounced` and move on.

### Token glossary

| Token | Example |
| --- | --- |
| `{{firm}}` | "Tapani Inc." |
| `{{first_name}}` | "Sarah" |
| `{{vertical_hook}}` | one of: "jobsite Wi-Fi", "Procore + Sage hand-offs", "submittal-PDF email security", "M365 license waste" |
| `{{specific_observation}}` | one short line tied to their public footprint, e.g. "saw you just opened a second yard in Battle Ground" — leave blank if you have nothing real |

---

## Email 1 — Intro + free 30-min IT health check (no pitch)

**Send:** Day 0
**Subject:** Free 30-min IT health check for {{firm}}
**Word count target:** ≤120

```
Hi {{first_name}},

I'm Justin — I run River Mountain Systems, a small IT shop here in Vancouver
that works with Clark County construction firms in the 10–25 employee range.

I'm not pitching managed services in this email. I'm offering a free 30-minute
IT health check — Zoom or in person, your call. You walk away with a one-page
snapshot of where IT could break: jobsite Wi-Fi, ransomware exposure on
submittal PDFs, M365 license waste, that kind of thing. No follow-up sales call
unless you ask for one.

If that's useful, reply with a time, or grab a slot here:
https://cal.com/rivermountainsystems

Either way — thanks for the work you do. Roads and buildings don't build themselves.

— Justin
River Mountain Systems
(360) 644-4820
justin@rivermountainsystems.com
```

---

## Email 2 — Value-add (one vertical-specific tip)

**Send:** Day 5 (only if no reply to Email 1 and Email 1 did not bounce)
**Subject:** Construction IT — 1 quick tip
**Word count target:** ≤120

```
Hi {{first_name}},

Quick one — no ask.

The submittal-PDF ransomware route is hitting Pacific Northwest GCs hard right
now. The pattern: a sub emails a real-looking submittal PDF with an embedded
macro, your office manager opens it because the filename matches a live job,
and 20 minutes later your file server is encrypted. Standard email filters miss
it because the sender domain is legitimate (the sub's mailbox got popped
upstream).

Two-minute fix: in M365, turn on "Safe Attachments" with Dynamic Delivery for
your office staff. It sandboxes the PDF before it hits the inbox. Costs nothing
extra on Business Premium.

Happy to walk through it on a call if useful.

— Justin
(360) 644-4820
```

---

## Email 3 — Breakup

**Send:** Day 10 (only if no reply to Emails 1 or 2)
**Subject:** Last note from RMS
**Word count target:** ≤120

```
Hi {{first_name}},

I won't keep emailing — I know the inbox is loud.

If IT becomes urgent, my number is (360) 644-4820. Otherwise, take care, and
good luck with the season.

— Justin
River Mountain Systems
```

---

## CAN-SPAM compliance footer (append to EVERY email above)

Each send must include the footer below, separated by a single blank line and
a `--` separator. Plain text, no tracking-pixel image, no obfuscated link.

```
--
River Mountain Systems
[ADDRESS — Vancouver, WA — replace with real street address before first send]
Vancouver, WA

You're receiving this because I'm reaching out to local Clark County
construction firms one time. To stop hearing from me, just reply with the
word "unsubscribe" and I'll remove you the same day.
```

### Unsubscribe handling (manual, until volume justifies tooling)

- Justin maintains `.swarm/secrets.local.md` (gitignored) with a section
  `## Outbound unsubscribe list` — one email per line, lowercase.
- Before any send, grep that list. If the recipient is on it, **do not send**
  and remove them from the targets sheet.
- Honor any "remove me / stop / unsubscribe" reply within 10 business days
  (CAN-SPAM requires ≤10 days; we target same-day).

---

## Word-count verification

| Email | Body words (excl. subject + footer) |
| --- | --- |
| Email 1 | ~115 |
| Email 2 | ~115 |
| Email 3 | ~30 |

All three are under the 120-word ceiling.

---

## Compliance checklist (before first send)

- [ ] Replace `[ADDRESS — Vancouver, WA]` in the footer with a real, verifiable
      physical postal address (P.O. Box is acceptable under CAN-SPAM).
- [ ] Confirm `cal.com/rivermountainsystems` resolves to a real booking page
      (or replace with the actual scheduling URL).
- [ ] Confirm `justin@rivermountainsystems.com` is the live sending mailbox
      (SPF/DKIM/DMARC pass — otherwise Email 1 will land in spam).
- [ ] Set up a manual `outbound-log` row per send (firm, contact, date, stage).
- [ ] Justin sends from his own mailbox. The agent does not send.
