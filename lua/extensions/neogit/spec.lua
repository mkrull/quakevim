return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim", -- required
            "sindrets/diffview.nvim",
        },
        lazy = true,
        opts = {
            graph_style = "unicode",
            signs = {
                hunk = { "", "" },
                item = { "", "" },
                section = { "", "" },
            },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPost",
        config = true,
        opts = {
            current_line_blame_opts = {
                delay = 100,
            },
        },
    },
}
