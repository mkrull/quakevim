local util = require "util"

-- one terminal instance per flavor, keyed by name; the buffer is recreated
-- when the shell inside it exited
local terminals = {}

local function toggle(name, win_opts)
    local term = terminals[name]
    if term and term:buf_valid() then
        -- re-evaluate the geometry so the terminal follows window resizes
        term.opts.width = win_opts.width
        term.opts.height = win_opts.height
        term:toggle()
        return
    end
    terminals[name] = require("snacks").terminal.open(nil, { win = win_opts })
end

local function third_height()
    local third = math.ceil(vim.o.lines / 3)
    if third < 10 then
        third = 10
    end

    return third
end

local function half_width()
    local half = math.ceil(vim.o.columns / 2)
    if half < 10 then
        half = 10
    end

    return half
end

local function float_opts()
    return {
        position = "float",
        width = 0.7,
        height = 0.7,
        border = util.border,
        wo = {
            winblend = 6,
        },
    }
end

local function quake_opts()
    return {
        position = "float",
        -- snacks treats sizes >= 1 as absolute columns, so use the actual
        -- column count instead of a fraction for the full width dropdown
        width = vim.o.columns,
        height = third_height(),
        row = 0,
        col = 0,
        border = util.bottom_border,
        wo = {
            winblend = 15,
        },
    }
end

local function half_life_opts()
    return {
        position = "float",
        width = half_width(),
        height = third_height(),
        row = 3,
        col = 6,
        border = util.border,
        wo = {
            winblend = 15,
        },
    }
end

require("util").wk_add {
    { "<leader>t", group = "Terminal", icon = { icon = "" } },
    {
        "<leader>tt",
        function()
            toggle("float", float_opts())
        end,
        desc = "Toggle terminal",
    },
    {
        "~",
        function()
            toggle("half_life", half_life_opts())
        end,
        desc = "Toggle terminal window",
    },
    {
        "<C-x>",
        function()
            toggle("quake", quake_opts())
        end,
        desc = "Quake terminal",
        mode = { "n", "t" },
    },
}
