M = {}

M.loaded = "default"

M.use = function(scheme)
    if scheme then
        vim.cmd.colorscheme(scheme)
        return
    end

    vim.cmd.colorscheme(M.loaded)
end

-- load all colorschemes and use the last one that successfully loads as
-- default
local kanagawa = "kanagawa-paper"
local ok, _ = pcall(require, kanagawa)
if ok then
    M.loaded = kanagawa
end

local nordic = "nordic"
local ok, _ = pcall(require, nordic)
if ok then
    M.loaded = "nordic"
end

local catppuccin = "catppuccin"
local ok, _ = pcall(require, catppuccin)
if ok then
    M.loaded = catppuccin
end

local tokyonight = "tokyonight"
local ok, _ = pcall(require, tokyonight)
if ok then
    M.loaded = tokyonight .. "-storm"
end

return M
