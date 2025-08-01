require "extensions.lang.yaml.mappings"

require("util").install "yaml-language-server"

local ok, lsp = pcall(require, "lspconfig")
if ok then
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    lsp.yamlls.setup {
        capabilities = capabilities,
    }
end
