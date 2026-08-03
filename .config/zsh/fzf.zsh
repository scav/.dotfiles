# Setup fzf
source <(fzf --zsh)

export FZF_COMPLETION_OPTS='--border --info=inline'

_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
}

alias sd="cd ~ && cd \$(find * -type d | fzf)"

