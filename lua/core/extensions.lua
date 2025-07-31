local M = {}

function M.make_extension(name)
    local config_dir = vim.fn.stdpath "config"

    local path_name = name:gsub("%.", "/")
    local ext_dir = config_dir .. "/lua/extensions/" .. path_name
    local mappings_file = ext_dir .. "/mappings.lua"
    local init_file = ext_dir .. "/init.lua"
    local spec_file = ext_dir .. "/spec.lua"

    vim.fn.mkdir(ext_dir, "p")
    vim.fn.mkdir(spec_dir, "p")

    local mappings_handle = io.open(mappings_file, "w")
    if mappings_handle then
        local mappings_content = string.format(
            [[
local ok, wk = pcall(require, "which-key")
if ok then
    -- wk.add {
        -- mappings for %s extension
    -- }
end
]],
            name
        )
        mappings_handle:write(mappings_content)
        mappings_handle:close()
    else
        error "Failed to create mappings.lua file"
    end

    local init_content = string.format(
        [[
require "extensions.%s.mappings"
]],
        name
    )

    local init_handle = io.open(init_file, "w")
    if init_handle then
        init_handle:write(init_content)
        init_handle:close()
    else
        error "Failed to create init.lua file"
    end

    local spec_handle = io.open(spec_file, "w")
    if spec_handle then
        spec_handle:write "return {}"
        spec_handle:close()
    else
        error "Failed to create spec.lua file"
    end

    print("Created extension '" .. name .. "' at " .. ext_dir)
end

vim.api.nvim_create_user_command("MakeExtension", function(opts)
    M.make_extension(opts.args)
end, { nargs = 1, desc = "Create extension skeleton" })

return M
