-- Creates autocommand group for ui autocomamands
local group = vim.api.nvim_create_augroup("Ui", { clear = true })

vim.diagnostic.config({
    -- Diagnostic ui popup to show errors,
    -- warnings and  others.
    float = {
        border = "rounded", -- Rounded border
        source = true,      -- Show where from error(ex: pyright, lua_ls)
    },
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "󰌵",
            [vim.diagnostic.severity.INFO] = "󰋼",
        },
    },
})

-- Open error popup when the cursor stop on line error
vim.api.nvim_create_autocmd("CursorHold", {
    group = group,
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
    end,
})
