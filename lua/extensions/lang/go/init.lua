require("util").ts_install { "go", "gomod", "gowork" }

require("util").lsp {
    name = "gopls",
    mason = "gopls",
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
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

-- lint with revive on save, picking up ~/.config/revive.toml when present
local revive_configured = false

local lint = function()
    local ok, linter = pcall(require, "lint")
    if not ok then
        return
    end

    if not revive_configured then
        revive_configured = true
        local config_file = vim.fn.expand "~/.config/revive.toml"
        if vim.fn.filereadable(config_file) == 1 then
            table.insert(linter.linters.revive.args, "-config")
            table.insert(linter.linters.revive.args, config_file)
        end
        linter.linters_by_ft.go = { "revive" }
    end

    linter.try_lint()
end

-- organize imports on save before formatting, gofmt alone does not do it
local function go_formatter()
    local params = vim.lsp.util.make_range_params(0, "utf-8")
    params.context = { only = { "source.organizeImports" } }

    local resp = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)

    for _, res in pairs(resp or {}) do
        for _, r in pairs(res.result or {}) do
            if r.edit then
                vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
            else
                vim.lsp.buf.execute_command(r.command)
            end
        end
    end

    vim.lsp.buf.format()
end

local gogroup = vim.api.nvim_create_augroup("GoBufferMappings", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.go",
    group = gogroup,
    callback = lint,
})

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
    end,
})
