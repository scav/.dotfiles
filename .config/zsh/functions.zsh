# kubectl change context
function kc {
    local context=$(kubectl config get-contexts --output='name' | fzf)
    kubectl config use-context $context
}

# Print process on port

fn psport() {
  if [ -z "$1" ]; then
        echo "Error: No port supplied"
        return 1
    fi

    lsof -nP -iTCP:$1 -sTCP:LISTEN
}
#
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
