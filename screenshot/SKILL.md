---
name: screenshot
description: Find and display recent screenshots from ~/Screenshots
invocable: true
---

# Instructions

When the user invokes `/screenshot` or `/screenshot N`:

1. **Determine the number of screenshots from arguments:**
   - No argument — show 1 (the latest)
   - A number — show that many
   - Maximum 5 at a time

2. **Find screenshots:**
   ```bash
   ls -1t ~/Screenshots/screenshot-*.png ~/Screenshots/Screenshot*.png 2>/dev/null | head -n N
   ```

3. **Read each found file using the Read tool**

4. **Describe the contents:**
   - 1 screenshot — give a detailed description
   - Multiple — give a brief description of each

5. **Error handling:**
   - No files found → "No screenshots yet. Take one with Cmd+Shift+4 (area) or Cmd+Shift+3 (full screen)."
   - Directory missing → "Screenshots directory ~/Screenshots does not exist."

## Help

If the user asks how to take screenshots or how the system works:

**How to capture**: Cmd+Shift+4 → Space → click a window. The clipboard monitor daemon saves it to `~/Screenshots`.

**Setup**: See the project README for installation instructions (`install.sh`).
