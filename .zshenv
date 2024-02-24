. ~/.cargo/env
. ~/.ghcup/env
. ~/.fzf.zsh
export JAVA_HOME=$(/usr/libexec/java_home)
export EDITOR=nvim
export VISUAL=nvim
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#625e85"
export ZSH_AUTOSUGGEST_STRATEGY=(completion history)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export YSU_MESSAGE_POSITION="after"
export ZSH=~/.oh-my-zsh 
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
export AUTO_NOTIFY_IGNORE=($AUTO_NOTIFY_IGNORE
    'crontab'
    'vi'
    'vim'
    'nvim'
    'less'
    'more'
    'man'
    'tig'
    'watch'
    'git commit'
    'git diff'
    'top'
    'htop'
    'btop'
    'ssh'
    'nano'
    'cat'
    'bat'
    'tmux'
    'rlwrap'
    'diff'
)

export PAGER='less -F --mouse'
export MANPAGER='nvim +Man!'
export DELTA_PAGER=$PAGER
