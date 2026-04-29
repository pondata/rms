#!/usr/bin/env bash
# Usage: bash .swarm/linkcheck.sh [--help]
# Pre-deploy linkcheck for River Mountain Systems static site.
# Exits non-zero on broken internal links, forbidden phrasings, or contact-info drift.
# WU-INFRA-02

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PORT="${LINKCHECK_PORT:-8080}"
SERVER_PID=""
TMPDIR_RUN="$(mktemp -d)"
EXIT_CODE=0

EXPECTED_EMAIL="joberg@rivermountainsystems.com"
EXPECTED_TEL_DIGITS="+13606444820"

show_help() {
  cat <<'EOF'
linkcheck.sh — Pre-deploy linkcheck for River Mountain Systems

USAGE:
  bash .swarm/linkcheck.sh [--help]

CHECKS:
  1. Boot local server on $LINKCHECK_PORT (default 8080)
  2. Crawl internal links via linkinator (npx) — fallback to grep+curl
  3. href="#" detection (excludes valid anchor targets)
  4. mailto: must be joberg@rivermountainsystems.com
  5. tel: must be +13606444820
  6. Orphan HTML pages (in repo, no inbound link)
  7. Forbidden phrases (money-back, satisfaction guarantee, risk-free, 100% guarantee) — DEPLOY GATE
  8. SLA-leak grep (15-min response/SLA) — WARNING only

EXIT CODE:
  0 = all checks pass
  1 = at least one blocking check failed

ENV:
  LINKCHECK_PORT=8080      override server port
  LINKCHECK_SKIP_CRAWL=1   skip linkinator crawl (still runs greps)
EOF
}

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
  show_help
  exit 0
fi

cleanup() {
  if [[ -n "$SERVER_PID" ]] && kill -0 "$SERVER_PID" 2>/dev/null; then
    kill "$SERVER_PID" 2>/dev/null || true
    wait "$SERVER_PID" 2>/dev/null || true
  fi
  rm -rf "$TMPDIR_RUN"
}
trap cleanup EXIT INT TERM

cd "$REPO_ROOT"

echo "==> linkcheck.sh starting in $REPO_ROOT"
echo "==> port=$PORT  tmpdir=$TMPDIR_RUN"
echo

# ---------------------------------------------------------------------------
# 1. Boot local server (if nothing already on port)
# ---------------------------------------------------------------------------
server_already_up=0
if curl -s -o /dev/null -w "%{http_code}" "http://localhost:$PORT/" 2>/dev/null | grep -qE '^(200|301|302)$'; then
  server_already_up=1
  echo "==> server already running on :$PORT — reusing"
else
  if command -v python3 >/dev/null 2>&1; then
    python3 -m http.server "$PORT" >"$TMPDIR_RUN/server.log" 2>&1 &
    SERVER_PID=$!
  elif command -v python >/dev/null 2>&1; then
    python -m SimpleHTTPServer "$PORT" >"$TMPDIR_RUN/server.log" 2>&1 &
    SERVER_PID=$!
  else
    echo "ERROR: no python found to boot static server" >&2
    EXIT_CODE=1
  fi
  if [[ -n "$SERVER_PID" ]]; then
    for _ in 1 2 3 4 5 6 7 8 9 10; do
      if curl -s -o /dev/null "http://localhost:$PORT/"; then break; fi
      sleep 0.5
    done
    echo "==> booted local server pid=$SERVER_PID on :$PORT"
  fi
fi
echo

# ---------------------------------------------------------------------------
# 2. Crawl with linkinator (fallback to grep+curl)
# ---------------------------------------------------------------------------
broken_links_count=0
crawled_urls_file="$TMPDIR_RUN/crawled.txt"
: >"$crawled_urls_file"

run_linkinator=1
if [[ "${LINKCHECK_SKIP_CRAWL:-0}" == "1" ]]; then
  run_linkinator=0
  echo "==> LINKCHECK_SKIP_CRAWL=1 — skipping crawl"
fi

