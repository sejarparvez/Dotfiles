# Add local bin to PATH (if not already there)
set -gx PATH $HOME/.local/bin $PATH
set -gx PATH /usr/local/node-latest/bin $PATH

# Alias: vim -> nvim
function vim
    nvim $argv
end

# Custom prompt: only an arrow
function fish_prompt
    # Set the color of your arrow (e.g., green, blue, yellow, red, magenta, cyan, normal)
    set_color green
    # Print the arrow character. You can use different arrow characters:
    # ▶ (solid right arrow)
    # ➜ (heavy right arrow)
    # > (simple greater than)
    # → (light right arrow)
    echo -n '➡ '
    # Reset color to default for your input
    set_color normal
end

# Use 'config' command for dotfiles
function config
    git --git-dir=$HOME/.cfg/ --work-tree=$HOME $argv
end
