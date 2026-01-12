vim.diagnostic.config({
    float = {
        border = "rounded", -- Rounded border
        source = "always",  -- Show where from error(ex: pyright, lua_ls)
    },
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚",
            [vim.diagnostic.severity.WARN]  = "",
            [vim.diagnostic.severity.HINT]  = "󰌵",
            [vim.diagnostic.severity.INFO]  = "󰋼",
        },
    },
})
