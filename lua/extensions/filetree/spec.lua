return {
    {
        "s1n7ax/nvim-window-picker",
        name = "window-picker",
        version = "2.*",
        lazy = false,
        opts = {},
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        opts = {
            open_files_do_not_replace_types = { "terminal", "Trouble", "qf" },
        },
    },
}
