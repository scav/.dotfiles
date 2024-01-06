eval "$(starship init zsh)"

# Whalebrew install directory
WHALEBREW_INSTALL_PATH=$HOME/.whalebrew/bin

# ALIASES
alias p=pulumi
alias d=docker
alias dicker=docker
alias vim=nvim
alias dotfiles="cd $HOME/.dotfiles/"
alias projects="cd $HOME/Projects/"
alias downloads="cd $HOME/Downloads/"

# GIT
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

#GPG for github and stuff
export GPG_TTY=$(tty)

# Go shit
export GOPATH="/Users/dag/go"
export PATH=$PATH:$GOPATH/bin
export GOPRIVATE=github.com/scav/pulumi-tf-flux

# add Pulumi to the PATH
export PATH=$PATH:$HOME/.pulumi/bin

# Sets up fzf awesome-ness for back search
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export PATH="/opt/homebrew/opt/node@14/bin:$PATH"
export PATH="/opt/homebrew/opt/node@16/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

