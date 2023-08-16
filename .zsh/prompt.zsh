# Install required packages
[[ $(command -v gpg) == "" ]] && brew install gnupg
install_zsh_dependency "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$HOME/zsh-syntax-highlighting"
install_zsh_dependency "https://github.com/zsh-users/zsh-autosuggestions.git" "$HOME/zsh-autosuggestions"
install_zsh_dependency "https://github.com/marlonrichert/zsh-autocomplete.git" "$HOME/zsh-autocomplete"
install_zsh_dependency "https://github.com/romkatv/powerlevel10k.git" "$HOME/powerlevel10k"
install_zsh_dependency "https://github.com/romkatv/zsh-defer.git" "$HOME/zsh-defer"

# Install Foundry
if [[ ! -e ~/.foundry ]]; then
    echo "Installing foundry..."
    curl -L https://foundry.paradigm.xyz | bash
    foundryup
fi

# Install Krew for Kubernetes
if [[ ! -e ~/krew ]]; then
    set -x
    mkdir ~/krew && cd ~/krew
    OS="$(uname | tr '[:upper:]' '[:lower:]')"
    ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')"
    KREW="krew-${OS}_${ARCH}"
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz"
    tar zxvf "${KREW}.tar.gz"
    ./"${KREW}" install krew
fi