#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Clean Text
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

pbpaste | awk '
  /^[[:space:]]*$/ {
    if (buf) print buf
    buf = ""
    print ""
    next
  }
  {
    gsub(/^[[:space:]]+/, "")
    if (/^[-*] / || /^[0-9]+\. /) {
      if (buf) print buf
      buf = $0
    } else {
      buf = (buf ? buf " " $0 : $0)
    }
  }
  END { if (buf) print buf }
' | sed '/^$/{ N; /^\n$/d; }' | pbcopy

osascript -e '
  delay 0.5
  tell application "System Events" to keystroke "v" using command down'