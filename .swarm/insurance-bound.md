---
status: bound
carrier: Hiscox Insurance Company Inc
naic: 10200
insured_entity: PONDATA LLC
insured_address: 14705 NE 5TH Ave, Vancouver, WA 98685
producer: Hiscox Inc., 5 Concourse Parkway, Suite 2150, Atlanta GA 30328 — (888) 202-3007 — contact@hiscox.com
policy_number: P106.395.009.1
policy_period: 2026-04-06 to 2027-04-06
coverage:
  professional_liability_e_and_o:
    each_claim: 1000000
    aggregate: 1000000
gaps_to_flag_to_buyers:
  - cyber_liability: not_on_this_coi
  - general_liability: not_on_this_coi
  - auto: not_on_this_coi
  - workers_comp: not_on_this_coi
coi_file: .swarm/legal/certs/Hiscox_COI_2026-04-06.PDF
---

# Hiscox Insurance — bound 2026-04-06

## What's covered
Professional Liability / E&O at $1M each claim / $1M aggregate. Industry-standard for solo IT consulting + MSP work.

## What's NOT on this COI
The certificate shows only Professional Liability. If a prospect's MSA template requires:
- Cyber Liability — not currently bound; ask Hiscox to add or bind separately if needed
- General Liability — not currently bound; quote separately if a client requires premises coverage
- Auto, Workers Comp — not applicable for solo

## How to deliver a COI to a prospect
The certificate as filed has a **blank HOLDER field** — it's a generic info copy. Real client engagements need a fresh COI naming them as Certificate Holder (and often as Additional Insured). Process:
1. Send the client's full legal name + address to Hiscox: contact@hiscox.com or (888) 202-3007
2. Hiscox issues a new COI with the client named as Holder, typically within 1–2 business days
3. Forward the new COI as a PDF; never send the generic copy as the binding COI

## Implications for the swarm plan
- WU-LEGAL-01 (insurance quote intake) — close as obsolete; insurance is bound, not just quoted
- WU-HERO-01 SLA wording — insurance side is unblocked; phone-routing side (WU-PHONE-01) still gates the 15-min SLA. Keep "Same-day response" until phone routing is wired
- WU-LEGAL-02 (MSA template) — still applies; the MSA references "Contractor maintains Professional Liability of not less than $1M each claim, $1M aggregate" — wording matches this policy
- A buyer asking for proof of insurance is now answerable in under 24 hours
