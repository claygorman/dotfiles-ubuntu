#!/usr/bin/zsh

source ~/.zshrc

mkdir -p ~/.local/share/fonts

cp ~/.config/coderv2/dotfiles/.fonts/* ~/.local/share/fonts/

fc-cache -fv

asdf --version
