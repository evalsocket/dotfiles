### config view

alias kcv='k config'
alias kcv='kc view'

### users

alias kusers="kcv -o jsonpath='{.users[*].name}'"
kuser() { kcv -o jsonpath='{.users[?(@.name == "'"${1:-${USER:-$(whoami)}}"'")].user.password}'; }
alias kusers="kcv -o jsonpath='{.users[*].name}'"
kuser() { kcv -o jsonpath='{.users[?(@.name == "'"${1:-${USER:-$(whoami)}}"'")].user.password}'; }

### exec

alias kx='k exec'
alias kxit='kx -it'
kxls() { local rest="${@:2}"; kx ${1:-my-pod} -- ls ${rest:-/}; }
alias kls=kxls
kxlsx() { local rest="${@:3}"; kx ${1:-my-pod} -c ${2:-my-container} -- ls ${rest:-/}; }

### logs

klbl()   { local rest="${@:2}"; klo -l name=${1:-my-label} ${rest}; }
klprev() { local rest="${@:2}"; klo ${1} --previous ${rest}; }
klblc()  { local rest="${@:3}"; klbl ${1:-my-label} -c ${2:-my-container} ${rest}; }
alias klblcp='klblc --previous'

### port-forward

alias kpf='kubectl port-forward'
kfwd() { kpf ${1:-my-pod} ${2:-8000}:${3:-${2:-8000}}; }

### run

alias kr='k run'
alias krun='kr busybox-test --image=busybox -it --rm --restart=Never --'
alias kash='krun /bin/ash'

### top

alias ktop='k top'
ktpod() { ktop pod ${1:-my-pod} --containers; }
ktnod() { ktop node ${1:-my-node}; }
alias ktnode=ktnod

### attach

alias katt='k attach -i'

### api-resources

alias kapi='k api-resources --sort-by=kind'
alias kapiny='kapi --namespaced=true'
alias kapino='kapi --namespaced=false'
alias kapiw='kapi -o wide'
alias kapir='kapiw --verbs=list,get'

### cluster

alias kcl='k cluster-info'
alias kcld='kcl dump'

### misc

alias kapp='k apply'
alias kdel='k delete'
alias kgen='k --dry-run=client -o yaml' # for creating manifests. e.g. kman run nginx --image=nginx

# This script is sourced from .zshrc.
# Add GNU tools not linked by Homebrew.
alias find='gfind'
alias xargs='gxargs'
alias stat='gstat'

# convenience aliases
alias cd..='cd ..'
alias cd...='cd ../..'
alias ls='ls --color'
alias l='ls -lF'
alias dir='ls'
alias la='ls -lah'
alias ll='ls -l'
alias ls-l='ls -l'
alias j='jobs'
alias time='gtime --format "$(tput setab 255)$(tput setaf 160)took %es.$(tput sgr0)"'
alias vi='vim'
alias grep='grep -E --color'
alias ping='ping -c 3'
alias pstree='pstree -w'
alias c='pbcopy'
alias p='pbpaste'
alias pt='pbpaste | tee'
alias t='tee'
alias slp='/System/Library/CoreServices/"Menu Extras"/User.menu/Contents/Resources/CGSession -suspend'
alias bd='bg && disown %1'
alias pg='ps ax | grep -v "grep" | grep'
alias o='less'
alias no='yes n'
alias cl='clear;clear'
alias page='less -S'
alias start=open
alias ccat='ccat --bg=dark'
alias c.='code .'
alias code.='code .'
alias fd='fd --no-ignore'
alias ag='ag --hidden'

# cloud stuff
alias d='docker'
alias dr='docker run --rm -i -t'
alias drb='docker run --rm -i -t --entrypoint sh'
alias drr='docker run --rm -i -t -p 8080:8080 -e PORT=8080'
alias dx='docker exec -i -t'
alias db='docker build -t'

# google cloud platform
alias gcurl='curl -k --header "Authorization: Bearer $(gcloud auth print-access-token -q)"'
alias runcurl='curl -k --header "Authorization: Bearer $(gcloud auth print-identity-token -q)"'
alias gke='gcloud container clusters'
alias gkedel='gcloud container clusters delete -q --async'
alias gce='gcloud compute instances'
alias gcssh='gcloud compute ssh'
alias runlist='gcloud run services list --platform=managed'
alias rundel='gcloud run services delete -q --platform=managed --region us-central1'

# git aliases
alias gc='_git_dbg commit -S -v -s'
alias gdc='_git_dbg diff --cached'
alias git='hub'
alias gpp='_git_dbg push ahmetb HEAD && hub pull-request --browse'
alias gpah='_git_dbg push ahmetb HEAD'
alias glah='_git_dbg pull ahmetb HEAD'
alias gfah='_git_dbg fetch ahmetb'
alias glom='_git_dbg pull origin master --tags'
alias gloh='_git_dbg pull origin HEAD --tags'
alias grom='_git_dbg rebase origin/master'
alias gpoh='_git_dbg push origin HEAD'
alias gbv="git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"
unalias grv

# kubectl
alias kx='kubectl explain'
alias pka='pbpaste | kubectl apply -f-'
alias pkr='pbpaste | kubectl delete -f-'
alias pkd='pbpaste | kubectl describe -f-'
alias kpl='kubectl plugin'
alias krew_install_clipboard='kubectl krew install --manifest <(pbpaste)'
alias kk='kubectl krew'


# misc shortcuts
alias tunneloff='networksetup -setsocksfirewallproxystate Wi-Fi off && echo Tunnel is turned off.'
alias tunnel='networksetup -setsocksfirewallproxystate Wi-Fi on && ssh -N -p 22 -D 8080 mine; networksetup -setsocksfirewallproxystate Wi-Fi off; echo Tunnel is turned off.'
alias ffmpeg='docker run --rm -i -t -v $PWD:/tmp/workdir jrottenberg/ffmpeg'
alias youtube-dl='docker run --rm -i -t -v $PWD:/data vimagick/youtube-dl'
alias goclone='$HOME/workspace/goclone/goclone'
alias decodecert='openssl x509 -in /dev/stdin -text'