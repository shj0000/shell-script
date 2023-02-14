#!/bin/bash

# Add timestamp to Linux history
LINE='export HISTTIMEFORMAT="$USER %F %T -- "'
FILE='/etc/profile'
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"

# Append history immediately after each command
LINE='export PROMPT_COMMAND="history -a"'
FILE='/etc/profile'
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"

# Change max history size
LINE='HISTFILESIZE=99000'
FILE='/etc/profile'
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
