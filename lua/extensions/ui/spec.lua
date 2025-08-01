return {
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = false,
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        opts = {},
    },
    {
        "folke/todo-comments.nvim",
        opts = {},
    },
    {
        "nvim-lualine/lualine.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "yavorski/lualine-macro-recording.nvim",
        },
        opts = function()
            return {
                options = {
                    theme = "auto",
                    globalstatus = true,
                    disabled_filetypes = { statusline = { "dashboard", "alpha" } },
                    component_separators = { left = "│", right = "│" },
                    section_separators = { left = "", right = "" },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch" },
                    lualine_c = {
                        {
                            "diagnostics",
                        },
                        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                        { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
                    },
                    lualine_x = {
                        { "macro_recording", "%S" },
                        {
                            "diff",
                        },
                    },
                    lualine_y = {
                        { "progress", separator = " ", padding = { left = 1, right = 0 } },
                        { "location", padding = { left = 0, right = 1 } },
                    },
                    lualine_z = {
                        function()
                            -- don't show time in tmux
                            if os.getenv "TMUX" then
                                return ""
                            end
                            return " " .. os.date "%R"
                        end,
                    },
                },
                extensions = { "neo-tree", "lazy" },
            }
        end,
    },
    {
        "echasnovski/mini.indentscope",
        version = "*",
        opts = {
            draw = {
                -- Delay (in ms) between event and start of drawing scope indicator
                delay = 30,
                -- disable animations
                animation = function()
                    return 0
                end,
            },
            symbol = "│",
            options = {
                try_as_border = true,
            },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },
}
