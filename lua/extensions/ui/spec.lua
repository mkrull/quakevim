return {
    {
        "folke/snacks.nvim",
        opts = {
            indent = {
                enabled = true,
                -- no animated scope, matching the previous mini.indentscope
                -- setup
                animate = { enabled = false },
            },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "help",
                    "alpha",
                    "dashboard",
                    "snacks_picker_list",
                    "snacks_picker_preview",
                    "snacks_picker_input",
                    "Trouble",
                    "trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "terminal",
                    "lazyterm",
                },
                callback = function()
                    vim.b.snacks_indent = false
                end,
            })
        end,
    },
    {
        "Bekaboo/dropbar.nvim",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "nvim-telescope/telescope-fzf-native.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {},
    },
    {
        "folke/todo-comments.nvim",
        opts = {},
    },
    {
        "nvim-lualine/lualine.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = function()
            return {
                options = {
                    theme = "auto",
                    globalstatus = true,
                    disabled_filetypes = { statusline = { "dashboard", "alpha" } },
                    component_separators = { left = "│", right = "│" },
                    section_separators = { left = "", right = "" },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch" },
                    lualine_c = {
                        {
                            "diagnostics",
                        },
                        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                        { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
                    },
                    lualine_x = {
                        {
                            function()
                                local reg = vim.fn.reg_recording()
                                if reg == "" then
                                    return ""
                                end
                                return " @" .. reg
                            end,
                            color = { fg = "#ff9e64" },
                        },
                        {
                            "diff",
                        },
                    },
                    lualine_y = {
                        { "progress", separator = " ", padding = { left = 1, right = 0 } },
                        { "location", padding = { left = 0, right = 1 } },
                    },
                    lualine_z = {
                        function()
                            -- don't show time in tmux
                            if os.getenv "TMUX" then
                                return ""
                            end
                            return " " .. os.date "%R"
                        end,
                    },
                },
                extensions = { "lazy" },
            }
        end,
    },
}
