# Files with _ in front of the filename are autoloaded by fpath.
# This means dont put a file in this directory with a _ prefix if you have to manually source it to work

[ ! -e ~/.completions ] && mkdir -p ~/.completions
[[ ! -f ~/.completions/kubectl.zsh && $(command -v kubectl) != "" ]] && kubectl completion zsh > ~/.completions/kubectl.zsh
[[ ! -f ~/.completions/helm.zsh && $(command -v helm) != "" ]] && helm completion zsh > ~/.completions/helm.zsh
[ ! -f ~/.completions/_kubectx.zsh ] && curl -s "https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/_kubectx.zsh" -o ~/.completions/_kubectx.zsh
[ ! -f ~/.completions/_kubens.zsh ] && curl -s "https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/_kubens.zsh" -o ~/.completions/_kubens.zsh
[[ ! -f ~/.completions/chezmoi.zsh && $(command -v chezmoi) != "" ]] && chezmoi completion zsh --output=~/.completions/chezmoi.zsh
[[ ! -f ~/.completions/ngrok.zsh && $(command -v ngrok) != "" ]] && ngrok completion > ~/.completions/ngrok.zsh
[[ ! -f ~/.completions/op.zsh && $(command -v op) != "" ]] && op completion zsh > ~/.completions/op.zsh && echo "compdef _op op" >> ~/.completions/op.zsh
if [[ $(command -v rg) != "" ]]; then
  rgVersion=$(rg --version | awk 'NR==1{print $2}')
  rgCompletionDestinationPath="$HOME/.completions/_rg_$rgVersion.zsh"
  rgCompletionSourcePath="$HOME/.asdf/installs/ripgrep/$rgVersion/complete/_rg"
  if [ ! -f $rgCompletionDestinationPath ]; then
    cp "$rgCompletionSourcePath" "$rgCompletionDestinationPath"
  fi
fi

zsh-defer source ~/zsh-autocomplete/zsh-autocomplete.plugin.zsh
[ -f ~/.fzf.zsh ] && zsh-defer source ~/.fzf.zsh

source ~/.completions/kubectl.zsh
source ~/.completions/helm.zsh
source ~/.completions/chezmoi.zsh
[ -f ~/.completions/ngrok.zsh ] && source ~/.completions/ngrok.zsh
[ -f ~/.completions/op.zsh ] && source ~/.completions/op.zsh

fpath=(${HOME}/.completions $fpath)
