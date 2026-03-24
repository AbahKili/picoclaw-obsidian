#!/bin/bash
set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

info()    { echo -e "${CYAN}[INFO]${NC}  $1"; }
success() { echo -e "${GREEN}[OK]${NC}    $1"; }
warn()    { echo -e "${YELLOW}[WARN]${NC}  $1"; }
error()   { echo -e "${RED}[ERR]${NC}   $1"; exit 1; }

echo ""
echo -e "${CYAN}╔══════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║       PicoClaw × Obsidian — Setup Wizard        ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════╝${NC}"
echo ""

check_cmd() {
  if ! command -v "$1" &>/dev/null; then
    error "Required command not found: $1. Please install it first."
  fi
}

check_cmd curl
check_cmd unzip

info "Downloading PicoClaw..."
PC_DL="https://github.com/sipeed/picoclaw/releases/latest/download/picoclaw-linux-amd64.zip"
curl -sL "$PC_DL" -o /tmp/picoclaw.zip || error "Failed to download PicoClaw"
unzip -qo /tmp/picoclaw.zip picoclaw -d /usr/local/bin/ 2>/dev/null || error "Failed to extract PicoClaw"
chmod +x /usr/local/bin/picoclaw
rm /tmp/picoclaw.zip
success "PicoClaw installed"

info "Downloading gws CLI (Google Workspace)..."
GWS_DL="https://github.com/googleworkspace/cli/releases/latest/download/gws-linux-amd64.zip"
curl -sL "$GWS_DL" -o /tmp/gws.zip && {
  unzip -qo /tmp/gws.zip gws -d /usr/local/bin/ 2>/dev/null
  chmod +x /usr/local/bin/gws
  rm /tmp/gws.zip
  success "gws CLI installed"
} || warn "gws CLI download failed — Google Workspace skills will need manual setup"

echo ""
echo "──────────────────────────────────────────────────"
echo " Step 1/3 — Vault Location"
echo "──────────────────────────────────────────────────"
echo ""
DEFAULT_VAULT="$HOME/Documents/Obsidian"
info "This directory will be created if it doesn't exist."
info "Later, open it as an Obsidian vault in the Obsidian app."
echo ""
read -rp "Vault parent directory [$DEFAULT_VAULT]: " VAULT_PARENT
VAULT_PARENT="${VAULT_PARENT:-$DEFAULT_VAULT}"
mkdir -p "$VAULT_PARENT"

read -rp "Vault name [PicoClaw]: " VAULT_NAME
VAULT_NAME="${VAULT_NAME:-PicoClaw}"

VAULT_PATH="$VAULT_PARENT/$VAULT_NAME"
PICOCLAW_DIR="$VAULT_PATH/PicoClaw"

if [ -d "$PICOCLAW_DIR" ]; then
  warn "PicoClaw folder already exists at $PICOCLAW_DIR"
else
  mkdir -p "$PICOCLAW_DIR/memory" "$PICOCLAW_DIR/Facts" "$PICOCLAW_DIR/Episodes" "$PICOCLAW_DIR/Logs" "$PICOCLAW_DIR/Tasks" "$PICOCLAW_DIR/.obsidian"
  info "Created vault structure at $PICOCLAW_DIR"
fi

info "Symlinking workspace to $PICOCLAW_DIR"
picoclaw config set workspace "$PICOCLAW_DIR" 2>/dev/null || {
  warn "Could not set workspace via picoclaw config — check picoclaw config command"
}

echo ""
echo "──────────────────────────────────────────────────"
echo " Step 2/3 — LLM Provider"
echo "──────────────────────────────────────────────────"
echo ""
echo "  1) Groq       (fast, free tier available)"
echo "  2) Anthropic  (Claude models)"
echo "  3) OpenAI     (GPT models)"
echo "  4) Gemini     (Google AI models)"
echo "  5) OpenRouter (access to many models)"
echo "  6) Ollama     (local models)"
echo "  7) DeepSeek   (DeepSeek V3 / Coder)"
echo ""
read -rp "Choose LLM provider [1]: " LLM_CHOICE
LLM_CHOICE="${LLM_CHOICE:-1}"

case $LLM_CHOICE in
  1) LLM_NAME="groq"; LLM_BASE="https://api.groq.com/openai/v1" ;;
  2) LLM_NAME="anthropic"; LLM_BASE="https://api.anthropic.com" ;;
  3) LLM_NAME="openai"; LLM_BASE="https://api.openai.com/v1" ;;
  4) LLM_NAME="gemini"; LLM_BASE="https://generativelanguage.googleapis.com/v1beta/openai/" ;;
  5) LLM_NAME="openrouter"; LLM_BASE="https://openrouter.ai/api/v1" ;;
  6) LLM_NAME="ollama"; LLM_BASE="http://localhost:11434/v1" ;;
  7) LLM_NAME="deepseek"; LLM_BASE="https://api.deepseek.com" ;;
  *) error "Invalid choice" ;;
esac

echo ""
echo "──────────────────────────────────────────────────"
echo " Step 3/3 — API Key"
echo "──────────────────────────────────────────────────"
echo ""
read -rp "Enter your $LLM_NAME API key: " API_KEY
if [ -z "$API_KEY" ]; then
  warn "No API key entered — you'll need to set it manually in the config."
fi

CONFIG_DIR="$HOME/.picoclaw"
mkdir -p "$CONFIG_DIR"

cat > "$CONFIG_DIR/config.json" << EOF
{
  "workspace": "$PICOCLAW_DIR",
  "llm": {
    "provider": "$LLM_NAME",
    "base_url": "$LLM_BASE",
    "api_key": "$API_KEY",
    "model": ""
  }
}
EOF

if [ "$LLM_NAME" = "ollama" ]; then
  info "Ollama selected — set your model manually:"
  info "  picoclaw config set llm.model llama3.3"
fi
if [ "$LLM_NAME" = "ollama" ]; then
  info "Or set it now: "
  read -rp "Model name [llama3.3]: " OLLAMA_MODEL
  OLLAMA_MODEL="${OLLAMA_MODEL:-llama3.3}"
  sed -i "s/\"model\": \"\"/\"model\": \"$OLLAMA_MODEL\"/" "$CONFIG_DIR/config.json"
fi

if [ -f "$PICOCLAW_DIR/memory/MEMORY.md" ]; then
  success "MEMORY.md already exists — skipping seed file"
else
  cat > "$PICOCLAW_DIR/memory/MEMORY.md" << 'MEMEOF'
# Memory

## About Me
- Name:
- Role:
- Preferences:

## Current Context

## Active Projects

## Notes

MEMEOF
fi

echo ""
echo "──────────────────────────────────────────────────"
echo ""
success "Setup complete!"
echo ""
info "Next steps:"
echo "  1. Open Obsidian → Open vault → select $VAULT_PATH"
echo "  2. Run: picoclaw"
echo "  3. Optional: gws auth login  (for Google Workspace skills)"
echo ""
