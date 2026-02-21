# Screenshot Skill for Claude Code

A clipboard monitor daemon that automatically saves screenshots and a Claude Code skill to view them.

## Prerequisites

- macOS
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code)
- [pngpaste](https://github.com/jcsalterego/pngpaste) — reads images from clipboard

```bash
brew install pngpaste
```

## Installation

```bash
bash scripts/install.sh
```

The installer will:
1. Copy the daemon script to `~/.local/bin/`
2. Generate and load a LaunchAgent (auto-starts on login)
3. Copy the skill to `~/.claude/skills/screenshot/`
4. Create `~/Screenshots` directory

## Usage

In Claude Code:

```
/screenshot       # show the latest screenshot
/screenshot 3     # show the last 3 screenshots
```

**Taking screenshots:**
- `Cmd+Shift+3` — full screen
- `Cmd+Shift+4` — select area
- `Cmd+Shift+4` → `Space` → click window — capture a window

The daemon monitors your clipboard every second. When it detects a new image, it saves it as `~/Screenshots/screenshot-YYYYMMDD-HHMMSS.png`.

## How It Works

1. **Daemon** (`auto-screenshot-saver.sh`) runs in the background via LaunchAgent
2. Every second it checks if the clipboard contains a new image (using `pngpaste`)
3. Compares the MD5 hash with the previous one to avoid duplicates
4. Saves new images to `~/Screenshots/`
5. Auto-cleans: deletes files older than 7 days, keeps max 50

## Uninstall

```bash
# Stop and remove the daemon
launchctl unload ~/Library/LaunchAgents/com.user.screenshot-autosaver.plist
rm ~/Library/LaunchAgents/com.user.screenshot-autosaver.plist
rm ~/.local/bin/auto-screenshot-saver.sh

# Remove the skill
rm -rf ~/.claude/skills/screenshot

# Optionally remove screenshots
rm -rf ~/Screenshots
```

## License

MIT
