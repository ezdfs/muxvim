local M = {}

-- Lua options
M.lua = {
        linter = "luasnip",
        formatter = "stylua",
        lsp = "lua-language-server",
        filetype = "lua",
        cmd_setup = {
            "pkg install lua-language-server"
        }
}

return M
