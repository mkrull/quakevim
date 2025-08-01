local ok, wk = pcall(require, "which-key")
if ok then
    wk.add {
        { "<leader>x", group = "Trouble", icon = { icon = "" } },
        { "<leader>xS", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols" },
        { "<leader>xs", "<cmd>Trouble symbols toggle focus=true win = { size = 80 }<cr>", desc = "Symbols (wide)" },
        { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Open buffer diagnostics" },
        {
            "<leader>xt",
            function()
                require "trouble"
                vim.cmd "Trouble todo"
            end,
            desc = "Todo",
        },
        { "<leader>xx", "<cmd>Trouble diagnostics toggle focus=true<cr>", desc = "Open workspace diagnostics" },
    }
end
