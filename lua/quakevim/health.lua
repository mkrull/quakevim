local M = {}

-- mason packages installed per language extension, mapped to the binaries
-- they put on the path
local binaries_by_extension = {
    ["lang/gleam"] = { "gleam" },
    ["lang/go"] = { "gopls" },
    ["lang/json"] = { "vscode-json-language-server" },
    ["lang/lua"] = { "lua-language-server", "stylua" },
    ["lang/yaml"] = { "yaml-language-server" },
}

local parsers_by_extension = {
    ["lang/gleam"] = { "gleam" },
    ["lang/go"] = { "go", "gomod", "gowork" },
    ["lang/json"] = { "json" },
    ["lang/lua"] = { "lua", "luadoc", "vimdoc" },
    ["lang/markdown"] = { "markdown", "markdown_inline" },
    ["lang/yaml"] = { "yaml" },
}

local function read_config(file)
    local ok, config = pcall(dofile, file)
    if not ok then
        vim.health.error(("failed to load %s:\n%s"):format(file, tostring(config)))
        return nil
    end
    if type(config) ~= "table" then
        vim.health.error(file .. " did not return a table")
        return nil
    end
    return config
end

function M.check()
    local config_dir = vim.fn.stdpath "config"
    local home_config = vim.env.HOME .. "/.quakevim.lua"

    vim.health.start "quakevim config"

    local config_file = config_dir .. "/extensions.lua"
    if vim.fn.filereadable(config_file) == 1 then
        vim.health.ok("default config: " .. config_file)
    end

    if vim.fn.filereadable(home_config) == 1 then
        vim.health.ok("user config (authoritative): " .. home_config)
    end

    local config = read_config(config_file)
    if vim.fn.filereadable(home_config) == 1 then
        config = read_config(home_config) or config
    end

    if not config then
        return
    end

    local extensions = config.extensions or {}
    if type(extensions) ~= "table" then
        vim.health.error "extensions in config is not a list"
        return
    end

    for _, ext in ipairs(extensions) do
        local dir = config_dir .. "/lua/extensions/" .. ext
        if vim.fn.isdirectory(dir) == 0 then
            vim.health.error(("unknown extension %q"):format(ext))
        end
    end

    vim.health.start "quakevim language tooling"

    for _, ext in ipairs(extensions) do
        for _, bin in ipairs(binaries_by_extension[ext] or {}) do
            if vim.fn.executable(bin) == 1 then
                vim.health.ok(("%s: %s installed"):format(ext, bin))
            else
                vim.health.warn(("%s: %s missing (mason installs it on startup)"):format(ext, bin))
            end
        end

        for _, lang in ipairs(parsers_by_extension[ext] or {}) do
            if pcall(vim.treesitter.language.inspect, lang) then
                vim.health.ok(("%s: treesitter parser %s installed"):format(ext, lang))
            else
                vim.health.warn(("%s: treesitter parser %s not installed"):format(ext, lang))
            end
        end
    end
end

return M
