local kanagawa = "kanagawa-paper"
local ok, _ = pcall(require, kanagawa)
if not ok then
    return {}
end

local catppuccin = "catppuccin"
local ok, _ = pcall(require, catppuccin)
if not ok then
    return {}
end

local nordic = "nordic"
local ok, _ = pcall(require, nordic)
if not ok then
    return {}
end

local tokyonight = "tokyonight"
local ok, _ = pcall(require, tokyonight)
if not ok then
    return {}
end

vim.cmd.colorscheme "tokyonight-storm"
