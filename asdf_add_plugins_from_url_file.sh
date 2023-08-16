# Loop over each line in the file
while IFS= read -r line; do
    # Extract plugin name and URL from the line
    plugin_name=$(echo "$line" | awk '{print $1}')
    plugin_url=$(echo "$line" | awk '{print $2}')

    # Run the asdf plugin add command
    asdf plugin add "$plugin_name" "$plugin_url"
done < /home/${USER}/.tool-versions-urls