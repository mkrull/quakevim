local ok, wk = pcall(require, "which-key")
if ok then
    local float = require("toggleterm.terminal").Terminal:new {
        size = 10,
        open_mapping = [[<C-X>]],
        shading_factor = 6,
        direction = "float",
        float_opts = {
            border = require("util").border,
        },
    }

    local quake = require("toggleterm.terminal").Terminal:new {
        open_mapping = [[<C-X>]],
        direction = "float",
        float_opts = {
            height = function()
                local third = math.ceil(vim.o.lines / 3)
                if third < 10 then
                    third = 10
                end

                return third
            end,
            width = function()
                return vim.o.columns
            end,
            row = 0,
            col = 0,
            winblend = 15,
            border = require("util").bottom_border,
        },
    }
    wk.add {
        { "<leader>t", group = "Terminal", icon = { icon = "" } },
        {
            "<leader>tt",
            function()
                float:toggle()
            end,
            desc = "Toggle terminal",
        },
        {
            "<C-x>",
            function()
                quake:toggle()
            end,
            desc = "Quake terminal",
        },
    }
end
