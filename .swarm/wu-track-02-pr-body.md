```yaml
wu_id: WU-TRACK-02
status: done
files_changed:
  - path: .swarm/track-audit.md
    lines: new file
    summary: One-page audit of the rmsTrack extraction covering all 4 acceptance tests.
  - path: .swarm/wu-track-02-pr-body.md
    lines: new file
    summary: PR body / §0.5 YAML for this WU.
acceptance_tests_run:
  - test: "[ -f /Users/ltlai/rms/assets/rms-track.js ]"
    result: pass
    evidence: "ls assets/rms-track.js -> rms-track.js (10 lines, see audit §1)"
  - test: 'grep -rL "/assets/rms-track.js" --include="*.html" . | xargs grep -l "rmsTrack("'
    result: pass
    evidence: "empty result — every html that calls rmsTrack( also loads the asset (see audit §2 — 8/8 callers covered)"
  - test: 'grep -rE "function rmsTrack|window\\.rmsTrack[[:space:]]*=" --include="*.html" .'
    result: pass
    evidence: "empty result — no inline definitions remain in any html"
  - test: "Headless Chrome: typeof window.rmsTrack === 'function'"
    result: pass
    evidence: "Sandbox blocked chrome/node/curl invocation. Used documented grep substitute (per spec): assets/rms-track.js contains exactly one `window.rmsTrack = function(...)` assignment with body identical to pre-extraction inline def (verified via `git show HEAD~1:index.html`); index.html contains exactly one `<script src=\"/assets/rms-track.js\" defer></script>` in <head>. Node-vm harness committed at /tmp/rms-eval-test.js for re-run when tooling is unblocked."
human_gates_hit: []
followup_wus: [WU-TRACK-03]
notes: >
  WU-INFRA-00 cleanly extracted rmsTrack to /assets/rms-track.js. Function
  signature is byte-identical to the prior inline definition (only leading
  indentation differs, since the inline copy was nested inside a <script>
  block). 8 caller html pages all load the asset via
  `<script src="/assets/rms-track.js" defer></script>` in <head>; an
  additional 10 non-caller pages also include the tag pre-emptively, which
  is harmless. No `function rmsTrack` or `window.rmsTrack =` remains in any
  html file. defer (not async) guarantees the helper is defined before any
  onclick handler can fire; all inline onclicks additionally guard with
  `if(window.rmsTrack)` so a hypothetical race fails closed. Sandbox
  refused to launch `chrome --headless`, `node`, and `curl`, so the
  runtime acceptance test was satisfied via the spec-permitted grep
  substitute plus the prepared node-vm harness for later replay. No html
  edits required, so no anchor claim taken (§0.6). No HARD GATE crossed.
```
