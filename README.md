# My Dotfiles

> A collection of my personal configuration files (dotfiles) for a cohesive and productive Linux development environment. Features Fish shell, Kitty terminal, Neovim (LazyVim), and a unified Tokyo Night theme.

---

## 🚀 Features

- **Shell:** [Fish Shell](https://fishshell.com/) for a friendly and interactive command-line experience.
  - Custom minimalist prompt (single arrow).
  - `config` alias for easy dotfile management (bare Git repo method).
  - PATH extensions for `~/.local/bin` and Node.js.
- **Terminal:** [Kitty](https://sw.kovidgoyal.net/kitty/) - a fast, feature-rich, GPU-accelerated terminal emulator.
  - Configured with transparency, blur, and custom padding.
  - Integrated Tokyo Night color scheme.
- **Editor:** [Neovim](https://neovim.io/) with [LazyVim](https://www.lazyvim.org/) for a powerful and efficient coding experience.
  - Utilizes the Tokyo Night color theme.
- **Theme:** Consistent [Tokyo Night](https://github.com/folke/tokyonight.nvim) aesthetic across terminal and editor.
- **Managed with:** [Bare Git Repository method](https://www.atlassian.com/git/tutorials/dotfiles) for seamless synchronization across machines.

---

## 📋 Prerequisites

Before setting up these dotfiles, ensure you have the following installed on your Linux Mint (or similar Debian-based) system:

- `git`
- `curl` (for `install.sh` and Fisher)
- `fish` (Fish Shell)
- `kitty` (Kitty Terminal)
- `nvim` (Neovim)
- `node` and `npm` (for Neovim plugins if LazyVim requires them)

You can typically install most with:

```bash
sudo apt update
sudo apt install git curl fish kitty neovim nodejs npm
```

---

### **Part 4: Installation Section**

---

---

## 🛠️ Installation

Follow these steps to quickly set up your dotfiles on a new system:

1.  **Install Git and Curl:**

    ```bash
    sudo apt update
    sudo apt install git curl
    ```

2.  **Clone the Installer Script:**

    ```bash
    git clone [https://github.com/sejarparvez/Dotfiles.git](https://github.com/sejarparvez/Dotfiles.git) ~/temp_dotfiles_installer
    ```

3.  **Run the Installation Script:**
    This script will set up the bare Git repository (`~/.cfg`), check out your dotfiles, and configure the `config` alias for Fish Shell.

    ```bash
    bash ~/temp_dotfiles_installer/install.sh
    ```

    - **Warning:** This script will **overwrite** existing configuration files in your home directory (`~`). Proceed with caution.

4.  **Clean Up:**

    ```bash
    rm -rf ~/temp_dotfiles_installer
    ```

5.  **Restart Your Terminal:**
    Close your current terminal and open a new one to ensure all Fish configurations are loaded, or simply run:

    ```bash
    source ~/.config/fish/config.fish
    ```

6.  **Install Fish Plugins/Themes (Optional, but recommended):**
    If your `config.fish` doesn't automatically handle these, you might need to run:

    ```bash
    # Install Fisher (if not already handled by install.sh)
    # curl -sL [https://git.io/fisher](https://git.io/fisher) | fish

    # Install Tokyo Night Fish theme
    fisher install vitallium/tokyonight-fish
    fish_config theme choose "TokyoNight Night" # Or "TokyoNight Storm", etc.
    ```

    _(Adjust based on your specific Fish theme/plugin choices)_

---

## 👨‍💻 Usage

Once installed, you can manage your dotfiles using the `config` alias:

- `config status`: Check the status of your dotfiles.
- `config add <file>`: Add a new dotfile to track.
- `config commit -m "Message"`: Commit changes to your dotfiles.
- `config push`: Push committed changes to your GitHub repository.
- `config pull`: Pull the latest changes from your GitHub repository.

---

## 📂 Structure _(Optional, but helpful)_

```
.
├── .cfg/                     # Bare Git repository for dotfiles (hidden)
├── .config/
│   ├── fish/                 # Fish shell configurations
│   │   ├── config.fish       # Main Fish config
│   │   ├── functions/        # Auto-saved Fish functions (e.g., 'config')
│   │   └── conf.d/           # Modular Fish snippets
│   ├── kitty/                # Kitty terminal configurations
│   │   ├── kitty.conf        # Main Kitty config
│   │   └── themes/
│   │       └── tokyo-night-kitty.conf # Tokyo Night color scheme
│   └── nvim/                 # Neovim configuration (LazyVim structure)
│       └── ...
└── install.sh                # Script to deploy dotfiles on new systems
```

(Note: .gitconfig, .tmux.conf etc. would be directly in ~ and managed by 'config')

---

## 🙏 Credits

- Inspired by various dotfile repositories and articles.
- [Tokyo Night Theme](https://github.com/folke/tokyonight.nvim) for Neovim and its derivatives for Kitty and Fish.
- [Kitty Terminal](https://sw.kovidgoyal.net/kitty/)
- [Fish Shell](https://fishshell.com/)
- [Neovim](https://neovim.io/) & [LazyVim](https://www.lazyvim.org/)

---

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
