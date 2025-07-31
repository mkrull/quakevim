return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = { "vimdoc", "luadoc", "vim", "lua" },
                auto_install = true,

                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            }
        end,
        build = ":TSUpdate",
    },
}
