-- Enable colorscheme as tokyonight
vim.cmd([[colorscheme tokyonight]])

vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimStarted",
    callback = function()
        if vim.fn.argc() == 0 then
            -- Verify if Lazy is open
            local lazy_opened = false
            for _, win in ipairs(vim.api.nvim_list_wins()) do
                if vim.api.nvim_win_get_config(win).relative ~= "" then
                    lazy_opened = true
                    break
                end
            end

            if lazy_opened then
                -- "Restart" neovim
                vim.cmd("silent! bufdo bwipeout!") -- Clear buffers
                vim.cmd("source $MYVIMRC")         -- Reload configuration
                vim.cmd("Alpha")                   -- Open alpha dashboard
            end
        end
    end,
})


-- Open error popup when the cursor stop on line error
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
    end,
})

-- Configures autoformat on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})
