return {
    {
        "folke/snacks.nvim",
        opts = {
            terminal = {
                enabled = true,
                win = {
                    wo = {
                        -- render terminal floats with the same background as
                        -- other floating windows so the borders blend in
                        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
                    },
                },
            },
        },
    },
}
