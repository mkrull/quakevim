return {
    {
        "folke/which-key.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        -- needs to load eagerly: the mapping modules require it while
        -- init.lua is still sourcing, which is before VeryLazy fires
        lazy = false,
        opts = {
            icons = { group = "" },
        },
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
    },
}
