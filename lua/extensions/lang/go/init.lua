-- disable vim-go mappings, they get set either via lsp mappings or in
-- mappings.lua
vim.g.go_def_mapping_enabled = false

require "extensions.lang.go.lint"

require("util").install "gopls"

local ok, lsp = pcall(require, "lspconfig")
if ok then
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    lsp.gopls.setup {
        capabilities = capabilities,
        settings = {
            gopls = {
                hints = {
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    compositeLiteralTypes = true,
                    constantValues = true,
                    functionTypeParameters = true,
                    parameterNames = true,
                    rangeVariableTypes = true,
                },
            },
        },
    }
end

-- disable calling :GoDoc and keep lsp hover info mapped to K
vim.g.go_doc_keywordprg_enabled = 0

local function go_formatter()
    local params = vim.lsp.util.make_range_params(0, "utf-8")
    params.context = { only = { "source.organizeImports" } }

    local method = "textDocument/codeAction"
    local resp = vim.lsp.buf_request_sync(0, method, params, 1000)

    for _, res in pairs(resp or {}) do
        for _, r in pairs(res.result or {}) do
            if r.edit then
                vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
            else
                vim.lsp.buf.execute_command(r.command)
            end
        end
    end

    if vim.lsp.buf.format then
        vim.lsp.buf.format()
    elseif vim.lsp.buf.formatting then
        vim.lsp.buf.formatting()
    end
end

local gogroup = vim.api.nvim_create_augroup("GoBufferMappings", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "format buffer before saving",
    pattern = "*.go",
    group = gogroup,
    callback = go_formatter,
})

vim.api.nvim_create_autocmd("FileType", {
    group = gogroup,
    pattern = "go",
    callback = function()
        -- remove tab listchar for Go as that is default for indentation
        vim.opt_local.listchars:append { tab = "  " }
        local bufnr = vim.api.nvim_get_current_buf()
        require("extensions.lsp.mappings").add_to_buffer(bufnr)
    end,
})
