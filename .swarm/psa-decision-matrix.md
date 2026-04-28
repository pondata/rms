# PSA / RMM Tooling Decision Matrix

**WU:** WU-PSA-01
**Owner:** Justin (solo MSP, RMS - Clark County, WA)
**Vertical (locked):** Construction (per `vertical.md`, WU-VERTICAL-01)
**Date:** 2026-04-28
**Pricing source:** WU-PSA-01 spec-listed prices (vendor pages were not WebFetch-accessible from this environment on 2026-04-28; prices below are spec-of-record and must be confirmed at signature time). Vendor pricing pages: atera.com/pricing, superops.com/pricing, halopsa.com/pricing, ninjaone.com/pricing.

---

## 1. Vendors evaluated

| # | Vendor | Posture | Spec-of-record price |
|---|--------|---------|----------------------|
| 1 | **Atera** | All-in-one PSA + RMM, per-technician unlimited endpoints | $129 / tech / mo (Pro tier, RMM included) |
| 2 | **HaloPSA** | PSA-only (RMM via integration); free under 3 techs | $0 (<3 techs) -> ~$85 / tech / mo paid; RMM separate (NinjaOne / Datto add-on) |
| 3 | **SuperOps** | Modern unified PSA + RMM, per-technician | $79 / tech / mo (Pro / Standard tier with PSA+RMM) |
| 4 | **NinjaOne** | RMM-first, per-endpoint; PSA via partner (HaloPSA, ConnectWise) or basic ticketing add-on | ~$3-7 / endpoint / mo (premium tier) - PSA NOT included |

---

## 2. Eight-axis comparison matrix

Scoring: **5 = best in class, 4 = strong, 3 = adequate, 2 = weak, 1 = poor**.
Construction-mobile (axis 7) is double-weighted in the recommendation since the vertical is locked.

| # | Axis | Atera | HaloPSA | SuperOps | NinjaOne |
|---|------|:-----:|:-------:|:--------:|:--------:|
| 1 | Ticketing UX | 3 | **5** | 4 | 2 (basic) |
| 2 | RMM agent maturity | 3 | 1 (none native) | 4 | **5** |
| 3 | PSA depth (projects, time, contracts, recurring billing) | 3 | **5** | 4 | 1 |
| 4 | M365 / Datto / Sophos integration | 3 | **5** | 3 | 4 |
| 5 | Billing automation (recurring invoices, time-to-invoice) | 4 | **5** | 4 | 1 |
| 6 | Mobile experience (tech app + jobsite use) | 4 | 3 | 3 | **5** |
| 7 | Vertical fit - construction (jobsite mobile, ruggedized agents, foreman tablets) **[2x weight]** | 4 | 2 | 3 | **5** |
| 8 | Total Y1 cost at 1->10 clients (per-tech licensing, projected below) | 3 | **5** (free tier covers Y1) | 4 | 3 (endpoint-priced - scales with client size) |
| | **Weighted total (axis 7 x2)** | **27** | **33** | **30** | **31** |

**Notes on scoring:**
- HaloPSA wins on PSA depth, ticketing, integrations, and sub-3-tech cost - but lacks native RMM, so cannot stand alone for a construction MSP that needs jobsite agent visibility.
- NinjaOne wins on RMM, mobile, and vertical fit - but lacks PSA depth; needs pairing.
- Atera is the all-in-one floor - adequate everywhere, best at nothing, simple pricing.
- SuperOps is the modern middle - solid unified product, weaker on construction-specific mobile / ruggedized agent edge cases.

The raw weighted score puts HaloPSA highest, but the score is misleading: HaloPSA depends on a paired RMM, which the score table doesn't fully penalize. The recommendation in section 5 corrects for that.

---

## 3. Per-vendor pros / cons

