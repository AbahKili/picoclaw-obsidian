# Google Workspace Setup via gws CLI

This guide walks you through setting up Google Workspace integration (Calendar, Meet, Sheets) for PicoClaw using the [gws CLI](https://github.com/googleworkspace/cli).

## Prerequisites

- Google Cloud project with APIs enabled
- OAuth 2.0 credentials (client ID + client secret)
- `gws` CLI installed (see below)

---

## 1. Install gws CLI

```bash
# Linux (amd64)
curl -sL https://github.com/googleworkspace/cli/releases/latest/download/gws-linux-amd64.zip -o /tmp/gws.zip
unzip -qo /tmp/gws.zip gws -d /usr/local/bin/
chmod +x /usr/local/bin/gws
rm /tmp/gws.zip

# Verify
gws version
```

---

## 2. Create Google Cloud Project

1. Go to [console.cloud.google.com](https://console.cloud.google.com)
2. Create a new project or select existing
3. Enable these APIs:
   - **Google Calendar API** (for Calendar + Meet)
   - **Google Sheets API** (for Sheets)

---

## 3. OAuth Credentials

1. Go to **APIs & Services → Credentials**
2. Click **Create Credentials → OAuth client ID**
3. Application type: **Desktop app**
4. Download the JSON file
5. Rename it to `gws-credentials.json` and place it at `~/.gws/credentials.json`

```bash
mkdir -p ~/.gws
mv ~/Downloads/client_secret_*.json ~/.gws/credentials.json
```

---

## 4. Authenticate

```bash
gws auth login
```

This will open your browser for OAuth consent. After approval, credentials are stored at `~/.gws/`.

To verify:
```bash
gws calendar list --limit 5
```

---

## 5. Quick Reference

### Google Calendar

```bash
# List upcoming events
gws calendar events list --calendar_id primary --time_min now --limit 10

# Create event
gws calendar events create \
  --summary "Team Sync" \
  --start "2026-03-25T10:00:00Z" \
  --end "2026-03-25T11:00:00Z" \
  --calendar_id primary

# Create event with Google Meet
gws calendar events create \
  --summary "Video Call" \
  --start "2026-03-25T14:00:00Z" \
  --end "2026-03-25T15:00:00Z" \
  --conference_data_version 1 \
  --calendar_id primary
```

### Google Sheets

```bash
# List spreadsheets
gws sheets list --limit 10

# Read a sheet
gws sheets read \
  --spreadsheet_id "YOUR_SPREADSHEET_ID" \
  --range "Sheet1!A1:Z100"

# Append row
gws sheets append \
  --spreadsheet_id "YOUR_SPREADSHEET_ID" \
  --range "Sheet1!A:A" \
  --values '[["2026-03-25","Task 1","Done"]]'
```

### Google Meet

Meet links are created automatically when you create a Calendar event with video conference data (see above).

---

## 6. Headless / No-Browser Setup

If running on a server without a browser:

```bash
gws auth login --headless
```

For CI/CD or automated environments, use a service account instead:

```bash
gws auth login --service_account path/to/sa.json
```

---

## 7. Troubleshooting

| Issue | Fix |
|-------|-----|
| `Error: credentials not found` | Run `gws auth login` again |
| `Error: invalid_grant` | Delete `~/.gws/credentials.json` and re-auth |
| `Error: calendar not found` | Use `--calendar_id primary` |
| Rate limit errors | Add `--delay 1s` or check quotas |

---

## Environment Variables (Optional)

```bash
export GWS_CREDENTIALS_PATH="$HOME/.gws/credentials.json"
export GWS_CACHE_TOKENS="true"
```

These are optional — gws CLI picks them up automatically from the default paths.
