#!/bin/bash
# River Mountain Systems — Pixel ID Setup Script
# Usage: ./setup-pixels.sh GA4_ID GADS_ID META_ID LINKEDIN_ID CLARITY_ID
#
# Example:
#   ./setup-pixels.sh G-AB12345678 AW-987654321 123456789012345 1234567 abcd1234ef
#
# Get your IDs from:
#   GA4:      analytics.google.com  → Admin → Data Streams → Web stream → Measurement ID
#   G Ads:    ads.google.com        → Goals → Conversions → Summary → (create one) → Tag setup → G-tag ID
#   Meta:     business.facebook.com → Events Manager → your pixel → Settings → Pixel ID
#   LinkedIn: linkedin.com/campaignmanager → Analyze → Insight Tag → See my Insight Tag → Partner ID
#   Clarity:  clarity.microsoft.com → your project → Settings → Tracking Code → ID in the URL

set -e

GA4="$1"
GADS="$2"
META="$3"
LI="$4"
CLARITY="$5"

# Validate all 5 args provided
if [ -z "$GA4" ] || [ -z "$GADS" ] || [ -z "$META" ] || [ -z "$LI" ] || [ -z "$CLARITY" ]; then
  echo ""
  echo "ERROR: Missing arguments. Provide all 5 IDs."
  echo ""
  echo "Usage:"
  echo "  ./setup-pixels.sh GA4_ID GADS_ID META_ID LINKEDIN_ID CLARITY_ID"
  echo ""
  echo "Example:"
  echo "  ./setup-pixels.sh G-AB12345678 AW-987654321 123456789012345 1234567 abcd1234ef"
  echo ""
  exit 1
fi

# Validate GA4 format
if [[ ! "$GA4" =~ ^G-[A-Z0-9]{8,10}$ ]]; then
  echo "WARNING: GA4 ID '$GA4' doesn't look right. Should be G-XXXXXXXXXX (e.g. G-AB12345678)"
  read -p "Continue anyway? (y/N) " yn
  [[ "$yn" =~ ^[Yy]$ ]] || exit 1
fi

# Validate Google Ads format
if [[ ! "$GADS" =~ ^AW-[0-9]{9,11}$ ]]; then
  echo "WARNING: Google Ads ID '$GADS' doesn't look right. Should be AW-XXXXXXXXXX (e.g. AW-987654321)"
  read -p "Continue anyway? (y/N) " yn
  [[ "$yn" =~ ^[Yy]$ ]] || exit 1
fi

echo ""
echo "River Mountain Systems — Pixel ID Setup"
echo "========================================"
echo "GA4 ID:       $GA4"
echo "Google Ads:   $GADS"
echo "Meta Pixel:   $META"
echo "LinkedIn:     $LI"
echo "Clarity:      $CLARITY"
echo ""
echo "This will update 18 HTML files. Continue? (y/N)"
read -p "> " confirm
[[ "$confirm" =~ ^[Yy]$ ]] || { echo "Cancelled."; exit 0; }
echo ""

# Find all HTML files with placeholders
FILES=$(grep -rl "G-XXXXXXXXXX\|AW-XXXXXXXXXX\|XXXXXXXXXXXXXXX\|XXXXXXX\b\|XXXXXXXXXX" \
  "$(dirname "$0")" --include="*.html" 2>/dev/null)

COUNT=0
for f in $FILES; do
  # Run replacements in a specific order (longest placeholder first to avoid partial matches)
  sed -i '' \
    -e "s/XXXXXXXXXXXXXXX/$META/g" \
    -e "s/G-XXXXXXXXXX/$GA4/g" \
    -e "s/AW-XXXXXXXXXX/$GADS/g" \
    -e "s/\"XXXXXXX\"/\"$LI\"/g" \
    -e "s/clarity\", \"script\", \"XXXXXXXXXX\"/clarity\", \"script\", \"$CLARITY\"/g" \
    "$f"
  echo "  ✓ $(basename "$f")"
  COUNT=$((COUNT + 1))
done

echo ""
echo "Done. $COUNT files updated."
echo ""
echo "Next steps:"
echo "  1. Run: git add -A && git commit -m 'Add real pixel IDs' && git push"
echo "  2. Open your site, open DevTools → Network tab, reload, and verify:"
echo "       - google-analytics.com/g/collect appears  (GA4)"
echo "       - googleads.g.doubleclick.net appears     (Google Ads)"
echo "       - connect.facebook.net/en_US appears      (Meta)"
echo "  3. In GA4: Admin → DebugView — you should see a page_view event within 30 seconds"
echo ""
