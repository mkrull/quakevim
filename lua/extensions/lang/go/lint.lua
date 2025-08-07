local linter = nil
local ok = false

local lint = function()
    if not linter then
        ok, linter = pcall(require, "lint")
        if ok then
            local revive = linter.linters.revive

            -- Check if the config file exists and add it to the revive
            -- arguments if it is a readable file
            local config_file = vim.fn.expand "~/.config/revive.toml"
            if vim.fn.filereadable(config_file) == 1 then
                table.insert(revive.args, "-config")
                table.insert(revive.args, config_file)
            end

            linter.linters.revive = revive
            linter.linters_by_ft.go = { "revive" }
        else
            print "no linter loaded"
            return
        end
    end

    linter.try_lint()
end

local go_lint_group = vim.api.nvim_create_augroup("go-lint-after-save", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.go",
    group = go_lint_group,
    callback = function()
        lint()
    end,
})
