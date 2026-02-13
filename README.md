# Clean Text

A Raycast script that cleans up text copied from terminal output — particularly from tools like Claude Code that wrap lines at a fixed width with leading whitespace.

It joins wrapped lines back into proper paragraphs while preserving paragraph breaks and bullet points, then pastes the cleaned text wherever your cursor is.

**Before:**
```
  The main thing to understand about this approach is that it
  requires consistent effort over time. You can't just set it
  up once and walk away.

  - First, make sure your configuration is correct. This means
  checking every environment variable and validating against
  the expected schema.
  - Second, automate the parts that are repetitive. Manual
  steps will eventually be skipped or done wrong.
```

**After:**
```
The main thing to understand about this approach is that it requires consistent effort over time. You can't just set it up once and walk away.

- First, make sure your configuration is correct. This means checking every environment variable and validating against the expected schema.
- Second, automate the parts that are repetitive. Manual steps will eventually be skipped or done wrong.
```

## Install

1. Clone this repo:
   ```
   git clone https://github.com/ryanschmidt/raycast-cleantext.git
   ```
2. In Raycast, open **Extensions → Add Script Directory** and point it at the cloned folder.
3. Copy text from your terminal, invoke Raycast, type "clean", and hit Enter. The cleaned text pastes wherever your cursor was.
