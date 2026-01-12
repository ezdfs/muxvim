-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
require("config.leader")
require("config.options")
require("config.ui")
require("config.lazy")
require("config.lsp-installer").setup()
require("config.formatter-installer").setup()
require("config.lsp").setup()
require("config.setup")
require("config.cmd")
require("config.keymaps")
