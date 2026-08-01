local M = {
    plugins = {},
}

function M.get_extensions_file()
    local in_home = vim.env.HOME .. "/.quakevim.lua"
    if vim.fn.filereadable(in_home) == 1 then
        return in_home
    end

    -- in case no .quakevim.lua is found in $HOME use the default in the neovim
    -- config home
    return vim.fn.stdpath "config" .. "/extensions.lua"
end

local config_cache

function M.load_config()
    if not config_cache then
        local ok, config = pcall(dofile, M.get_extensions_file())
        config_cache = ok and config or {}
    end
    return config_cache.config or {}
end

function M.load_specs(spec)
    if not config_cache then
        M.load_config()
    end
    M.plugins = config_cache.extensions or {}
    for _, value in ipairs(M.plugins) do
        local spec_path = vim.fn.stdpath "config" .. "/lua/extensions/" .. value .. "/spec.lua"
        if vim.fn.filereadable(spec_path) == 1 then
            table.insert(spec, { import = "extensions." .. value:gsub("/", ".") .. ".spec" })
        end
    end
    return spec
end

function M.require()
    for _, value in ipairs(M.plugins) do
        local plugin_path = "extensions." .. string.gsub(value, "/", ".")
        pcall(require, plugin_path)
    end
end

return M
