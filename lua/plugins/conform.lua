return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")

		conform.setup({})

		-- Configures autoformat on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("ConformAutoFormat", { clear = true }),
			pattern = "*",
			callback = function(args)
				conform.format({ bufnr = args.buf })
			end,
		})
	end,
}
