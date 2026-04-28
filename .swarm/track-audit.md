# WU-TRACK-02 — rmsTrack extraction audit

**Date:** 2026-04-28
**Branch:** `swarm/wu-track-02` (off `swarm/wu-infra-00`)
**Auditor:** Claude (Opus 4.7, 1M)
**Subject WU:** WU-INFRA-00 extracted `rmsTrack` to `/assets/rms-track.js`.

## 1. Function-signature parity

Compared the in-tree extracted file against the inline definition that lived in `index.html` before WU-INFRA-00 (read via `git show HEAD~1:index.html`).

Inline (pre-extraction, leading whitespace from script block):

```
    window.rmsTrack = function(name, params) {
      try { gtag('event', name, params || {}); } catch(e){}
      try { if (window.fbq) fbq('trackCustom', name, params || {}); } catch(e){}
      try { if (window.lintrk) lintrk('track', { conversion_id: 0 }); } catch(e){}
    };
```

Extracted (`assets/rms-track.js`, lines 5–9):

```
window.rmsTrack = function(name, params) {
  try { gtag('event', name, params || {}); } catch(e){}
  try { if (window.fbq) fbq('trackCustom', name, params || {}); } catch(e){}
  try { if (window.lintrk) lintrk('track', { conversion_id: 0 }); } catch(e){}
};
```

Identical modulo leading-whitespace difference (file uses 2-space indent, was nested inside a `<script>` block previously). Behaviour-preserving. **PASS.**

## 2. Page coverage

Files calling `rmsTrack(` (8):

```
about.html
contact.html
demo.html
index.html
pricing.html
services/it-operations.html
services/logistics-events.html
tools/it-health-check.html
```

All 8 files contain `<script src="/assets/rms-track.js" defer></script>` in `<head>`:

```
about.html:27
contact.html:15
demo.html:22
index.html:29
pricing.html:28
services/it-operations.html:28
services/logistics-events.html:28
tools/it-health-check.html:17
```

`grep -rL "/assets/rms-track.js" --include="*.html" . | xargs grep -l "rmsTrack("` → empty. **PASS.**

(WU-INFRA-00 also added the script tag to several pages that don't currently invoke `rmsTrack` — blog posts, case studies, industries hubs. That's pre-emptive coverage and is harmless.)

## 3. No remaining inline definitions

```
grep -rE 'function rmsTrack|window\.rmsTrack[[:space:]]*=' --include="*.html" /Users/ltlai/rms
```

Returned **no matches**. **PASS.**

## 4. Loading order

The script tag uses `defer`, not `async`, in every page. Per HTML spec, `defer` scripts execute after document parsing in document order — strictly before any `DOMContentLoaded` handler and before user-driven `onclick` handlers can fire. Inline `onclick` calls all guard with `if(window.rmsTrack)…`, so even on a hypothetical race they fail closed (no-op) rather than throw. **PASS.**

## 5. Headless runtime test

The harness blocked direct invocation of `chrome --headless`, `node`, and `curl` for this WU. Per the WU spec ("documented `curl + grep` substitute. Don't skip silently"), substituted with two static checks:

- `grep -E "window\.rmsTrack\s*=\s*function" assets/rms-track.js` → 1 match.
- `grep -c '<script src="/assets/rms-track.js" defer></script>' index.html` → `1`.

A node-vm sandbox harness was prepared at `/tmp/rms-eval-test.js` (reads the asset, evaluates it inside `vm.createContext` with stub `gtag/fbq/lintrk` globals, asserts `typeof window.rmsTrack === 'function'`, smoke-calls with synthetic data per §0.11). The script is committed to the report for reproducibility but could not be run in this sandbox; a follow-up WU should re-run it once the harness is permitted to invoke `node` or Chrome.

## Conclusion

All four acceptance tests pass via static / git-history evidence. No HTML edits required. No HARD GATE crossed. No claim taken (§0.6 says claims only required when html edits are made).

## Follow-up

- **WU-TRACK-03 (suggested):** once headless tooling is unblocked in the sandbox, run `/tmp/rms-eval-test.js` (or equivalent puppeteer probe of the live site) and append the runtime evidence here.
