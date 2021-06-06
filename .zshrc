export ZSH=/Users/evalsocket/.oh-my-zsh
export ZSH_DISABLE_COMPFIX=true

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting virtualenv zsh-z colored-man-pages zsh-completions)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias n="nvim"
alias c="clear"
export PATH=$PATH:$HOME/bin
export EDITOR='nvim'

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="$HOME/.cargo/bin:$PATH"
export PATH=/usr/local/opt/ruby/bin:$PATH

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

source $(brew --prefix asdf)/asdf.sh
export TERM="xterm-256color"

# Set custom prompt
export GPG_TTY=$(tty)
PROMPT="%{$fg[green]%}%* "
PROMPT+="%(?:%{$fg_bold[green]%}➜:%{$fg_bold[red]%}➜)"
PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg[red]%}"

# Run tmux automatically on zsh lunch
eval "$(direnv hook zsh)"
if [ "$TMUX" = "" ]; then tmux; fi

# User configuration
export EDITOR=vim

# GO Path
export GOPATH=$HOME/go # don't forget to change your path correctly!
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# arkade
export PATH=$PATH:$HOME/.arkade/bin/

#jenv 
export PATH="$HOME/.jenv/bin:$PATH"

# Extra until
export PATH=$PATH:$HOME/.arkade/bin/
export PATH="${PATH}:${HOME}/.krew/bin"

# Load custom aliases
if [[ -f "$HOME/workspace/evalsocket/dotfiles/zsh_aliases.inc" ]]; then
	source "$HOME/workspace/evalsocket/dotfiles/zsh_aliases.inc"
else
	echo >&2 "WARNING: can't load shell aliases"
fi

[ -f ~/.kubectl_aliases ] && source \
   <(cat ~/.kubectl_aliases | sed -r 's/(kubectl.*) --watch/watch \1/g')

# Load custom functions
if [[ -f "$HOME/workspace/evalsocket/dotfiles/zsh_functions.inc" ]]; then
	source "$HOME/workspace/evalsocket/dotfiles/zsh_functions.inc"
else
	echo >&2 "WARNING: can't load shell functions"
fi

# use system paths (e.g. /etc/paths.d/)
eval "$(/usr/libexec/path_helper -s)"

# go tools
PATH="$PATH:$HOME/go/bin"

if [ -f "$HOME/.gnupg/gpg_profile" ] && command -v gpg-agent > /dev/null; then
  source "$HOME/.gnupg/gpg_profile"
else
  log "WARNING: skipping loading gpg-agent"
fi

# kubectl completion (w/ refresh cache every 48-hours)
if command -v kubectl > /dev/null; then
	kcomp="$HOME/.kube/.zsh_completion"
	if [ ! -f "$kcomp" ] ||  [ "$(( $(date +"%s") - $(stat -c "%Y" "$kcomp") ))" -gt "172800" ]; then
		mkdir -p "$(dirname "$kcomp")"
		kubectl completion zsh > "$kcomp"
		log "refreshing kubectl zsh completion to $kcomp"
	fi
	source "$kcomp"
fi

# load zsh plugins installed via brew
if [[ -d "$HOMEBREW/share/zsh-syntax-highlighting" ]]; then
	source "$HOMEBREW/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
if [[ -d "$HOMEBREW/share/zsh-autosuggestions" ]]; then
	# source "$HOMEBREW/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

export BAT_PAGER="less -RF"