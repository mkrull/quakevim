local ok, wk = pcall(require, "which-key")
if ok then
    local float, quake, half_life

    local function load_toggleterm()
        require("lazy").load { plugins = { "toggleterm.nvim" } }
    end

    local function get_float()
        if not float then
            load_toggleterm()
            float = require("toggleterm.terminal").Terminal:new {
                size = 10,
                open_mapping = [[<C-X>]],
                shading_factor = 6,
                direction = "float",
                float_opts = {
                    border = require("util").border,
                },
            }
        end
        return float
    end

    local function get_quake()
        if not quake then
            load_toggleterm()
            quake = require("toggleterm.terminal").Terminal:new {
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
        end
        return quake
    end

    local function get_half_life()
        if not half_life then
            load_toggleterm()
            half_life = require("toggleterm.terminal").Terminal:new {
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
                        local half = math.ceil(vim.o.columns / 2)
                        if half < 10 then
                            half = 10
                        end

                        return half
                    end,
                    row = 3,
                    col = 6,
                    winblend = 15,
                    border = require("util").border,
                },
            }
        end
        return half_life
    end

    wk.add {
        { "<leader>t", group = "Terminal", icon = { icon = "" } },
        {
            "<leader>tt",
            function()
                get_float():toggle()
            end,
            desc = "Toggle terminal",
        },
        {
            "~",
            function()
                get_half_life():toggle()
            end,
            desc = "Toggle terminal window",
        },
        {
            "<C-x>",
            function()
                get_quake():toggle()
            end,
            desc = "Quake terminal",
            mode = { "n", "t" },
        },
    }
end
