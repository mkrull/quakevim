local s = require "util"

local function disable_titles_for_all_pickers(additional_pickers)
    local pickers = {}
    local ok, builtin = pcall(require, "telescope.builtin")
    if not ok then
        return pickers
    end

    -- Add all built-in pickers
    for picker_name, _ in pairs(builtin) do
        if type(picker_name) == "string" and type(builtin[picker_name]) == "function" then
            pickers[picker_name] = {
                prompt_title = false,
                results_title = false,
                preview_title = false,
            }
        end
    end

    -- Add any additional custom pickers
    if additional_pickers then
        for _, picker_name in ipairs(additional_pickers) do
            pickers[picker_name] = {
                prompt_title = false,
                results_title = false,
                preview_title = false,
            }
        end
    end

    return pickers
end

return {
    {
        "nvim-telescope/telescope.nvim",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            defaults = {
                prompt_prefix = "  ",
                selection_caret = "  ",
                entry_prefix = "   ",
                initial_mode = "insert",
                sorting_strategy = "ascending",
                layout_strategy = "flex",
                layout_config = {
                    horizontal = {
                        prompt_position = "bottom",
                        width = { padding = 7 },
                        height = { padding = 5 },
                        preview_width = 0.6,
                    },
                    vertical = {
                        prompt_position = "bottom",
                        width = { padding = 7 },
                        height = { padding = 5 },
                    },
                },
                borderchars = s.borderchars,
                -- disable titles by default, still has to be disabled for some
                -- pickers explicitly as their set titles take precedence over
                -- the default
                prompt_title = false,
                results_title = false,
                preview_title = false,
            },
            pickers = disable_titles_for_all_pickers(),
        },
    },
}
