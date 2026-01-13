return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {},
    init = function()
        local augroup = vim.api.nvim_create_augroup("AlphaNoBufferline", { clear = true })

        vim.api.nvim_create_autocmd("FileType", {
            group = augroup,
            pattern = "alpha",
            callback = function()
                vim.opt.showtabline = 0
            end,
        })

        vim.api.nvim_create_autocmd("BufLeave", {
            group = augroup,
            pattern = "*",
            callback = function()
                if vim.bo.filetype == "alpha" then
                    vim.opt.showtabline = 2
                end
            end,
        })
    end,
}
