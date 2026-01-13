local installer = require("core.installer")

local M = {}

M.tools = {
    {
        filetype = "lua",
        lsp_id = "lua_ls",
        name = "Lua-LS",
        install_cmd = "pkg install -y lua-language-server",
        bin = "lua-language-server",
        on_success = function()
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
        on_success = function()
            vim.lsp.enable("pyright")
            vim.cmd("LspStart pyright")
        end,
    },
}

M.setup = function()
    local function monitor_tools()
        local group = vim.api.nvim_create_augroup("LSPManager", { clear = true })
        local supported_fts = {}

        for _, tool in ipairs(M.tools) do
            supported_fts[tool.filetype] = true -- Map supported fts

            if vim.fn.executable(tool.bin) == 1 then
                if tool.lsp_id then
                    vim.lsp.enable(tool.lsp_id)
                end
            else
                vim.api.nvim_create_autocmd("FileType", {
                    group = group,
                    pattern = tool.filetype,
                    callback = function()
                        vim.notify(
                            "💡 LSP " .. tool.name .. " isn't installed. Use <leader>ll to install.",
                            vim.log.levels.WARN,
                            { title = "LSP Manager" }
                        )
                    end,
                    once = true,
                })
            end
        end

        -- Global check for unsupported languages
        vim.api.nvim_create_autocmd("FileType", {
            group = group,
            callback = function(args)
                local ft = vim.bo[args.buf].filetype
                -- Ignore common non-programming fts
                local ignore = {
                    [""] = true,
                    ["help"] = true,
                    ["checkhealth"] = true,
                    ["telescope"] = true,
                    ["NvimTree"] = true,
                    ["notify"] = true,
                    ["lazy"] = true,
                    ["alpha"] = true,
                }

                if not supported_fts[ft] and not ignore[ft] then
                    vim.notify(
                        "🚫 Language '" .. ft .. "' is not yet supported by installer.",
                        vim.log.levels.INFO,
                        { title = "LSP Manager" }
                    )
                end
            end,
            once = true,
        })
    end

    monitor_tools()

    vim.keymap.set("n", "<leader>ll", function()
        installer.open("LSP", M.tools)
    end, { desc = "Install LSPs" })
end

return M
