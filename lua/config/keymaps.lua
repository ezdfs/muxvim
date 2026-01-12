-- Set up vim keymaps
local keymap = vim.keymap

-- NvimTree keymaps
-- Open/close nvim-tree
keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { silent = true })

-- Focus on file tree if it is open
keymap.set('n', '<leader>f', ':NvimTreeFocus<CR>', { silent = true })

-- Telescope keymaps
local builtin = require('telescope.builtin')

-- Find files
keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })

-- Find an occurence between files
keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })

-- Find buffers
keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })

-- Help tags
keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Text navigation custom
keymap.set({'n', 'x', 'o'}, '9', '$', { desc = 'Go to line end' })

-- File manipulation
-- Save file
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })

-- Save all files
vim.keymap.set("n", "<leader>wa", "<cmd>wa<cr>", { desc = "Save all files" })

-- Close file
vim.keymap.set("n", "<leader>q", "<cmd>bd<cr>", { desc = "Close file" })

-- Close all files
vim.keymap.set("n", "<leader>qa", "<cmd>%bd|e#|bd#<cr>", { desc = "Close all files" })

-- Treesitter keymaps
-- Toggle fold with Spacebar
vim.keymap.set('n', '<space>', 'za', { desc = 'Toggle code fold' })
