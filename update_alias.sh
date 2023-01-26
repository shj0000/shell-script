#! /bin/bash

echo start update

wget -O - https://raw.githubusercontent.com/shj0000/shell-script/main/.bash_aliases > ~/.bash_aliases
source ~/.bash_aliases

echo finish update
