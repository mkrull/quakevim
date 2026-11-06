require("util").lsp {
    name = "jsonls",
    mason = "json-lsp",
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
}
