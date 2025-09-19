require "extensions.lang.json.mappings"

require("util").install "json-lsp"

local ok, lsp = pcall(require, "lspconfig")
if ok then
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    lsp.jsonls.setup {
        capabilities = capabilities,
    }
end
