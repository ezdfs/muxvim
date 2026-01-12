local installer = require("core.installer")

local M = {}

M.tools = {
	{
		name = "Lua-LS",
		install_cmd = "pkg install -y lua-language-server",
		bin = "lua-language-server",
		on_success = function()
			vim.lsp.enable("lua_ls")
			vim.cmd("LspStart lua_ls")
		end,
	},
	{
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
	vim.keymap.set("n", "<leader>ll", function()
		installer.open("LSP", M.tools)
	end, { desc = "Install LSPs" })
end

return M
