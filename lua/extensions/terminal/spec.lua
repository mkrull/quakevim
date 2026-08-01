return {
    {
        "akinsho/toggleterm.nvim",
        cmd = { "ToggleTerm", "TermExec" },
        opts = {
            size = 10,
            shading_factor = 6,
            direction = "float",
            float_opts = {
                border = require("util").border,
            },
        },
    },
}

