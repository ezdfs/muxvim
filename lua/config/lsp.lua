-- Lua LSP
vim.lsp.config("lua_ls", {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath("config")
				and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using (most
				-- likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Tell the language server how to find Lua modules same way as Neovim
				-- (see `:h lua-module-load`)
				path = {
					"lua/?.lua",
					"lua/?/init.lua",
				},
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					-- Depending on the usage, you might want to add additional paths
					-- here.
					-- '${3rd}/luv/library'
					-- '${3rd}/busted/library'
				},
				-- Or pull in all of 'runtimepath'.
				-- NOTE: this is a lot slower and will cause issues when working on
				-- your own configuration.
				-- See https://github.com/neovim/nvim-lspconfig/issues/3189
				-- library = {
				--   vim.api.nvim_get_runtime_file('', true),
				-- }
			},
		})
	end,
	settings = {
		Lua = {},
	},
})

local M = {}

M.tools = {
	{
		name = "Lua-LS",
		pkg = "lua-language-server",
		bin = "lua-language-server",
		lsp_id = "lua_ls",
		ft = "lua",
	},
	{
		name = "Pyright",
		pkg = "pyright",
		bin = "pyright",
		lsp_id = "pyright",
		ft = "python",
	},
	{
		name = "GoPLS",
		pkg = "gopls",
		bin = "gopls",
		lsp_id = "gopls",
		ft = "go",
	},
}

-- 2. Initialization function
M.setup = function()
	-- Keymap to telescope
	vim.keymap.set("n", "<leader>ll", function()
		require("core.installer").open("LSP Installer", M.tools)
	end, { desc = "Termux LSP" })

	-- AUTO ENABLE LOOP AND WARNING
	for _, tool in ipairs(M.tools) do
		if vim.fn.executable(tool.bin) == 1 then
			vim.lsp.enable(tool.lsp_id)
		else
			vim.api.nvim_create_autocmd("FileType", {
				pattern = tool.ft,
				callback = function()
					vim.notify(
						"💡 LSP " .. tool.name .. " isn't installed. Use <leader>ll to install.",
						vim.log.levels.WARN,
						{ title = "LSP Manager" }
					)
				end,
				once = true, -- Warnings once time in session
			})
		end
	end
end

return M
