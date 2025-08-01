local ok, mason = pcall(require, "mason-registry")
if ok then
    local p = mason.get_package "lua-language-server"
    if not p:is_installed() then
        p:install()
    end
end
