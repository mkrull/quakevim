local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config.gleam = {
    capabilities = capabilities,
    cmd = { "gleam", "lsp" },
    filetypes = { "gleam" },
}
vim.lsp.enable "gleam"

local ok, ts = pcall(require, "nvim-treesitter")
if ok then
    ts.install { "gleam" }
end
