# My Claude Code Skills

A collection of custom skills and references to third-party skills I use with [Claude Code](https://docs.anthropic.com/en/docs/claude-code).

## Custom Skills

### [screenshot](./screenshot/)

Clipboard monitor that automatically saves screenshots and makes them accessible to Claude Code via `/screenshot` command.

**How it works:**
- A background daemon watches the clipboard for images (every 1s)
- When a new screenshot is detected, it saves it to `~/Screenshots` as a PNG
- Claude Code reads and describes the screenshots on demand

**Components:**
- `SKILL.md` — Claude Code skill definition
- `scripts/auto-screenshot-saver.sh` — clipboard monitor daemon
- `scripts/install.sh` — one-command installer
- `templates/com.user.screenshot-autosaver.plist` — LaunchAgent template

**Quick install:**
```bash
brew install pngpaste
cd screenshot && bash scripts/install.sh
```

See [screenshot/README.md](./screenshot/README.md) for details.

## Third-Party Skills I Use

| Skill | Author | Description |
|-------|--------|-------------|
| [superpowers](https://github.com/obra/superpowers) | Jesse Vincent | TDD, debugging, brainstorming, code review, planning workflows |
| [data](https://github.com/anthropics/claude-code/tree/main/plugins) | Anthropic | SQL, data visualization, dashboards, statistical analysis |

## License

MIT
