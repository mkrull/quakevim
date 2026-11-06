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
            mappings = {
                status = {
                    -- <C-x> is the quake terminal; neogit would otherwise
                    -- shadow it with SplitOpen in its status buffer
                    ["<c-x>"] = false,
                },
            },
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
        opts = {
            current_line_blame_opts = {
                delay = 100,
            },
        },
    },
}
