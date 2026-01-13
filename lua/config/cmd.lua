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

-- Configures treesitter
vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        local bufnr = args.buf
        local ft = vim.bo[bufnr].filetype

        -- Verify if exists a installed parser to this  filetype
        local lang = vim.treesitter.language.get_lang(ft) or ft
        local has_parser = pcall(vim.treesitter.get_parser, bufnr, lang)

        if has_parser then
            -- Enable highlighting
            vim.treesitter.start(bufnr, lang)

            -- Configures local buffer to this file
            vim.opt_local.foldmethod = "expr"
            vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.opt_local.foldlevel = 99
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
