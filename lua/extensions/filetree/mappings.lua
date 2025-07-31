local ok, wk = pcall(require, "which-key")
if ok then
    wk.add {
        { "<leader>f", group = "File explorer", icon = { icon = "󱏒" } },
        {
            "<leader>fr",
            function()
                require("telescope.builtin").oldfiles()
            end,
            desc = "Search recent files",
        },
        {
            "<leader>ft",
            function()
                vim.cmd [[Neotree toggle]]
            end,
            desc = "Toggle Neotree",
        },
        {
            "<leader>fs",
            function()
                require("telescope.builtin").lsp_document_symbols { symbol_width = 80 }
            end,
            desc = "Search document symbols",
        },
    }
end
