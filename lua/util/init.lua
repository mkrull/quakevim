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

return M
