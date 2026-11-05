local s = require "util"

return {
    {
        "folke/snacks.nvim",
        opts = {
            explorer = {
                enabled = true,
                replace_netrw = true,
            },
            picker = {
                sources = {
                    explorer = {
                        layout = {
                            preview = false,
                            -- sidebar layout copied from the snacks preset with
                            -- the input border replaced by our square style
                            layout = {
                                backdrop = false,
                                width = 40,
                                min_width = 40,
                                height = 0,
                                position = "left",
                                border = "none",
                                box = "vertical",
                                {
                                    win = "input",
                                    height = 1,
                                    border = s.border,
                                    title = "{title} {live} {flags}",
                                    title_pos = "center",
                                },
                                { win = "list", border = "none" },
                                { win = "preview", title = "{preview}", height = 0.4, border = "top" },
                            },
                        },
                    },
                },
            },
        },
    },
}
