local installer = require("core.installer")
local tools_monitor = require("core.tools-monitor")

local M = {}

M.tools = {
    {
        filetype = "lua",
        lsp_id = "lua_ls",
        name = "Lua-LS",
        install_cmd = "pkg install -y lua-language-server",
        bin = "lua-language-server",
        onExecutable = function()
            vim.lsp.enable("lua_ls")
            vim.cmd("LspStart lua_ls")
        end,
    },
    {
        filetype = "python",
        lsp_id = "pyright",
        name = "Pyright",
        install_cmd = "pkg install -y nodejs && npm install -g pyright",
        bin = "pyright",
        onExecutable = function()
            vim.lsp.enable("pyright")
            vim.cmd("LspStart pyright")
        end,
    },
    {
        filetype = "go",
        lsp_id = "gopls",
        name = "Golang (Gopls)",
        install_cmd = "pkg install -y golang gopls",
        bin = "gopls",
        onExecutable = function()
            vim.lsp.enable("gopls")
            vim.cmd("LspStart gopls")
        end,
    },
    {
        filetype = { "javascript", "typescript" },
        lsp_id = "vtsls",
        name = "JS/TS Server",
        install_cmd = "pkg install -y nodejs && npm install -g @vtsls/language-server",
        bin = "vtsls",
        onExecutable = function()
            vim.lsp.enable("vtsls")
            vim.cmd("LspStart vtsls")
        end
    },
}

M.setup = function()
    tools_monitor.setup({ tools = M.tools })
    tools_monitor.monitor()
    vim.keymap.set("n", "<leader>ll", function()
        installer.open("LSP", M.tools)
    end, { desc = "Install LSPs" })
end

return M