### Atera - $129 / tech / mo (RMM included)
**Pros:** Single per-tech price covers unlimited endpoints - predictable cost for a solo operator scaling 0->10 clients without re-negotiating. RMM + PSA + ticketing in one pane. Fastest ramp-up for a solo MSP (one login, one vendor, one invoice). Strong AI ticket-summarization in 2025-26 releases.
**Cons:** PSA depth is shallow - project management, contract billing, and time-tracking are functional but not best-in-class. Mobile tech app is good, not great. Limited customization of ticket workflows. Construction-mobile fit is competent but not differentiated.

### HaloPSA - free <3 techs, ~$85/tech/mo paid (RMM separate)
**Pros:** Best-in-class PSA - deep project management, contract types, recurring billing, asset CMDB, change management, and audit logs (the latter matters for the CPA secondary vertical). Free tier under 3 techs covers Y1 cost ceiling. Massive integration catalog including direct M365, Datto, Sophos, NinjaOne RMM.
**Cons:** No native RMM - must pair with NinjaOne or Datto, which adds a second vendor, second contract, and second pane of glass. Setup complexity is the highest of the four; non-trivial onboarding for a solo operator. Mobile experience trails NinjaOne and Atera. The free tier becomes paid at tech #3, which arrives quickly if RMS hires.

### SuperOps - $79 / tech / mo (PSA + RMM unified)
**Pros:** Lowest unified-product price. Modern UI built post-2020 (no ConnectWise-era cruft). Unified PSA+RMM in one product. Solid M365 integration. Good fit for a solo operator who wants one tool without the legacy-PSA learning curve.
**Cons:** Younger product - RMM agent maturity trails NinjaOne (especially patch management edge cases and ruggedized-tablet support common on construction jobsites). PSA depth trails HaloPSA. Integration catalog is narrower than HaloPSA or NinjaOne. Construction-vertical fit is "fine" but not optimized for jobsite endpoints.

### NinjaOne - ~$3-7 / endpoint / mo (RMM only; PSA via partner)
**Pros:** Best-in-class RMM agent - most mature, fastest, lowest-overhead, strongest mobile / ruggedized device support (matters directly for foreman tablets, jobsite laptops, and construction trailers). Best mobile tech app of the four. Strong M365 + Sophos + Datto integrations. Endpoint pricing scales with client size, not tech count - favorable for a solo operator with many endpoints.
**Cons:** No real PSA - ticketing is rudimentary. To run a real MSP business (contracts, recurring billing, project work) requires pairing with HaloPSA or another PSA, which doubles vendor count and increases total cost. Endpoint pricing makes cost projection harder until client mix is known. Premium positioning - list price often requires negotiation.

---

## 4. Cost projection at 1, 3, 5, 10 clients (Y1, solo operator = 1 tech)

Assumptions:
- Solo operator = 1 technician throughout Y1 (so HaloPSA stays in free tier).
- Average client = ~25 endpoints (Clark County GC profile: office + field laptops + foreman tablets).
- Endpoint counts: 1 client = 25 EP, 3 = 75 EP, 5 = 125 EP, 10 = 250 EP.
- NinjaOne assumed at $5/EP/mo (mid-range premium; negotiable down at volume).
- HaloPSA + NinjaOne pairing: $0 PSA (free tier, <3 techs) + NinjaOne EP cost.

| Vendor / stack | 1 client (25 EP) | 3 clients (75 EP) | 5 clients (125 EP) | 10 clients (250 EP) |
|----------------|-----------------:|------------------:|-------------------:|--------------------:|
| **Atera** (1 tech, all-in) | $129/mo | $129/mo | $129/mo | $129/mo |
| **HaloPSA free + NinjaOne** | $125/mo | $375/mo | $625/mo | $1,250/mo |
| **SuperOps** (1 tech, all-in) | $79/mo | $79/mo | $79/mo | $79/mo |
| **NinjaOne alone** (no PSA) | $125/mo | $375/mo | $625/mo | $1,250/mo |

