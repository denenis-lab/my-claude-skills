# Remote Control — Claude Code from Your Phone

Connect to a running Claude Code terminal session from your phone or any device via web or the Claude mobile app.

## Requirements

- **Claude Code** ≥ 2.1.52
- **Max** subscription (Pro — coming soon)

## Quick Start

```bash
# In a separate terminal — start Remote Control
claude rc

# Confirm 'y' → get a link + QR code
# Open the link on your phone or scan the QR
```

## How to Connect

| Method | How |
|--------|-----|
| **Web** | Open `claude.ai/code/session_...` link in any browser |
| **iOS app** | Open the link in Safari → it offers to open in the app |
| **Another computer** | Open the same link in any browser |

## Inside an Active Session

You can also enable it via slash command:

```
/remote-control
```

Or the shortcut `/rc`.

## Important Notes

- `claude rc` cannot be run **inside** a Claude Code session (nested sessions are not allowed)
- Run it in a **separate terminal**
- The access token is temporary — the link stops working after the session ends
- Your code stays on your machine, nothing is sent to the cloud

## Documentation

- [Official Remote Control docs](https://code.claude.com/docs/en/remote-control)
- [Claude Code Desktop](https://code.claude.com/docs/en/desktop)
