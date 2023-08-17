#!/usr/bin/zsh

mkdir -p ~/.completions
mkdir -p ~/.local/share/fonts
mkdir -p ~/development

cp -R ~/.config/coderv2/dotfiles/* ~/
find ~/.config/coderv2/dotfiles/ -not -path '.' -not -path './.git' -iname '.*' -exec cp -r {} ~/ \;
cp ~/.config/coderv2/dotfiles/.fonts/* ~/.local/share/fonts/

source ~/.zshrc

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Meslo.zip
unzip Meslo.zip -d .local/share/fonts
cd .local/share/fonts
rm *Windows*
cd ~
rm Meslo.zip
fc-cache -fv

exec $SHELL

git config --global user.email $GIT_AUTHOR_EMAIL

asdf --version

# Install our ASDF extensions
while IFS= read -r line; do
    plugin_name=$(echo "$line" | awk '{print $1}')
    plugin_url=$(echo "$line" | awk '{print $2}')

    asdf plugin add "$plugin_name" "$plugin_url"
done < /home/${USER}/.tool-versions-urls

asdf install
