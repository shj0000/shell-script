#! /bin/bash

echo update

wget -O - https://raw.githubusercontent.com/shj0000/shell-script/main/update_alias.sh >> ~/.bash_aliases
source ~/.bash_aliases

echo finish update
