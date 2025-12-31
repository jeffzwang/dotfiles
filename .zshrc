# ╔══════════════════════════════════════════════════════════════════════════╗
# ║                                ZSH CONFIG                                  ║
# ╚══════════════════════════════════════════════════════════════════════════╝

# ┌──────────────────────────────────────────────────────────────────────────┐
# │                              ENVIRONMENT SETUP                             │
# └──────────────────────────────────────────────────────────────────────────┘

# Oh My Zsh Configuration
export ZSH="/Users/jwang/.oh-my-zsh"
ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Default Editor
export EDITOR="nvim"

# Shell Options
setopt nocorrectall
setopt correct

# Session Limits
ulimit -n 4096
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# Note: CHOKIDAR_USEPOLLING doesn't fix socket watch issue
# Real fix is the claude() function at end of file that removes stale sockets

# ┌──────────────────────────────────────────────────────────────────────────┐
# │                              PATH CONFIGURATION                            │
# └──────────────────────────────────────────────────────────────────────────┘

# NPM packages
NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$NPM_PACKAGES/bin:$PATH"
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
export PATH=~/.npm-global/bin:$PATH

# Local bin directories
export PATH="$HOME/.local/bin:$PATH"

# Development tools
export PATH="$PATH:/Users/jwang/dev_installs/flutter/bin"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm@14/bin:$PATH"
export PATH="/opt/homebrew/opt/rocksdb@6/bin:$PATH"
export PATH="/opt/homebrew/opt/protobuf@3/bin:$PATH"

# Go
export GOPATH=$HOME/go
export GOROOT="/opt/homebrew/opt/go/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ┌──────────────────────────────────────────────────────────────────────────┐
# │                            DEVELOPMENT VARIABLES                           │
# └──────────────────────────────────────────────────────────────────────────┘

# Java
export JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home"

# Flutter
export FLUTTER_ROOT="$HOME/projects/location/frontend"
export CHROME_EXECUTABLE="/Applications/Brave Browser.app/Contents/MacOS/Brave Browser"

# C++ Development
export LDFLAGS="-L/opt/homebrew/opt/llvm@14/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm@14/include"
export ROCKSDB_INCLUDE_DIR="/opt/homebrew/opt/rocksdb/include"
export ROCKSDB_LIBRARY_DIR="/opt/homebrew/opt/rocksdb/lib"
export DYLD_LIBRARY_PATH="/opt/homebrew/opt/mbedtls/lib:$DYLD_LIBRARY_PATH"

# Python
export PYTHONPATH="$HOME/projects/exa"

# Kubernetes
export KUBECONFIG="$HOME/.kube/config"

# SDK Manager
export SDKMAN_DIR="$HOME/.sdkman"

# ┌──────────────────────────────────────────────────────────────────────────┐
# │                            SECRETS (LOCAL FILE)                           │
# └──────────────────────────────────────────────────────────────────────────┘

# Source secrets from local file (not committed to version control)
[ -f ~/.zsh_secrets ] && source ~/.zsh_secrets

# ┌──────────────────────────────────────────────────────────────────────────┐
# │                             NODE VERSION MANAGER                           │
# └──────────────────────────────────────────────────────────────────────────┘

# Lazy load NVM, Node, and NPM
nvm() { 
    unset -f nvm
    export NVM_DIR=~/.nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    nvm "$@"
}

node() {
    unset -f node
    export NVM_DIR=~/.nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    node "$@"
}

npm() {
    unset -f npm
    export NVM_DIR=~/.nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    npm "$@"
}

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ┌──────────────────────────────────────────────────────────────────────────┐
# │                                 ALIASES                                    │
# └──────────────────────────────────────────────────────────────────────────┘

# Editor Aliases
alias vi=nvim
alias v=nvim
alias vf='vi `fzf`'
alias vimrc="nvim ~/.config/nvim/init.lua"
alias zshrc="vi ~/.zshrc; exec zsh"

# Development Aliases
alias dev="npm run dev"
alias mw="make watch"
alias fpb="flutter pub get"
alias ai="python3 ~/projects/scripts/cli.py"

# Navigation Aliases
alias exa="cd ~/projects/exa"

# Git Aliases
alias gs="git status -u"
alias gpom="git pull origin master"
alias gpos="git pull origin staging"
alias gn="git co master; gpom;"
alias lint='git add -A; git ci -m "lint"; git push'
alias typo='git add -A; git ci -m "typo"; git push'
alias fixtest='git add -A; git ci -m "fix test"; git push'
alias wip='git add -A && git commit --no-verify -m wip'
alias unwip='git reset --soft HEAD~'
alias prune="git fetch origin --prune"
alias gitrecent="git for-each-ref --sort=-committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)'"

# System Aliases
alias ls='ls -a'
alias killnode="killall node"
alias kc="kubectl"
alias ecrcreds="aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 472386928882.dkr.ecr.us-west-2.amazonaws.com"
alias startdb="pg_ctl -D /usr/local/var/postgres -l logfile start"
alias stopdb="pg_ctl -D /usr/local/var/postgres stop"
alias hammerload='hs -c "hs.reload()"'
alias ddchars='f() { dd if=$2 bs=1 count=${1:-500} 2>/dev/null; unset -f f; }; f'

# SSH Aliases
alias staker="ssh -i ~/.ssh/staking -p 5124 bean@218.144.188.36"
alias cbash="ssh -i ~/.ssh/cirrascale_rsa cirrascale@38.22.56.10"

# Docker Aliases
alias hasup='docker run -p 8080:8080 \
    hasura/graphql-engine:latest \
    graphql-engine \
    --database-url postgresql://jwang@host.docker.internal:5432/location_app \
    serve \
    --jwt-secret "$HASURA_JWT_SECRET"'

