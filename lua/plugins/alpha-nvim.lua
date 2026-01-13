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

        local augroup = vim.api.nvim_create_augroup("AlphaOnEmpty", { clear = true })
        vim.api.nvim_create_autocmd("User", {
            group = augroup,
            pattern = "LazyVimStarted",
            callback = function()
                if vim.fn.argc() == 0 and vim.api.nvim_buf_get_name(0) == "" then
                    local present, alpha = pcall(require, "alpha")
                    if present then
                        alpha.start(false)
                    end
                end
            end,
        })
    end
};
