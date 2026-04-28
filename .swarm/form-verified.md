---
status: verified_working
verified_date: 2026-04-28
verified_by: Justin (live test from phone)
sink: Google Apps Script → Google Sheet (Justin's existing setup)
---

# Form delivery verified

Justin tested the live hero quickform on https://www.rivermountainsystems.com from his phone. Submission landed in the Google Sheet sink as expected.

## Implications
- WU-FORM-00 (Formspree provisioning) — close as obsolete
- WU-FORM-01 (replace silent-fail pattern) — close as obsolete; the form delivers leads in production

## What's still NOT solved by this verification
The original concern was that `mode:'no-cors'` makes failures silent — meaning IF the endpoint expires or rate-limits in the future, you won't know until leads go missing. Today's test proves it works TODAY, not that it will keep working.

Mitigation options (P3, opportunistic):
- Light: WU-FORM-02 (UptimeRobot ping on the Apps Script endpoint) — 30 min one-time setup, free; alerts you if the endpoint stops responding
- Heavy: WU-FORM-01 (dual-channel Formspree + Apps Script) — closed; revisit only if the Apps Script ever fails silently

Recommend: do WU-FORM-02 anyway for cheap insurance. Do NOT do WU-FORM-01 unless something breaks.
