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
    end
};
