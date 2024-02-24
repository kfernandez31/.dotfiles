# Skip oh-my-zsh aliases.
# zstyle ':omz:lib:*' aliases no

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 7

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    zsh-history-substring-search
    zsh-syntax-highlighting
    zsh-autosuggestions
    you-should-use
    auto-notify
)

. $ZSH/oh-my-zsh.sh

# User configuration

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

swap() {
    if [ "$#" -lt 2 ]; then
        echo "Usage: swap [file1] [file2]"
        return 1
    fi

    if [ "$1" = "$2" ]; then
        echo "Error: Input files are the same."
        return 1
    fi

    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE && mv "$2" "$1" && mv $TMPFILE "$2"
}

take() {
    if [ "$#" -lt 1 ]; then
        echo "Usage: take [file]"
        return 1
    fi

    local DIR=$1
    mkdir -p $DIR && cd $DIR
}

note() { 
    local LOGFILE=~/notes.txt
    [ -f $LOGFILE ] || touch $LOGFILE 
    echo "date: $(date)" >> $LOGFILE
    echo "$@"            >> $LOGFILE
    echo ""              >> $LOGFILE
}


new_key() {
    if [ "$#" -lt 3 ]; then
        echo "Usage: new_key <host> <hostname> <keyname> [mail]"
        return 1
    fi

    local HOST=$1
    local HOSTNAME=$2
    local KEYNAME=$3

    local MAIL
    if [ -n "$4" ]; then
        MAIL="$4"
    else
        MAIL=""
    fi

    local SSH_DIR=~/.ssh
    local IDENTITY_FILE="${SSH_DIR}/${KEYNAME}"
    local CONFIG_FILE="${SSH_DIR}/config"
    local KNOWN_HOSTS_FILE="${SSH_DIR}/known_hosts"

    ssh-keygen -t ed25519 -f $IDENTITY_FILE -q -N "" -C "$MAIL"
    chmod 600 $IDENTITY_FILE
    eval "$(ssh-agent -s)" > /dev/null
    ssh-add $IDENTITY_FILE
    ssh-keyscan -H $HOSTNAME >> $KNOWN_HOSTS_FILE

    echo "Host ${HOST}"                   >> $CONFIG_FILE
    echo "\tHostName $HOSTNAME"           >> $CONFIG_FILE
    echo "\tIdentityFile $IDENTITY_FILE"  >> $CONFIG_FILE
    echo "\tAddKeysToAgent yes"           >> $CONFIG_FILE
    echo ""                               >> $CONFIG_FILE
}

ssh-tmux() {
  ssh -t "$@" -- /bin/sh -c 'tmux has && tmux a || tmux'
}

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(thefuck --alias)"

# aliases
## competitive programming
alias g++_=/opt/homebrew/Cellar/gcc/13.2.0/bin/c++-13
alias gcc_=/opt/homebrew/Cellar/gcc/13.2.0/bin/gcc-13
## essentials
alias s='source ~/.zprofile && source ~/.zshenv && source ~/.zshrc'
alias cd=z
alias cat=bat
alias diff=delta
alias du='dust -r'
alias ls='exa -h --group-directories-first --git --time-style=long-iso --no-user --color-scale'
alias la='ls -a'
alias ll='ls -l'
alias lf='ls --icons -F'
alias lt='lf -T --level=2'
alias lla='ll -a'
alias lfa='lf -a'
alias lta='lt -a'
alias rm='rm -i'
alias cp='cp -r'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias md=mkdir
alias rd=rmdir
alias tl=tail
alias hd=head
alias cl='clear -x'
# alias less='less --mouse -F'
alias less='bat --paging=always'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='../..'
alias ....='../../..'
alias .....='../../../..'
alias ......='../../../../..'
## git
alias g=git
alias gd='git diff'
alias gl='git log --oneline --graph --all --decorate'
alias gs='git status'
alias gc='git commit'
alias ga='git add'
alias gp='git push'
## vim
alias vi=nvim
alias vim=nvim
## misc
alias python=python3
alias py=python3
alias lua='rlwrap lua'
alias ocaml='rlwrap ocaml'
alias ff=fastfetch
alias pb=pbcopy
alias wttr='curl wttr.in'
alias code='codium'

cdl() {
    local DIR=$1
    cd $DIR && ls
}

# bindings
bindkey -r "^H"    
bindkey '^[[A'    history-substring-search-up
bindkey '^[[B'    history-substring-search-down
bindkey "^[[1;3C" forward-word
bindkey '^[F'     forward-word
bindkey '^[f'     forward-word
bindkey "^[[1;3D" backward-word
bindkey '^[B'     backward-word      
bindkey '^[b'     backward-word    

# prelude
autoload compinit && compinit

# session_name="main"
#
# tmux has-session -t=$session_name 2> /dev/null
#
# if [[ $? -ne 0 ]]; then
#     TMUX='' tmux new-session -d -s "$session_name"
# fi
#
# if [[ -z "$TMUX" ]]; then
#     tmux attach -t "$session_name"
# else
#     tmux switch-client -t "$session_name"
# fi

# fastfetch
