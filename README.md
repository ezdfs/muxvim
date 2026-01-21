> [!CAUTION]  
> MuxVim is still in development and may be buggy. There are no stable releases yet.
> 
> With that in mind, feel free to test, modify, or submit a pull request. 👍

# 🤔 What is this project?

This project is a lightweight, opinionated Neovim configuration and helper setup designed to make Neovim comfortable and productive on mobile devices (phones and tablets). It bundles sensible defaults, UI tweaks, and plugins (in Lua) that prioritize 
small screens, touch and virtual-keyboard workflows, and performance-constrained environments so you can edit code and text smoothly on Termux.

- **Purpose**: Provide a ready-to-use Neovim configuration tuned for mobile workflows so you don’t have to rework a desktop config for small screens.
- **Focus**: small-screen layout, simplified mappings, minimal but useful plugins, startup/performance optimizations, and optional integrations for common mobile shells.
- **Contents (typical)**: Lua-based init/config files, plugin list and manager setup, keybindings and touch-friendly mappings, tips for installing on Termux.

# ✨ Features & Plugins

### 🚀 **Core Interface**
| Plugin | Purpose | Key Features |
|--------|---------|--------------|
| **alpha-nvim** | Dashboard/Start Screen | Custom ASCII header art, hides bufferline when active |
| **lualine.nvim** | Status Line | TokyoNight theme, devicon support |
| **bufferline.nvim** | Buffer Tabs | Visual tabs for open buffers, integrates with dashboard |
| **nvim-tree.lua** | File Explorer | Sidebar file tree with devicons |

### 🎯 **Navigation & Search**
| Plugin | Purpose | Key Features |
|--------|---------|--------------|
| **telescope.nvim** | Fuzzy Finder | File/buffer search, live grep, built with fzf-native |
| **which-key.nvim** | Keybinding Guide | Popup hints for available commands (`<leader>?`) |
| **nvim-treesitter** | Syntax Highlighting | Smart parsing, auto-installs language parsers |

### 🔧 **Development Tools**
| Plugin | Purpose | Key Features |
|--------|---------|--------------|
| **LSP Installer** | Language Server Setup | Auto-installs LSPs (lua_ls, pyright, gopls, etc.) |
| **conform.nvim** | Code Formatter | Auto-format on save, multi-language support |
| **LuaSnip** | Snippet Engine | Fast snippet expansion, regex support |
| **Comment.nvim** | Code Commenting | Toggle comments with intuitive keymaps |

### ⚡ **Productivity**
| Plugin | Purpose | Key Features |
|--------|---------|--------------|
| **trouble.nvim** | Diagnostics Panel | Clean list for errors, references, quickfix (`<leader>xx`) |
| **gitsigns.nvim** | Git Integration | Inline change markers, blame, staging preview |

### ⚙️ **Infrastructure**
| Plugin | Purpose | Key Features |
|--------|---------|--------------|
| **lazy.nvim** | Plugin Manager | Fast loading, auto-updates, bootstrap setup |
| **Formatter Installer** | Tool Management | Auto-installs formatters and linters |

# 📦 How to Install

> [!NOTE]
> - Initial launch may take 1-2 minutes as plugins download
> - Treesitter parsers will install automatically in the background
> - LSP servers will prompt for installation when needed

### Prerequisites
- **Termux** installed(can be PlayStore version - 2026)
- Active internet connection
- At least 500MB storage free

### Step 1: Install Dependencies
```bash
# Update packages and install essential tools
pkg update && pkg upgrade -y
pkg install -y neovim mandoc git wget make luarocks tar curl clang termux-api ripgrep cmake fd unzip
```

### Step 2: Install Nerd Font(optional, but highly recommended)

> [!WARNING]
> **Font Setup is Critical**  
> If the Nerd Font isn't properly installed and configured, the Neovim interface will display broken icons, missing emojis, and incorrect text rendering.

```bash
# Download and install Cousine Nerd Font
wget -P ~ https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Cousine.zip
mkdir -p ~/.termux/
mkdir -p ~/fonts
unzip ~/Cousine.zip -d ~/fonts
mv ~/fonts/CousineNerdFont-Regular.ttf ~/.termux/font.ttf

# Apply font settings and clean up
termux-reload-settings
rm -rf ~/Cousine.zip ~/fonts
```

### Step 3: Install MuxVim Configuration
```bash
# Clone the MuxVim repository
git clone https://github.com/ezdfs/muxvim.git ~/.config/nvim

# (Optional) Backup existing Neovim config
if [ -d "$HOME/.config/nvim" ]; then
    mv ~/.config/nvim ~/.config/nvim.backup
    echo "Existing config backed up to ~/.config/nvim.backup"
fi
```

### Step 4: First Launch
```bash
# Start Neovim - plugins will auto-install
nvim
```
