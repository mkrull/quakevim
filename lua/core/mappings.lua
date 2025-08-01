local ok, wk = pcall(require, "which-key")
if not ok then
    print "couldn't load which-key"
    return {}
end

wk.add {
    {
        "<leader><space>",
        function()
            require("telescope.builtin").find_files()
        end,
        desc = "Find files",
    },
    {
        "<leader>F",
        function()
            require("conform").format { async = true, lsp_format = "fallback" }
        end,
        desc = "Format buffer",
    },
    {
        "<leader>B",
        function()
            require("telescope.builtin").buffers()
        end,
        desc = "Find buffers",
    },
    {
        "<leader>H",
        function()
            require("telescope.builtin").help_tags()
        end,
        desc = "Help tags",
        icon = { icon = "󰞋" },
    },
    {
        "<leader>T",
        function()
            require("telescope.builtin").builtin()
        end,
        desc = "Telescope",
        icon = { icon = "󰭎" },
    },
    {
        "<leader>L",
        "<cmd>e!<cr>",
        desc = "Reload file from disk",
        icon = { icon = "󰑓" },
    },
    { "<leader>b", group = "Buffers", icon = { icon = "" } },
    { "<leader>bb", "<cmd>e #<cr>", desc = "Previous buffer" },
    {
        "<leader>n",
        function()
            vim.cmd "enew"
        end,
        desc = "New file",
        icon = { icon = "" },
    },
    { "<leader>s", group = "Search", icon = { icon = "" } },
    {
        "<leader>ss",
        function()
            require("telescope.builtin").live_grep()
        end,
        desc = "Search in project",
    },
    { "<leader>w", group = "Windows", icon = { icon = "" } },
    { "<C-W>-", "<C-W>s", desc = "Split" },
    { "<C-W>\\", "<C-W>v", desc = "Vertical split" },
    { "<leader>wh", "<C-W>h", desc = "Focus left" },
    { "<leader>wj", "<C-W>j", desc = "Focus down" },
    { "<leader>wk", "<C-W>k", desc = "Focus up" },
    { "<leader>wl", "<C-W>l", desc = "Focus right" },
    { "<leader>wH", "<C-W>H", desc = "Move left" },
    { "<leader>wJ", "<C-W>J", desc = "Move down" },
    { "<leader>wK", "<C-W>K", desc = "Move up" },
    { "<leader>wL", "<C-W>L", desc = "Move right" },
    { "<leader>ws", "<C-W>s", desc = "Split" },
    { "<leader>wv", "<C-W>v", desc = "Vertical split" },
}

wk.add {
    {
        {
            "K",
            function()
                vim.lsp.buf.hover { border = require("util").border }
            end,
            desc = "Hover info",
        },
        {
            "L",
            function()
                vim.diagnostic.open_float()
            end,
            desc = "Hover diagnostics",
        },
        {
            "gD",
            function()
                vim.cmd "vsplit"
                vim.lsp.buf.definition()
            end,
            desc = "Go to definition of current symbol in vsplit",
        },
        {
            "gS",
            function()
                vim.cmd "split"
                vim.lsp.buf.definition()
            end,
            desc = "Go to definition of current symbol in split",
        },
        {
            "gd",
            function()
                vim.lsp.buf.definition()
            end,
            desc = "Go to definition of current symbol",
        },
        {
            "gF",
            function()
                vim.cmd "vsplit"
                vim.cmd "edit <cfile>"
            end,
            desc = "Go to file under cursor in vsplit",
        },
    },
}
