> [!CAUTION]  
> MuxVim is still in development and may be buggy. There are no stable releases yet.
> 
> With that in mind, feel free to test, modify, or submit a pull request. 👍

# What is this project?

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
