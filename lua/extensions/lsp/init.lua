local lua_group = vim.api.nvim_create_augroup("LuaLSPGroup", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
    group = lua_group,
    pattern = "*.lua",
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        require("extensions.lsp.mappings").add_to_buffer(bufnr)
    end,
})
