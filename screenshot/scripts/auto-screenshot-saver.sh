#!/bin/bash

# Automatic clipboard screenshot saver
# Monitors the clipboard and saves images to ~/Screenshots
# Requires: pngpaste (brew install pngpaste)

SCREENSHOTS_DIR="$HOME/Screenshots"
TEMP_FILE="$HOME/.local/.clipboard_check.png"
LAST_HASH_FILE="$HOME/.local/.last_screenshot_hash"
CHECK_INTERVAL=1  # Check every second

# Create directories if missing
mkdir -p "$SCREENSHOTS_DIR"
mkdir -p "$HOME/.local"

# Clean up old screenshots
cleanup_screenshots() {
    # Delete files older than 7 days
    find "$SCREENSHOTS_DIR" -name "screenshot-*.png" -type f -mtime +7 -delete 2>/dev/null

    # Keep only the latest 50 files
    local count=$(ls -1t "$SCREENSHOTS_DIR"/screenshot-*.png 2>/dev/null | wc -l | tr -d ' ')
    if [ "$count" -gt 50 ]; then
        ls -1t "$SCREENSHOTS_DIR"/screenshot-*.png | tail -n +51 | xargs rm -f 2>/dev/null
    fi
}

# Save a screenshot from clipboard
save_screenshot() {
    local filename="screenshot-$(date +%Y%m%d-%H%M%S).png"
    local filepath="$SCREENSHOTS_DIR/$filename"

    if pngpaste "$filepath" 2>/dev/null; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Saved: $filename"
        cleanup_screenshots
        return 0
    fi
    return 1
}

# Get hash of current clipboard contents
get_clipboard_hash() {
    rm -f "$TEMP_FILE" 2>/dev/null
    if pngpaste "$TEMP_FILE" 2>/dev/null; then
        md5 -q "$TEMP_FILE" 2>/dev/null
        rm -f "$TEMP_FILE"
    fi
}

echo "Clipboard monitor started"
echo "Directory: $SCREENSHOTS_DIR"
echo "Interval: ${CHECK_INTERVAL}s"
echo ""

# Main loop
while true; do
    current_hash=$(get_clipboard_hash)

    last_hash=""
    if [ -f "$LAST_HASH_FILE" ]; then
        last_hash=$(cat "$LAST_HASH_FILE")
    fi

    # If hash changed and clipboard has an image — save it
    if [ -n "$current_hash" ] && [ "$current_hash" != "$last_hash" ]; then
        save_screenshot
        echo "$current_hash" > "$LAST_HASH_FILE"
    fi

    sleep "$CHECK_INTERVAL"
done
