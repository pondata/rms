# WU-PHONE-01 — Phone routing + answering-service spec (agent prep)

**Status:** PREP — agent-authored decision matrix. Justin executes vendor selection and signup. Outcome lands in `.swarm/phone-routing-live.md` (gitignored).
**Existing line:** `(360) 644-4820` — DO NOT change this number anywhere. Routing layers sit *behind* it.
**Hard cost ceiling:** ≤ $170/mo target, $250/mo absolute, until first MSP client signs.

---

## 1. Phone routing platform comparison

The job of this layer: own `(360) 644-4820`, ring Justin's mobile during business hours, fall through to the answering service after hours, and provide an SMS auto-reply to missed calls.

| Feature | **OpenPhone** | **Google Voice (Workspace)** | Dialpad / RingCentral (reference) |
|---|---|---|---|
| Monthly cost (1 user, 1 number) | $19 Standard / $33 Business | $10 Starter (≤10 users) on Workspace; free personal GV not portable to a business number | $27–$35+ per user |
| Port-in `(360) 644-4820` | Yes, ~5–10 business days, free | Yes on Workspace tier, $20 one-time port fee, ~3–5 business days. Free personal GV does **not** allow porting *in* of an existing US number it doesn't already host | Yes |
| SMS auto-reply on missed call | **Native** — per-number auto-reply, business-hours rules, snippets | **No** native missed-call SMS. Requires Apps Script / Zapier glue or doesn't happen | Native |
| Business-hours forwarding rules | Per-number schedule, per-day, fallback to voicemail or another number | Per-user schedule via "Do Not Disturb"; forwarding to external number is limited and can drop on Workspace tier | Robust |
| IVR / auto-attendant | Built-in, simple ("Press 1 for support") | Workspace has basic auto-attendant; Starter tier does not | Built-in |
| Voicemail-to-text | Yes, accurate | Yes, mediocre | Yes |
| M365 / Calendar integration | Slack, HubSpot, Zapier; no native M365 calendar | Native Google Calendar; M365 not native | Native both |
| Mobile + desktop apps | iOS / Android / macOS / Windows / web | iOS / Android / web (no desktop app) | Full |
| Shared inbox (multiple humans answer same number) | Yes — core feature | No | Yes |
| Vendor quirks | Recording is paid add-on on Standard. Spam filter is decent. | GV requires Workspace seat for the business number; rules engine is thin. Auto-reply on miss is the dealbreaker. | Pricier; built for 10+ seats. |

