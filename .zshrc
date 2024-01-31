eval "$(starship init zsh)"

# Whalebrew install directory
WHALEBREW_INSTALL_PATH=$HOME/.whalebrew/bin

# Workflow aliases
alias p=pulumi
alias d=docker
alias dicker=docker
alias vim=nvim
alias dotfiles="cd $HOME/.dotfiles/"
alias projects="cd $HOME/projects/"
alias downloads="cd $HOME/Downloads/"
alias nvimcfg="nvim $HOME/.dotfiles/.config/nvim ."
alias psport="sudo lsof -i -P | grep LISTEN | grep "

alias ts='fd --type d --max-depth 3 --absolute-path --base-directory /Users/dag/projects | fzf | dmux'


# GIT
alias lg="lazygit"
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
alias dotsync="zsh $HOME/.dotfiles/dotsystem.sh --sync"

#GPG for github and stuff
export GPG_TTY=$(tty)

# Go shit
export GOPATH="/Users/dag/go"
export PATH=$PATH:$GOPATH/bin
export GOPRIVATE=github.com/scav/pulumi-tf-flux

# add Pulumi to the PATH
export PATH=$PATH:$HOME/.pulumi/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export PATH="/opt/homebrew/opt/node@14/bin:$PATH"
export PATH="/opt/homebrew/opt/node@16/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

