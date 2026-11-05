local s = require "util"

return {
    {
        "folke/snacks.nvim",
        opts = {
            picker = {
                enabled = true,
                -- default layout for all pickers: results on top with the
                -- prompt at the bottom, square borders, no titles
                layouts = {
                    default = {
                        layout = {
                            box = "horizontal",
                            width = 0.8,
                            min_width = 120,
                            height = 0.8,
                            {
                                box = "vertical",
                                border = s.border,
                                { win = "list", border = "none" },
                                { win = "input", height = 1, border = "top" },
                            },
                            { win = "preview", border = s.border, width = 0.5 },
                        },
                    },
                },
            },
        },
    },
}
