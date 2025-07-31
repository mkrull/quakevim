local M = {}

function M.add_to_buffer(bufnr)
    local ok, wk = pcall(require, "which-key")
    if not ok then
        return {}
    end
    wk.add {
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
                require("telescope.builtin").diagnostics()
            end,
            desc = "Search diagnostics",
            buffer = bufnr,
        },
        {
            "<leader>li",
            function()
                require("telescope.builtin").lsp_implementations()
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
                require("telescope.builtin").lsp_references()
            end,
            desc = "References",
            buffer = bufnr,
        },
    }
end

return M
