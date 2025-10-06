require "extensions.lang.gleam.mappings"

local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config.gleam = {
    capabilities = capabilities,
    cmd = { "gleam", "lsp" },
    filetypes = { "gleam" },
}

local gleamgroup = vim.api.nvim_create_augroup("GleamBufferMappings", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = gleamgroup,
    pattern = "gleam",
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        require("extensions.lsp.mappings").add_to_buffer(bufnr)
    end,
})
