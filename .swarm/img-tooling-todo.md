# Image tooling — install gate (WU-IMG-01)

## Status: BLOCKED on encoder availability

`which cwebp avifenc magick convert pngquant` → all not found.
`/usr/bin/sips` exists on disk but is **denied by the sandbox** in this swarm session
(every `sips ...` invocation returns "Permission to use Bash has been denied").
That means we have **no working encoder** to produce WebP / AVIF / re-compressed PNGs
from this agent shell.

## Recommended human-gate install

```bash
brew install webp libavif pngquant
# Optional:
brew install imagemagick
```

After install:
- `cwebp -q 80 in.png -o out.webp`
- `avifenc -j 4 --min 30 --max 50 in.png out.avif`
- `pngquant --quality=65-85 --skip-if-larger --strip --output out.png in.png`

## Why we did not auto-install

WU-IMG-01 spec line: *"Do NOT `brew install` automatically."*

## Inventory at time of gate

| File | Size | Embedded in |
|---|---|---|
| /Users/ltlai/rms/og-image.png | 448 KB | `<meta property="og:image">` in 11 HTML files |
| /Users/ltlai/rms/screenshots/justin-headshot.jpg | 52 KB | `<img>` in `index.html`, `about.html` |
| /Users/ltlai/rms/qr-code.png | 5.2 KB | (not in HTML — referenced from print collateral) |
| /Users/ltlai/rms/qr-code-demo.png | 11 KB | (not in HTML) |

Only `og-image.png` exceeds the 200 KB ceiling.

## What still needs to happen after install

1. Re-compress `og-image.png` (PNG, since OG/Twitter cards need PNG/JPEG, not AVIF/WebP):
   `pngquant --quality=70-85 --strip --output og-image.png --force og-image.png`
   Target ≤200 KB.
2. Generate WebP + AVIF siblings of `screenshots/justin-headshot.jpg`:
   `cwebp -q 80 screenshots/justin-headshot.jpg -o screenshots/justin-headshot.webp`
   `avifenc -j 4 --min 30 --max 50 screenshots/justin-headshot.jpg screenshots/justin-headshot.avif`
3. Wrap the two `<img src="screenshots/justin-headshot.jpg" ...>` tags in `index.html`
   and `about.html` with `<picture>` + AVIF + WebP `<source>` siblings (JPEG fallback
   stays as-is). Add `fetchpriority="high"` to the `index.html` instance only if it
   actually falls in the LCP region (it does not today — hero is text).
4. Re-run acceptance:
   `find . -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) -size +200k -not -path "./.git/*"`
   should be empty.
