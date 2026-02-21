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

## Tips & Tricks

### `lfg` — Launch Claude Code in autonomous mode

A shell alias to run Claude Code with `--dangerously-skip-permissions` (no confirmation prompts). Inspired by [Sereja Ris](https://github.com/serejaris/ris-claude-code) and his Claude Code workflow.

Add to your `~/.zshrc`:

```bash
alias lfg="claude --dangerously-skip-permissions"
```

Then just type `lfg` in any project directory to start a fully autonomous Claude Code session.

> **Warning:** This skips all permission prompts. Use only in trusted environments — Claude will read, write, and execute without asking.

## Third-Party Skills I Use

| Skill | Author | Description |
|-------|--------|-------------|
| [superpowers](https://github.com/obra/superpowers) | Jesse Vincent | TDD, debugging, brainstorming, code review, planning workflows |
| [data](https://github.com/anthropics/claude-code/tree/main/plugins) | Anthropic | SQL, data visualization, dashboards, statistical analysis |
| [skill-creator](https://github.com/anthropics/skills) | Anthropic | Meta-skill for creating, validating, and packaging new skills |
| [frontend-design](https://github.com/anthropics/claude-code/tree/main/plugins/frontend-design) | Anthropic | Distinctive, production-grade frontend UI with bold aesthetics |
| [developing-with-streamlit](https://github.com/streamlit/agent-skills) | Streamlit | Production-grade Streamlit apps — design, performance, layouts, data display |
| [frontend-slides](https://github.com/zarazhangrui/frontend-slides) | zarazhangrui | Animation-rich HTML presentations from scratch or PPT conversion |
| [macos-fixer](https://github.com/serejaris/ris-claude-code) | Sereja Ris | macOS memory diagnostics, performance troubleshooting |
| [git-workflow-manager](https://github.com/serejaris/ris-claude-code) | Sereja Ris | Conventional commits, semantic versioning, changelogs |

## License

MIT
