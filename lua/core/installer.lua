local M = {}

-- Helper to handle the terminal window creation and execution
local function run_install_term(data)
	-- Create a buffer for the terminal
	local buf = vim.api.nvim_create_buf(false, true)

	-- Open a bottom split with the new buffer
	vim.cmd("botright 10split")
	local win = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_buf(win, buf)

	-- Modern way to open a terminal in a specific buffer
	-- Using 'term' command is the cleanest way to handle interactive/visible output
	vim.cmd("terminal " .. data.install_cmd)

	-- Get the job ID of the terminal we just opened
	local job_id = vim.b.terminal_job_id

	-- Poll for job completion
	if job_id then
		vim.api.nvim_create_autocmd("TermClose", {
			buffer = buf,
			callback = function()
				local exit_code = vim.v.event.status
				if exit_code == 0 then
					-- Close window on success after a short delay
					vim.defer_fn(function()
						if vim.api.nvim_win_is_valid(win) then
							vim.api.nvim_win_close(win, true)
						end
					end, 2000)

					vim.notify("✅ " .. data.name .. " installed!", vim.log.levels.INFO)
					if data.on_success then
						data.on_success()
					end
				else
					vim.notify("❌ Installation failed for " .. data.name, vim.log.levels.ERROR)
				end
			end,
		})
	end

	-- Auto-scroll to bottom
	vim.cmd("startinsert")
end

M.open = function(filter_type, tools)
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	pickers
		.new({}, {
			prompt_title = "🚀 Termux Installer: " .. filter_type,
			finder = finders.new_table({
				results = tools,
				entry_maker = function(entry)
					local is_installed = vim.fn.executable(entry.bin) == 1
					return {
						value = entry,
						display = (is_installed and "◍ " or "○ ") .. entry.name,
						ordinal = entry.name,
						installed = is_installed,
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr)
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					if not selection then
						return
					end

					local data = selection.value

					if selection.installed then
						return vim.notify("⚠️ " .. data.name .. " is already installed", vim.log.levels.WARN)
					end

					actions.close(prompt_bufnr)
					run_install_term(data)
				end)
				return true
			end,
		})
		:find()
end

return M
