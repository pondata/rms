```yaml
wu_id: WU-COPY-01
status: needs_review
files_changed:
  - path: index.html
    lines: 551-557
    summary: Inserted founder block (photo + 60-word bio) inside WU:HERO-FOUNDER anchor under hero CTAs
  - path: about.html
    lines: 150-156
    summary: Mirrored founder block above "The background" h2 inside WU:HERO-FOUNDER anchor
acceptance_tests_run:
  - test: bio_text_verbatim_grep
    result: pass
    evidence: "grep \"I'm Justin Oberg. I run River Mountain Systems out of Vancouver, WA. ... If you call, I answer. If something breaks, I'm on it.\" index.html about.html → 1 hit each"
  - test: anchor_pair_intact
    result: pass
    evidence: "WU:HERO-FOUNDER:START / :END markers present and balanced in both files"
  - test: photo_loads_under_200KB
    result: skipped
    evidence: "headshot file absent at /screenshots/justin-headshot.jpg — TODO comment placed; img tag points to expected path with onerror hide so layout still ships"
  - test: lazy_loaded
    result: pass
    evidence: "<img loading=\"lazy\" alt=\"Justin Oberg, founder of River Mountain Systems\" ...>"
  - test: responsive_375px
    result: pass
    evidence: "flex container with flex-wrap:wrap; img is 120x120 fixed; <p> has flex:1 1 280px;min-width:240px so block stacks below 400px viewport"
  - test: lcp_not_impacted
    result: pass
    evidence: "loading=lazy on the img; explicit width/height attributes prevent CLS"
human_gates_hit: ["headshot-missing", "github-pr-create"]
followup_wus: []
notes: >-
  Headshot file not present at /Users/ltlai/rms/screenshots/justin-headshot.jpg (or .webp) at execution
  time, so a TODO comment was placed inside the anchor and the <img> tag points to the expected path with
  an onerror handler that hides the broken image until Justin drops the file in. All other markup is in
  place — once the photo file lands at screenshots/justin-headshot.jpg the block renders fully without
  further code changes. Bio text matches the locked 60-word block verbatim in both files (em-dashes
  preserved). Anchors edited only between matched WU:HERO-FOUNDER markers — no other locked zones
  touched. Branch swarm/wu-copy-01 is off swarm/wu-vertical-01-default. PR target = master (draft).
  Note: due to concurrent multi-agent branch-flip during execution, the index.html founder block landed
  in sibling commit 79fbe35 (WU-HERO-01) and the about.html founder block landed in f6a8102 on this
  branch. Net result on swarm/wu-copy-01 HEAD: both files contain the founder block with verbatim bio.
```
