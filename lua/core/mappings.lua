require("util").wk_add {
    {
        "<leader><space>",
        function()
            require("snacks").picker.files()
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
            require("snacks").picker.buffers()
        end,
        desc = "Find buffers",
    },
    {
        "<leader>H",
        function()
            require("snacks").picker.help()
        end,
        desc = "Help tags",
        icon = { icon = "󰞋" },
    },
    {
        "<leader>T",
        function()
            require("snacks").picker.pickers()
        end,
        desc = "Pickers",
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
            require("snacks").picker.grep()
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
    {
        "gF",
        function()
            vim.cmd "vsplit"
            vim.cmd "edit <cfile>"
        end,
        desc = "Go to file under cursor in vsplit",
    },
}
