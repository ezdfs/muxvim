return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function(_, opts)
        -- Initialize treesitter with provided options
        require("nvim-treesitter").setup(opts)

        -- Configures treesitter
        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true }),
            callback = function(args)
                local bufnr = args.buf
                local ft = vim.bo[bufnr].filetype

                -- Ignore UI and system buffers
                local ignore = {
                    [""] = true,
                    ["NvimTree"] = true,
                    ["telescope"] = true,
                    ["notify"] = true,
                    ["lazy"] = true,
                    ["cmp_menu"] = true,
                }
                if ignore[ft] then return end

                -- Verify if exists a installed parser to this filetype
                local lang = vim.treesitter.language.get_lang(ft) or ft
                local has_parser, _ = pcall(vim.treesitter.get_parser, bufnr, lang)

                if has_parser then
                    -- Enable highlighting
                    vim.treesitter.start(bufnr, lang)

                    -- Configures local buffer to this file
                    vim.opt_local.foldmethod = "expr"
                    vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                    vim.opt_local.foldlevel = 99
                else
                    -- If parser is missing, try to install it automatically via nvim-treesitter
                    -- This requires 'clang' and 'tar' installed in Termux
                    vim.notify("📥 Installing Treesitter parser for: " .. ft, vim.log.levels.INFO,
                        { title = "Treesitter" })
                    pcall(function()
                        vim.cmd("TSInstall " .. lang)
                    end)
                end
            end,
        })
    end,
    opts = {
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        -- Ensure core parsers are always installed
        ensure_installed = {
            "lua",
            "vim",
            "vimdoc",
            "query",
        },
    },
}
