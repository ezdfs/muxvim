local M = {}

-- 1. Tool definitions for the Installer
-- Added 'on_success' to trigger a live reload of the formatting engine
M.tools = {
	{
		name = "Stylua (Lua)",
		install_cmd = "pkg install -y stylua",
		bin = "stylua",
		filetype = "lua",
		on_success = function()
			M.setup()
		end,
	},
	{
		name = "Black (Python)",
		install_cmd = "pkg install python -y && pkg install python-pip -y && pip install black",
		bin = "black",
		filetype = "python",
		on_success = function()
			M.setup()
		end,
	},
	{
		name = "GoFmt (Golang)",
		install_cmd = "pkg install -y golang",
		bin = "gofmt",
		filetype = "go",
		on_success = function()
			M.setup()
		end,
	},
}

M.setup = function()
	local ok, conform = pcall(require, "conform")
	if not ok then
		vim.notify("Conform.nvim not found", vim.log.levels.ERROR)
		return
	end

	-- 2. Build the formatters_by_filetype table dynamically
	-- It only registers binaries that actually exist in the Termux PATH
	local formatters_map = {}
	for _, tool in ipairs(M.tools) do
		if vim.fn.executable(tool.bin) == 1 then
			-- Note: We use a list because some filetypes might use multiple formatters
			formatters_map[tool.filetype] = { tool.bin }
		end
	end

	-- 3. Configure Conform
	conform.setup({
		formatters_by_filetype = formatters_map,
		-- Default: format on save
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	})

	-- 4. Mapping for the Telescope Installer
	vim.keymap.set("n", "<leader>lf", function()
		require("core.installer").open("Formatter Manager", M.tools)
	end, { desc = "Manage Formatters" })

	-- 5. Mapping to format buffer manually
	vim.keymap.set("n", "<leader>fb", function()
		conform.format({ async = true, lsp_fallback = true })
	end, { desc = "Format Buffer" })
end

return M
