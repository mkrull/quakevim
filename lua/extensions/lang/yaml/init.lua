require "extensions.lang.yaml.mappings"

local ok, mason = pcall(require, "mason-registry")
if ok then
    local p = mason.get_package "yaml-language-server"
    if not p:is_installed() then
        p:install()
    end
end

local ok, lsp = pcall(require, "lspconfig")
if ok then
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    lsp.yamlls.setup {
        capabilities = capabilities,
    }
end
