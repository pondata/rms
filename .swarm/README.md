# `.swarm/` — Swarm coordination directory

This directory coordinates parallel work units (WUs) executed against the River Mountain Systems repo.

## Files

- **`claims.jsonl`** (gitignored, append-only) — every agent that edits a file under an anchor MUST append a claim line here BEFORE editing. Format:
  ```json
  {"wu_id":"WU-...","file":"index.html","anchor":"WU:HERO-COPY","claimed_at":"2026-04-28T17:30:00Z"}
  ```
  And on completion:
  ```json
  {"wu_id":"WU-...","anchor":"WU:HERO-COPY","released_at":"2026-04-28T18:00:00Z"}
  ```
- **`secrets.local.md`** (gitignored) — local-only placeholder. WU-FORM-00 injects the Formspree endpoint here. Never commit.
- **`branch-protection-target.md`** (only present if `gh` was not authed during bootstrap) — desired GitHub branch protection ruleset for `master`. Apply manually.
- **`wu-infra-00-pr-body.md`** (only present if `gh pr create` failed during bootstrap) — desired draft PR body.

## Protocol summary

The full protocol lives in `AUDIT_2026-04-28.md` §0 (the source of truth). Highlights:

- **§0.1 Scope rules** — what agents may freely edit vs. hard human gates (phone number, pricing, DNS, etc.).
- **§0.4 Locked zones** — anchor-based locking inside `index.html` and friends. Agents claim by anchor name (`WU:HERO-COPY`, `WU:HEAD`, …), not by line number. Two agents may hold *different* anchors in the same file simultaneously; two agents must never hold the *same* anchor.
- **§0.5 Output format** — every WU returns the YAML in §0.5 as its final message.
- **§0.6 Collision protocol** — claim → edit → release. If an anchor is held, pick a different WU; do not retry-loop.
- **§0.9 Done definition** — all acceptance tests pass, files listed, no hard gate crossed silently, release line appended, PR opened.
- **§0.10 Deploy protocol** — never push `master`; each WU branches to `swarm/<wu_id>`, opens a draft PR, never merges. Pre-commit hooks may not be skipped.
- **§0.11 PII rules** — synthetic data only for form acceptance tests (`name=test_<wu_id>`, `email=swarm+<wu_id>@rivermountainsystems.com`).

## Anchor names (inserted by WU-INFRA-00)

| Anchor | Allowed editors | Purpose |
|---|---|---|
| `WU:HEAD` | WU-TRACK-01, WU-TRACK-02, WU-SEO-02, WU-SEO-03 | head + tracking + schema |
| `WU:HERO-COPY` | WU-HERO-01, WU-HERO-02, WU-VERTICAL-03 | hero `<h1>` + tagline + CTA pair |
| `WU:HERO-FOUNDER` | WU-COPY-01 | founder photo + bio block |
| `WU:HERO-QUICKFORM` | WU-FORM-01 | hero quickform |
| `WU:HERO-EMBED` | WU-CAL-01 | optional Cal.com inline embed |
| `WU:REVIEWS` | WU-PROOF-* | reviews / proof carousel |
| `WU:CONTACT-FORM` | WU-FORM-01 | full contact form |
| `WU:CAL-CTA` | WU-CAL-01, WU-HERO-02 | Cal.com link CTA |
| `WU:FOOTER` | WU-COSMETIC-01, WU-COPY-04 | footer (logo href, newsletter) |
| `WU:DEMO-FORM` | WU-FORM-01 | demo page form (demo.html only) |

Agents NEVER delete or relocate the markers themselves; they edit only between the matched `<!-- WU:<NAME>:START -->` and `<!-- WU:<NAME>:END -->` comments.
