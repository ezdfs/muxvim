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
