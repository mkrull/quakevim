local ok, wk = pcall(require, "which-key")
if ok then
    wk.add {
        { "<leader>t", group = "Terminal", icon = { icon = "" } },
        { "<leader>tq", "<cmd>ToggleTerm size=20 direction=horizontal<cr>", desc = "Toggle bottom terminal" },
        { "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle terminal" },
        { "<leader>tv", "<cmd>ToggleTerm size=100 direction=vertical<cr>", desc = "Toggle vertical terminal" },
    }
end
