require("util").wk_add {
    { "<leader>u", group = "UI", icon = { icon = "" } },
    {
        "<leader>ub",
        function()
            vim.go.background = vim.go.background == "light" and "dark" or "light"
        end,
        desc = "Toggle background",
    },
    {
        "<leader>ui",
        function()
            -- the scope is enabled unless the buffer var is explicitly false
            vim.b.snacks_scope = vim.b.snacks_scope == false
        end,
        desc = "Toggle indent scope",
    },
    { "<leader>uc", group = "Colorscheme", icon = { icon = "" } },
    {
        "<leader>ucc",
        function()
            vim.cmd.colorscheme "catppuccin-mocha"
        end,
        desc = "Use catppuccin",
    },
    {
        "<leader>uck",
        function()
            vim.cmd.colorscheme "kanagawa-paper"
        end,
        desc = "Use kanagawa-paper",
    },
    {
        "<leader>ucn",
        function()
            vim.cmd.colorscheme "nordic"
        end,
        desc = "Use nordic",
    },
    {
        "<leader>uct",
        function()
            vim.cmd.colorscheme "tokyonight-storm"
        end,
        desc = "Use tokyonight-storm",
    },
}
