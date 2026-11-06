local M = {}

function M.make_extension(name)
    local config_dir = vim.fn.stdpath "config"

    local path_name = name:gsub("%.", "/")
    local module_name = name:gsub("/", "%.")
    local ext_dir = config_dir .. "/lua/extensions/" .. path_name
    local init_file = ext_dir .. "/init.lua"
    local spec_file = ext_dir .. "/spec.lua"

    vim.fn.mkdir(ext_dir, "p")

    local init_handle = io.open(init_file, "w")
    if not init_handle then
        error "Failed to create init.lua file"
    end
    init_handle:write(string.format(
        [[
require("util").wk_add {
    -- mappings for %s extension
}
]],
        module_name
    ))
    init_handle:close()

    local spec_handle = io.open(spec_file, "w")
    if not spec_handle then
        error "Failed to create spec.lua file"
    end
    spec_handle:write "return {}"
    spec_handle:close()

    print("Created extension '" .. module_name .. "' at " .. ext_dir)
end

function M.make_config()
    local in_home = vim.env.HOME .. "/.quakevim.lua"
    local src = vim.fn.stdpath "config" .. "/extensions.lua"

    local extensions_file = io.open(src, "rb")
    if not extensions_file then
        error("Could not open source file: " .. src)
        return false
    end

    local content = extensions_file:read "*all"
    extensions_file:close()

    local config_file = io.open(in_home, "wb")
    if not config_file then
        error("Could not open destination file: " .. in_home)
        return false
    end

    -- Write content to destination
    config_file:write(content)
    config_file:close()

    return true
end

vim.api.nvim_create_user_command("MakeExtension", function(opts)
    M.make_extension(opts.args)
end, { nargs = 1, desc = "Create extension skeleton" })

vim.api.nvim_create_user_command("MakeConfig", function()
    M.make_config()
end, { desc = "Create extension config in HOME directory" })

vim.api.nvim_create_user_command("EditConfig", function()
    local extensions_file = require("core.loader").get_extensions_file()
    vim.cmd("edit " .. extensions_file)
end, { desc = "Open extension config" })

return M
