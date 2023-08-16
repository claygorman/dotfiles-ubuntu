# Define helper functions
function zcompile-many() {
    for f in "$@"; do
        zcompile -R -- "$f".zwc "$f"
    done
}

function asdf_add_plugins_from_url_file() {
   # Loop over each line in the file
    while IFS= read -r line; do
        # Extract plugin name and URL from the line
        plugin_name=$(echo "$line" | awk '{print $1}')
        plugin_url=$(echo "$line" | awk '{print $2}')

        # Run the asdf plugin add command
        asdf plugin add "$plugin_name" "$plugin_url"
    done < ~/.tool-versions-urls
}

function install_zsh_dependency() {
    local repository=$(eval echo $1)
    local destination=$(eval echo $2)
    [ ! -e $destination ] && git clone --depth=1 $repository $destination
}
