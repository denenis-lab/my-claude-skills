#!/bin/bash
# SessionStart hook: load open GitHub Issues for current repo
# Runs at the beginning of each Claude Code session

# Check if we're in a git repo
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0

# Get repo owner/name from remote
REPO=$(gh repo view --json nameWithOwner -q '.nameWithOwner' 2>/dev/null)
[ -z "$REPO" ] && exit 0

# Get open issues
ISSUES=$(gh issue list --repo "$REPO" --state open --limit 20 --json number,title,labels -q '.[] | "#\(.number) [\(.labels | map(.name) | join(", "))] \(.title)"' 2>/dev/null)

if [ -n "$ISSUES" ]; then
    echo "Open GitHub Issues for $REPO:"
    echo "$ISSUES"
    echo ""
    echo "Check project board for priorities: gh project item-list 1 --owner $(echo $REPO | cut -d/ -f1)"
fi
