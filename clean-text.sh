#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Clean Text
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

cleaned=$(pbpaste | awk '
  /^[[:space:]]*$/ {
    if (buf) print buf
    buf = ""
    print ""
    next
  }
  {
    gsub(/^[[:space:]]+/, "")
    if (/^- / || /^\* / || /^\+ / || /^• / || /^◦ / || /^▪ / || /^‣ / || /^· / || /^[0-9]+[.)] /) {
      if (buf) print buf
      buf = $0
    } else {
      buf = (buf ? buf " " $0 : $0)
    }
  }
  END { if (buf) print buf }
' | cat -s)

# Plain text: strip markdown bold markers
plain=$(echo "$cleaned" | sed 's/\*\*\([^*]*\)\*\*/\1/g')

# HTML: escape ampersands, then convert **bold** to <b> tags
html=$(echo "$cleaned" \
  | sed 's/&/\&amp;/g' \
  | sed 's/\*\*\([^*]*\)\*\*/<b>\1<\/b>/g' \
  | sed 's/$/<br>/' \
  | tr -d '\n')

# Write to temp files for safe passing to JXA
plain_file=$(mktemp)
html_file=$(mktemp)
printf '%s' "$plain" > "$plain_file"
printf '%s' "$html" > "$html_file"

# Set both HTML and plain text on the clipboard
/usr/bin/osascript -l JavaScript -e "
ObjC.import('AppKit');
ObjC.import('Foundation');
var pb = \$.NSPasteboard.generalPasteboard;
pb.clearContents;
var plain = \$.NSString.stringWithContentsOfFileEncodingError('$plain_file', \$.NSUTF8StringEncoding, null);
pb.setStringForType(plain, 'public.utf8-plain-text');
var htmlStr = \$.NSString.stringWithContentsOfFileEncodingError('$html_file', \$.NSUTF8StringEncoding, null);
var htmlData = htmlStr.dataUsingEncoding(\$.NSUTF8StringEncoding);
pb.setDataForType(htmlData, 'public.html');
void 0;
" 2>/dev/null

rm -f "$plain_file" "$html_file"

osascript -e '
  delay 0.5
  tell application "System Events" to keystroke "v" using command down'
