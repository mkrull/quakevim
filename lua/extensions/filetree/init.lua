local function toggle_explorer()
    local snacks = require "snacks"
    local picker = snacks.picker.get({ source = "explorer" })[1]
    if picker then
        picker:close()
        return
    end
    -- reveal the current file in the explorer if there is one
    if vim.fn.filereadable(vim.api.nvim_buf_get_name(0)) == 1 then
        snacks.explorer.reveal()
    else
        snacks.explorer()
    end
end

require("util").wk_add {
    { "<leader>f", group = "File explorer", icon = { icon = "󱏒" } },
    {
        "<leader>fr",
        function()
            require("snacks").picker.recent()
        end,
        desc = "Search recent files",
    },
    {
        "<leader>ft",
        toggle_explorer,
        desc = "Toggle explorer",
    },
    {
        "<leader>fs",
        function()
            require("snacks").picker.lsp_symbols { symbol_width = 80 }
        end,
        desc = "Search document symbols",
    },
}
