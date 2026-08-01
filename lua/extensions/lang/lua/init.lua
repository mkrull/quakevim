require("util").install "stylua"
require("util").install "lua-language-server"

local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config.lua_ls = {
    capabilities = capabilities,
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    settings = {
        Lua = {
            completion = {
                callSnippet = "Replace",
            },
            -- Ignore Lua_LS's noisy `missing-fields` warnings
            diagnostics = { disable = { "missing-fields" } },
        },
    },
}
vim.lsp.enable "lua_ls"
