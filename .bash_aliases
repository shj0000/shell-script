# default
## rm
alias rm='rm -i'

## mv
alias mv='mv -i'

## cp
alias cp='cp -i'

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

# k8s
## kubectl
alias k='kubectl'

## kubectl get
alias kg='kubectl get'

## kubectl get all
alias kga='kubectl get all'

## kubectl get all -A
alias kgaa='kubectl get all -A'

## kubectl get po
alias kgp='kubectl get po'

## kubectl get po -A
alias kgpa='kubectl get po -A'

## kubectl get po -A -o wide
alias kgpaw='kubectl get po -A -o wide'

## kubectl get service
alias kgs='kubectl get service'

## kubectl get service -A
alias kgsa='kubectl get service -A'

## kubectl get service -A
alias kgsaw='kubectl get service -A -o wide'

## kubectl get no
alias kgn='kubectl get no'

## kubectl get no
alias kgno='kubectl get no'

## kubectl get namespace
alias kgns='kubectl get namespace'

## kubctl ns
alias kns='kubctl ns'
