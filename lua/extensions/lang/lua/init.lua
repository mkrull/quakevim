require("util").lsp {
    name = "lua_ls",
    mason = { "lua-language-server", "stylua" },
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    settings = {
        Lua = {
            completion = {
                callSnippet = "Replace",
            },
            -- ignore lua_ls's noisy `missing-fields` warnings
            diagnostics = { disable = { "missing-fields" } },
        },
    },
}
