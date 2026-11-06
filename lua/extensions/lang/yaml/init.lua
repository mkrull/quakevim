require("util").lsp {
    name = "yamlls",
    mason = "yaml-language-server",
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
}

require("util").ts_install { "yaml" }

-- default to yamlfmt for autoformatting yaml if it is available
if vim.fn.executable "yamlfmt" == 1 then
    local ok, conform = pcall(require, "conform")
    if ok then
        conform.formatters_by_ft["yaml"] = { "yamlfmt" }
    end
end
