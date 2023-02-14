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
LINE='export CUSTOM_HISTORY_FILE=/tmp/hfile_$(id -u -n)_$(date +%F).log'
FILE='/etc/bash.bashrc'
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"


read -r -d '' LINE << EOM
export PROMPT_COMMAND='history -a && echo "\$(id -u -n) \$(who am i)  \$(history |tail -1)" >> \$CUSTOM_HISTORY_FILE '
EOM

FILE='/etc/bash.bashrc'
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
