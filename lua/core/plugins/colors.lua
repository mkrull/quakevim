return {
    {
        "folke/tokyonight.nvim",
        opts = {
            style = "night",
            lualine_bold = true, -- bold headers for each section header
            day_brightness = 0.15, -- high contrast but colorful

            on_highlights = function(highlights, colors)
                -- blue, less bright float borders
                highlights.FloatBorder = {
                    fg = colors.blue0,
                }

                -- more visible window borders
                highlights.WinSeparator = {
                    fg = colors.blue0,
                }
            end,
        },
    },
    {
        "AlexvZyl/nordic.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("nordic").load {}
        end,
    },
    {
        "sho-87/kanagawa-paper.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            overrides = function(colors)
                local theme = colors.theme
                return {
                    FloatBorder = { fg = theme.ui.fg_dim, bg = theme.ui.bg_dim },
                    NormalFloat = { bg = theme.ui.bg_dim },
                    Pmenu = { fg = theme.ui.fg_dim, bg = theme.ui.bg_dim },
                }
            end,
        },
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = true,
        opts = {
            custom_highlights = function(colors)
                return {
                    NormalFloat = { bg = colors.mantle },
                    Pmenu = { bg = colors.mantle },
                    SpellBad = { fg = colors.yellow, style = { "underline" } },
                    DiagnosticUnderlineInfo = { style = { "underline" } },
                    DiagnosticUnderlineWarn = { style = { "underline" } },
                    DiagnosticUnderlineError = { style = { "underline" } },
                }
            end,
            dim_inactive = { enabled = true, percentage = 0.25 },
            integrations = {
                cmp = false,
                indent_blankline = {
                    enabled = false,
                },
                lsp_trouble = true,
                mason = true,
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { "underline" },
                        hints = { "underline" },
                        warnings = { "underline" },
                        information = { "underline" },
                    },
                },
                neotest = true,
                telescope = {
                    enabled = false,
                },
                which_key = true,
            },
        },
    },
}
