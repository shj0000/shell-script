#!/bin/bash

FILE='/etc/profile'
# Change max history size
LINE='HISTFILESIZE=99000'
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"

# Add timestamp to Linux history
LINE='export HISTTIMEFORMAT="%F %T -- "'
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"



FILE='/etc/bash.bashrc'
# Append history immediately after each command
LINE='export CUSTOM_HISTORY_FILE=/tmp/hfile_$(id -u -n)_$(date +%F).log'
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"

# Write Detail Log
read -r -d '' LINE << EOM
export PROMPT_COMMAND='history -a && echo "\$(id -u -n) \$(who am i)  \$(history |tail -1)" >> \$CUSTOM_HISTORY_FILE '
EOM
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