# Project Tools Aliases
alias codeload='python3 ~/projects/gpt-repository-loader/gpt_repository_loader.py'
alias codeload2='python3 ~/projects/gpt-repository-loader/gpt_repository_loader2.py'
alias charcount='sh ~/projects/scripts/charcounter.sh'
# Python via uv - handles -c, -m, and script execution
function python {
    if [[ "$1" == "-c" || "$1" == "-m" || "$1" == "-V" || "$1" == "--version" ]]; then
        uv run python "$@"
    else
        uv run "$@"
    fi
}
function python3 { python "$@"; }

# Pip via uv
alias pip="uv pip"
alias pip3="uv pip"

# Development Environment Alias
alias mdev="startdb; open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app; tmux new-session\; split-window -h -p 15\; split-window -v\; send-keys -t 0 'cd /Users/jwang/projects/location/backend' C-m 'make watch' C-m\; send-keys -t 2 'cd /Users/jwang/projects/location/frontend' C-m 'flutter run' C-m\; send-keys -t 1 'cd /Users/jwang/projects/location/frontend' C-m\;"

# Claude CLI (main function defined at end of file to fix socket bug)
alias cc="claude"
alias ccc="claude --continue"
alias ccr="claude --resume"
alias c="claude"
alias cv='claude --settings '\''{"enabledPlugins": {}}'\'''
alias cj='claude --settings '\''{"enabledPlugins": {"jeffai@local": true}}'\'''

# ┌──────────────────────────────────────────────────────────────────────────┐
# │                            CUSTOM FUNCTIONS                                │
# └──────────────────────────────────────────────────────────────────────────┘

# Enhanced cd - always ls after changing directory
function cd {
    builtin cd "$@" && ls -F
}

# Quick parent directory navigation
function .. {
    builtin cd .. && ls -F
}

function ... {
    builtin cd ../.. && ls -F
}

# Docker logs with JSON formatting
devlog() {
    command docker logs --tail 100 -f $(docker ps --filter=name=$1 -q) | jq
}

# Kill process on specific port
killport() {
    if [ -z "$1" ]; then
        echo 'Please provide a port number'
        return 1
    fi
    lsof -n -iTCP:$1 | grep LISTEN | awk '{print $2}' | xargs kill -9
}

# ┌──────────────────────────────────────────────────────────────────────────┐
# │                           EXTERNAL TOOLS SETUP                             │
# └──────────────────────────────────────────────────────────────────────────┘

# FZF Configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Syntax Highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Autojump
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# Conda (lazy-loaded - only initializes when first called)
conda() {
    unset -f conda
    __conda_setup="$("$HOME/anaconda3/bin/conda" 'shell.zsh' 'hook' 2>/dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ] && . "$HOME/anaconda3/etc/profile.d/conda.sh"
    fi
    unset __conda_setup
    conda "$@"
}

# Bun Completions
[ -s "/Users/jwang/.bun/_bun" ] && source "/Users/jwang/.bun/_bun"

# UV Completions
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

# Workaround for uv bug #8432: add file completion for 'uv run'
_uv_custom() {
    local line state

    _arguments -C \
        "1: :->cmds" \
        "*::arg:->args"

    case "$state" in
        cmds)
            _uv "$@"
            ;;
        args)
            case $line[1] in
                run)
                    _files
                    ;;
                *)
                    _uv "$@"
                    ;;
            esac
            ;;
    esac
}

compdef _uv_custom uv

# ┌──────────────────────────────────────────────────────────────────────────┐
# │                         JINA CLI AUTOCOMPLETE                              │
# └──────────────────────────────────────────────────────────────────────────┘

if [[ -o interactive ]]; then
    compctl -K _jina jina
    _jina() {
        local words completions
        read -cA words
        if [ "${#words}" -eq 2 ]; then
            completions="$(jina commands)"
        else
            completions="$(jina completions ${words[2,-2]})"
        fi
        reply=(${(ps:
:)completions})
    }
fi

# ┌──────────────────────────────────────────────────────────────────────────┐
# │                         END OF CONFIGURATION                               │
# └──────────────────────────────────────────────────────────────────────────┘


# ┌──────────────────────────────────────────────────────────────────────────┐
# │                         AUTO-START CLAUDE CODE                            │
# └──────────────────────────────────────────────────────────────────────────┘

# Auto-launch Claude Code in new interactive terminals
if [[ -o interactive ]] && [[ -z "$CLAUDE_AUTO_STARTED" ]]; then
    export CLAUDE_AUTO_STARTED=1
    claude
fi

# Open .md files in Obsidian via Hammerspoon
open() {
    for arg in "$@"; do
        if [[ "$arg" == *.md && -f "$arg" ]]; then
            command open "hammerspoon://openmd?path=$(realpath "$arg")"
            return
        fi
    done
    command open "$@"
}
export PATH="/Applications/Hammerspoon.app/Contents/Frameworks/hs:$PATH"

# Fix for EOPNOTSUPP error with stale sockets (fs.watch fails on Unix sockets)
# This function removes stale sockets before running claude
claude() {
    local TMPDIR="${TMPDIR:-/tmp}"

    # Remove browser bridge socket if it exists
    local BROWSER_SOCKET="$TMPDIR/claude-mcp-browser-bridge-$USER"
    [ -S "$BROWSER_SOCKET" ] && rm -f "$BROWSER_SOCKET" 2>/dev/null

    # Remove stale zeb_def_ipc sockets (use subshell with nullglob to avoid errors)
    (setopt NULL_GLOB; rm -f /tmp/zeb_def_ipc_* 2>/dev/null)

    # Run the actual claude binary with default flags
    command claude --dangerously-skip-permissions "$@"
}
