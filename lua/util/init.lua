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
        if not mason.is_installed(name) then
            mason.refresh(function()
                local p = mason.get_package(name)
                p:install()
            end)
        end
    end
end

return M
