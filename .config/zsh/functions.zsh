# kubectl change context
function kc {
    local context
    if context=$(kubectl config get-contexts --output='name' | fzf --tmux --border --padding 1,2 --border-label 'Kubernetes context'); then
        kubectl config use-context $context
    fi
}

# switch aws profile
function ap {
    local profile
   if profile=$(aws configure list-profiles | fzf --tmux --border --padding 1,2 --border-label 'AWS Profile'); then
        if [[ -n "$profile" ]]; then
            export AWS_PROFILE="$profile"
            export AWS_DEFAULT_PROFILE="$profile"
        fi
    fi
}

# Print process on port
fn psport() {
  if [ -z "$1" ]; then
        echo "Error: No port supplied"
        return 1
    fi

    lsof -nP -iTCP:$1 -sTCP:LISTEN
}

# Kill process on port
fn killport() {
    if [ -z "$1" ]; then
        echo "Error: No port supplied"
        return 1
    fi

    pid=$(lsof -ti :$1)

    if [ -z "$pid" ]; then
        echo "No process found on port $1"
        return 1
    fi

    echo "Killing process $pid on port $1"
    kill -9 $pid
}

# Git operations

# Switch git branch 
function gs {
    local branch
    if branch=$(git branch | sed 's/.* //' | fzf --tmux --border --padding 1,2 --border-label 'Git branch'); then
        git switch "$branch"
    fi
}

