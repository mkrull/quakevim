return {
    {
        "folke/tokyonight.nvim",
        opts = {
            style = "night",
            lualine_bold = true, -- bold headers for each section header
            day_brightness = 0.15, -- high contrast but colorful

            on_highlights = function(highlights, colors)
                -- more visible window borders
                highlights.WinSeparator = {
                    fg = colors.blue0,
                }

                -- more dimmed indent scope
                highlights.MiniIndentscopeSymbol = {
                    fg = colors.blue7,
                }

                -- less bright selection
                highlights.TelescopeSelection = {
                    bg = colors.bg_dark,
                }
                -- more pronounced selection caret
                highlights.TelescopeSelectionCaret = {
                    bg = colors.bg_dark1,
                    fg = colors.magenta2,
                }

                -- dark results
                highlights.TelescopeResultsBorder = {
                    fg = colors.bg_dark1,
                    bg = colors.bg_dark1,
                }
                highlights.TelescopeResultsTitle = {
                    bg = colors.bg_dark1,
                }
                highlights.TelescopeResultsNormal = {
                    bg = colors.bg_dark1,
                }

                -- dark preview
                highlights.TelescopePreviewTitle = {
                    fg = colors.bg_dark,
                    bg = colors.bg_dark,
                }
                highlights.TelescopePreviewBorder = {
                    fg = colors.blue0,
                }

                -- dark prompt
                highlights.TelescopePromptBorder = {
                    fg = colors.magenta,
                    bg = colors.bg_dark1,
                }
                highlights.TelescopePromptTitle = {
                    bg = colors.bg_dark1,
                    fg = colors.bg_dark1,
                }
                highlights.TelescopePromptNormal = {
                    bg = colors.bg_dark1,
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
                    TelescopeSelection = { fg = colors.text, bg = colors.base },
                    TelescopeSelectionCaret = { fg = colors.red, bg = colors.mantle },

                    TelescopePromptNormal = { fg = colors.text, bg = colors.surface0 },
                    TelescopePromptBorder = { fg = colors.surface0, bg = colors.surface0 },
                    TelescopePromptTitle = { fg = colors.text, bg = colors.crust },

                    TelescopePreviewNormal = { fg = colors.overlay2, bg = colors.mantle },
                    TelescopePreviewBorder = { fg = colors.surface0, bg = colors.mantle },
                    TelescopePreviewTitle = { fg = colors.text, bg = colors.crust },

                    TelescopeResultsNormal = { fg = colors.overlay2, bg = colors.mantle },
                    TelescopeResultsBorder = { fg = colors.surface0, bg = colors.mantle },
                    TelescopeResultsTitle = { fg = colors.text, bg = colors.crust },

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
                mini = {
                    enabled = true,
                    indentscope_color = "overlay0",
                },
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
                neotree = true,
                noice = true,
                telescope = {
                    enabled = true,
                },
                which_key = true,
                window_picker = true,
            },
        },
    },
}
