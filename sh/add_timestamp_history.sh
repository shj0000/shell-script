#!/bin/bash

# Change max history size
LINE='HISTFILESIZE=99000'
FILE='/etc/profile'
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"

# Add timestamp to Linux history
LINE='export HISTTIMEFORMAT="%F %T -- "'
FILE='/etc/profile'
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"

# Append history immediately after each command
LINE='CUSTOM_HISTORY_FILE=/tmp/hfile_$(date +%F_%T)'
FILE='/etc/profile'
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"

LINE='export PROMPT_COMMAND='history -a && echo "$(who am i)  $(history |tail -1)" >> $CUSTOM_HISTORY_FILE '   PROMPT_COMMAND=""'
FILE='/etc/profile'
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
