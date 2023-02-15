# default
## rm
alias rm='rm -i'

## mv
alias mv='mv -i'

## cp
alias cp='cp -i'

## systemctl
alias sys='systemctl'
alias syss='systemctl status'

## ls
alias llh='ls -alFh'

## du
alias llu='du -h -d 1 . | sort -h'

## history
alias h='history'
alias hg='history | grep $1'
alias hga='history | grep -A 2 -B 2 $1'

## watch (with alias)
alias wt='watch -d -n1 '

## cd
alias cdr='cd /'
alias cdt='cd ..'
alias cdp='cd -'
alias p='cd -'

## a quick way to get out of current directory ##
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'


## find > function
ff() {
    #do things with parameters like $1 such as
    find . -name "*$1*"
}
ffd() {
    #do things with parameters like $1 such as
    find . -type d -name "*$1*" -exec du -h -d 0 {} \;
}
fff() {
    #do things with parameters like $1 such as
    find . -type f -name "*$1*" -exec ls -alFh --color=auto {} \;
}
