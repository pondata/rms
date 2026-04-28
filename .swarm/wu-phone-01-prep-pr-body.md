[WU-PHONE-01] Phone routing + answering-service spec (agent prep)

Agent-prep portion of WU-PHONE-01. Adds `.swarm/phone-routing-spec.md` — a decision matrix Justin can act on:

- OpenPhone vs Google Voice (vs Dialpad/RingCentral as reference). Recommendation: OpenPhone Standard $19/mo for native missed-call SMS auto-reply + shared inbox.
- Answering services Ruby Receptionists / AnswerConnect / Smith.ai compared on P1-SMS reliability, cost, contract length. Recommendation: AnswerConnect entry plan ($50–$120 budget at ~30 calls/mo).
- Verbatim greeting + P1/P2/P3 triage tree + business-hours rules + spam-filter rules.
- 5-item go-live checklist that, once green, gates WU-HERO-01 to publish the 15-min SLA wording.
- Cost ceiling: ≤$170/mo target, $250/mo absolute until first MSP client signs.

Hard constraints respected:
- Published number `(360) 644-4820` not changed anywhere.
- Agent did not contact vendors, did not sign up, did not commit spend.
- `.swarm/phone-routing-live.md` (Justin's outcome doc) stays gitignored.
