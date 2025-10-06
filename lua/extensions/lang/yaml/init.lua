require "extensions.lang.yaml.mappings"

require("util").install "yaml-language-server"

local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config.yamlls = {
    capabilities = capabilities,
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
}

-- default to yamlfmt for autoformatting yaml
local ok, conform = pcall(require, "conform")
if ok then
    conform.formatters_by_ft["yaml"] = { "yamlfmt" }
end
