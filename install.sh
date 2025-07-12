#!/bin/bash

# This script sets up dotfiles using the bare Git repository method.
# It's designed to be run on a new machine to quickly configure your environment.

# --- Configuration ---
# IMPORTANT: This has been updated with your GitHub repository URL!
DOTFILES_REPO="https://github.com/sejarparvez/Dotfiles.git"
BARE_REPO_DIR="$HOME/.cfg" # Hidden directory where the bare Git repo will live locally

# --- Functions ---

# Sets up the bare Git repository for dotfiles
setup_bare_repo() {
    echo "--- Setting up bare Git repository for dotfiles ---"

    if [ -d "$BARE_REPO_DIR" ]; then
        echo "Dotfiles repository already exists at $BARE_REPO_DIR. Pulling latest changes..."
        # Navigate into the bare repo and pull
        /usr/bin/git --git-dir="$BARE_REPO_DIR" --work-tree="$HOME" pull origin main || \
        /usr/bin/git --git-dir="$BARE_REPO_DIR" --work-tree="$HOME" pull origin master
        if [ $? -ne 0 ]; then
            echo "Warning: Failed to pull latest changes. You may need to resolve conflicts manually."
        fi
    else
        echo "Cloning dotfiles repository from $DOTFILES_REPO to $BARE_REPO_DIR..."
        git clone --bare "$DOTFILES_REPO" "$BARE_REPO_DIR"
        if [ $? -ne 0 ]; then
            echo "Error: Failed to clone the bare repository. Check the repository URL and your network connection."
            exit 1
        fi
    fi

    # Define the 'config' alias for the current shell session
    # This ensures 'config' works immediately after cloning/pulling
    alias config="/usr/bin/git --git-dir=$BARE_REPO_DIR/ --work-tree=$HOME"

    # Configure 'config' to hide untracked files in the home directory
    config config --local status.showUntrackedFiles no

    echo "Bare repository setup complete."
    echo "You can now use 'config <git_command>' to manage your dotfiles in this session."
}

# Checks out dotfiles into the home directory
checkout_dotfiles() {
    echo "--- Checking out dotfiles into your home directory ---"
    # Perform a checkout, forcing overwrite of existing files.
    # BE CAREFUL: This will overwrite files in your HOME directory!
    config checkout --force

    if [ $? -eq 0 ]; then
        echo "Dotfiles checked out successfully."
    else
        echo "WARNING: Some dotfiles could not be checked out. This usually happens if files already exist and are not tracked by Git, or if there are conflicts."
        echo "Please review 'config status' and resolve conflicts manually if needed."
    fi
}

# Sets up the 'config' alias permanently in Fish shell's config.fish
setup_fish_alias() {
    echo "--- Setting up 'config' alias for Fish shell ---"
    FISH_CONFIG_DIR="$HOME/.config/fish"
    FISH_CONFIG_FILE="$FISH_CONFIG_DIR/config.fish"
    FISH_FUNCTIONS_DIR="$FISH_CONFIG_DIR/functions"
    FISH_CONFIG_FUNCTION_FILE="$FISH_FUNCTIONS_DIR/config.fish"

    mkdir -p "$FISH_FUNCTIONS_DIR" # Ensure functions directory exists

    # Check if the alias function already exists in config.fish
    if ! grep -q "function config" "$FISH_CONFIG_FILE" 2>/dev/null; then
        echo '
# Dotfiles management alias (managed by install.sh)
function config
    git --git-dir=$HOME/.cfg/ --work-tree=$HOME $argv
end
# This function is saved to ~/.config/fish/functions/config.fish
# The `funcsave config` command should NOT be in config.fish itself
# It is run once by the install script if the alias is new.
' >> "$FISH_CONFIG_FILE"
        echo "Added 'config' function definition to $FISH_CONFIG_FILE."
    else
        echo "'config' function definition already found in $FISH_CONFIG_FILE. Skipping addition."
    fi

    # Ensure the function is saved persistently
    # This command creates/updates ~/.config/fish/functions/config.fish
    /usr/bin/fish -c "funcsave config" # Run in a fresh fish instance to avoid issues

    echo "'config' alias should now be persistent. Open a new Fish shell or run 'source ~/.config/fish/config.fish'."
}

# --- Main Execution ---

echo "Starting dotfiles setup..."

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Error: Git is not installed. Please install Git (e.g., 'sudo apt install git') and try again."
    exit 1
fi

# Check if curl is installed (often needed for Fisher or other installs)
if ! command -v curl &> /dev/null; then
    echo "Warning: 'curl' is not installed. Some parts of the setup (like Fisher installation) might fail."
fi

# 1. Setup the bare Git repository
setup_bare_repo

# 2. Checkout dotfiles
checkout_dotfiles

# 3. Setup Fish alias permanently
setup_fish_alias

echo "--- Dotfiles setup script finished ---"
echo "Next Steps:"
echo "1. Install your preferred applications (e.g., fish, kitty, neovim, nodejs, npm)."
echo "2. Install Fish plugins/themes (e.g., 'fisher install vitallium/tokyonight-fish')."
echo "3. Remember to open a new terminal or run 'source ~/.config/fish/config.fish' to apply all changes."
echo "4. Manage your dotfiles using the 'config' command (e.g., 'config status', 'config push')."