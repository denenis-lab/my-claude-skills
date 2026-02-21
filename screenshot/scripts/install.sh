#!/bin/bash

# Screenshot skill installer for Claude Code
# Installs the clipboard monitor daemon and Claude Code skill

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
INSTALL_DIR="$HOME/.local/bin"
PLIST_DIR="$HOME/Library/LaunchAgents"
SKILL_DIR="$HOME/.claude/skills/screenshot"
SCREENSHOTS_DIR="$HOME/Screenshots"
PLIST_NAME="com.user.screenshot-autosaver"

echo "Installing screenshot skill for Claude Code..."
echo ""

# Check dependencies
if ! command -v pngpaste &> /dev/null; then
    echo "Error: pngpaste is required but not installed."
    echo "Install it with: brew install pngpaste"
    exit 1
fi

# Create directories
mkdir -p "$INSTALL_DIR"
mkdir -p "$PLIST_DIR"
mkdir -p "$SKILL_DIR"
mkdir -p "$SCREENSHOTS_DIR"

# Copy the daemon script
cp "$SCRIPT_DIR/scripts/auto-screenshot-saver.sh" "$INSTALL_DIR/auto-screenshot-saver.sh"
chmod +x "$INSTALL_DIR/auto-screenshot-saver.sh"
echo "Installed daemon to $INSTALL_DIR/auto-screenshot-saver.sh"

# Generate plist from template (replace __HOME__ with actual home dir)
sed "s|__HOME__|$HOME|g" "$SCRIPT_DIR/templates/$PLIST_NAME.plist" > "$PLIST_DIR/$PLIST_NAME.plist"
echo "Installed LaunchAgent to $PLIST_DIR/$PLIST_NAME.plist"

# Copy SKILL.md
cp "$SCRIPT_DIR/SKILL.md" "$SKILL_DIR/SKILL.md"
echo "Installed skill to $SKILL_DIR/SKILL.md"

# Unload if already running, then load
launchctl unload "$PLIST_DIR/$PLIST_NAME.plist" 2>/dev/null || true
launchctl load "$PLIST_DIR/$PLIST_NAME.plist"
echo "Started clipboard monitor daemon"

echo ""
echo "Done! Use /screenshot in Claude Code to view your screenshots."
echo "Take a screenshot with Cmd+Shift+4 — it will be auto-saved to $SCREENSHOTS_DIR"
