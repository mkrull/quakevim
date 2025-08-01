local zen = require "extensions.ui.zen"

local ok, wk = pcall(require, "which-key")
if ok then
    wk.add {
        { "<leader>u", group = "UI", icon = { icon = "" } },
        {
            "<leader>ub",
            function()
                vim.go.background = vim.go.background == "light" and "dark" or "light"
            end,
            desc = "Toggle background",
        },
        {
            "<leader>uu",
            zen.toggle_clean,
            desc = "Toggle focus mode",
        },
        {
            "<leader>uz",
            zen.toggle_minimal,
            desc = "Toggle zen mode",
        },
        {
            "<leader>ui",
            zen.toggle_indent_scope,
            desc = "Toggle indent scope",
        },
        { "<leader>uc", group = "Colorscheme", icon = { icon = "" } },
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
end
