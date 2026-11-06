local M = {
    plugins = {},
}

local function notify_error(msg)
    vim.notify("quakevim: " .. msg, vim.log.levels.ERROR)
end

---@param file string
---@return table?
local function read_config_file(file)
    local ok, config = pcall(dofile, file)
    if not ok then
        notify_error("failed to load " .. file .. ":\n" .. tostring(config))
        return nil
    end
    if type(config) ~= "table" then
        notify_error(file .. " did not return a table")
        return nil
    end
    return config
end

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
        -- a config in $HOME is authoritative and fully replaces the default
        -- extensions.lua
        local config = read_config_file(M.get_extensions_file()) or {}
        config_cache = config
    end
    return config_cache.config or {}
end

function M.load_specs(spec)
    if not config_cache then
        M.load_config()
    end
    M.plugins = config_cache.extensions or {}
    for _, value in ipairs(M.plugins) do
        local ext_dir = vim.fn.stdpath "config" .. "/lua/extensions/" .. value
        local spec_path = ext_dir .. "/spec.lua"
        if vim.fn.isdirectory(ext_dir) == 0 then
            notify_error("unknown extension " .. vim.inspect(value) .. " in extensions.lua")
        elseif vim.fn.filereadable(spec_path) == 1 then
            table.insert(spec, { import = "extensions." .. value:gsub("/", ".") .. ".spec" })
        end
        -- extensions without a spec.lua only provide setup code in init.lua,
        -- nothing to import for lazy.nvim
    end
    return spec
end

function M.require()
    for _, value in ipairs(M.plugins) do
        local plugin_path = "extensions." .. string.gsub(value, "/", ".")
        local ok, err = pcall(require, plugin_path)
        if not ok then
            notify_error("failed to load extension " .. vim.inspect(value) .. ":\n" .. tostring(err))
        end
    end
end

return M
