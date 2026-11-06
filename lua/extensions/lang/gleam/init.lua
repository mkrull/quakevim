require("util").lsp {
    name = "gleam",
    cmd = { "gleam", "lsp" },
    filetypes = { "gleam" },
}

require("util").ts_install { "gleam" }
