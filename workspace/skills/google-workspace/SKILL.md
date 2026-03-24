# Skill: google-workspace

> Base skill for Google Workspace integration via `gws` CLI.

## Overview

The `gws` (Google Workspace) CLI handles all Google authentication and API calls. Skills that need Google services call `gws` as exec commands — no direct Google API code needed.

## Installation

```bash
# Install gws CLI
curl -sL https://github.com/googleworkspace/cli/releases/latest/download/gws-linux-amd64.zip -o /tmp/gws.zip
unzip -qo /tmp/gws.zip gws -d /usr/local/bin/
chmod +x /usr/local/bin/gws

# Authenticate (opens browser)
gws auth login

# Verify
gws version
```

See `docs/google-setup.md` for full setup walkthrough.

## Common gws Commands

```bash
# Check auth status
gws auth status

# List calendars
gws calendar list

# List spreadsheets
gws sheets list --limit 10

# Get spreadsheet info
gws sheets get --spreadsheet_id "SPREADSHEET_ID"
```

## Environment

| Variable | Default | Description |
|----------|--------|-------------|
| `GWS_CREDENTIALS_PATH` | `~/.gws/credentials.json` | OAuth credentials path |

## Error Handling

| Error | Fix |
|-------|-----|
| `credentials not found` | Run `gws auth login` |
| `invalid_grant` | Delete `~/.gws/credentials.json` and re-auth |
| `permission denied` | Check API is enabled in Google Cloud Console |

## Services Available

| Skill | Capability |
|-------|-----------|
| `google-calendar` | List events, create events, meeting prep |
| `google-meet` | Create Meet video conferences |
| `google-sheets` | Read, append, create spreadsheets |

## Google Cloud Setup (One-time)

1. Create project at [console.cloud.google.com](https://console.cloud.google.com)
2. Enable: **Google Calendar API**, **Google Sheets API**
3. Create OAuth 2.0 credentials (Desktop app)
4. Download JSON → rename to `credentials.json` → place at `~/.gws/`
5. Run `gws auth login`