if [[ "$run_linkinator" == "1" ]] && command -v npx >/dev/null 2>&1; then
  echo "==> crawling with linkinator…"
  npx -y linkinator "http://localhost:$PORT" \
        --recurse \
        --skip "^https?://(?!localhost)" \
        --format json \
        --silent \
        >"$TMPDIR_RUN/linkinator.json" 2>"$TMPDIR_RUN/linkinator.err" || true

  if [[ -s "$TMPDIR_RUN/linkinator.json" ]] && command -v node >/dev/null 2>&1; then
    node -e "
      const fs = require('fs');
      try {
        const j = JSON.parse(fs.readFileSync('$TMPDIR_RUN/linkinator.json','utf8'));
        const links = j.links || [];
        const broken = links.filter(l => l.state === 'BROKEN');
        const ok = links.filter(l => l.state === 'OK');
        fs.writeFileSync('$TMPDIR_RUN/crawled.txt', ok.map(l => l.url).join('\n'));
        if (broken.length) {
          console.error('BROKEN LINKS (' + broken.length + '):');
          broken.forEach(l => console.error('  ' + l.status + '  ' + l.url + (l.parent ? '  <- ' + l.parent : '')));
          process.exit(2);
        } else {
          console.log('  no broken links found by linkinator');
        }
      } catch (e) {
        console.error('  WARN: failed to parse linkinator output: ' + e.message);
        process.exit(0);
      }
    "
    if [[ $? -eq 2 ]]; then
      broken_links_count=1
    fi
  else
    echo "  WARN: linkinator unavailable or no output — falling back to grep+curl"
    run_linkinator=0
  fi
fi

