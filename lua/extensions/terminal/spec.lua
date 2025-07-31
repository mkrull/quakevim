return {
    {
        "akinsho/toggleterm.nvim",
        cmd = { "ToggleTerm", "TermExec" },
        opts = {
            size = 10,
            open_mapping = [[<C-X>]],
            shading_factor = 6,
            direction = "float",
            float_opts = {
                border = require("util").border,
            },
        },
    },
}

