require "core.options"
require "core.linenumbers"
require "core.save"
require "core.extensions"

local loader = require "core.loader"
local spec = {
    { import = "core/plugins" },
}

-- loading list of extensions and inserting them into the spec
spec = loader.load_specs(spec)

-- installing lazy.nvim in case it doesn't already exist
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

-- space is my leader
vim.g.mapleader = " "

-- let lazy setup the plugins
require("lazy").setup {
    change_detection = {
        enabled = false,
        notify = false,
    },
    spec = loader.flatten_plugins(spec),
}

-- remap recording to Q as q is used in too many places to quit and I keep
-- ending up in recording
vim.cmd [[nnoremap Q q]]
vim.cmd [[nnoremap q <Nop>]]

-- those packages depend on lazy installed plugins, e.g. which-key and
-- colorschemes
require "core.colors"
require "core.mappings"

loader.require()
