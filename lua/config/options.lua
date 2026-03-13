-- Defines opt variable
local opt = vim.opt

-- Enable to bufferline work
opt.termguicolors = true

-- Identation options
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.clipboard = "unnamedplus"

-- Visual options
-- Disable visual text break on code view
opt.wrap = false
-- Neovim time to start reactioon
opt.updatetime = 500
-- Show numbers lines
opt.number = true
-- Set insert cursor style as default
opt.guicursor = "n-v-c-i:ver25"
