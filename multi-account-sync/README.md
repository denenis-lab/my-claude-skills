# Multi-Account Sync for Claude Code

Sync Claude Code configuration (skills, rules, CLAUDE.md, settings) between multiple macOS user accounts on the same machine.

Inspired by [Sereja Ris](https://sereja.tech/blog/sync-claude-code-four-machines/) — he syncs across 4 machines via Git. This is a simpler version for multiple accounts on one Mac.

## The Problem

macOS user accounts have separate home directories. If you use Claude Code under two accounts, each has its own `~/.claude/` with separate skills, rules, and settings. Changes in one account don't appear in the other.

## Solution: Shared Directory + Symlinks

Store config in `/Users/Shared/` (readable by all macOS users) and symlink from each account.

```
/Users/Shared/claude-config/     ← single source of truth
├── CLAUDE.md
├── settings.json
├── skills/
└── rules/

/Users/alice/.claude/
├── CLAUDE.md → /Users/Shared/claude-config/CLAUDE.md
├── settings.json → /Users/Shared/claude-config/settings.json
├── skills → /Users/Shared/claude-config/skills/
└── rules → /Users/Shared/claude-config/rules/

/Users/bob/.claude/
├── CLAUDE.md → /Users/Shared/claude-config/CLAUDE.md
├── settings.json → /Users/Shared/claude-config/settings.json
├── skills → /Users/Shared/claude-config/skills/
└── rules → /Users/Shared/claude-config/rules/
```

## Setup

### 1. Move config to shared location

Run from your primary account:

```bash
# Create shared directory
mkdir -p /Users/Shared/claude-config

# Copy your config
cp ~/.claude/CLAUDE.md /Users/Shared/claude-config/
cp ~/.claude/settings.json /Users/Shared/claude-config/
cp -R ~/.claude/skills /Users/Shared/claude-config/
cp -R ~/.claude/rules /Users/Shared/claude-config/

# Make accessible to all users
chmod -R a+rw /Users/Shared/claude-config
```

### 2. Replace originals with symlinks (primary account)

```bash
rm -rf ~/.claude/skills ~/.claude/rules
rm -f ~/.claude/CLAUDE.md ~/.claude/settings.json

ln -s /Users/Shared/claude-config/skills ~/.claude/skills
ln -s /Users/Shared/claude-config/rules ~/.claude/rules
ln -s /Users/Shared/claude-config/CLAUDE.md ~/.claude/CLAUDE.md
ln -s /Users/Shared/claude-config/settings.json ~/.claude/settings.json
```

### 3. Set up second account

```bash
# Run with sudo from primary account, replacing <username> with the second account name
SECOND_USER="<username>"
SECOND_HOME="/Users/$SECOND_USER"

sudo -u $SECOND_USER mkdir -p "$SECOND_HOME/.claude"
sudo -u $SECOND_USER rm -rf "$SECOND_HOME/.claude/skills" "$SECOND_HOME/.claude/rules"
sudo -u $SECOND_USER rm -f "$SECOND_HOME/.claude/CLAUDE.md" "$SECOND_HOME/.claude/settings.json"

sudo -u $SECOND_USER ln -s /Users/Shared/claude-config/skills "$SECOND_HOME/.claude/skills"
sudo -u $SECOND_USER ln -s /Users/Shared/claude-config/rules "$SECOND_HOME/.claude/rules"
sudo -u $SECOND_USER ln -s /Users/Shared/claude-config/CLAUDE.md "$SECOND_HOME/.claude/CLAUDE.md"
sudo -u $SECOND_USER ln -s /Users/Shared/claude-config/settings.json "$SECOND_HOME/.claude/settings.json"
```

## Optional: Git Backup

Add a Git remote for backup and cross-machine sync:

```bash
cd /Users/Shared/claude-config
git init
git add -A
git commit -m "chore: initial claude-config"
gh repo create claude-config --private --source=. --push
```

For same-machine sync between accounts, Git is **not required** — both accounts read the same files instantly.

## Credits

- Approach inspired by [Как я синхронизирую Claude Code на четырёх компах](https://sereja.tech/blog/sync-claude-code-four-machines/) by Sereja Ris
