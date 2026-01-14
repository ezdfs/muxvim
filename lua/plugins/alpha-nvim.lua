return {
    'goolord/alpha-nvim',
    config = function()
        local dashboard = require('alpha.themes.dashboard')

        dashboard.section.header.val = {
            [[ _______               ___ ___ __           ]],
            [[|   |   |.--.--.--.--.|   |   |__|.--------.]],
            [[|       ||  |  |_   _||   |   |  ||        |]],
            [[|__|_|__||_____|__.__| \_____/|__||__|__|__|]],
        }

        require('alpha').setup(dashboard.config)

        local group = vim.api.nvim_create_augroup("AlphaNvim", { clear = true })

        vim.api.nvim_create_autocmd("User", {
            group = group,
            pattern = "LazyVimStarted",
            callback = function()
                if vim.fn.argc() == 0 then
                    -- Verify if Lazy is open
                    local lazy_opened = false
                    for _, win in ipairs(vim.api.nvim_list_wins()) do
                        if vim.api.nvim_win_get_config(win).relative ~= "" then
                            lazy_opened = true
                            break
                        end
                    end

                    if lazy_opened then
                        -- "Restart" neovim
                        vim.cmd("silent! bufdo bwipeout!") -- Clear buffers
                        vim.cmd("source $MYVIMRC")         -- Reload configuration
                        vim.cmd("Alpha")                   -- Open alpha dashboard
                    end
                end
            end,
        })
    end
};
