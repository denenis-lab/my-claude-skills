#!/bin/bash
# PostToolUse hook: remind to update issues after git push
# Triggered only when Claude Code runs "git push"

# Check if we're in a git repo
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0

REPO=$(gh repo view --json nameWithOwner -q '.nameWithOwner' 2>/dev/null)
[ -z "$REPO" ] && exit 0

ISSUES=$(gh issue list --repo "$REPO" --state open --limit 5 --json number,title -q '.[] | "#\(.number) \(.title)"' 2>/dev/null)

if [ -n "$ISSUES" ]; then
    echo "Pushed to $REPO. Open issues:"
    echo "$ISSUES"
    echo "Consider: update issue comments with progress, close completed issues, move items on project board."
fi
