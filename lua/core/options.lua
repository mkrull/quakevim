-- options
local options = {
    mouse = "a",
    backup = false,
    swapfile = false,

    tabstop = 4,
    shiftwidth = 4,
    softtabstop = 4,
    expandtab = true,

    scrolloff = 10,
    sidescrolloff = 10,
    wrap = false,

    number = true,
    relativenumber = true,

    hlsearch = false,
    timeoutlen = 300,
    completeopt = { "menuone", "noselect", "preview" },
    clipboard = "unnamedplus",
    signcolumn = "yes",

    splitright = true,
    splitbelow = true,

    termguicolors = true,

    -- hide status bar initially before lualine is loaded
    laststatus = 0,

    list = true,
    listchars = { tab = " ", trail = "·", nbsp = "␣" },

    cursorline = true,
    cursorlineopt = "number",
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

-- default floating window borders to the same square style used elsewhere
-- (util.borderchars order: top, right, bottom, left, top-left, top-right,
-- bottom-right, bottom-left; winborder expects them clockwise starting from
-- the top-left corner)
local borderchars = require("util").borderchars
vim.o.winborder = table.concat({
    borderchars[5],
    borderchars[1],
    borderchars[6],
    borderchars[2],
    borderchars[7],
    borderchars[3],
    borderchars[8],
    borderchars[4],
}, ",")

-- disable messages for writing
vim.opt.shortmess:append "w"
