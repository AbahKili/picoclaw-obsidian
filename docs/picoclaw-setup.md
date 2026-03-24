# PicoClaw Setup Guide

## What is PicoClaw?

PicoClaw is a CLI-based AI agent that runs in your terminal. With this integration, it gains long-term memory via an Obsidian vault.

## Requirements

- Linux (Ubuntu 24.04 recommended)
- `curl`, `unzip`
- An Obsidian vault (or a directory to become one)
- An LLM API key (Groq recommended for speed/free tier)

## Quick Install

```bash
curl -sL https://github.com/sipeed/picoclaw/releases/latest/download/picoclaw-linux-amd64.zip -o /tmp/picoclaw.zip
unzip -qo /tmp/picoclaw.zip picoclaw -d /usr/local/bin/
chmod +x /usr/local/bin/picoclaw
rm /tmp/picoclaw.zip
```

## Or Use the Installer

```bash
git clone https://github.com/AbahKili/picoclaw-obsidian.git
cd picoclaw-obsidian
chmod +x setup.sh
./setup.sh
```

The installer will:
1. Download and install PicoClaw + gws CLI
2. Ask for your Obsidian vault path
3. Auto-create the `PicoClaw/` workspace subfolder
4. Pick your LLM provider and enter your API key
5. Generate `~/.picoclaw/config.json`

## Vault Path

The vault path you choose will have a `PicoClaw/` subfolder created inside it. Open that vault in the Obsidian app to see your memory notes.

Recommended: `~/Documents/Obsidian/PicoClaw/`

## Config Location

All PicoClaw config lives at `~/.picoclaw/config.json`.

## Switch LLM Provider

Edit `~/.picoclaw/config.json`:
```json
{
  "llm": {
    "provider": "groq",
    "base_url": "https://api.groq.com/openai/v1",
    "api_key": "your-key-here",
    "model": "llama-3.3-70b-versatile"
  }
}
```

## Run PicoClaw

```bash
picoclaw
```

PicoClaw will load `AGENTS.md`, your memory, and skills on startup.

## Directory Structure

```
~/.picoclaw/
├── config.json          ← LLM and workspace config
└── workspace/           ← Symlinked to vault/PicoClaw/
    ├── AGENTS.md
    ├── HEARTBEAT.md
    ├── IDENTITY.md
    ├── SOUL.md
    ├── USER.md
    └── skills/
        ├── obsidian-memory/
        ├── google-workspace/
        ├── google-calendar/
        ├── google-sheets/
        └── google-meet/
```

## Update PicoClaw

```bash
curl -sL https://github.com/sipeed/picoclaw/releases/latest/download/picoclaw-linux-amd64.zip -o /tmp/picoclaw.zip
sudo unzip -qo /tmp/picoclaw.zip picoclaw -d /usr/local/bin/
rm /tmp/picoclaw.zip
```

## Troubleshooting

| Issue | Fix |
|-------|-----|
| `command not found: picoclaw` | Re-run install; check `/usr/local/bin/` is in PATH |
| `No such file or directory: config.json` | Run `./setup.sh` again |
| `LLM error` | Check API key in `~/.picoclaw/config.json` |
| Vault empty | Make sure you opened the vault in the Obsidian app |
