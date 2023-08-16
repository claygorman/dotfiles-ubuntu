export ASDF_DIR="$HOME/.asdf"

# Modify the PATH
export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Initialize tmux if not in specific conditions
if [[ -z ${TMUX+X}${ZSH_SCRIPT+X}${ZSH_EXECUTION_STRING+X} ]]; then
    if [[ "$TERMINAL_EMULATOR" != "JetBrains-JediTerm" ]]; then
        exec tmux
    fi
fi

# Order matters here...
source ~/.zsh/functions.zsh
source ~/.zsh/prompt.zsh

# Initialize p10k prompt for zsh shell
[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ] && source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

[ ! -e ~/.asdf ] && git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.12.0

# Init ASDF for managing deps
source "$HOME/.asdf/asdf.sh"

# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)

autoload -Uz compinit
[ ! "$(find ~/.zcompdump -mtime 1)" ] || compinit
compinit -C

[[ ~/.zcompdump.zwc -nt ~/.zcompdump ]] || zcompile-many ~/.zcompdump
unfunction zcompile-many
unfunction install_zsh_dependency

ZSH_AUTOSUGGEST_MANUAL_REBIND=1

source ~/zsh-defer/zsh-defer.plugin.zsh
source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/powerlevel10k/powerlevel10k.zsh-theme

source ~/.p10k.zsh

source ~/.zsh/completions.zsh
source ~/.zsh/aliases.zsh

# This has to be here because `complete` command isnt found in other places then this file...
[ $(command -v aws_completer) != "" ] && zsh-defer complete -C "$HOME/.asdf/shims/aws_completer" aws

