#!/bin/bash

FILE='/etc/profile'
# Change max history size
LINE='HISTFILESIZE=99000'
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"

# Add timestamp to Linux history
LINE='export HISTTIMEFORMAT="%F %T -- "'
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"

# if logic
## cenos /etc/bashrc
## ubuntu /etc/bash.bashrc
FILE='/etc/bash.bashrc'

LINE='HISTORY_FILE_PATH=~/.history/'
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
LINE='mkdir -p $HISTORY_FILE_PATH'
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"

# Append history immediately after each command
LINE='export CUSTOM_HISTORY_FILE=$(echo $HISTORY_FILE_PATH)hfile_$(id -u -n)_$(date +%F).log'
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"

# Write Detail Log
read -r -d '' LINE << EOM
export PROMPT_COMMAND='history -a && echo "\$(id -u -n) \$(who am i)  \$(history |tail -1)" >> \$CUSTOM_HISTORY_FILE '
EOM
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
