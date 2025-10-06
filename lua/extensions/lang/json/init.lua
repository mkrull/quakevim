require "extensions.lang.json.mappings"

require("util").install "json-lsp"

local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config.jsonls = {
    capabilities = capabilities,
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
}
