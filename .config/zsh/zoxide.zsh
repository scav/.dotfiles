[ -f ~/.config/zsh/zoxide.generated.zsh ] && source ~/.config/zsh/zoxide.generated.zsh

alias cd="z"

function cf() {
    local dir = $(fd | fzf --height=90% --reverse --border --preview 'cat {}') &&
    zoxide "$dir"
}
