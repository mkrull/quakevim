require "extensions.lang.yaml.mappings"

require("util").install "yaml-language-server"

local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config.yamlls = {
    capabilities = capabilities,
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
}
vim.lsp.enable "yamlls"

-- default to yamlfmt for autoformatting yaml if it is available
if vim.fn.executable "yamlfmt" == 1 then
    local ok, conform = pcall(require, "conform")
    if ok then
        conform.formatters_by_ft["yaml"] = { "yamlfmt" }
    end
end
