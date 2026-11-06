local M = {}

local util = require "util"

require("util").wk_add {
    {
        "K",
        function()
            vim.lsp.buf.hover { border = util.border }
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
}

function M.add_to_buffer(bufnr)
    require("util").wk_add {
        { "<leader>l", group = "LSP", icon = { icon = "󱉯" }, buffer = bufnr },
        {
            "<leader>lF",
            function()
                vim.g.autoformat_disabled = not vim.g.autoformat_disabled
            end,
            desc = "Toggle formatting",
            buffer = bufnr,
        },
        {
            "<leader>la",
            function()
                require("actions-preview").code_actions()
            end,
            desc = "Code actions",
            buffer = bufnr,
        },
        {
            "<leader>ld",
            function()
                require("snacks").picker.diagnostics()
            end,
            desc = "Search diagnostics",
            buffer = bufnr,
        },
        {
            "<leader>li",
            function()
                require("snacks").picker.lsp_implementations()
            end,
            desc = "Implementations",
            buffer = bufnr,
        },
        {
            "<leader>ln",
            function()
                vim.lsp.buf.rename()
            end,
            desc = "Rename",
            buffer = bufnr,
        },
        {
            "<leader>lr",
            function()
                require("snacks").picker.lsp_references()
            end,
            desc = "References",
            buffer = bufnr,
        },
    }
end

return M