if [[ "$run_linkinator" == "0" ]] && [[ "${LINKCHECK_SKIP_CRAWL:-0}" != "1" ]]; then
  echo "==> fallback crawl (grep + curl)…"
  while IFS= read -r html; do
    rel="${html#./}"
    while IFS= read -r href; do
      url="${href#href=\"}"
      url="${url%\"}"
      [[ -z "$url" ]] && continue
      [[ "$url" =~ ^https?:// ]] && continue
      [[ "$url" =~ ^mailto: ]] && continue
      [[ "$url" =~ ^tel: ]] && continue
      [[ "$url" =~ ^# ]] && continue
      target="${url%%#*}"
      target="${target%%\?*}"
      [[ -z "$target" ]] && continue
      if [[ "$target" == /* ]]; then
        full="http://localhost:$PORT$target"
      else
        full="http://localhost:$PORT/$(dirname "$rel")/$target"
      fi
      code=$(curl -s -o /dev/null -w "%{http_code}" -L "$full" 2>/dev/null || echo "000")
      if [[ "$code" != "200" && "$code" != "301" && "$code" != "302" ]]; then
        echo "  BROKEN  $code  $full  (from $rel)"
        broken_links_count=$((broken_links_count + 1))
      else
        echo "$full" >>"$crawled_urls_file"
      fi
    done < <(grep -oE 'href="[^"]+"' "$html" 2>/dev/null || true)
  done < <(find . -name "*.html" -not -path "./node_modules/*" -not -path "./.git/*")
fi
echo

# ---------------------------------------------------------------------------
# 3. href="#" detection (skip-link targets like #main are fine)
# ---------------------------------------------------------------------------
echo "==> checking for empty href=\"#\"…"
empty_href_hits=$(grep -rEn 'href=["'\'']#["'\'']' --include="*.html" . 2>/dev/null || true)
empty_href_count=0
if [[ -n "$empty_href_hits" ]]; then
  empty_href_count=$(printf '%s\n' "$empty_href_hits" | wc -l | tr -d ' ')
  echo "  FOUND $empty_href_count empty href(s):"
  printf '%s\n' "$empty_href_hits" | sed 's/^/    /'
else
  echo "  none"
fi
echo

# ---------------------------------------------------------------------------
# 4. mailto sanity
# ---------------------------------------------------------------------------
echo "==> checking mailto: links…"
mailto_bad=0
while IFS= read -r line; do
  [[ -z "$line" ]] && continue
  if [[ "$line" != *"$EXPECTED_EMAIL"* ]]; then
    echo "  WRONG MAILTO: $line"
    mailto_bad=$((mailto_bad + 1))
  fi
done < <(grep -rEhn 'mailto:[^"'\'' >]+' --include="*.html" . 2>/dev/null || true)
if [[ "$mailto_bad" == "0" ]]; then
  echo "  all mailto: links use $EXPECTED_EMAIL"
fi
echo

# ---------------------------------------------------------------------------
# 5. tel sanity
# ---------------------------------------------------------------------------
echo "==> checking tel: links…"
tel_bad=0
while IFS= read -r line; do
  [[ -z "$line" ]] && continue
  if [[ "$line" =~ tel:([^\"\'\ \>\<]+) ]]; then
    val="${BASH_REMATCH[1]}"
    digits="${val//[^0-9+]/}"
    if [[ "$digits" != "$EXPECTED_TEL_DIGITS" && "$digits" != "13606444820" && "$digits" != "3606444820" ]]; then
      echo "  WRONG TEL: $line"
      tel_bad=$((tel_bad + 1))
    fi
  fi
done < <(grep -rEhn 'tel:[^"'\'' ><]+' --include="*.html" . 2>/dev/null || true)
if [[ "$tel_bad" == "0" ]]; then
  echo "  all tel: links resolve to $EXPECTED_TEL_DIGITS"
fi
echo

# ---------------------------------------------------------------------------
# 6. Orphan pages
# ---------------------------------------------------------------------------
echo "==> checking for orphan HTML pages…"
all_html_file="$TMPDIR_RUN/all_html.txt"
find . -name "*.html" -not -path "./node_modules/*" -not -path "./.git/*" \
  | sed 's|^\./||' | sort -u >"$all_html_file"

referenced_file="$TMPDIR_RUN/referenced.txt"
: >"$referenced_file"

if [[ -s "$crawled_urls_file" ]]; then
  while IFS= read -r u; do
    p="${u#http://localhost:$PORT/}"
    p="${p%%#*}"
    p="${p%%\?*}"
    [[ -z "$p" ]] && p="index.html"
    [[ "$p" == */ ]] && p="${p}index.html"
    echo "$p" >>"$referenced_file"
  done <"$crawled_urls_file"
fi

while IFS= read -r html; do
  rel="${html#./}"
  base="$(dirname "$rel")"
  while IFS= read -r href; do
    url="${href#href=\"}"
    url="${url%\"}"
    [[ -z "$url" ]] && continue
    [[ "$url" =~ ^https?:// ]] && continue
    [[ "$url" =~ ^mailto: ]] && continue
    [[ "$url" =~ ^tel: ]] && continue
    [[ "$url" =~ ^# ]] && continue
    target="${url%%#*}"
    target="${target%%\?*}"
    [[ -z "$target" ]] && continue
    if [[ "$target" == /* ]]; then
      norm="${target#/}"
    else
      if [[ "$base" == "." ]]; then
        norm="$target"
      else
        norm="$base/$target"
      fi
    fi
    [[ "$norm" == */ ]] && norm="${norm}index.html"
    norm="$(python3 -c "import os,sys;print(os.path.normpath(sys.argv[1]))" "$norm" 2>/dev/null || echo "$norm")"
    echo "$norm" >>"$referenced_file"
  done < <(grep -oE 'href="[^"]+"' "$html" 2>/dev/null || true)
done < <(find . -name "*.html" -not -path "./node_modules/*" -not -path "./.git/*")

sort -u "$referenced_file" -o "$referenced_file"

orphan_count=0
orphans_list=""
while IFS= read -r page; do
  case "$page" in
    "index.html"|"404.html") continue ;;
  esac
  if ! grep -qxF "$page" "$referenced_file"; then
    orphan_count=$((orphan_count + 1))
    orphans_list+="    $page"$'\n'
  fi
done <"$all_html_file"

if [[ "$orphan_count" -gt 0 ]]; then
  echo "  FOUND $orphan_count orphan page(s):"
  printf '%s' "$orphans_list"
else
  echo "  none"
fi
echo

# ---------------------------------------------------------------------------
# 7. Forbidden phrases — DEPLOY GATE
# ---------------------------------------------------------------------------
echo "==> checking for forbidden phrases (deploy gate)…"
forbidden_hits=$(grep -rEn '(money-back|satisfaction guarantee|risk-free|100% guarantee)' \
  --include="*.html" --include="*.md" . 2>/dev/null \
  | grep -vE '^(\./)?AUDIT' \
  | grep -vE '^(\./)?PLAN\.md' \
  | grep -vE '^(\./)?\.swarm/' \
  | grep -vE '^(\./)?CLAUDE\.md' \
  || true)
forbidden_count=0
if [[ -n "$forbidden_hits" ]]; then
  forbidden_count=$(printf '%s\n' "$forbidden_hits" | wc -l | tr -d ' ')
  echo "  FOUND $forbidden_count forbidden phrase hit(s):"
  printf '%s\n' "$forbidden_hits" | sed 's/^/    /'
else
  echo "  none"
fi
echo

# ---------------------------------------------------------------------------
# 7b. CSS sanity — DEPLOY GATE
#     Catches the round-3 regression class: a strip script removes a rule body
#     and leaves the selector list dangling, breaking everything downstream
#     in the <style> block. Two checks:
#       a) Inline <style> brace balance (open count == close count)
#       b) No selector lists ending in `,` immediately followed by a non-selector
#          line (a comment or another rule), which would imply an orphan.
# ---------------------------------------------------------------------------
echo "==> checking inline <style> brace balance and orphan selectors (deploy gate)…"
css_problems=0
css_problem_files=()
while IFS= read -r f; do
  inline=$(perl -0777 -ne 'while (/<style[^>]*>(.*?)<\/style>/gs) { print "$1\n"; }' "$f")
  if [[ -z "$inline" ]]; then continue; fi
  open=$(printf '%s' "$inline" | tr -cd '{' | wc -c | tr -d ' ')
  close=$(printf '%s' "$inline" | tr -cd '}' | wc -c | tr -d ' ')
  if [[ "$open" != "$close" ]]; then
    echo "  BRACE_MISMATCH $f: { $open } $close"
    css_problems=$((css_problems+1))
    css_problem_files+=("$f")
    continue
  fi
  # Check for orphan selector lists: line ending in `,` whose buffered group never reaches a `{`
  # before hitting `}` or end of style block. Use python for precision.
  if python3 - "$f" <<'PY'
import sys, re, pathlib
s = pathlib.Path(sys.argv[1]).read_text()
problem = False
for m in re.finditer(r'<style[^>]*>(.*?)</style>', s, re.DOTALL):
    css = m.group(1)
    # Walk depth-zero: collect selector buffer; require a `{` before next `}` or end.
    depth = 0; buf = ''; i = 0; n = len(css)
    while i < n:
        c = css[i]
        if c == '/' and i+1 < n and css[i+1] == '*':
            e = css.find('*/', i+2); i = (e+2) if e!=-1 else n; continue
        if depth == 0 and c == '{':
            buf = ''; depth = 1; i += 1; continue
        if depth > 0:
            if c == '{': depth += 1
            elif c == '}': depth -= 1
            i += 1; continue
        # depth 0
        if c == '}':
            # Got `}` at depth 0 — buffered selector had no opening brace
            if buf.strip():
                problem = True; break
            buf = ''; i += 1; continue
        buf += c; i += 1
    if buf.strip() and not problem:
        # End of style with an orphan selector
        problem = True
        break
sys.exit(1 if problem else 0)
PY
  then : ; else
    echo "  ORPHAN_SELECTOR $f"
    css_problems=$((css_problems+1))
    css_problem_files+=("$f")
  fi
done < <(find . -maxdepth 4 -name "*.html" -not -path "./node_modules/*" 2>/dev/null)
if [[ "$css_problems" -eq 0 ]]; then
  echo "  none"
fi
echo

# ---------------------------------------------------------------------------
# 8. SLA-leak grep — warning only
# ---------------------------------------------------------------------------
echo "==> checking for 15-min SLA leaks (warning only)…"
sla_hits=$(grep -rEn '15[-[:space:]]?min(ute)?s?[[:space:]]+(first[[:space:]]+)?response|15[-[:space:]]?min(ute)?s?[[:space:]]+SLA' \
  --include="*.html" . 2>/dev/null \
  | grep -vE '^(\./)?\.swarm/' \
  | grep -vE '^(\./)?AUDIT' \
  || true)
sla_count=0
if [[ -n "$sla_hits" ]]; then
  sla_count=$(printf '%s\n' "$sla_hits" | wc -l | tr -d ' ')
  echo "  WARN: found $sla_count SLA-leak occurrence(s) (non-blocking):"
  printf '%s\n' "$sla_hits" | sed 's/^/    /'
else
  echo "  none"
fi
echo

# ---------------------------------------------------------------------------
# Summary
# ---------------------------------------------------------------------------
echo "================ linkcheck summary ================"
printf "  broken internal links : %s\n" "$broken_links_count"
printf "  empty href=\"#\"        : %s\n" "$empty_href_count"
printf "  bad mailto:           : %s\n" "$mailto_bad"
printf "  bad tel:              : %s\n" "$tel_bad"
printf "  orphan pages          : %s\n" "$orphan_count"
printf "  forbidden phrases     : %s  (DEPLOY GATE)\n" "$forbidden_count"
printf "  CSS problems          : %s  (DEPLOY GATE)\n" "$css_problems"
printf "  SLA-leak warnings     : %s  (non-blocking)\n" "$sla_count"
echo "==================================================="

if [[ "$broken_links_count" -gt 0 ]] \
   || [[ "$empty_href_count" -gt 0 ]] \
   || [[ "$mailto_bad" -gt 0 ]] \
   || [[ "$css_problems" -gt 0 ]] \
   || [[ "$tel_bad" -gt 0 ]] \
   || [[ "$forbidden_count" -gt 0 ]]; then
  EXIT_CODE=1
fi

if [[ "$EXIT_CODE" -eq 0 ]]; then
  echo "PASS"
else
  echo "FAIL"
fi
exit "$EXIT_CODE"
