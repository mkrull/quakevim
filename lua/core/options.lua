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

-- disable messages for writing
vim.opt.shortmess:append "w"
