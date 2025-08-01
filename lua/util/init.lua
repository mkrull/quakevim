local M = {}

-- order as used by telescope
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

M.install = function(name)
    local ok, mason = pcall(require, "mason-registry")
    if ok then
        local p = mason.get_package(name)
        if not p:is_installed() then
            p:install()
        end
    end
end

return M
