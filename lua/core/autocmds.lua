-- toggle line numbers based on focus, use relativenumbers in focussed buffers
-- only and only if not in insert mode
local numbertoggle = vim.api.nvim_create_augroup("numbertoggle", {})

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
    pattern = "*",
    group = numbertoggle,
    callback = function()
        if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
            vim.opt.relativenumber = true
        end
    end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
    pattern = "*",
    group = numbertoggle,
    callback = function()
        if vim.o.nu then
            vim.opt.relativenumber = false
        end
    end,
})

-- remove trailing whitespace on save, this is here instead of the lsp
-- formatter to make sure it works in case no language server is attached
local cleanup_before_save = vim.api.nvim_create_augroup("cleanup_before_save", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    desc = "remove trailing whitespace before saving",
    group = cleanup_before_save,
    callback = function()
        -- skip buffers that cannot be modified, e.g. when force-writing
        -- checkhealth output
        if not vim.bo.modifiable then
            return
        end

        local save_cursor = vim.fn.getpos "."
        vim.cmd [[%s/\s\+$//e]]
        vim.fn.setpos(".", save_cursor)
    end,
})
