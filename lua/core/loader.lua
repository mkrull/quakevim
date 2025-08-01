local M = {
    plugins = {},
}
--[[
  flatten_plugins - Flattens a nested table structure of Neovim plugin specifications

  This function recursively processes a nested table structure typically used in Neovim plugin
  managers like lazy.nvim or packer.nvim, and flattens it into a single-level array of plugin
  specifications.

  The function identifies three types of elements:
  1. Plugin specifications - tables with a string at index 1 (the plugin's repository)
  2. Import specifications - tables with an 'import' key
  3. Nested tables - tables containing other plugin or import specifications

  Parameters:
    tbl - The nested table structure to flatten

  Returns:
    A new table containing all plugin and import specifications in a flat structure

  Example Input:
    {
      {
        import = "core/plugins"  -- Import specification
      },
      {                          -- Nested table
        {                        -- Plugin specification
          "s1n7ax/nvim-window-picker",
          lazy = false,
          name = "window-picker",
          opts = {},
          version = "2.*"
        },
        {                        -- Plugin specification
          "nvim-neo-tree/neo-tree.nvim",
          dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim"
          },
          opts = {
            open_files_do_not_replace_types = { "terminal", "Trouble", "qf" }
          }
        }
      }
    }

  Example Output:
    {
      {
        import = "core/plugins"  -- Import specification
      },
      {                        -- Plugin specification
        "s1n7ax/nvim-window-picker",
        lazy = false,
        name = "window-picker",
        opts = {},
        version = "2.*"
      },
      {                        -- Plugin specification
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons",
          "MunifTanjim/nui.nvim"
        },
        opts = {
          open_files_do_not_replace_types = { "terminal", "Trouble", "qf" }
        }
      }
    }
--]]
function M.flatten_plugins(tbl)
    -- Initialize an empty table to store the flattened result
    local result = {}

    -- Iterate through each item in the input table
    for _, item in ipairs(tbl) do
        -- Check if the current item is a table
        if type(item) == "table" then
            -- Case 1: Plugin specification - has a string at index 1 (repository path)
            -- Example: { "s1n7ax/nvim-window-picker", lazy = false, ... }
            if type(item[1]) == "string" then
                table.insert(result, item)

            -- Case 2: Import specification - has an 'import' key
            -- Example: { import = "core/plugins" }
            elseif item.import then
                table.insert(result, item)

            -- Case 3: Nested table - contains other plugin or import specifications
            -- Example: { { "plugin1/repo" }, { "plugin2/repo" } }
            else
                -- Recursively flatten the nested table
                -- For each item in the flattened result of the nested table
                for _, subitem in ipairs(M.flatten_plugins(item)) do
                    -- Add it to our result table
                    table.insert(result, subitem)
                end
            end
        end
        -- Note: Non-table items are ignored
    end

    -- Return the flattened table
    return result
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

function M.require()
    for _, value in ipairs(M.plugins) do
        local plugin_path = "extensions." .. string.gsub(value, "/", ".")
        pcall(require, plugin_path)
    end
end

function M.load_specs(spec)
    -- loading list of extensions and inserting them into the spec
    local ok, plugins = pcall(dofile, M.get_extensions_file())
    M.plugins = plugins
    if ok then
        for _, value in ipairs(plugins) do
            local spec_path = vim.fn.stdpath "config" .. "/lua/extensions/" .. value .. "/spec.lua"
            local ok, loaded = pcall(loadfile, spec_path)
            if ok then
                table.insert(spec, loaded())
            end
        end
    end

    return spec
end

return M
