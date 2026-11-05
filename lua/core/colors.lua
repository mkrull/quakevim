local M = {}

-- keep the FloatBorder background in sync with the NormalFloat background so
-- that borders blend into floating windows instead of showing the editor
-- background around them
local function sync_float_border()
    local normal = vim.api.nvim_get_hl(0, { name = "NormalFloat", link = false })
    local border = vim.api.nvim_get_hl(0, { name = "FloatBorder", link = false })
    vim.api.nvim_set_hl(0, "FloatBorder", {
        fg = border.fg,
        bg = normal.bg or "NONE",
    })

    -- blink.cmp links its border groups to bright groups (Pmenu/NormalFloat)
    -- by default, dim them to the FloatBorder color on the matching window
    -- background instead
    local pmenu = vim.api.nvim_get_hl(0, { name = "Pmenu", link = false })
    local dim = { fg = border.fg, bg = pmenu.bg or "NONE" }
    vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", dim)
    local dim_float = { fg = border.fg, bg = normal.bg or "NONE" }
    vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", dim_float)
    vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", dim_float)
end

vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("quakevim-float-border", { clear = true }),
    callback = sync_float_border,
})

M.loaded = "default"

M.use = function(scheme)
    if scheme then
        vim.cmd.colorscheme(scheme)
        return
    end

    vim.cmd.colorscheme(M.loaded)
end

return M
