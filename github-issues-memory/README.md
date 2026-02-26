# GitHub Issues as Agent Memory

Use GitHub Issues + Projects as persistent task memory for Claude Code. The agent creates, updates, and closes issues automatically — you never lose context between sessions.

Inspired by [Sereja Ris](https://sereja.tech/blog/github-projects-ai-agent-memory/) and his [hooks article](https://sereja.tech/blog/claude-code-hooks-github-issues/).

## How It Works

1. **Project Board** — one unified board across all repos (Backlog → In Progress → Done)
2. **Issues as tasks** — each task is a GitHub Issue with full context
3. **SessionStart hook** — loads open issues when you start Claude Code
4. **PostToolUse hook** — reminds to update issues after `git push`

```
Session starts → hook loads open issues → agent knows context
     ↓
Work happens → git push → hook reminds about issues
     ↓
Agent closes/updates issues → board stays current
```

## Setup

### 1. Create a Project Board

```bash
# Add required scopes
gh auth refresh -s read:project,project

# Create board
gh project create --owner <YOUR_USERNAME> --title "Tasks"

# Add Priority field
gh project field-create 1 --owner <YOUR_USERNAME> \
  --name "Priority" \
  --data-type "SINGLE_SELECT" \
  --single-select-options "High,Medium,Low"
```

### 2. Install Hooks

Copy the hook scripts to a persistent location (e.g. `~/.claude/hooks/`):

```bash
mkdir -p ~/.claude/hooks
cp hooks/session-start-issues.sh ~/.claude/hooks/
cp hooks/post-push-remind.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh
```

Add to `~/.claude/settings.json`:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "type": "command",
        "command": "bash ~/.claude/hooks/session-start-issues.sh",
        "timeout": 15000
      }
    ],
    "PostToolUse": [
      {
        "type": "command",
        "command": "bash ~/.claude/hooks/post-push-remind.sh",
        "matcher": {
          "tool": "Bash",
          "command": "git push"
        },
        "timeout": 15000
      }
    ]
  }
}
```

### 3. Add a Rule

Create `~/.claude/rules/github-issues.md` so the agent knows the workflow:

```markdown
# GitHub Issues as task memory

## Workflow
- When starting work on a project, check open issues: `gh issue list`
- When creating tasks, create them as GitHub Issues and add to the project board
- When completing a task, close the issue
- When user asks "what to do next" — check the board, suggest highest priority open issue
- Update issue comments with progress and context for future sessions

## Priority rules
- **High** — blocks other tasks or delivers visible result now
- **Medium** — useful but can wait
- **Low** — nice to have
```

## What It Looks Like

When you start a session in a project directory:

```
Open GitHub Issues for your-username/your-project:
#3 [] Unify design system across all pages
#2 [] Migrate component to new API
#1 [] Add responsive layout
```

After `git push`:

```
Pushed to your-username/your-project. Open issues:
#2 Migrate component to new API
#1 Add responsive layout
Consider: update issue comments with progress, close completed issues.
```

## Credits

- Concept: [GitHub Projects как память для AI-агента](https://sereja.tech/blog/github-projects-ai-agent-memory/) by Sereja Ris
- Hooks: [Хуки Claude Code: агент сам ведёт задачи](https://sereja.tech/blog/claude-code-hooks-github-issues/) by Sereja Ris
