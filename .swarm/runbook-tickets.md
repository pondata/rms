---
title: River Mountain Systems — Ticket Runbook
owner: Justin P. Åberg
last_reviewed: 2026-04-28
audience: internal ops + sophisticated buyers (co-managed peers, IT directors, MSP M&A diligence)
status: live
version: 1.0
---

# Ticket Runbook — One Page

This is the operating procedure for every support request that enters River Mountain Systems (RMS). It covers the full lifecycle from first contact to invoice, with explicit SLA timers and escalation rules. If you're a buyer asking *"how does work actually flow through your shop?"* — this is the answer.

Today RMS is operator-led: Justin Åberg owns triage, work, and closure. The runbook is written so the same flow scales from solo to a co-managed pod (Justin + 1–2 techs + dispatch) without changing the lifecycle stages — only who occupies which role.

---

## Flowchart

```mermaid
flowchart TD
    A1[Phone<br/>360-644-4820] --> B[Stage 1<br/>Inbound capture]
    A2[Answering service<br/>after-hours / overflow] --> B
    A3[Email<br/>joberg@rivermountainsystems.com] --> B
    A4[Portal / Cal.com<br/>booking] --> B

    B --> C{Stage 2<br/>Triage<br/>P1 / P2 / P3}

    C -->|P1 Critical| D1[Stage 3<br/>Assign — Justin<br/>drop everything]
    C -->|P2 Degraded| D2[Stage 3<br/>Assign — Justin<br/>or pod tech]
    C -->|P3 Standard| D3[Stage 3<br/>Assign — queue<br/>by next-available]

    D1 --> E[Stage 4<br/>SLA timer starts<br/>at first acknowledgement]
    D2 --> E
    D3 --> E

    E --> F[Stage 5<br/>Work + status updates<br/>timer pauses if client-blocked]

    F --> G{SLA breach risk?}
    G -->|Yes| H[Escalation<br/>see §Escalation rules]
    G -->|No| I[Stage 6<br/>Resolution<br/>+ client confirmation]
    H --> I

    I --> J[Stage 7<br/>Invoicing + closure<br/>recurring / project / T&M]
    J --> K((Closed))
```

---

## Lifecycle stages

### Stage 1 — Inbound capture
Every contact lands as a ticket within 1 business hour of arrival, regardless of channel. No verbal or texted request is "remembered" — it gets logged.

| Channel | Destination | Capture method |
|---|---|---|
| Phone — `(360) 644-4820` | Justin's mobile (direct, per `.swarm/phone-routing-live.md`) | Justin logs ticket in PSA after call; if missed, voicemail transcribed → ticket within 1 hr |
| Answering service | Activates when WU-PHONE-01 vendor goes live (Ruby / AnswerConnect / Smith.ai) | Service dispatches ticket via email/API on every call; P1 also triggers SMS to Justin |
| Email | `joberg@rivermountainsystems.com` | Forwarded to PSA inbox; auto-creates ticket; auto-acknowledges sender |
| Portal | Cal.com booking today; PSA self-service portal once stood up | Booking → ticket; portal form → ticket with attachments |

**Required ticket fields at capture:** client, contact name + callback, channel, raw description, business impact (one sentence), affected systems/users.

### Stage 2 — Triage (P1 / P2 / P3)
Triage happens at capture or within 30 minutes of capture, whichever is sooner. The priority drives SLA, assignment, and escalation. **Triage is not negotiable on volume — every ticket gets a priority before it gets worked.**

| Priority | Definition | Examples | SLA — first response | SLA — resolution target |
|---|---|---|---|---|
| **P1 — Critical** | Business operations halted. Revenue, payroll, or safety at risk. No workaround. | M365 tenant outage, ransomware/active intrusion, server down, payroll cannot run, internet down at HQ during business hours, line-of-business app totally unavailable | **Same-day response, business hours.** After-hours P1: 30-min callback from Justin or on-call tech. | 4 business hours to mitigation; full resolution case-by-case |
| **P2 — Degraded** | Working but impaired. Workaround exists. Single user blocked or department-wide slowness. | Email slow/intermittent, printer down, single-user account locked, VPN flaky, app crashes intermittently | 4 business hours | 1 business day |
| **P3 — Standard** | How-to, request, scheduled work, low-impact. | New-hire onboarding (non-urgent), license request, password reset (non-locked), cabling, scheduled patching, reporting question | 1 business day | 5 business days (or scheduled date) |

**Public-facing SLA wording:** "Same-day response, business hours." Per `.swarm/phone-routing-live.md`, the 15-minute number is **not marketable** until phone routing matures (WU-PHONE-01 reactivation triggers). Do not publish 15-min wording.

**Triage authority:** Justin today; dispatch role in the future pod model. Client may request priority bump; the bump is honored only if triage criteria support it (no inflated P1s).

### Stage 3 — Assignment
| Priority | Default assignee | Rule |
|---|---|---|
| P1 | Justin (drop-everything) | Pod model: primary on-call tech; Justin co-owns until mitigated |
| P2 | Justin or pod tech with capacity | Skills-match → soonest free slot |
| P3 | Round-robin / next-available | Batched into scheduled blocks |

