> **DEPRECATED — superseded by `AUDIT_2026-04-28.md` (2026-04-28).** Do not follow this doc; it is retained for history only.

# Get Your 5 Pixel IDs — Exact Steps
**Time: ~25 minutes total. Do these in order.**

When you have all 5, run one command to update every page:
```
./setup-pixels.sh G-yourGA4id AW-yourAdsid yourMetaId yourLinkedInId yourClarityId
```
Then `git add -A && git commit -m "Add pixel IDs" && git push`

---

## 1. Google Analytics 4 (GA4) — ~5 min
**Gets you:** `G-XXXXXXXXXX`

1. Go to **analytics.google.com** — sign in with your Google account
2. Click **Start measuring** (or **Create Property** if you've been here before)
3. Property name: `River Mountain Systems`
4. Reporting time zone: `United States → Pacific Time`
5. Currency: `US Dollar`  → click **Next**
6. Business size: **Small** → click **Next**
7. Objectives: check **Get baseline reports** → click **Create**
8. Accept the Terms of Service
9. You're now in "Data Streams" — click **Web**
10. Website URL: `www.rivermountainsystems.com` · Stream name: `RMS Web` → click **Create stream**
11. **Your ID is at the top: `G-XXXXXXXXXX`** — copy it

---

## 2. Google Ads Conversion Tag — ~5 min
**Gets you:** `AW-XXXXXXXXXX`
*(You need a Google Ads account first. If you don't have one, create it at ads.google.com — you can skip creating a campaign when prompted)*

1. Go to **ads.google.com** → sign in
2. Click the wrench icon (**Tools & Settings**) in the top nav
3. Under "Measurement" → click **Conversions**
4. Click the blue **+** button → **Website**
5. Goal category: **Contact us** · Conversion name: `Phone Call`
6. Value: **Don't use a value** · Count: **One** → click **Done**
7. Click **Save and continue** → choose **Install the tag yourself**
8. Click **Google tag** tab
9. **Your ID is labeled "Tag ID": `AW-XXXXXXXXXX`** — copy just this part

*(Repeat to create a second conversion for "Form submission" if you want — same flow, Goal category: Lead, name: Form Submit)*

---

## 3. Meta (Facebook) Pixel — ~5 min
**Gets you:** a 15-digit number like `123456789012345`

1. Go to **business.facebook.com** → sign in with your Facebook account
2. In the left sidebar: **All Tools → Events Manager**
3. Click **Connect data sources** (green button)
4. Choose **Web** → click **Connect**
5. Name your pixel: `River Mountain Systems`
6. Enter `www.rivermountainsystems.com` → click **Continue**
7. Choose **Set up the Meta Pixel** → **Install code manually**
8. **Your Pixel ID is shown in a box at the top** — it's a 15-digit number → copy it
9. Click **Continue** → **Done** (ignore the rest of the setup wizard — the code is already in your site)

---

## 4. LinkedIn Insight Tag — ~5 min
**Gets you:** a 7-digit number like `1234567`

1. Go to **linkedin.com/campaignmanager** → sign in
2. If you don't have a Campaign Manager account: click **Create account** · Account name: `River Mountain Systems` · currency: USD · LinkedIn Page: your company page (or skip)
3. In the left nav: **Analyze → Insight Tag**
4. Click **See my Insight Tag** → **I will install the tag myself**
5. Look at the code shown — find the line: `_linkedin_partner_id = "XXXXXXX"`
6. **Your ID is that 7-digit number** — copy it
7. Click **Done** (the tag is already in your site)

---

## 5. Microsoft Clarity — ~5 min
**Gets you:** a 10-character code like `abcd1234ef`

1. Go to **clarity.microsoft.com** → sign in with a Microsoft account (Outlook, Hotmail, or work account)
2. Click **Add new project**
3. Name: `River Mountain Systems` · URL: `www.rivermountainsystems.com`
4. Click **Add**
5. Choose **Install manually**
6. **Your ID is in the code snippet** — look for `clarity("set", "ProjectId", "XXXXXXXXXX")` — the quoted string after ProjectId is your ID
   - OR: look at the page URL — it ends in `/projects/YOURCODE/setup`
7. Click **Done** (code is already in your site)

---

## Run the Setup Script

Once you have all 5, open Terminal, navigate to the project, and run:

```bash
cd ~/rms
./setup-pixels.sh G-yourGA4id AW-yourAdsid yourMetaId yourLinkedInId yourClarityId
```

Real example (fake IDs):
```bash
./setup-pixels.sh G-AB12345678 AW-9876543210 123456789012345 7654321 abc123def4
```

The script updates all 18 HTML files and tells you what to verify.

Then push:
```bash
git add -A && git commit -m "Add real pixel IDs" && git push
```

---

## Verify It Worked

1. Open **rivermountainsystems.com** in Chrome
2. Open DevTools (Cmd+Option+I) → **Network** tab → type `collect` in the filter
3. Reload the page
4. You should see a request to `www.google-analytics.com/g/collect` within 5 seconds

For GA4 real-time: **analytics.google.com → Reports → Realtime** — should show 1 active user while you're on the page.
