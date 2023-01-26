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
alias -='cd -'
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


## kubectl log
alias kl='kubectl log'


## kubectl apply
alias ka='kubectl apply -f'

## kubectl delete
alias kd='kubectl delete -f'

## kubectl replace
alias kr='kubectl replace --force -f'


## kubectl describe
alias kdb='kubectl describe'

## kubectl describe
alias kdbn='kubectl describe no'

## kubectl describe
alias kdbp='kubectl describe pod -A'

## kubectl describe
alias kdbs='kubectl describe service -A'


## kubectl get
alias kg='kubectl get'

## kubectl get all -A
alias kga='kubectl get all -A'

## kubectl get po -A
alias kgp='kubectl get po -A'

## kubectl get po -A -o wide
alias kgpa='kubectl get po -A -o wide'

## kubectl get service
alias kgs='kubectl get service -'

## kubectl get service -A
alias kgsa='kubectl get service -A -o wide'

## kubectl get no
alias kgn='kubectl get no -A'

## kubectl get no
alias kgna='kubectl get no -A -o wide'

## kubectl get namespace
alias kgns='kubectl get namespace'


## kubctl ns
alias kns='kubctl ns'
