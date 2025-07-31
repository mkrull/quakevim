-- remove trailing whitespace on save, this is here instead of the lsp
-- formatter to make sure it works in case no language server is attached
local cleanup_before_save = vim.api.nvim_create_augroup("cleanup_before_save", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    desc = "remove trailing whitespace before saving",
    group = cleanup_before_save,
    callback = function()
        local save_cursor = vim.fn.getpos "."
        vim.cmd [[%s/\s\+$//e]]
        vim.fn.setpos(".", save_cursor)
    end,
})
