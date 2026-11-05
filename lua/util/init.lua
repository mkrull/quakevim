local M = {}

-- order: top, right, bottom, left, top-left, top-right, bottom-right, bottom-left
M.borderchars = { "▔", "▕", "▁", "▏", "🭽", "🭾", "🭿", "🭼" }
M.border = {
    { "🭽", "FloatBorder" }, -- top left
    { "▔", "FloatBorder" }, -- top
    { "🭾", "FloatBorder" }, -- top right
    { "▕", "FloatBorder" }, -- right
    { "🭿", "FloatBorder" }, -- bottom right
    { "▁", "FloatBorder" }, -- bottom
    { "🭼", "FloatBorder" }, -- bottom left
    { "▏", "FloatBorder" }, -- left
}

M.bottom_border = {
    { " ", "FloatBorder" }, -- top left
    { " ", "FloatBorder" }, -- top
    { " ", "FloatBorder" }, -- top right
    { " ", "FloatBorder" }, -- right
    { "▁", "FloatBorder" }, -- bottom right
    { "▁", "FloatBorder" }, -- bottom
    { "▁", "FloatBorder" }, -- bottom left
    { " ", "FloatBorder" }, -- left
}

-- single thin accent line on the left edge, used where a full box is too
-- heavy, e.g. the completion menu
M.left_border = { "", "", "", "", "", "", "", "▏" }

-- Add which-key specs. This has to go through which-key's config module
-- directly: the public `wk.add` only queues specs for a one-time drain when
-- the plugin is set up, so specs added later (like ours, but also buffer
-- local ones added on LspAttach) would never become actual keymaps.
M.wk_add = function(specs)
    local ok, config = pcall(require, "which-key.config")
    if ok then
        config.add(specs)
    end
end

M.install = function(name)
    local ok, mason = pcall(require, "mason-registry")
    if ok then
        if not mason.is_installed(name) then
            mason.refresh(function()
                local pkg_ok, pkg = pcall(mason.get_package, name)
                if not pkg_ok then
                    vim.notify("quakevim: unknown mason package " .. name, vim.log.levels.WARN)
                    return
                end
                vim.notify(
                    "quakevim: installing " .. name .. ", its LSP attaches on the next file you open",
                    vim.log.levels.INFO
                )
                pkg:install()
            end)
        end
    end
end

return M
