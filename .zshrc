autoload -Uz compinit
compinit

export XDG_CONFIG_HOME=$HOME/.config

eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

# calibre/books
alias books="cd $HOME/Library/Mobile\ Documents/com~apple~CloudDocs/calibre"

# Whalebrew install directory
WHALEBREW_INSTALL_PATH=$HOME/.whalebrew/bin

# k9s
export K9S_CONFIG_DIR="$HOME/.config/k9s"

# Workflow aliases
alias p=pulumi
alias d=docker
alias dicker=docker
alias vim=nvim
alias dotfiles="cd $HOME/.dotfiles/"
alias projects="cd $HOME/projects/"
alias downloads="cd $HOME/Downloads/"
alias nvimcfg="nvim $HOME/.dotfiles/.config/nvim ."

# Open a file wherever
alias vimo='vim $(fzf)'

# GIT
alias lg="lazygit"
alias gsc="git switch -c"
alias gss="git switch"
alias gs="git status"
alias gb="git branch"
alias gcb="git checkout -b"
alias gc="git checkout"
alias gpull="git pull --rebase origin"
alias gpush="git push origin"
alias gcommit="git commit --all -m"
alias gl="git log --oneline --decorate --color"

alias dotlink="zsh $HOME/.dotfiles/dotsystem.sh --link"
alias dotbrew="zsh $HOME/.dotfiles/dotsystem.sh --brew"
alias dotupdate="zsh $HOME/.dotfiles/dotsystem.sh --update"
alias dotsync="zsh $HOME/.dotfiles/dotsystem.sh --sync"

# psql 
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

#GPG for github and stuff
export GPG_TTY=$(tty)

# Whalebrew
export PATH=$PATH:/opt/whalebrew/bin

# Go shit
export GOPATH="$HOME/go"
export PATH=$PATH:$GOPATH/bin

# add Pulumi to the PATH
export PATH=$PATH:$HOME/.pulumi/bin

# Import other functions
[ -f ~/.config/zsh/functions.zsh ] && source ~/.config/zsh/functions.zsh
[ -f ~/.config/zsh/zoxide.zsh ] && source ~/.config/zsh/zoxide.zsh
[ -f ~/.config/zsh/fzf.zsh ] && source ~/.config/zsh/fzf.zsh
[ -f ~/.config/cyphernetes.zsh ] && source ~/.config/cyphernetes.zsh

export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export PATH="/opt/homebrew/opt/node@14/bin:$PATH"
export PATH="/opt/homebrew/opt/node@16/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

