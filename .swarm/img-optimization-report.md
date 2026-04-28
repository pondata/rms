# WU-IMG-01 — Image Optimization Report

**Date:** 2026-04-28
**Branch:** `swarm/wu-img-01`
**Status:** BLOCKED — no working encoder available in agent sandbox.
See `.swarm/img-tooling-todo.md` for the install gate.

## Inventory

| File | Original | WebP | AVIF | Embedded where |
|---|---|---|---|---|
| `/Users/ltlai/rms/og-image.png` | 448 KB | — (gate) | — (gate; OG cards stay PNG/JPEG anyway) | 11 HTML files via `<meta property="og:image">` |
| `/Users/ltlai/rms/screenshots/justin-headshot.jpg` | 52 KB | — (gate) | — (gate) | `index.html:587`, `about.html:153` (`<img>` tags) |
| `/Users/ltlai/rms/qr-code.png` | 5.2 KB | n/a (already tiny) | n/a | not in HTML |
| `/Users/ltlai/rms/qr-code-demo.png` | 11 KB | n/a (already tiny) | n/a | not in HTML |

## Acceptance check

```
$ find . -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) \
    -size +200k -not -path "./.git/*" -not -path "./node_modules/*"
./og-image.png
```

**Acceptance fails on `og-image.png`.** Cannot remediate without an encoder.

## Notes

- `qr-code.png` and `qr-code-demo.png` are not referenced from any `*.html`. Leaving on disk per spec ("for images not currently used in HTML, leave them on disk but note them in the report").
- `og-image.png` is a social-card asset. Open Graph and Twitter Cards do **not** reliably render AVIF or WebP — Facebook + LinkedIn fetchers still want PNG or JPEG. So the remediation is a re-compressed PNG (via `pngquant`), not a format swap. WebP/AVIF would actually break previews on most platforms.
- `justin-headshot.jpg` is already ≤200 KB so the JPEG itself passes acceptance. The `<picture>` upgrade per spec ("If already ≤200KB, generate WebP/AVIF copies + update") is queued behind the encoder gate. Shipping `<picture>` markup *now* would create broken `<source>` references because no `.webp`/`.avif` sibling exists on disk yet.
- LCP: homepage hero is text (`<h1>` "Vancouver, WA managed IT…"), not an image. Headshot is below the fold inside the founder block. No `fetchpriority="high"` change needed.

## Followup

Single follow-up WU once tooling lands: re-compress `og-image.png` ≤200 KB, generate
`justin-headshot.{webp,avif}`, wrap the two `<img>` tags in `<picture>`. Estimated
≤30 min once binaries are installed.
