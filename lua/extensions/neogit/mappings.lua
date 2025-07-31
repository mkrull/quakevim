local ok, wk = pcall(require, "which-key")

if not ok then
    return
end

wk.add {
    { "<leader>g", group = "Git", icon = { icon = "" } },
    { "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle line blame" },
    {
        "<leader>gj",
        function()
            vim.fn.search "\\(<\\{7}\\|=\\{7}\\|>\\{7}\\)"
        end,
        desc = "Jump to conflict",
    },
    { "<leader>gd", "<cmd>Gitsigns diffthis<cr>", desc = "Vim diff" },
    {
        "<leader>gg",
        function()
            require("neogit").open { kind = "vsplit" }
        end,
        desc = "Open Neogit",
    },
    {
        "<leader>gs",
        function()
            require("neogit").open { kind = "split" }
        end,
        desc = "Open Neogit",
    },
}