**Cost ceilings from spec:** <=$200/mo until 5 clients live; <=$500/mo at 10 clients.

| Stack | Within <=$200/mo through 5 clients? | Within <=$500/mo at 10 clients? |
|-------|:----------------------------------:|:-------------------------------:|
| Atera | yes ($129) | yes ($129) |
| HaloPSA + NinjaOne | yes through 1 client; **no at 3+** ($375) | **no** ($1,250) |
| SuperOps | yes ($79) | yes ($79) |
| NinjaOne alone | yes through 1 client; **no at 3+** ($375) | **no** ($1,250) |

Endpoint-priced stacks (NinjaOne and HaloPSA+NinjaOne) **bust both cost ceilings** before client #5 at the assumed 25 EP/client. They become viable only with (a) volume pricing negotiated to ~$2/EP, or (b) smaller average endpoint counts.

---

## 5. Recommendation

### Primary recommendation: **SuperOps** ($79 / tech / mo, unified PSA+RMM)

**Rationale (per spec-rubric - RMM maturity > construction-mobile > Y1 cost > ramp-up):**
1. **Y1 cost ceiling held with the largest margin** of any option - $79/mo through 10 clients, vs. Atera's $129/mo, vs. NinjaOne-paired stacks busting the ceiling at 3 clients. The spec's <=$200 / <=$500 ceilings are not just met, they leave room for adjacent tooling (backup, EDR, documentation).
2. **Unified product = single pane of glass for a solo operator.** Ramp-up is fastest among the unified options because the UI is modern (post-2020 build), where Atera carries some legacy patterns.
3. **RMM maturity is "good enough" for Y1** - SuperOps RMM is not best-in-class (NinjaOne is), but at 1-10 construction clients with ~250 endpoints, the gap doesn't yet justify a 4x cost premium for endpoint-priced NinjaOne.
4. **PSA depth is sufficient for a wedge-stage MSP** - recurring billing, contracts, and project work are all native; HaloPSA's deeper PSA features (advanced CMDB, ITIL change management) are over-tooled for 1-10 clients.

### Trip-wires that flip the recommendation

- **If a flagship construction client (>50 endpoints, jobsite-heavy) signs in Q2:** revisit NinjaOne RMM specifically for that client's fleet. SuperOps PSA can stay; pair NinjaOne RMM if SuperOps's agent shows gaps on ruggedized tablets or remote-jobsite Wi-Fi.
- **If RMS adds tech #3 within 12 months:** re-evaluate HaloPSA - at 3+ techs, HaloPSA's depth begins to justify its cost, and pairing with NinjaOne becomes more defensible at volume pricing.
- **If a CPA client signs (secondary vertical with audit-log demands):** HaloPSA's audit / ITIL features become material; revisit then.
- **If SuperOps RMM agent fails a real construction-jobsite test in the first 30 days:** fall back to **Atera** ($129/mo, +$50/mo) for slightly better RMM maturity in a unified product, before considering a paired stack.

### Decision summary

| Stage | Tool | Monthly cost |
|-------|------|--------------|
| Y1 default (0->10 clients, solo) | **SuperOps** | $79 |
| Fallback if SuperOps RMM under-delivers | Atera | $129 |
| Trigger to re-evaluate paired stack | tech #3 hire OR enterprise-construction client signed | - |

---

## 6. Open items (for Justin to confirm at signature)

1. Confirm SuperOps current 2026 pricing - spec-of-record $79/tech/mo may have moved; verify on superops.com/pricing before contracting.
2. Confirm SuperOps RMM agent supports the specific ruggedized tablet OS images RMS's first GC prospect uses (typical: Windows 11 Pro on Panasonic Toughbook / Dell Latitude Rugged).
3. Confirm M365 GDAP / granular-delegation support in SuperOps integration - required for managing client M365 tenants.
4. Schedule a 14-day SuperOps trial against one volunteer prospect's office network before signing an annual contract.
