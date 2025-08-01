local M = {}

-- order as used by telescope
M.borderchars = { "▔", "▕", "▁", "▏", "🭽", "🭾", "🭿", "🭼" }
M.border = {
    { "🭽", "WinSeparator" }, -- top left
    { "▔", "WinSeparator" }, -- top
    { "🭾", "WinSeparator" }, -- top right
    { "▕", "WinSeparator" }, -- right
    { "🭿", "WinSeparator" }, -- bottom right
    { "▁", "WinSeparator" }, -- bottom
    { "🭼", "WinSeparator" }, -- bottom left
    { "▏", "WinSeparator" }, -- left
}

M.bottom_border = {
    { " ", "WinSeparator" }, -- top left
    { " ", "WinSeparator" }, -- top
    { " ", "WinSeparator" }, -- top right
    { " ", "WinSeparator" }, -- right
    { "▁", "WinSeparator" }, -- bottom right
    { "▁", "WinSeparator" }, -- bottom
    { "▁", "WinSeparator" }, -- bottom left
    { " ", "WinSeparator" }, -- left
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
