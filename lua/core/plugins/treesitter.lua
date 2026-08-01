return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local ensure_installed = { "vimdoc", "luadoc", "vim", "lua" }

            local ok, ts = pcall(require, "nvim-treesitter")
            if ok then
                ts.install(ensure_installed)
            end

            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })
        end,
    },
}