Assignment is logged in PSA with assignee, expected start, and committed first-response time. Client receives an acknowledgement that names the owner.

### Stage 4 — SLA timer start
- Timer starts at **first acknowledgement** (auto-ack email or human reply, whichever is first).
- Timer **pauses** when ticket status = `awaiting client info` (client-blocked).
- Timer **resumes** the moment the client replies.
- Timer is logged per state-change in PSA. Pause reasons must be explicit ("waiting on credentials", "waiting on vendor RMA", "waiting on scheduled window").
- After-hours P1: timer runs against the after-hours SLA (30-min callback); business-hours SLAs do not apply outside Mon–Fri 8a–6p PT.

### Stage 5 — Work + status updates
Cadence of client updates is mandatory and proportional to priority:

| Priority | Update cadence to client |
|---|---|
| P1 | Every 60 minutes until mitigated, then at resolution |
| P2 | At start, at midpoint, at resolution (minimum daily if multi-day) |
| P3 | At start and at resolution; interim updates if slipping past target |

Every status change (in-progress → awaiting-client → in-progress → resolved) is logged in PSA. Time entries are captured live, not reconstructed.

### Stage 6 — Resolution + client confirmation
- Tech marks ticket `resolved` with: root cause, fix applied, prevention notes, time spent.
- Client receives a resolution summary and is asked to confirm.
- Ticket auto-closes 3 business days after `resolved` if client does not respond.
- If client reports the issue is **not** fixed, ticket reopens at the **same priority** and the SLA clock restarts on the resolution target (not first-response).
- Post-incident: P1 tickets generate a 1-paragraph internal write-up (what failed, what we changed) within 5 business days.

### Stage 7 — Invoicing + closure
Billing model is set in the client agreement and applied at closure:

| Engagement type | Billing | Trigger |
|---|---|---|
| Managed services (recurring) | Monthly recurring on the **1st**, in advance | Auto-generated by PSA on the 1st; ticket time rolls into the flat fee |
| Project work | Per milestone, defined in SOW | Milestone sign-off → invoice |
| Time & materials (ad-hoc) | **$185/hr**, billed in 15-min increments after a 1-hr minimum | Ticket closure → invoice within 5 business days |

After-hours T&M (outside Mon–Fri 8a–6p PT): 1.5× rate unless the client agreement specifies otherwise.

Ticket is `closed` in PSA only after invoice is issued (T&M / project) or rolled into the recurring batch (managed). Closure note records billing path.

---

## Escalation rules

Escalation is automatic on time-in-state, not on judgment calls. The PSA enforces these timers; Justin receives the escalation alert.

| Trigger | Action |
|---|---|
| **P1 unresolved 4 hrs (mitigation not achieved)** | Justin escalates to vendor partner or co-managed peer. Placeholder partner list: Microsoft Pro support (M365), vendor-of-record for affected line-of-business app, peer MSP for hands-on-deck (TBD — recruit during WU-PARTNER-XX). Client gets a written status with named escalation contact. |
| **P2 unresolved 8 business hours** | Re-triage. If still legitimately P2, reassign to a fresh tech (or Justin takes over). If business impact has grown, upgrade to P1 and restart Stage 3. |
| **P3 stale 5 business days with no client reply** | Auto-nudge to client (email). After 2 nudges (10 business days total) → close as `pending-client`. Reopen on client reply. |
| **Any ticket: client requests escalation** | Routes to Justin within 1 business hour. Justin owns the response personally. |
| **Repeat incident (same root cause within 30 days)** | Auto-flagged. Triggers a problem ticket (separate from incident) and a written remediation plan to client within 5 business days. |
| **Security incident suspected at any priority** | Immediate hard-escalation: isolate affected systems, notify client primary contact, engage IR partner. SLA timers do not apply — incident-response playbook takes over. |

---

## Roles (today and next)

| Role | Today | Pod model (next) |
|---|---|---|
| Inbound capture | Justin (phone), email auto-capture | Answering service + dispatch |
| Triage | Justin | Dispatch (with Justin as escalation) |
| P1 owner | Justin | Primary on-call tech + Justin co-own |
| P2/P3 owner | Justin | Pod tech, round-robin |
| Escalation contact | Justin | Justin |
| Invoicing | Justin (monthly batch + per-close T&M) | Bookkeeping role + Justin sign-off |

---

## SLA summary card (for client-facing use)

> **River Mountain Systems support**
> - P1 (critical, business halted): **same-day response, business hours**; 30-min callback after-hours
> - P2 (degraded, workaround exists): 4 business hours
> - P3 (standard request): 1 business day
> Hours: Mon–Fri 8a–6p PT. After-hours coverage available on managed-service agreements.

---

## Change log
- 2026-04-28 — v1.0 — Initial runbook (WU-PSA-02). Triage thresholds, SLA timers, escalation rules, billing model captured. Public SLA wording pinned to "same-day response, business hours" per `.swarm/phone-routing-live.md`.