**Recommendation:** **OpenPhone Standard at $19/mo.** Two reasons that override cost: (a) native SMS auto-reply on missed calls (Google Voice can't do this without glue and is fragile), and (b) the shared-inbox model maps to MSP support flow when a second tech joins. Google Voice on Workspace is $10/mo cheaper but the missing auto-reply forces hand-built Zapier infrastructure that becomes tech debt. Pick Google Voice only if Justin has already paid for Workspace and wants strict cost zero on this layer.

**Port-in protocol for `(360) 644-4820`:**
1. Do not change the published number anywhere on the site or marketing material.
2. Open OpenPhone account, request port-in of `(360) 644-4820`.
3. Keep the current carrier active until port confirms (5–10 business days). Do not cancel old service early — cancelling kills the port.
4. Test inbound + outbound before flipping the answering-service forward target.

---

## 2. Answering-service vendor list

Target: human (or human-supervised AI) answers when Justin can't, classifies the call, and sends Justin an SMS within 5 minutes for any P1.

| Feature | **Ruby Receptionists** | **AnswerConnect** | **Smith.ai** |
|---|---|---|---|
| Pricing target ($50–$120/mo for ~30 calls) | Lowest plan ~$235/mo / 50 calls. **Above ceiling.** | Plans from ~$90/mo / 30 calls (24/7) | Plans from ~$285/mo / 30 calls. **Above ceiling.** Starter virtual receptionist ~$140/mo / 20 calls is close. |
| Per-minute / per-call overage | ~$3.50–$4.50 / extra call | ~$1.85 / extra call | ~$8 / extra call |
| P1 SMS-to-Justin feature | Yes — "urgent message" SMS as part of intake config | Yes — "warm transfer + SMS notify" is core feature, configurable per call type | Yes — "text Justin immediately" workflow is configurable |
| AI vs human | Human (US) | Human, US-based, 24/7 | Hybrid: AI receptionist + human escalation |
| After-hours coverage | Business-hours plan default; 24/7 costs more | **24/7 included** | 24/7 available |
| CRM / Slack / email integration | HubSpot, Slack, basic email | HubSpot, Salesforce, Zapier, Slack, email | Slack, HubSpot, Zapier, Clio, email, native API |
| Free trial | 21-day money-back | 7-day free trial | 14-day free trial / first 20 calls free |
| Contract length | Month-to-month | Month-to-month | Month-to-month |
| Vendor quirks | Polished US receptionists, but pricing is built for law firms. Hard to get under $200. | Cheapest of the three at our volume. Quality is good but not Ruby-grade. | AI-first; AI handoffs can feel robotic on first call. Powerful integrations. |

**Recommendation rubric:** P1-SMS reliability + month-to-month + ≤$120/mo cap.
- **Primary pick:** **AnswerConnect** — only vendor whose entry plan fits the $50–$120 budget at ~30 calls/mo *and* delivers 24/7 + reliable P1 SMS. Take the 7-day free trial first; run a P1 simulation before committing the card.
- **Fallback:** **Smith.ai virtual receptionist starter** (~$140/mo) if AnswerConnect's escalation feels weak in trial. Slightly above ceiling, but inside the $250 absolute hard line.
- **Defer:** Ruby Receptionists. Quality is real but pricing won't fit pre-first-MSP-client.

Ask each vendor in the discovery call: "If a caller says the words 'we're locked out' or 'system is down', will your agent send me an SMS within 5 minutes? Show me where that's configured." If the answer is hand-wavy, eliminate.

---

## 3. Answering-service script — Justin hands this verbatim to chosen vendor

### 3.1 Greeting (verbatim)
> *"Thank you for calling River Mountain Systems, this is [agent]. How can I help?"*

Do not say "voicemail," "answering service," or "after-hours line." Caller should believe they reached the firm.

### 3.2 Triage tree

**P1 — System down / outage / cannot work**
- Trigger phrases: *"locked out," "everything is down," "can't log in," "ransomware," "we got hacked," "email is broken for everyone," "server is down," "site is down."*
- Action sequence:
  1. Collect: caller name, company, callback number, one-line problem statement.
  2. **Immediately** trigger the answering-service P1-SMS escalation to Justin's mobile. SMS must contain: caller name, callback number, one-line problem.
  3. Tell caller: *"I've paged Justin directly. He'll call you back within 15 minutes during business hours, 30 minutes after hours."*
  4. Do NOT promise a fix ETA. Do NOT quote pricing.

**P2 — Degraded but working**
- Trigger phrases: *"slow," "intermittent," "one user can't print," "Wi-Fi is flaky," "need help with a setting."*
- Action: collect name + callback + problem. Schedule a callback window within **4 business hours**. Email transcript to `joberg@rivermountainsystems.com`. No SMS.

**P3 — Non-urgent / how-to / billing / sales inquiry**
- Trigger phrases: *"general question," "pricing," "do you support X," "invoice question," "want to schedule a quote."*
- Action: collect name + callback + reason. Email transcript to `joberg@rivermountainsystems.com`. No SMS. Justin returns next business day.

### 3.3 Hours

- **Business hours:** Mon–Fri, 8:00am–6:00pm Pacific. Primary line `(360) 644-4820` rings Justin's mobile direct. Answering service does **not** intercept during these hours unless Justin's mobile rolls to voicemail (3 missed rings).
- **After hours / weekends:** answering service handles all calls per triage tree above.

### 3.4 Spam filter

Discard silently — do not forward, do not log, do not SMS:
- "Vehicle warranty," "Google business listing," "SEO services," "we noticed your website," "merchant services," IRS robocalls, generic political robocalls.
- Agent's discretion on common red flags. If unsure, default to P3.

---

## 4. 15-min SLA go-live checklist

All five must pass before the SLA wording on the site can be upgraded from "Same-day response" to "15-min response during business hours." This gates **WU-HERO-01**.

- [ ] **Forward test:** `(360) 644-4820` forwards to Justin's mobile during business hours. Test call from a number Justin doesn't own. Expect ≤ 4 rings before Justin's phone rings.
- [ ] **After-hours route:** Test call placed at 7:00pm PT routes to answering service, not voicemail.
- [ ] **P1 classification:** Test caller says *"we're locked out of M365."* Answering service correctly classifies as P1 and triggers SMS escalation.
- [ ] **SMS within 5 min:** Justin's mobile receives SMS within 5 minutes of the test call. SMS contains caller name + callback number + one-line problem statement.
- [ ] **Justin reply path:** Justin replies to the test caller (or the answering-service rep, per their flow) within the test window without leaking that it was a test.

When all five tick → write `.swarm/phone-routing-live.md` containing: vendor name, monthly cost, plan tier, go-live date, port-in completion date for `(360) 644-4820`. That file is gitignored — local only. Once it exists, **WU-HERO-01** is unblocked to publish the 15-min SLA wording.

---

## 5. Cost ceiling

| Layer | Target | Hard line |
|---|---|---|
| Phone routing (OpenPhone Standard) | $19/mo | — |
| Answering service (AnswerConnect entry / Smith.ai starter) | $90–$140/mo | — |
| **Total monthly** | **≤ $170/mo** | **$250/mo absolute until first MSP client signs** |

If the only viable vendor pushes total > $250/mo, stop and re-scope. Options before exceeding hard line: drop to business-hours-only answering coverage, use AI-only Smith.ai tier, or defer the SLA upgrade and keep "Same-day response" on the site.

---

## 6. Hard constraints (do not violate)

- The published phone number `(360) 644-4820` does not change. Routing layers sit behind it.
- Agent (this doc) does not contact vendors, does not sign up, does not enter card details. Justin executes.
- No insurance binding, no contract signing, no spend commitment authored by agent.
- `.swarm/phone-routing-live.md` is gitignored. Vendor + cost + go-live date stay local until Justin chooses to surface them.
